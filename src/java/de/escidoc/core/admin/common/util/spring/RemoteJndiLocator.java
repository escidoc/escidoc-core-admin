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
package de.escidoc.core.admin.common.util.spring;

import java.util.Properties;

import javax.naming.Context;
import javax.naming.NamingException;

import org.springframework.jndi.JndiObjectFactoryBean;

import de.escidoc.core.common.exceptions.system.WebserverSystemException;

/**
 * Customized Proxy factory Bean for the Remote and Stateless EJB lookup.
 * 
 * @author Michael Hoppe
 * 
 */
public class RemoteJndiLocator extends JndiObjectFactoryBean {

    private String jndiUrl;

    /**
     * Business interface is required for casting. If the interface does not
     * exist an exception is thrown.
     * 
     * @throws NamingException
     *             From the lookup
     */
    public void afterPropertiesSet() throws NamingException {
        try {
            setInitialContextJndiProperties();
        }
        catch (WebserverSystemException e) {
            NamingException ex = new NamingException();
            ex.setRootCause(e);
            throw ex;
        }
        super.afterPropertiesSet();
    }

    /**
     * Returns true, because the object is a Spring singleton.
     * 
     * @return boolean true because is a Spring singleton
     */
    public boolean isSingleton() {
        return true;
    }

    /**
     * Set the JNDI properties.
     * 
     * @throws WebserverSystemException
     *             Thrown in case of an internal error.
     */
    private void setInitialContextJndiProperties()
        throws WebserverSystemException {
        Properties properties = new Properties();
        properties.setProperty(Context.INITIAL_CONTEXT_FACTORY,
        "org.jnp.interfaces.NamingContextFactory");
        properties.setProperty(Context.URL_PKG_PREFIXES,
        "org.jnp.interfaces:org.jboss.naming");
        properties.setProperty(Context.PROVIDER_URL, jndiUrl);
        this.setJndiEnvironment(properties);
    }

	/**
	 * @param jndiUrl the jndiUrl to set
	 */
	public void setJndiUrl(final String jndiUrl) {
		this.jndiUrl = jndiUrl;
	}

}
