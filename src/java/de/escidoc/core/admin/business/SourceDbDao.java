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
package de.escidoc.core.admin.business;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.BeanInitializationException;

import de.escidoc.core.admin.business.interfaces.SourceDbDaoInterface;

/**
 * This class encapsulates the reading operations on the original (source)
 * database.
 * 
 * @spring.bean id="de.escidoc.core.admin.SourceDbDao"
 * @author TTE
 * 
 */
public class SourceDbDao extends DbDao implements SourceDbDaoInterface {

    // CHECKSTYLE:JAVADOC-OFF
    /**
     * See Interface for functional description.
     * 
     * @param tableName
     * @return
     * @see de.escidoc.core.admin.business.interfaces.SourceDbDaoInterface#retrieveTableData(java.lang.String,
     *      String, int, int)
     */
    public List<Map<String, Object>> retrieveTableData(
        final String tableName, final String whereClause, final int offset,
        final int limit) {

        final StringBuffer cmd = new StringBuffer("select * from ");
        cmd.append(tableName);
        if (whereClause != null) {
            cmd.append(" ");
            cmd.append(whereClause);
        }
        cmd.append(" OFFSET ");
        cmd.append(offset);
        cmd.append(" LIMIT ");
        cmd.append(limit);
        cmd.append(";");
        return getJdbcTemplate().queryForList(cmd.toString());
    }

    /**
     * See Interface for functional description.
     * 
     * @see org.springframework.jdbc.core.support.JdbcDaoSupport#checkDaoConfig()
     */
    @Override
    protected void checkDaoConfig() {

        super.checkDaoConfig();
        if (getUrl() == null || getUrl().length() == 0) {
            throw new BeanInitializationException(
                "Database URL must not be null or empty.");
        }

    }

    // CHECKSTYLE:JAVADOC-ON
}
