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
package de.escidoc.core.admin.common.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import sun.misc.BASE64Decoder;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.service.HttpRequester;

/**
 * Execute http-request to escidoc-core system.
 * 
 * @spring.bean id="de.escidoc.core.admin.EscidocCoreHandler"
 * 
 * @admin
 */
public class EscidocCoreHandler {

    private static AppLogger log =
        new AppLogger(EscidocCoreHandler.class.getName());

    private HttpRequester httpRequester;
    
	private final String LOGIN_PATH = 
		"/aa/login?target="
		+ "&shire=https%3A%2F%2Flocalhost%3A8080%2Fshibboleth%2Facs"
		+ "&providerId=https%3A%2F%2Fwww.escidoc.de%2Fshibboleth";

	private final Pattern userHandlePattern = 
		Pattern.compile("(?s).*?URL=\\?eSciDocUserHandle=(.*?)\".*");
	
	private final BASE64Decoder decoder = new BASE64Decoder();

	/**
     * initialize EscidocCoreHandler with 
     * escidocCoreUrl to eSciDocCore-System.
     * 
     * @param escidocCoreUrl
     *            String escidocCoreUrl.
     * 
     * @admin
     */
    public EscidocCoreHandler(
    		final String escidocCoreUrl) {
        httpRequester = 
        	new HttpRequester(escidocCoreUrl);
    }

	/**
     * initialize EscidocCoreHandler with 
     * escidocCoreUrl to eSciDocCore-System
     * and securityHandle.
     * 
     * @param escidocCoreUrl
     *            String escidocCoreUrl.
     * @param login
     *            String login.
     * @param password
     *            String password.
     * @throws Exception e
     * 
     * @admin
     */
    public EscidocCoreHandler(
    		final String escidocCoreUrl, 
    		final String login, 
    		final String password) throws Exception {
    	String securityHandle = login(escidocCoreUrl, login, password);
        httpRequester = 
        	new HttpRequester(escidocCoreUrl, securityHandle);
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
    public String postRequestEscidoc(
        final String resource, final String postParam)
        throws ApplicationServerSystemException {
        try {
            String result = httpRequester.doPost(resource, postParam);
            return result;
        }
        catch (Exception e) {
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
        }
        catch (Exception e) {
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
     * @param putParam
     *            String put-parameters.
     * @return String response
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    public String putRequestEscidoc(
    		final String resource, final String putParam)
        throws ApplicationServerSystemException {
        try {
            String result = httpRequester.doPut(resource, putParam);
            return result;
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }
    
    /**
     * login into escidoc and return userHandle.
     * 
     * @param escidocCoreUrl
     *            String escidocCoreUrl.
     * @param login
     *            String login.
     * @param password
     *            String password.
     * @return String userHandle
     * 
     * @throws Exception e
     * @admin
     */
    private String login(
    		final String escidocCoreUrl, 
    		final String login, 
    		final String password) throws Exception {
        String loginUrl = escidocCoreUrl + LOGIN_PATH;
        HttpRequester httpRequester = new HttpRequester(loginUrl);
        httpRequester.setFollowRedirects(false);
    	String returnXml = httpRequester.doPost(
    			"", "login=" + login + "&password=" + password);
    	String encodedUserHandle = getUserHandle(returnXml);
    	String decodedUserHandle = new String(
    			decoder.decodeBuffer(encodedUserHandle));
    	return decodedUserHandle;
    	
    }

    /**
     * extract userHandle out of loginPage.
     * 
     * @param xml
     *            String xml.
     * @return String userHandle
     * 
     * @admin
     */
	private String getUserHandle(final String xml) {
		Matcher userHandleMatcher = userHandlePattern.matcher(xml);
		userHandleMatcher.matches();
		return userHandleMatcher.group(1);
	}
	
}
