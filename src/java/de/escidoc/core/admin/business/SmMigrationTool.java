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
 * Copyright 2006-2009 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.business;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import de.escidoc.core.admin.business.interfaces.SmMigrationInterface;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;
import de.escidoc.core.common.util.logger.AppLogger;

/**
 * Provides a method used for migrating the database to the most current
 * version.
 * 
 * @author MIH
 * 
 * @spring.bean id="de.escidoc.core.admin.SmMigrationTool"
 * 
 */
public class SmMigrationTool extends DbDao
    implements SmMigrationInterface {
    /**
     * The logger.
     */
    private static AppLogger log =
        new AppLogger(SmMigrationTool.class.getName());

    /**
     * Database settings.
     */
    private final String driverClassName;

    private final String url;

    private final String username;

    private final String password;

    private final String scriptPrefix;

    /**
     * Construct a new DataBaseMigrationTool object.
     * 
     * @param driverClassName
     *            name of the JDBC driver
     * @param url
     *            JDBCL URL
     * @param username
     *            name of the database user
     * @param password
     *            password of the database user
     * @param scriptPrefix
     *            prefix for database script names (mainly for MySQL)
     */
    public SmMigrationTool(final String driverClassName,
        final String url, final String username, final String password,
        final String scriptPrefix) {
        this.driverClassName = driverClassName;
        this.url = url;
        this.username = username;
        this.password = password;
        this.scriptPrefix = scriptPrefix;
    }

    /**
     * See Interface for functional description.
     * 
     * @throws IntegritySystemException
     *             Thrown in case the content of the database is not as
     *             expected.
     * @see de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface#migrate()
     */
    public void migrate() throws IntegritySystemException {
        List result = getJdbcTemplate().queryForList(
                    "select * from sm.aggregation_definitions_old;");
        for (Iterator iter = result.iterator(); iter.hasNext();) {
            Map map = (Map) iter.next();
            String xml = (String)map.get("xml_data");
        }
        System.out.println("OK");
    }
    
    /**
     * Injects the data source.
     * 
     * @spring.property ref="escidoc-core.DataSource"
     * @param myDataSource
     *            data source from Spring
     */
    public final void setMyDataSource(final DataSource myDataSource) {
        super.setDataSource(myDataSource);
    }

}
