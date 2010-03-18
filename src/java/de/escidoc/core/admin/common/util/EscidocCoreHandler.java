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

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.xml.namespace.QName;

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
import org.apache.commons.httpclient.Cookie;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.URI;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.ws.axis.security.WSDoAllSender;
import org.apache.ws.security.handler.WSHandlerConstants;

import sun.misc.BASE64Decoder;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.service.ConnectionUtility;

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

    private final ConnectionUtility connectionUtility = new ConnectionUtility();

    private static final String LOGIN_PATH = "/aa/login?target=";

    private final Pattern loginFormPattern =
        Pattern.compile("(?s).*?action=\"(.*?)\".*");

    private final Pattern userHandlePattern =
        Pattern.compile("(?s).*?href=\"\\?eSciDocUserHandle=(.*?)\".*");

    private Cookie cookie = null;

    private final HashMap<String, Object> wsSecurityHash =
        new HashMap<String, Object>();

    private final BASE64Decoder decoder = new BASE64Decoder();

    private static final String COOKIE_LOGIN = "escidocCookie";

    private String escidocCoreUrl = null;

    /**
     * initialize EscidocCoreHandler with escidocCoreUrl to eSciDocCore-System.
     * 
     * @param escidocCoreUrl
     *            String escidocCoreUrl.
     * 
     * @admin
     */
    public EscidocCoreHandler(final String escidocCoreUrl) {
        this.escidocCoreUrl = escidocCoreUrl;
    }

    /**
     * initialize EscidocCoreHandler with escidocCoreUrl to eSciDocCore-System
     * and securityHandle.
     * 
     * @param escidocCoreUrl
     *            String escidocCoreUrl.
     * @param login
     *            String login.
     * @param password
     *            String password.
     * @throws Exception
     *             e
     * 
     * @admin
     */
    public EscidocCoreHandler(final String escidocCoreUrl, final String login,
        final String password) throws Exception {
        this.escidocCoreUrl = escidocCoreUrl;
        cookie = new Cookie();
        cookie.setName(COOKIE_LOGIN);
        cookie.setValue(login(escidocCoreUrl, login, password));
    }

    /**
     * initialize EscidocCoreHandler with escidocCoreUrl to eSciDocCore-System
     * and securityHandle.
     * 
     * @param escidocCoreUrl
     *            String escidocCoreUrl.
     * @param persistentHandle
     *            String persistentHandle.
     * @throws Exception
     *             e
     * 
     * @admin
     */
    public EscidocCoreHandler(
            final String escidocCoreUrl, 
            final String persistentHandle) throws Exception {
        cookie = new Cookie();
        this.escidocCoreUrl = escidocCoreUrl;
        cookie.setName(COOKIE_LOGIN);
        cookie.setValue(persistentHandle);
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
            String result = connectionUtility.postRequestURLAsString(
                        new URL(escidocCoreUrl + resource), postParam, cookie);
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
            String result = connectionUtility.getRequestURLAsString(
                    new URL(escidocCoreUrl + resource), cookie);
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
            String result = connectionUtility.putRequestURLAsString(
                    new URL(escidocCoreUrl + resource), putParam, cookie);
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
        final String targetNamespace, final String methodName,
        final Object[] arguments) throws ApplicationServerSystemException {
        try {
            URL url = new URL(targetNamespace);
            Service service = new Service(createClientConfig());
            Call call = (Call) service.createCall();
            call.setTargetEndpointAddress(url);
            call.setOperationName(new QName(targetNamespace, methodName));

            // write type-mappings
            QName poqn =
                new QName("http://result.service.om.core.escidoc.de",
                    "MIMETypedStream");
            Class mappingClass =
                Class
                    .forName(
                       "de.escidoc.core.om.service.result.MIMETypedStream");
            call.registerTypeMapping(mappingClass, poqn,
                new BeanSerializerFactory(mappingClass, poqn),
                new BeanDeserializerFactory(mappingClass, poqn));

            // write security
            if (cookie != null) {
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
        }
        catch (Exception e) {
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
     * @throws Exception
     *             e
     * @admin
     */
    private String login(
        final String escidocCoreUrl, final String login, final String password)
        throws Exception {
        String result = null;
        HttpClient client = new HttpClient();

        client.getHostConfiguration().setHost(new URI(escidocCoreUrl, false));

        GetMethod authget = new GetMethod(LOGIN_PATH);

        client.executeMethod(authget);

        PostMethod authpost =
            new PostMethod(getLoginFormName(authget.getResponseBodyAsString()));

        authget.releaseConnection();

        NameValuePair userid = new NameValuePair("j_username", login);
        NameValuePair passwd = new NameValuePair("j_password", password);

        authpost.setRequestBody(new NameValuePair[] { userid, passwd });
        client.executeMethod(authpost);
        authpost.releaseConnection();

        int statuscode = authpost.getStatusCode();

        if ((statuscode == HttpStatus.SC_MOVED_TEMPORARILY)
            || (statuscode == HttpStatus.SC_MOVED_PERMANENTLY)
            || (statuscode == HttpStatus.SC_SEE_OTHER)
            || (statuscode == HttpStatus.SC_TEMPORARY_REDIRECT)) {
            Header header = authpost.getResponseHeader("location");

            if (header != null) {
                String newuri = header.getValue();

                if ((newuri == null) || (newuri.equals(""))) {
                    newuri = "/";
                }

                GetMethod redirect = new GetMethod(newuri);

                redirect.setFollowRedirects(false);
                client.executeMethod(redirect);

                StringBuffer response = new StringBuffer();
                BufferedReader reader =
                    new BufferedReader(new InputStreamReader(redirect
                        .getResponseBodyAsStream()));
                String line = null;

                while ((line = reader.readLine()) != null) {
                    response.append(line + "\n");
                }
                reader.close();

                String encodedUserHandle = getUserHandle(response.toString());

                if (encodedUserHandle != null) {
                    result =
                        new String(decoder.decodeBuffer(encodedUserHandle));
                }
                redirect.releaseConnection();
            }
        }
        return result;
    }

    /**
     * extract login form name out of loginPage.
     * 
     * @param xml
     *            String xml.
     * @return String login form name
     * 
     * @admin
     */
    private String getLoginFormName(final String xml) {
        Matcher matcher = loginFormPattern.matcher(xml);
        matcher.matches();
        return matcher.group(1);
    }

    /**
     * extract userHandle out of loginPage.
     * 
     * @param xml
     *            String xml.
     * @return String userHandle
     * @throws Exception e
     * 
     * @admin
     */
    private String getUserHandle(final String xml) throws Exception {

        Matcher userHandleMatcher = userHandlePattern.matcher(xml);
        if (!userHandleMatcher.matches()) {
            throw new ApplicationServerSystemException(
                "Login failed, can't retrieve user handle.");
        }
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
        wsSecurityHash.put(WSHandlerConstants.USER, "");
        wsSecurityHash.put(WSHandlerConstants.PW_CALLBACK_REF, new PWCallback(
            "", cookie.getValue()));

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
            Handler securityHandler = new WSDoAllSender();
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
            Handler pivot = new HTTPSender();
            Handler transport =
                new SimpleTargetedChain(reqHandler, pivot, respHandler);
            clientConfig.deployTransport(HTTPTransport.DEFAULT_TRANSPORT_NAME,
                transport);
            return clientConfig;
        }
        catch (Exception ex) {
            System.out.println("Couldn't create engine configuration: " + ex);
            return null;
        }
    }
}
