/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License, Version 1.0 only
 * (the "License").  You may not use this file except in compliance
 * with the License.
 *
 * You can obtain a copy of the license at license/ESCIDOC.LICENSE
 * or http://www.escidoc.de/license.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at license/ESCIDOC.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */

/*
 * Copyright 2008 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.  
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.common.util.stax.handler;

import java.util.Vector;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import de.escidoc.core.common.exceptions.application.missing.MissingAttributeValueException;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.xml.stax.events.Attribute;
import de.escidoc.core.common.util.xml.stax.events.StartElement;
import de.escidoc.core.common.util.xml.stax.handler.DefaultHandler;

/**
 * Extracts hrefs to objects out of filtered List.
 * 
 * @author Michael Hoppe
 * 
 */
public class ListHrefHandler extends DefaultHandler {
    public static final String XLINK_PREFIX = "xlink";

    public static final String XLINK_URI = "http://www.w3.org/1999/xlink";

    private StaxParser parser;

    private String listName;

    private String listElementName;

    private Vector<String> hrefs = new Vector<String>();

    private int numberOfRecords = -1;

    private static Logger log = LoggerFactory.getLogger(ListHrefHandler.class);

    /**
     * initialize handler with StaxParser.
     * 
     * @param parser
     *            StaxParser parser.
     * @param listName
     *            root-element name of the List.
     * @param listElementName
     *            element-name of one entry of the list.
     * 
     * @admin
     */
    public ListHrefHandler(final StaxParser parser, final String listName,
        final String listElementName) {
        this.parser = parser;
        this.listName = listName;
        this.listElementName = listElementName;

    }

    /**
     * handle startElement.
     * 
     * @param element
     *            StartElement.
     * @return StartElement element
     * @throws MissingAttributeValueException
     *             e
     * 
     * @admin
     */
    @Override
    public StartElement startElement(final StartElement element)
        throws MissingAttributeValueException {

        String listElementRefPath = "/" + listName + "/" + listElementName;
        String listPath = "/" + listName;
        String currentPath = parser.getCurPath();

        if (listPath.equals(currentPath)) {
            int indexOfNumberOfRecords =
                element.indexOfAttribute(null, "number-of-records");
            if (indexOfNumberOfRecords != (-1)) {
                Attribute recordNumberAttribute =
                    element.getAttribute(indexOfNumberOfRecords);
                numberOfRecords =
                    Integer.parseInt(recordNumberAttribute.getValue());
            }
        }
        if (listElementRefPath.equals(currentPath)) {
            int indexOfHref = element.indexOfAttribute(XLINK_URI, "href");
            if (indexOfHref != (-1)) {
                Attribute href = element.getAttribute(indexOfHref);
                hrefs.add(href.getValue());
            }
        }
        return element;
    }

    /**
     * @return the hrefs
     */
    public Vector<String> getHrefs() {
        return hrefs;
    }

    /**
     * @return the numberOfRecords
     */
    public int getNumberOfRecords() {
        return numberOfRecords;
    }

}
