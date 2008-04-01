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

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.jdbc.core.support.JdbcDaoSupport;

import de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.string.StringUtility;

/**
 * @author TTE
 * 
 * @spring.bean id="de.escidoc.core.admin.DataBaseMigrationTool"
 * 
 */
public class DataBaseMigrationTool extends JdbcDaoSupport
    implements DataBaseMigrationInterface {

    /**
     * The (default) bean id.
     */
    public static final String BEAN_ID =
        "de.escidoc.core.admin.DataBaseMigrationTool";

    /**
     * Pattern used to change content-type actions to content-model.
     */
    private static final Pattern PATTERN_UPDATE_CMM_ACTIONS =
        Pattern
            .compile("(info:escidoc/names:aa:1.0:action:([^-]+)-content-)type");

    /**
     * Pattern used to convert content of old ous field to new ou fields with
     * removing primary ou information (see issue 433).
     * 
     * @see http://www.escidoc-project.de/issueManagement/show_bug.cgi?id=443
     */
    private static final Pattern PATTERN_UPDATE_OUS =
        Pattern.compile("[^|]+\\|([^|]+)\\|([p]?)\\|");

    /**
     * The logger.
     */
    private static AppLogger log =
        new AppLogger(DataBaseMigrationTool.class.getName());

    // CHECKSTYLE:JAVADOC-OFF

    /**
     * See Interface for functional description.
     * 
     * @throws IntegritySystemException
     * @see de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface#migrate()
     */
    public void migrate() throws IntegritySystemException {

        log.info("Adding table unsecured_actions");
        executedSqlCommand(StringUtility.concatenateToString(
            "CREATE TABLE aa.unsecured_action_list (",
            "id VARCHAR(255) NOT NULL, context_id VARCHAR(255) NOT NULL,",
            "action_ids TEXT NOT NULL, primary key (id) );"));

        migrateActionsAndMethodMappings();
        migrateRolesAndPolicies();
        migrateUserAccountsAndGrants();
        migrateSmTables();
    }

    /**
     * Migrates the role_grant and user_account tables.
     * 
     * @throws IntegritySystemException
     *             Thrown in case of an integrity error found in the database.
     */
    private void migrateUserAccountsAndGrants() throws IntegritySystemException {

        log.info("Migrating table role_grant");
        // there was an error in the database setup, in role_grants the id
        // escidoc:role6 was used for the work flow manager
        executedSqlCommand(StringUtility.concatenateToString(
            "UPDATE aa.role_grant",
            " SET role_id = 'escidoc:role-workflow-manager'",
            " WHERE role_id = 'escidoc:role6'"));
        // new foreign key has been added
        executedSqlCommand(StringUtility.concatenateToString(
            "ALTER TABLE aa.role_grant",
            " ADD CONSTRAINT FK_ROLE_GRANT FOREIGN KEY (role_id)",
            " REFERENCES aa.escidoc_role"));
        // roleTitle has been removed from table
        executedSqlCommand("ALTER TABLE aa.role_grant DROP COLUMN role_title;");

        log.info("Migrating table user_account");

        if (log.isDebugEnabled()) {
            log
                .debug(StringUtility
                    .concatenateToString("Updating content of ous with removing primary ou information"));
        }
        final List<Map<String, Object>> results =
            getJdbcTemplate().queryForList(
                "select id, ous from aa.user_account");
        final Iterator<Map<String, Object>> iter = results.iterator();
        while (iter.hasNext()) {
            final Map<String, Object> result = iter.next();

            final String id = (String) result.get("id");
            final String ous = (String) result.get("ous");

            Matcher matcher = PATTERN_UPDATE_OUS.matcher(ous);
            int index = 0;
            final StringBuffer newOus = new StringBuffer();
            while (matcher.find(index)) {
                final String ouId = matcher.group(1);
                newOus.append(ouId);
                newOus.append("|||");
                index = matcher.end();
            }
            if (newOus.length() == 0) {
                throw new IntegritySystemException(StringUtility
                    .concatenateWithBracketsToString(
                        "Unexpected content in ous", id, ous));
            }

            executedSqlCommand(StringUtility.concatenateToString(
                "UPDATE aa.user_account SET ous = '", newOus, "' WHERE id = '",
                id, "';"));
        }
    }

    /**
     * Migrates report_definitiona table.
     */
    private void migrateSmTables() {

        log.info("Migrating table report_definitions");
        executedSqlCommand(StringUtility
            .concatenateToString(
                "UPDATE sm.report_definitions",
                " SET id=4, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"4\">    <name>Item retrievals, all users</name>  <scope objid=\"2\" />    <sql>       select object_id as itemId, sum(requests) as itemRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieve'' group by object_id;  </sql> </report-definition>',",
                " scope_id=2 WHERE id=4;"));
        executedSqlCommand(StringUtility
            .concatenateToString(
                "UPDATE sm.report_definitions",
                " SET id=5, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"5\">    <name>File downloads per Item, all users</name>  <scope objid=\"2\" />    <sql>       select parent_object_id as itemId, sum(requests)    as fileRequests from _1_object_statistics       where parent_object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' group by parent_object_id; </sql> </report-definition>',",
                " scope_id=2  WHERE id=5;"));
        executedSqlCommand(StringUtility
            .concatenateToString(
                "UPDATE sm.report_definitions",
                " SET id=6, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"6\">    <name>File downloads, all users</name>  <scope objid=\"2\" /> <sql>       select object_id as fileId, sum(requests) as fileRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' group by object_id;   </sql> </report-definition>',",
                " scope_id=2 WHERE id=6;"));
        executedSqlCommand(StringUtility
            .concatenateToString(
                "INSERT INTO sm.report_definitions",
                " (id, xml, scope_id) VALUES (7, '<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"7\">    <name>Item retrievals, anonymous users</name>  <scope objid=\"2\" />  <sql>       select object_id as itemId, sum(requests) as itemRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieve'' and user_id='''' group by object_id; </sql> </report-definition>',",
                " 2);"));
        executedSqlCommand(StringUtility
            .concatenateToString(
                "INSERT INTO sm.report_definitions",
                " (id, xml, scope_id) VALUES (8, '<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"8\">    <name>File downloads per Item, anonymous users</name>  <scope objid=\"2\" />  <sql>       select parent_object_id as itemId, sum(requests)    as fileRequests from _1_object_statistics       where parent_object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' and user_id='''' group by parent_object_id;    </sql> </report-definition>',",
                " 2);"));
        executedSqlCommand(StringUtility
            .concatenateToString(
                "INSERT INTO sm.report_definitions",
                " (id, xml, scope_id) VALUES (9, '<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"9\">    <name>File downloads, anonymous users</name>  <scope objid=\"2\" />   <sql>       select object_id as fileId, sum(requests) as fileRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' and user_id='''' group by object_id;  </sql> </report-definition>',",
                " 2);"));
    }

    /**
     * Drops policy_Actions table, migrates escidoc_role and escidoc_policies
     * tables.
     */
    private void migrateRolesAndPolicies() {

        log.info("Migrating table escidoc_role");
        executedSqlCommand(StringUtility.concatenateToString(
            "ALTER TABLE aa.escidoc_role", " DROP COLUMN creator_title"));
        executedSqlCommand(StringUtility.concatenateToString(
            "ALTER TABLE aa.escidoc_role", " DROP COLUMN modified_by_title"));
        executedSqlCommand(StringUtility.concatenateToString(
            "ALTER TABLE aa.escidoc_role",
            " ADD CONSTRAINT FK_ROLE_CREATED_BY FOREIGN KEY (creator_id)",
            " REFERENCES aa.user_account"));
        executedSqlCommand(StringUtility.concatenateToString(
            "ALTER TABLE aa.escidoc_role",
            " ADD CONSTRAINT FK_ROLE_MODIFIED_BY FOREIGN KEY (modified_by_id)",
            " REFERENCES aa.user_account"));

        log.info("Migrating table escidoc_policies");
        try {
            executeSqlScript("aa.update.policies-xml.sql");
        }
        catch (IOException e) {
            // FIXME: Exception handling
            throw new RuntimeException(e);
        }
        // some attributes have been renamed, xml of policies have to be changed
        // FIXME: action ids have been changed, too.
        final List<Map<String, Object>> policiesData =
            getJdbcTemplate().queryForList(
                "select id, xml from aa.escidoc_policies");
        final Iterator<Map<String, Object>> policiesIter =
            policiesData.iterator();
        while (policiesIter.hasNext()) {
            final Map<String, Object> policyData = policiesIter.next();
            final String id = (String) policyData.get("id");
            final String xml = (String) policyData.get("xml");
            if (xml != null) {
                String newXml = xml;
                final Matcher matcher2 =
                    PATTERN_UPDATE_CMM_ACTIONS.matcher(newXml);
                if (matcher2.groupCount() > 0) {
                    newXml = matcher2.replaceAll("$1model");
                    executedSqlCommand(StringUtility.concatenateToString(
                        "UPDATE aa.escidoc_policies SET xml = '", newXml,
                        "' WHERE id = '", id, "';"));
                }
            }
        }
    }

    /**
     * Migrates the actions, method_mappings and invocation_mappings tables.
     */
    private void migrateActionsAndMethodMappings() {

        log.info("Dropping table policy_actions");
        executedSqlCommand("DROP TABLE aa.policy_actions;");

        log.info("Migrating table action");
        // action ids have been renamed from ...-content-type to
        // ...-content-model
        // FIXME: changes needed?

        executedSqlCommand("DROP TABLE aa.actions;");
        executedSqlCommand(StringUtility.concatenateToString(
            "CREATE TABLE aa.actions ( id VARCHAR(255) NOT NULL,",
            "name VARCHAR(255) NOT NULL,",
            "CONSTRAINT actions_pkey PRIMARY KEY(id)) WITH OIDS;"));
        try {
            executeSqlScript("aa.init.actions.sql");
        }
        catch (IOException e) {
            // FIXME: Exception handling
            throw new RuntimeException(e);
        }

        log.info("Migrating tables method-mappings and invocation_mappings");
        // These tables should not be changed by anyone as action is no
        // resource.
        // Therefore, the tables are dropped and new created and initialized.
        executedSqlCommand("DROP TABLE aa.invocation_mappings;");
        executedSqlCommand("DROP TABLE aa.method_mappings;");
        executedSqlCommand(StringUtility.concatenateToString(
            "CREATE TABLE aa.method_mappings (", "id VARCHAR(255) NOT NULL,",
            "class_name VARCHAR(255) NOT NULL,",
            "method_name VARCHAR(255) NOT NULL,",
            "action_name VARCHAR(255) NOT NULL,", "before BOOLEAN NOT NULL,",
            "single_resource BOOLEAN NOT NULL,",
            "resource_not_found_exception TEXT,",
            "CONSTRAINT method_mappings_pkey PRIMARY KEY(id)) WITH OIDS;", "",
            "CREATE TABLE aa.invocation_mappings (",
            "id VARCHAR(255) NOT NULL,", "attribute_id TEXT NOT NULL,",
            "path VARCHAR(100) NOT NULL,", "position NUMERIC(2,0) NOT NULL,",
            "attribute_type VARCHAR(255) NOT NULL,",
            "mapping_type NUMERIC(2,0) NOT NULL,",
            "multi_value boolean NOT NULL,", "value VARCHAR(100) NULL,",
            "method_mapping VARCHAR(255) NULL,",
            "CONSTRAINT invocation_mappings_pkey PRIMARY KEY(id),",
            "CONSTRAINT invocation_mappings_fkey FOREIGN KEY",
            " (method_mapping) REFERENCES aa.method_mappings) WITH OIDS;"));

        try {
            executeSqlScript("aa.init.method-mappings.aa.sql");
            executeSqlScript("aa.init.method-mappings.cmm.sql");
            executeSqlScript("aa.init.method-mappings.om.container.sql");
            executeSqlScript("aa.init.method-mappings.om.context.sql");
            executeSqlScript("aa.init.method-mappings.om.indexer.sql");
            executeSqlScript("aa.init.method-mappings.om.item.sql");
            executeSqlScript("aa.init.method-mappings.om.semantic-store.sql");
            executeSqlScript("aa.init.method-mappings.oum.sql");
            executeSqlScript("aa.init.method-mappings.sb.sql");
            executeSqlScript("aa.init.method-mappings.sm.sql");
            executeSqlScript("aa.init.method-mappings.st.sql");
            executeSqlScript("aa.init.method-mappings.wm.sql");
        }
        catch (IOException e) {
            // FIXME: Exception handling
            throw new RuntimeException(e);
        }
    }

    // CHECKSTYLE:JAVADOC-ON

    /**
     * Executed the specified SQL script.
     * 
     * @param scriptName
     *            The name of the SQL script.
     * @throws IOException
     *             Thrown if data could not be read from SQL script.
     */
    private void executeSqlScript(final String scriptName) throws IOException {

        InputStream resource =
            getClass().getClassLoader().getResourceAsStream(scriptName);
        if (resource == null) {
            throw new IOException(StringUtility
                .concatenateWithBracketsToString("Resource not found",
                    scriptName));
        }
        int c = resource.read();
        StringBuffer cmd = new StringBuffer();
        while (c != -1) {
            cmd.append((char) c);
            if (c == ';') {
                executedSqlCommand(cmd.toString());
                cmd = new StringBuffer();
            }
            c = resource.read();
        }
    }

    /**
     * Executes the given SQL command.
     * 
     * @param command
     *            The command to execute.
     */
    private void executedSqlCommand(final String command) {

        log.debug(command);
        getJdbcTemplate().execute(command);
    }
}
