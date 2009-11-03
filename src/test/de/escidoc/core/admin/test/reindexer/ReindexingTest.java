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

import de.escidoc.core.admin.AdminMain;

/**
 * Test the implementation of the admin/reindexer.
 * 
 * @author MIH
 * 
 */
public class ReindexingTest extends ReindexingTestBase {

    static int numberOfItemHits = 0;

    static int numberOfContainerHits = 0;

    /**
     * Set up test.
     * 
     * @throws Exception
     *             If anything fails.
     */
    @Override
    protected void setUp() throws Exception {
        super.setUp();
    }

    /**
     * Clean up after test.
     * 
     * @throws Exception
     *             If anything fails.
     */
    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }

    /**
     * test to recreate index.
     * 
     * @test.name testRecreateIndex (1)
     * @test.id ADRI_1
     * @test.input
     * @test.inputDescription
     * @test.expected index that delivers no search-results and no exception
     *                when searching.
     * @test.status Implemented
     * 
     * @throws Exception
     *             If anything fails.
     */
    public void testADRI_1() throws Exception {
        // Create and release one item,
        // so we get at least 1 hit when searching for items
        String item =
            getTemplateAsString(TEMPLATE_REINDEXER_ITEM_PATH,
                "escidoc_search_item0_rest.xml");
        String xml = createItem(item);
        String id = getId(xml);
        String lastModificationDate = getLastModificationDate(xml);

        submitItem(id, "<param last-modification-date=\""
            + lastModificationDate + "\" />");

        xml = retrieveItem(id);
        lastModificationDate = getLastModificationDate(xml);

        releaseItem(id, "<param last-modification-date=\""
            + lastModificationDate + "\" />");

        // Wait until item is indexed
        Thread.sleep(10000);

        // search all items an store number of hits for later comparison
        String searchResult =
            getEscidocCoreHandler().getRequestEscidoc(ITEM_SEARCH_REQUEST);
        numberOfItemHits = getNumberOfHits(searchResult);

        // search all containers an store number of hits for later comparison
        searchResult =
        	getEscidocCoreHandler().getRequestEscidoc(CONTAINER_SEARCH_REQUEST);
        numberOfContainerHits = getNumberOfHits(searchResult);

        // delete index
        getReindexer().clearIndex();

        // check if no items are found any longer
        searchResult =
        	getEscidocCoreHandler().getRequestEscidoc(ITEM_SEARCH_REQUEST);
        assertEquals(0, getNumberOfHits(searchResult));

        // trigger reindexing
        String[] args = new String[1];
        args[0] = "reindex";
        AdminMain.main(args);
        Thread.sleep(60000);

        // check if we get as many search-results as before
        searchResult =
        	getEscidocCoreHandler().getRequestEscidoc(ITEM_SEARCH_REQUEST);
        assertEquals(numberOfItemHits, getNumberOfHits(searchResult));

        searchResult =
        	getEscidocCoreHandler().getRequestEscidoc(CONTAINER_SEARCH_REQUEST);
        assertEquals(numberOfContainerHits, getNumberOfHits(searchResult));

    }

}
