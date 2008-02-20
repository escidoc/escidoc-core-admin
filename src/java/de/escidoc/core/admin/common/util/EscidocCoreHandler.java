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
package de.escidoc.core.admin.common.util;

import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.service.HttpRequester;

/**
 * Execute http-request to escidoc-core system.
 * 
 * @admin
 */
public class EscidocCoreHandler {

	private static AppLogger log = new AppLogger(EscidocCoreHandler.class
			.getName());

	private static final String DEFAULT_HANDLE = "Shibboleth-Handle-1";

	private static final String DEFAULT_ESCIDOC_CORE_URL = 
										"http://localhost:8080";

	private HttpRequester httpRequester;

    /**
     * initialize EscidocCoreHandler.
     * escidocCoreUrl is set to default.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
	public EscidocCoreHandler() {
		httpRequester = new HttpRequester(DEFAULT_ESCIDOC_CORE_URL,
				DEFAULT_HANDLE);
	}

    /**
     * initialize EscidocCoreHandler 
     * with escidocCoreUrl to eSciDocCore-System.
     * 
     * @param escidocCoreUrl
     *            String escidocCoreUrl.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
	public EscidocCoreHandler(String escidocCoreUrl) {
		if (escidocCoreUrl == null) {
			escidocCoreUrl = DEFAULT_ESCIDOC_CORE_URL;
		}
		httpRequester = new HttpRequester(escidocCoreUrl, DEFAULT_HANDLE);
	}

	/**
	 * requests escidoc-resource with post-request.
	 * 
	 * <pre>
	 *        execute post-request.
	 * </pre>
	 * 
	 * @param resource
	 *            String resource.
	 * @param postParam
	 *            String post-parameters.
	 * @return String response
	 * 
	 * @throws ApplicationServerSystemException
	 *             e
	 * @admin
	 */
	public String postRequestEscidoc(final String resource, final String postParam)
			throws ApplicationServerSystemException {
		try {
			String result = httpRequester.doPost(resource, postParam);
			return result;
		} catch (Exception e) {
			log.error(e);
			throw new ApplicationServerSystemException(e);
		}
	}

	/**
	 * requests escidoc-resource with get-request.
	 * 
	 * <pre>
	 *        execute get-request.
	 * </pre>
	 * 
	 * @param resource
	 *            String resource.
	 * @return String response
	 * 
	 * @throws ApplicationServerSystemException
	 *             e
	 * @admin
	 */
	public String getRequestEscidoc(final String resource)
			throws ApplicationServerSystemException {
		try {
			String result = httpRequester.doGet(resource);
			return result;
		} catch (Exception e) {
			log.error(e);
			throw new ApplicationServerSystemException(e);
		}
	}

	/**
	 * requests escidoc-resource with put-request.
	 * 
	 * <pre>
	 *        execute put-request.
	 * </pre>
	 * 
	 * @param resource
	 *            String resource.
	 * @param postParam
	 *            String put-parameters.
	 * @return String response
	 * 
	 * @throws ApplicationServerSystemException
	 *             e
	 * @admin
	 */
	public String putRequestEscidoc(final String resource, final String putParam)
			throws ApplicationServerSystemException {
		try {
			String result = httpRequester.doPut(resource, putParam);
			return result;
		} catch (Exception e) {
			log.error(e);
			throw new ApplicationServerSystemException(e);
		}
	}

}
