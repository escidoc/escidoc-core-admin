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

import de.escidoc.core.common.exceptions.system.SystemException;

public interface ReindexerInterface {

    /**
     * Clear all resources from index.
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    void clearIndex() throws SystemException;

    /**
     * Index all Containers.
     * 
     * @return number of Containers
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    int indexContainers() throws SystemException;

    /**
     * Index all Content Models.
     * 
     * @return number of Content Models
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    int indexContentModels() throws SystemException;

    /**
     * Index all Content Relations.
     * 
     * @return number of Content Relations
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    int indexContentRelations() throws SystemException;

    /**
     * Index all Contexts.
     * 
     * @return number of Contexts
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    int indexContexts() throws SystemException;

    /**
     * Index all Items.
     * 
     * @return number of Items
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    int indexItems() throws SystemException;

    /**
     * Index all Organizational Units.
     * 
     * @return number of Organizational Units
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    int indexOrganizationalUnits() throws SystemException;
}
