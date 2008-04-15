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

import java.net.URL;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.namespace.QName;
import javax.xml.rpc.Stub;

import org.apache.axis.EngineConfiguration;
import org.apache.axis.Handler;
import org.apache.axis.SimpleChain;
import org.apache.axis.SimpleTargetedChain;
import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.configuration.SimpleProvider;
import org.apache.axis.encoding.ser.BeanDeserializerFactory;
import org.apache.axis.encoding.ser.BeanSerializerFactory;
import org.apache.axis.transport.http.HTTPSender;
import org.apache.axis.transport.http.HTTPTransport;
import org.apache.ws.axis.security.WSDoAllSender;
import org.apache.ws.security.handler.WSHandlerConstants;

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
	
	private String login = null;
	
	private String password = null;
	
	private String securityHandle = null;
	
    private HashMap<String, Object> wsSecurityHash 
	= new HashMap<String, Object>();

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
    	this.login = login;
    	this.password = password;
    	securityHandle = login(escidocCoreUrl, login, password);
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
     * requests escidoc-resource with put-request.
     * 
     * <pre>
     *        execute put-request.
     * </pre>
     * 
     * @param targetNamespace
     *            String targetNamespace.
     * @param methodName
     *            String methodName.
     * @param arguments
     *            Object[] arguments.
     * @return Object response
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    public Object soapRequestEscidoc(
    		final String targetNamespace, 
    		final String methodName, 
    		final Object[] arguments)
        throws ApplicationServerSystemException {
		try {
	        URL url = new URL(targetNamespace);
	        Service service = new Service(createClientConfig());
	        Call call = (Call) service.createCall();
	        call.setTargetEndpointAddress(url);
	        call.setOperationName(new QName(targetNamespace, methodName));
	        
	        //write type-mappings
            QName poqn =
                new QName("http://result.interfaces.service.om.core.escidoc.de",
                    "MIMETypedStream");
            Class mappingClass = Class.forName("de.escidoc.core.om.service.interfaces.result.MIMETypedStream");
            call.registerTypeMapping(mappingClass, poqn,
                new BeanSerializerFactory(mappingClass, poqn),
                new BeanDeserializerFactory(mappingClass, poqn));

	        //write security
	    	if (securityHandle != null) {
	    		fillWsSecurityHash();
	    	}
			if (wsSecurityHash != null) {
				for (String key : wsSecurityHash.keySet()) {
					call.setProperty(key, wsSecurityHash.get(key));
				}
			}
			
			call.setTimeout(120000);
	        Object ret = call.invoke(arguments);
	        return ret;
		} catch (Exception e) {
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
	
    /**
     * fill WS security parameters.
     * 
     * @admin
     */
    private void fillWsSecurityHash() {
    	wsSecurityHash.put(WSHandlerConstants.MUST_UNDERSTAND, "false");
    	wsSecurityHash.put(WSHandlerConstants.ACTION, "UsernameToken");
    	wsSecurityHash.put(WSHandlerConstants.PASSWORD_TYPE, "PasswordText");
		wsSecurityHash.put(WSHandlerConstants.USER, login);
		wsSecurityHash.put(WSHandlerConstants.PW_CALLBACK_REF
				, new PWCallback(login, securityHandle));

    }

    /**
     * create configuration for WS-Call.
     * 
     * @return EngineConfiguration EngineConfiguration
     * 
     * @admin
     */
    private EngineConfiguration createClientConfig() { 
		try {
			SimpleProvider clientConfig = new SimpleProvider(); 
			Handler securityHandler = (Handler) new WSDoAllSender();
			if (wsSecurityHash != null) {
				for (String key : wsSecurityHash.keySet()) {
					securityHandler.setOption(key, wsSecurityHash.get(key));
				}
			}
			SimpleChain reqHandler = new SimpleChain(); 
			SimpleChain respHandler = new SimpleChain(); 
			// add the handler to the request
			reqHandler.addHandler(securityHandler); 
			// add the handler to the response
			respHandler.addHandler(securityHandler); 
			Handler pivot =(Handler) new HTTPSender(); 
			Handler transport = new SimpleTargetedChain(
							reqHandler, pivot, respHandler); 
			clientConfig.deployTransport(
					HTTPTransport.DEFAULT_TRANSPORT_NAME, transport); 
			return clientConfig;   
		} catch (Exception ex) {
			System.out.println("Couldn't create engine configuration: " + ex);
			return null;
		}
	}

}
