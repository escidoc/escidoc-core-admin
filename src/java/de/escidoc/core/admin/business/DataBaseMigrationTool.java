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
import java.util.ArrayList;
import java.util.Date;
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
     * Pattern used to escape SQL forbidden characters.
     */
    private static final Pattern PATTERN_SQL_SPECIAL_CHARS =
        Pattern.compile("['´`]");

    /**
     * The logger.
     */
    private static AppLogger log =
        new AppLogger(DataBaseMigrationTool.class.getName());

    private SourceDbReaderInterface reader;

    // CHECKSTYLE:JAVADOC-OFF

    /**
     * See Interface for functional description.
     * 
     * @throws IntegritySystemException
     * @see de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface#migrate()
     */
    public void migrate() throws IntegritySystemException {

        log.info("Migrating data from original database to new database");
        try {
            // Create Database for Workflow Manager
            executeSqlScript("jbpm.create.sql");

            // copy aa data
            executeSqlScript("aa.create.sql");
            migrateActionsAndMethodMappings();
            migrateUserAccounts();
            migrateRolesAndPolicies();
            migrateGrants();
            copyTableData("aa.user_login_data", null);

            // copy om data
            executeSqlScript("om.lockstatus.create.sql");
            copyTableData("om.lockstatus", null);

            // migrate sm data
            executeSqlScript("sm.create.sql");
            copyTableData("sm.scopes", null);
            copyTableData("sm.statistic_data", null);
            copyTableData("sm.aggregation_definitions", null);
            copyTableData("sm.report_definitions", null);
            migrateSmTables();

            // copy st data
            executeSqlScript("st.create.sql");
            copyTableData("st.staging_file", null);

        }
        catch (IOException e) {
            // FIXME: Exception handling
            throw new RuntimeException(e);
        }

    }

    /**
     * Copies data from an original table to the new table without changing
     * them.
     * 
     * @param tableName
     *            The name of the table, including the schema name, e.g.
     *            aa.user_account.
     * @param dropColumns
     *            {@link List} containing the name of the columns that shall be
     *            dropped, i.e. will not be copied. This parameter may be
     *            <code>null</code>.
     */
    private void copyTableData(final String tableName, List<String> dropColumns) {

        if (log.isInfoEnabled()) {
            log.info("Copying data from table " + tableName);
        }
        List<Map<String, Object>> tableData =
            reader.retrieveTableData(tableName);
        insertTableData(tableName, dropColumns, tableData);
    }

    /**
     * Inserts the provided table data into the new table.
     * 
     * @param tableName
     *            The name of the table, including the schema name, e.g.
     *            aa.user_account.
     * @param dropColumns
     *            {@link List} containing the name of the columns that shall be
     *            dropped, i.e. will not be copied. This parameter may be
     *            <code>null</code>.
     * @param tableData
     *            The table data.
     */
    private void insertTableData(
        final String tableName, final List<String> dropColumns,
        final List<Map<String, Object>> tableData) {

        List<String> toBeDropped = dropColumns;
        if (toBeDropped == null) {
            toBeDropped = new ArrayList<String>(0);
        }

        Iterator<Map<String, Object>> iter = tableData.iterator();
        while (iter.hasNext()) {
            Map<String, Object> rowData = iter.next();
            Iterator<String> columnIter = rowData.keySet().iterator();
            StringBuffer cmd = new StringBuffer("INSERT INTO ");
            cmd.append(tableName);
            cmd.append(" VALUES (");
            boolean isNotFirst = false;
            while (columnIter.hasNext()) {
                String name = columnIter.next();
                if (!toBeDropped.contains(name)) {
                    Object value = rowData.get(name);
                    if (isNotFirst) {
                        cmd.append(", ");
                    }
                    if (value instanceof String) {
                        cmd.append("'");
                        cmd.append(PATTERN_SQL_SPECIAL_CHARS.matcher(
                            (String) value).replaceAll("\\\\'"));
                        cmd.append("'");
                    }
                    else if (value instanceof Date
                        || value instanceof java.sql.Date) {
                        cmd.append("'");
                        cmd.append(value);
                        cmd.append("'");
                    }
                    else {
                        cmd.append(value);
                    }
                    isNotFirst = true;
                }
            }
            cmd.append(");");
            executeSqlCommand(cmd.toString());
        }
    }

    /**
     * Migrates the user_account table.
     * 
     * @throws IntegritySystemException
     *             Thrown in case of an integrity error found in the database.
     */
    private void migrateUserAccounts() throws IntegritySystemException {

        log.info("Migrating table user_account");

        if (log.isDebugEnabled()) {
            log
                .debug(StringUtility
                    .concatenateToString("Updating ou information with removing primary ou information"));
        }
        final List<Map<String, Object>> tableData =
            reader.retrieveTableData("aa.user_account");
        // copy data to table user_account without ous column
        List<String> droppedColumns = new ArrayList<String>(1);
        droppedColumns.add("ous");
        insertTableData("aa.user_account", droppedColumns, tableData);

        // copy data to new table user_account_ous
        final Iterator<Map<String, Object>> iter = tableData.iterator();
        while (iter.hasNext()) {
            final Map<String, Object> columnData = iter.next();
            final String ous = (String) columnData.get("ous");

            Matcher matcher = PATTERN_UPDATE_OUS.matcher(ous);
            int matcherIndex = 0;
            int tableIndex = 0;
            // first, search the ou that previously has been marked as the
            // primary one. This ou will be the first one in the new list.
            while (matcher.find(matcherIndex)) {
                final String primaryFlag = matcher.group(2);
                if (primaryFlag != null && primaryFlag.length() > 0) {
                    final String ouId = matcher.group(1);
                    executeSqlCommand(StringUtility.concatenateToString(
                        "INSERT INTO aa.user_account_ous VALUES (",
                        tableIndex++, ", '", columnData.get("id"), "', '",
                        ouId, "');"));
                    matcherIndex = 0;
                    matcher.reset();
                    break;
                }
                matcherIndex = matcher.end();
            }
            // insert other ous
            while (matcher.find(matcherIndex)) {
                final String primaryFlag = matcher.group(2);
                if (primaryFlag == null || primaryFlag.length() == 0) {
                    final String ouId = matcher.group(1);
                    executeSqlCommand(StringUtility.concatenateToString(
                        "INSERT INTO aa.user_account_ous VALUES (",
                        tableIndex++, ", '", columnData.get("id"), "', '",
                        ouId, "');"));
                }
                matcherIndex = matcher.end();
            }

        }
    }

    /**
     * Migrates the role_grant tables.
     * 
     * @throws IntegritySystemException
     *             Thrown in case of an integrity error found in the database.
     */
    private void migrateGrants() {
        log.info("Migrating table role_grant");
        // role title has been removed from table
        final List<String> droppedColumns = new ArrayList<String>(1);
        droppedColumns.add("role_title");

        // FIXME: drop grants for roles that have been removed (
        // use insertTableData after removing the grants form the table data)
        // link to role:workflowmanager was wrong in build.159, escidoc:role6
        // instead of escidoc:role workflowmanager. Needs to be fixed.
        final List<Map<String, Object>> tableData =
            reader.retrieveTableData("aa.role_grant");
        final Iterator<Map<String, Object>> tableIter = tableData.iterator();
        while (tableIter.hasNext()) {
            Map<String, Object> rowData = tableIter.next();
            if ("escidoc:role6".equals(rowData.get("role_id"))) {
                rowData.put("role_id", "escidoc:role-workflow-manager");
            }
        }
        insertTableData("aa.role_grant", droppedColumns, tableData);
    }

    /**
     * Migrates report_definitions table.
     */
    private void migrateSmTables() {

        log.info("Migrating table report_definitions");
        executeSqlCommand(StringUtility
            .concatenateToString(
                "UPDATE sm.report_definitions",
                " SET id=4, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"4\">    <name>Item retrievals, all users</name>  <scope objid=\"2\" />    <sql>       select object_id as itemId, sum(requests) as itemRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieve'' group by object_id;  </sql> </report-definition>',",
                " scope_id=2 WHERE id=4;"));
        executeSqlCommand(StringUtility
            .concatenateToString(
                "UPDATE sm.report_definitions",
                " SET id=5, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"5\">    <name>File downloads per Item, all users</name>  <scope objid=\"2\" />    <sql>       select parent_object_id as itemId, sum(requests)    as fileRequests from _1_object_statistics       where parent_object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' group by parent_object_id; </sql> </report-definition>',",
                " scope_id=2  WHERE id=5;"));
        executeSqlCommand(StringUtility
            .concatenateToString(
                "UPDATE sm.report_definitions",
                " SET id=6, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"6\">    <name>File downloads, all users</name>  <scope objid=\"2\" /> <sql>       select object_id as fileId, sum(requests) as fileRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' group by object_id;   </sql> </report-definition>',",
                " scope_id=2 WHERE id=6;"));
        executeSqlCommand(StringUtility
            .concatenateToString(
                "INSERT INTO sm.report_definitions",
                " (id, xml, scope_id) VALUES (7, '<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"7\">    <name>Item retrievals, anonymous users</name>  <scope objid=\"2\" />  <sql>       select object_id as itemId, sum(requests) as itemRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieve'' and user_id='''' group by object_id; </sql> </report-definition>',",
                " 2);"));
        executeSqlCommand(StringUtility
            .concatenateToString(
                "INSERT INTO sm.report_definitions",
                " (id, xml, scope_id) VALUES (8, '<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"8\">    <name>File downloads per Item, anonymous users</name>  <scope objid=\"2\" />  <sql>       select parent_object_id as itemId, sum(requests)    as fileRequests from _1_object_statistics       where parent_object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' and user_id='''' group by parent_object_id;    </sql> </report-definition>',",
                " 2);"));
        executeSqlCommand(StringUtility
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
        // creator_title and modified_by_title have been dropped from table
        final List<String> toBeDropped = new ArrayList<String>(2);
        toBeDropped.add("creator_title");
        toBeDropped.add("modified_by_title");
        copyTableData("aa.escidoc_role", toBeDropped);

        log.info("Migrating table escidoc_policies");
        try {
            copyTableData("aa.escidoc_policies", null);
            executeSqlScript("aa.update.policies-xml.sql");
        }
        catch (IOException e) {
            // FIXME: Exception handling
            throw new RuntimeException(e);
        }

        copyTableData("aa.scope_def", null);

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
                    executeSqlCommand(StringUtility.concatenateToString(
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

        // action ids have been renamed from ...-content-type to
        // ...-content-model
        // FIXME: changes needed?

        log
            .info("Migrating tables action, method-mappings and invocation_mappings");
        // These tables should not be changed by anyone as action is no
        // resource.
        // Therefore, the tables are initialized from a script.
        try {
            executeSqlScript("aa.init.actions.sql");
            executeSqlScript("aa.init.method-mappings.aa.sql");
            executeSqlScript("aa.init.method-mappings.cmm.sql");
            executeSqlScript("aa.init.method-mappings.om.container.sql");
            executeSqlScript("aa.init.method-mappings.om.context.sql");
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
                executeSqlCommand(cmd.toString());
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
    private void executeSqlCommand(final String command) {

        log.debug(command);
        getJdbcTemplate().execute(command);
    }

    /**
     * Injects the reader of the original database.
     * 
     * @param reader
     *            the reader to inject.
     */
    public void setReader(final SourceDbReaderInterface reader) {
        this.reader = reader;
    }
}
