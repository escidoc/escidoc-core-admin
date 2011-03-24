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
 * Copyright 2006-2008 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.  
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.common.util.stax.handler;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.naming.directory.NoSuchAttributeException;

import de.escidoc.core.admin.common.util.vo.ReportDefinitionRoleVo;
import de.escidoc.core.admin.common.util.vo.ReportDefinitionVo;
import de.escidoc.core.common.exceptions.application.missing.MissingAttributeValueException;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.xml.XmlUtility;
import de.escidoc.core.common.util.xml.stax.events.AbstractElement;
import de.escidoc.core.common.util.xml.stax.events.StartElement;
import de.escidoc.core.common.util.xml.stax.handler.DefaultHandler;

/**
 * Fills xml-data into hibernate object.
 * 
 * @author MIH
 * @sm
 */
public class ReportDefinitionStaxHandler extends DefaultHandler {

    private ReportDefinitionVo reportDefinitionVo = new ReportDefinitionVo();

    private StaxParser parser;

    private int allowedRolesIndex = 0;

    private static final Pattern PATTERN_GET_ID_FROM_URI_OR_FEDORA_ID = Pattern
        .compile(".*/([^/>]+)>{0,1}");

    public static final String NAME_OBJID = "objid";

    public static final String NAME_HREF = "href";

    /**
     * Cosntructor with StaxParser.
     * 
     * @param parser
     *            StaxParser
     * 
     * @sm
     */
    public ReportDefinitionStaxHandler(final StaxParser parser) {
        this.parser = parser;
    }

    /**
     * Handle startElement event.
     * 
     * @param element
     *            startElement
     * @return StartElement startElement
     * @throws Exception
     *             e
     * 
     * @sm
     */
    public StartElement startElement(final StartElement element)
        throws Exception {
        if ("allowed-role".equals(element.getLocalName())) {
            String objId = getIdFromStartElement(element);
            if (objId != null) {
                allowedRolesIndex++;
                ReportDefinitionRoleVo reportDefinitionRoleVo =
                    new ReportDefinitionRoleVo();
                reportDefinitionRoleVo.setId(reportDefinitionVo.getId()
                    + "role" + allowedRolesIndex);
                reportDefinitionRoleVo.setRoleId(objId);
                reportDefinitionRoleVo.setListIndex(allowedRolesIndex);
                reportDefinitionVo.getReportDefinitionRoles().add(
                    reportDefinitionRoleVo);
            }
        }
        else if ("report-definition".equals(element.getLocalName())) {
            try {
                String reportDefinitionId = getIdFromStartElement(element);
                reportDefinitionVo.setId(reportDefinitionId);
            }
            catch (MissingAttributeValueException e) {
            }
        }
        return element;
    }

    /**
     * Extracts the objid from the provided element.<br/>
     * Either the id is fetched from the attribute objid of the provided
     * element. If this fails, it is extracted from the attribute href. If this
     * fials, too, an exception is thrown.
     * 
     * @param element
     *            The element to get the objid from.
     * @return Returns the objid value.
     * @throws MissingAttributeValueException
     *             Thrown if neither an objid nor an href attribute exists.
     */

    public static String getIdFromStartElement(final StartElement element)
        throws MissingAttributeValueException {

        try {
            final String objid;
            if (element.indexOfAttribute(null, NAME_OBJID) != -1) {
                objid = element.getAttributeValue(null, NAME_OBJID);
            }
            else {
                objid =
                    getIdFromURI(element.getAttributeValue(
                        de.escidoc.core.common.business.Constants.XLINK_NS_URI,
                        NAME_HREF));
            }
            return objid;
        }
        catch (final NoSuchAttributeException e) {
            throwMissingAttributeValueException(element, XmlUtility.NAME_OBJID
                + "|" + XmlUtility.NAME_HREF);
            return null;
        }
    }

    /**
     * Get the objid from an URI/Fedora identifier, e.g. from
     * &lt;info:fedora/escidoc:1&gt;<br/>
     * If the provided value does not match the expected pattern, it is returned
     * as provided. Otherwise, the objid is extracted from it and returned.
     * 
     * @param uri
     *            The value to get the objid from
     * @return Returns the extracted objid or the provided value.
     */
    public static String getIdFromURI(final String uri) {

        if (uri == null) {
            return null;
        }
        final Matcher matcher =
            PATTERN_GET_ID_FROM_URI_OR_FEDORA_ID.matcher(uri);
        if (matcher.find()) {
            return matcher.group(1);
        }
        else {
            return uri;
        }
    }

    /**
     * Throws an <code>MissingAttributeValueException</code>.
     * 
     * @param element
     *            The element in that the attribute is missing.
     * @param attributeName
     *            The name of the missing attribute.
     * @throws MissingAttributeValueException
     *             Throws created exception.
     */
    public static void throwMissingAttributeValueException(
        final AbstractElement element, final String attributeName)
        throws MissingAttributeValueException {

        throw new MissingAttributeValueException(
            XmlUtility.ERR_MSG_MISSING_ATTRIBUTE + " \"" + element.getPath()
                + attributeName + element.getLocationString() + "\"");
    }

    /**
     * @return the reportDefinition
     */
    public ReportDefinitionVo getReportDefinitionVo() {
        return reportDefinitionVo;
    }

}
