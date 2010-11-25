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

import org.apache.http.cookie.Cookie;
import org.apache.http.impl.cookie.BasicClientCookie;

import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.service.ConnectionUtility;

/**
 * Execute http-request to escidoc-core system.
 * 
 * @spring.bean id="de.escidoc.core.admin.EscidocCoreHandler"
 */
public class EscidocCoreHandler {

    private static final String COOKIE_LOGIN = "escidocCookie";

    private static final AppLogger LOG = new AppLogger(
        EscidocCoreHandler.class.getName());

    private final ConnectionUtility connectionUtility = new ConnectionUtility();

    private final Cookie cookie;

    private final String escidocCoreUrl;

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
     */
    public EscidocCoreHandler(final String escidocCoreUrl,
        final String persistentHandle) throws Exception {
        cookie = new BasicClientCookie(COOKIE_LOGIN, persistentHandle);
        this.escidocCoreUrl = escidocCoreUrl;
    }

    /**
     * initialize EscidocCoreHandler with escidocCoreUrl to eSciDocCore-System.
     * 
     * @param escidocCoreUrl
     *            String escidocCoreUrl.
     * @throws Exception
     *             e
     */
    public EscidocCoreHandler(final String escidocCoreUrl) throws Exception {
        this(escidocCoreUrl, "");
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
     */
    public String getRequestEscidoc(final String resource)
        throws ApplicationServerSystemException {
        String result = null;

        try {
            result =
                connectionUtility.getRequestURLAsString(new URL(escidocCoreUrl
                    + resource), cookie);
        }
        catch (Exception e) {
            LOG.error(e);
            throw new ApplicationServerSystemException(e);
        }
        return result;
    }
}
