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
 * Copyright 2006-2007 Fachinformationszentrum Karlsruhe Gesellschaft
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
	protected void setUp() throws Exception {
		super.setUp();
	}

	/**
	 * Clean up after test.
	 * 
	 * @throws Exception
	 *             If anything fails.
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
	}

	/**
	 * test to delete index.
	 * 
	 * @test.name testDeleteIndex (1)
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
		String item = getTemplateAsString(TEMPLATE_REINDEXER_ITEM_PATH,
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
		
		Thread.sleep(10000);

		String searchResult = escidocCoreHandler
				.getRequestEscidoc("/srw/search/escidoc_all?query=escidoc.objecttype%3Ditem");
		numberOfItemHits = getNumberOfHits(searchResult);

		searchResult = escidocCoreHandler
				.getRequestEscidoc("/srw/search/escidoc_all?query=escidoc.objecttype%3Dcontainer");
		numberOfContainerHits = getNumberOfHits(searchResult);

		reindexer.sendDeleteIndexMessage();

		searchResult = escidocCoreHandler
				.getRequestEscidoc("/srw/search/escidoc_all?query=escidoc.objecttype%3Ditem");
		assertEquals(0, getNumberOfHits(searchResult));

		String[] args = new String[1];
		args[0] = "reindex";
		AdminMain.main(args);

		searchResult = escidocCoreHandler
				.getRequestEscidoc("/srw/search/escidoc_all?query=escidoc.objecttype%3Ditem");
		assertEquals(numberOfItemHits, getNumberOfHits(searchResult));

		searchResult = escidocCoreHandler
				.getRequestEscidoc("/srw/search/escidoc_all?query=escidoc.objecttype%3Dcontainer");
		assertEquals(numberOfContainerHits, getNumberOfHits(searchResult));

	}

}
