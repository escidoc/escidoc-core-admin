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

import de.escidoc.core.common.exceptions.system.IntegritySystemException;

/**
 * Performs changes in the framework-internal database, schema sm.
 * 
 * @author MIH 
 */
public interface SmMigrationInterface {

    /**
     * Migrates the SM Tables<br>
     * @throws IntegritySystemException
     *             Thrown in case the content of the database is not as
     *             expected.
     */
    void migrate()
        throws IntegritySystemException;
}
