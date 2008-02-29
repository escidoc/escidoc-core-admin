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
package de.escidoc.core.admin.test.reindexer;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import de.escidoc.core.admin.business.Reindexer;
import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.admin.test.EscidocAdminTestBase;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;

/**
 * Test the implementation of the admin/reindexer.
 * 
 * @author MIH
 * 
 */
public class ReindexingTestBase extends EscidocAdminTestBase {

    protected Reindexer reindexer = new Reindexer();

    protected EscidocCoreHandler escidocCoreHandler = new EscidocCoreHandler();

    /**
     * get number of hits from xml String.
     * 
     * @param searchResult
     *            String searchResult
     * @return String number of hits
     * 
     */
    protected int getNumberOfHits(final String searchResult) {
        String numberOfHits = null;
        Pattern dateAttributePattern =
            Pattern.compile("numberOfRecords>(.*?)<");
        Matcher m = dateAttributePattern.matcher(searchResult);
        if (m.find()) {
            numberOfHits = m.group(1);
        }
        return new Integer(numberOfHits).intValue();
    }

    /**
     * extract id out of item-xml.
     * 
     * @param xml
     *            String xml
     * @return String id
     * 
     */
    protected String getId(final String xml) {
        String id = null;
        Pattern objidAttributePattern = Pattern.compile("objid=\"([^\"]*)\"");
        Matcher m = objidAttributePattern.matcher(xml);
        if (m.find()) {
            id = m.group(1);
        }
        else {
            Pattern hrefPattern = Pattern.compile("xlink:href=\"([^\"]*)\"");
            m = hrefPattern.matcher(xml);
            if (m.find()) {
                id = m.group(1);
                id = id.replaceFirst(".*\\/", "");
            }
        }
        return id;
    }

    /**
     * Gets the last-modification-date attribute of the root element from the
     * document.
     * 
     * @param document
     *            The document to retrieve the value from.
     * @return Returns the attribute value.
     * @throws Exception
     *             If anything fails.
     */
    protected String getLastModificationDate(final String xml) throws Exception {

        return getRootElementAttributeValue(getDocument(xml),
            "last-modification-date");
    }

    /**
     * create item.
     * 
     * @param item
     *            String item as xml
     * @return created item as xml
     * 
     */
    protected String createItem(final String item)
        throws ApplicationServerSystemException {
        return escidocCoreHandler.putRequestEscidoc(ITEM_BASE_URL, item);
    }

    /**
     * submit item.
     * 
     * @param itemId
     *            String itemId
     * @param lastModDate
     *            String lastModDate as xml
     * @return submitted item as xml
     * 
     */
    protected String submitItem(final String itemId, final String lastModDate)
        throws ApplicationServerSystemException {
        return escidocCoreHandler.postRequestEscidoc(ITEM_REPLACEMENT_PATTERN
            .matcher(ITEM_SUBMIT_PATH).replaceAll(itemId), lastModDate);
    }

    /**
     * release item.
     * 
     * @param itemId
     *            String itemId
     * @param lastModDate
     *            String lastModDate as xml
     * @return released item as xml
     * 
     */
    protected String releaseItem(final String itemId, final String lastModDate)
        throws ApplicationServerSystemException {
        return escidocCoreHandler.postRequestEscidoc(ITEM_REPLACEMENT_PATTERN
            .matcher(ITEM_RELEASE_PATH).replaceAll(itemId), lastModDate);
    }

    /**
     * retrieve item.
     * 
     * @param itemId
     *            String itemId
     * @return item as xml
     * 
     */
    protected String retrieveItem(final String itemId)
        throws ApplicationServerSystemException {
        return escidocCoreHandler.getRequestEscidoc(ITEM_BASE_URL + "/"
            + itemId);
    }

}
