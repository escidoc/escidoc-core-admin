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
 */package de.escidoc.core.admin.business.interfaces;

import java.util.Vector;

import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;

public interface ReindexerInterface {

    /**
     * Close Connection to SB-Indexing-Queue.
     * 
     * @admin
     */
    void close();

    /**
     * Get all released Items from OM and put hrefs into Vector.
     * 
     * @return Vector<String> item-hrefs
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    Vector<String> getReleasedItems()
        throws ApplicationServerSystemException;

    /**
     * Get all released Containers from OM and put hrefs into Vector.
     * 
     * @return Vector<String> container-hrefs
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    Vector<String> getReleasedContainers()
        throws ApplicationServerSystemException;

    /**
     * retrieve resource.
     * 
     * @param resource String resourceIdentifier
     * @return String resource as xml.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    String retrieveResource(final String resource)
        throws ApplicationServerSystemException;

    /**
     * get object from FedoraManagementDeviationHandler.
     * 
     * @param resource String resourceIdentifier
     * @return Object resource as xml.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    Object fedoraExport(
			final String resource)
	throws ApplicationServerSystemException;
	
    /**
     * get fulltext from FedoraAccessDeviationHandler.
     * 
     * @param resource String resourceIdentifier
     * @return Object resource as Object.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    Object fedoraGetDatastreamDissemination(
			final String resource)
	throws ApplicationServerSystemException;
	
	/**
     * Send delete-index Message to SB.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    void sendDeleteIndexMessage()
        throws ApplicationServerSystemException;

    /**
     * Send update-index Message to SB.
     * 
     * @param resource
     *            String resource.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    void sendUpdateIndexMessage(final String resource)
        throws ApplicationServerSystemException;

}
