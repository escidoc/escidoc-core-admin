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

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.Target;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import de.escidoc.core.admin.business.interfaces.AaMigrationInterface;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;

/**
 * Provides a method used for migrating the database to the most current
 * version.
 * 
 * @author MIH
 * 
 * @spring.bean id="de.escidoc.core.admin.AaMigrationTool"
 * 
 */
public class AaMigrationTool extends DbDao implements AaMigrationInterface {
    /**
     * The logger.
     */
    private static Logger log = LoggerFactory.getLogger(AaMigrationTool.class);

    /**
     * Database settings.
     */
    private final String driverClassName;

    private final String url;

    private final String username;

    private final String password;

    private final String scriptPrefix;

    private final String creatorId;

    /**
     * Attributes needed to call an Ant target.
     */
    private Project project = new Project();

    private Target target = new Target();

    /**
     * Queries.
     */
    private final String ID_CONTEXT_ADMIN =
        "escidoc:role-context-administrator";

    private final String ID_CONTEXT_MODIFIER = "escidoc:role-context-modifier";

    private final String ID_USER_ACCOUNT_ADMIN =
        "escidoc:role-user-account-administrator";

    private final String ID_USER_ACCOUNT_INSPECTOR =
        "escidoc:role-user-account-inspector";

    private final String QUERY_ROLES = "select id from aa.escidoc_role where "
        + "id = '" + ID_CONTEXT_ADMIN + "' " + "or id = '"
        + ID_CONTEXT_MODIFIER + "' " + "or id = '" + ID_USER_ACCOUNT_ADMIN
        + "' " + "or id = '" + ID_USER_ACCOUNT_INSPECTOR + "';";

    private final String UPDATE_ROLES_CONTEXT_ADMIN =
        "INSERT INTO aa.escidoc_role "
            + "(id, role_name, description, creator_id, creation_date, modified_by_id, last_modification_date) "
            + "VALUES "
            + "('escidoc:role-context-administrator', 'Context-Administrator', NULL, 'escidoc:exuser1', "
            + "CURRENT_TIMESTAMP, 'escidoc:exuser1', CURRENT_TIMESTAMP);";

    private final String UPDATE_ROLES_CONTEXT_MODIFIER =
        "INSERT INTO aa.escidoc_role "
            + "(id, role_name, description, creator_id, creation_date, modified_by_id, last_modification_date) "
            + "VALUES ('escidoc:role-context-modifier', 'Context-Modifier', NULL, 'escidoc:exuser1', "
            + "CURRENT_TIMESTAMP, 'escidoc:exuser1', CURRENT_TIMESTAMP);";

    private final String UPDATE_ROLES_USER_ACCOUNT_ADMIN =
        "INSERT INTO aa.escidoc_role "
            + "(id, role_name, description, creator_id, creation_date, modified_by_id, last_modification_date) "
            + "VALUES ('escidoc:role-user-account-administrator', 'User-Account-Administrator', NULL, 'escidoc:exuser1', "
            + "CURRENT_TIMESTAMP, 'escidoc:exuser1', CURRENT_TIMESTAMP);";

    private final String UPDATE_ROLES_USER_ACCOUNT_INSPECTOR =
        "INSERT INTO aa.escidoc_role "
            + "(id, role_name, description, creator_id, creation_date, modified_by_id, last_modification_date) "
            + "VALUES "
            + "('escidoc:role-user-account-inspector', 'User-Account-Inspector', NULL, 'escidoc:exuser1', "
            + "CURRENT_TIMESTAMP, 'escidoc:exuser1', CURRENT_TIMESTAMP);";

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
    public AaMigrationTool(final String driverClassName, final String url,
        final String username, final String password,
        final String scriptPrefix, final String creatorId) {
        this.driverClassName = driverClassName;
        this.url = url;
        this.username = username;
        this.password = password;
        this.scriptPrefix = scriptPrefix;
        this.creatorId = creatorId;
        project.init();
        target.setProject(project);
    }

    /**
     * See Interface for functional description.
     * 
     * @throws IntegritySystemException
     *             Thrown in case the content of the database is not as
     *             expected.
     * @see de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface#migrate()
     */
    public void migrate() throws ApplicationServerSystemException {
        handleRoles();
    }

    private void handleRoles() throws ApplicationServerSystemException {
        try {
            HashMap<String, String> roles = new HashMap<String, String>();
            roles.put(ID_CONTEXT_MODIFIER, UPDATE_ROLES_CONTEXT_MODIFIER);
            roles.put(ID_CONTEXT_ADMIN, UPDATE_ROLES_CONTEXT_ADMIN);
            roles.put(ID_USER_ACCOUNT_ADMIN, UPDATE_ROLES_USER_ACCOUNT_ADMIN);
            roles.put(ID_USER_ACCOUNT_INSPECTOR,
                UPDATE_ROLES_USER_ACCOUNT_INSPECTOR);
            List result = getJdbcTemplate().queryForList(QUERY_ROLES);
            if (result != null) {
                for (Iterator iter = result.iterator(); iter.hasNext();) {
                    Map map = (Map) iter.next();
                    String id = (String) map.get("id");
                    roles.remove(id);
                }
            }
            for (String roleSql : roles.values()) {
                getJdbcTemplate().update(roleSql);
            }
        }
        catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new ApplicationServerSystemException(e);
        }
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
