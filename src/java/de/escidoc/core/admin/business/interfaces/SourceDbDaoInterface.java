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

import java.util.List;
import java.util.Map;

/**
 * Interface providing read access to tables of the source database, i.e. the
 * database that shall be migrated.
 * 
 * @author TTE
 * 
 */
public interface SourceDbDaoInterface extends DbDaoInterface {

    /**
     * Gets the content of the specified table.
     * 
     * @param tableName
     *            The name of the table including the schema name, e.g.
     *            aa.user_account.
     * @param whereClause
     *            Optional where clause to restrict the result, e.g. 'where id <>
     *            someid'
     * @param offset
     *            The offset.
     * @param limit
     *            The limit (max number of results).
     * @return Returns the values of a table.
     */
    public List<Map<String, Object>> retrieveTableData(
        final String tableName, String whereClause, int offset, int limit);
}