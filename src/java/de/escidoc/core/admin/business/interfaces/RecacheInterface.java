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
package de.escidoc.core.admin.business.interfaces;

import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;

import java.io.IOException;
import java.text.ParseException;

/**
 * Interface definition of the recaching service.
 * 
 * @author SCHE
 */
public interface RecacheInterface {

    /**
     * Clear all resources from cache.
     */
    void clearCache();

    /**
     * Store all available resources in the database cache.
     * 
     * @throws ApplicationServerSystemException Thrown if eSciDoc failed to receive a resource.
     * @throws IOException Thrown if an I/O error occurred.
     * @throws ParseException The given string cannot be parsed.
     */
    void storeResources()
        throws ApplicationServerSystemException, IOException, ParseException;
}
