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

import java.util.Hashtable;

import javax.naming.InitialContext;
import javax.naming.NamingException;

import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;

/**
 * Execute jndi-operations.
 * 
 * @common
 */
public class JndiHandler {

    private static AppLogger log =
        new AppLogger(JndiHandler.class.getName());
    
    private InitialContext initialContext;

    /**
     * get jndi-object with given jndiName.
     * 
     * <pre>
     *        execute lookup.
     * </pre>
     * 
     * @param jndiName
     *            String jndiName.
     * @return Object jndi-object
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @common
     */
    public Object getJndiObject(final String jndiName)
        throws ApplicationServerSystemException {
        try {
            Object jndiObject = initialContext.lookup(jndiName);
            return jndiObject;
        }
        catch (NamingException e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

	/**
	 * @return the context
	 */
	public InitialContext getInitialContext() {
		return initialContext;
	}

	/**
	 * @param context the context to set
	 */
	public void setInitialContext(final String providerUrl) throws ApplicationServerSystemException {
        Hashtable<String, String> environment = new Hashtable<String, String>();
        environment.put("java.naming.provider.url", providerUrl);
        environment.put("java.naming.factory.initial", "org.jnp.interfaces.NamingContextFactory");
        environment.put("java.naming.factory.url.pkgs", "org.jnp.interfaces:org.jboss.naming");
        try {
			initialContext = new InitialContext(environment);
		} catch (NamingException e) {
			log.error(e);
			throw new ApplicationServerSystemException(e);
		}
	}

}
