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
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface;
import de.escidoc.core.admin.business.interfaces.SourceDbDaoInterface;
import de.escidoc.core.admin.business.interfaces.TargetDbDaoInterface;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.string.StringUtility;

/**
 * @author TTE
 * 
 * @spring.bean id="de.escidoc.core.admin.DataBaseMigrationTool"
 * 
 */
public class DataBaseMigrationTool implements DataBaseMigrationInterface {

    /**
     * Chunk size for copy operations on database table data.
     */
    private static final int LIMIT = 1000;

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
     * Pattern used to convert content of old ous/affiliation column to new
     * table user_account_ous with removing primary ou information (see issue
     * 443).
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

    /**
     * The DAO to access the source DB.
     */
    private SourceDbDaoInterface source;

    /**
     * The DAO to access the target DB.
     */
    private TargetDbDaoInterface target;

    /**
     * Flag indicating if tests shall be skipped.
     */
    private boolean skipTests = false;

    // CHECKSTYLE:JAVADOC-OFF

    /**
     * See Interface for functional description.
     * 
     * @throws IntegritySystemException
     * @see de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface#migrate()
     */
    public void migrate() throws IntegritySystemException {

        log.info("Migrating data from original database schema");
        log.info("to new database schema:");
        log.info(source.getUrl());
        log.info(" --> ");
        log.info(target.getUrl());
        if (source.getUrl().equals(target.getUrl())) {
            throw new RuntimeException(
                "Source and Target DB must not be the same.");
        }

        try {
            // Here it is assumed the new database has been
            // created using the old one as a template
            // e.g. CREATE DATABASE "escidoc-core" WITH TEMPLATE = escidoc;

            // migrate sm data
            // The sm schema is kept to keep the aggregation data tables.
            // changes of the db schema are changed per ALTER commands etc.
            migrateSmTables();

            // for all other schemas, the schemas may have been changed and will
            // be recreated using the new create scripts, after they have been
            // dropped, here.

            // Create Database for Workflow Manager
            target.dropSchema("jbpm");
            target.executeCreateScript("jbpm");

            // copy aa data
            target.dropSchema("aa");
            target.executeCreateScript("aa");
            migrateActionsAndMethodMappings();
            migrateUserAccounts();
            migrateRolesAndPolicies();
            migrateGrants();

            // copy om data
            target.dropSchema("om");
            target.executeCreateScript("om");
            copyTableData("om.lockstatus");

            // create object cache data
            target.executeCreateScript("list");
            target.executeSqlScript("list.init.rules.sql");

            // st schema has not been changed since 159, can be left as
            // copied from the source database

        }
        catch (IOException e) {
            // FIXME: Exception handling
            throw new RuntimeException(e);
        }

        selfTest();

    }

    /**
     * Copies data from an original table to the new table without changing the
     * tables.
     * 
     * @param tableName
     *            The name of the table, including the schema name, e.g.
     *            aa.user_account.
     */
    private void copyTableData(final String tableName) {

        copyTableData(tableName, null, null);
    }

    /**
     * Copies data from an original table to the new table without changing the
     * data.<br>
     * The operation is performed in chunks of size defined by the constant
     * value LIMIT.
     * 
     * @param tableName
     *            The name of the table, including the schema name, e.g.
     *            aa.user_account.
     * @param dropColumns
     *            {@link List} containing the name of the columns that shall be
     *            dropped, i.e. will not be copied. This parameter may be
     *            <code>null</code>.
     * @param whereClause
     *            Optional where clause to restrict the rows that shall be
     *            copied, e.g. 'where id <> someid'
     */
    private void copyTableData(
        final String tableName, final List<String> dropColumns,
        final String whereClause) {

        if (log.isInfoEnabled()) {
            log
                .info(StringUtility.concatenateWithBracketsToString(
                    "Copying data from table", tableName, dropColumns,
                    whereClause));
        }
        int offset = 0;
        // get first chunk
        List<Map<String, Object>> tableData =
            source.retrieveTableData(tableName, whereClause, offset, LIMIT);
        while (tableData != null && tableData.size() > 0) {
            // copy current chunk
            target.insertTableData(tableName, dropColumns, tableData);

            // get next chunk
            offset += tableData.size();
            tableData =
                source.retrieveTableData(tableName, whereClause, offset, LIMIT);
        }
    }

    /**
     * Migrates the user_account and login_data tables.
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
        // copy data to table user_account without ous/affiliations columns and
        // removed users
        List<String> droppedColumns = new ArrayList<String>(1);
        // migrate build 159 to build 0.9.2.421:the ous column is replaced by
        // the
        // new table
        droppedColumns.add("ous");
        // migrate build 0.9.1.x to build 0.9.2.421: the affiliations and
        // primary affiliation columns are replaced by the new table
        droppedColumns.add("affiliations");
        droppedColumns.add("primary-affiliation");

        // get first chunk
        int offset = 0;
        final String userAccountTableName = "aa.user_account";
        // indexer have been removed, but maybe they are referenced in existing
        // data, therefore they are not removed here.
        final String userAccountWhereClause = null;
        List<Map<String, Object>> tableData =
            source.retrieveTableData(userAccountTableName,
                userAccountWhereClause, offset, LIMIT);
        while (tableData != null && tableData.size() > 0) {

            target.insertTableData(userAccountTableName, droppedColumns,
                tableData);

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
                String primaryOuId = null;
                if (ous != null) {
                    // migrate from build 0159
                    while (matcher.find(matcherIndex)) {
                        final String primaryFlag = matcher.group(2);
                        if (primaryFlag != null && primaryFlag.length() > 0) {
                            primaryOuId = matcher.group(1);
                            target.executeSqlCommand(StringUtility
                                .concatenateToString(
                                    "INSERT INTO aa.user_account_ous VALUES (",
                                    tableIndex++, ", '", columnData.get("id"),
                                    "', '", primaryOuId, "');"));
                            break;
                        }
                        matcherIndex = matcher.end();
                    }
                }
                else {
                    // migrate from 0.9.1.x
                    primaryOuId =
                        (String) columnData.get("primary_affiliation");
                    if (primaryOuId != null) {
                        target.executeSqlCommand(StringUtility
                            .concatenateToString(
                                "INSERT INTO aa.user_account_ous VALUES (",
                                tableIndex++, ", '", columnData.get("id"),
                                "', '", primaryOuId, "');"));
                    }
                }

                // insert other ous
                matcherIndex = 0;
                matcher = PATTERN_UPDATE_OUS.matcher(ous);
                while (matcher.find(matcherIndex)) {
                    final String ouId = matcher.group(1);
                    if (!ouId.equals(primaryOuId)) {
                        target.executeSqlCommand(StringUtility
                            .concatenateToString(
                                "INSERT INTO aa.user_account_ous VALUES (",
                                tableIndex++, ", '", columnData.get("id"),
                                "', '", ouId, "');"));
                    }
                    matcherIndex = matcher.end();
                }

            }

            // get next chunk
            offset += tableData.size();
            tableData =
                source.retrieveTableData(userAccountTableName,
                    userAccountWhereClause, offset, LIMIT);
        }

        copyTableData("aa.user_login_data", null,
            "WHERE user_id<>'escidoc:user43' AND user_id<>'escidoc:exuser3'");
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

        // drop grants for roles (and users) that have been removed (
        // use insertTableData after removing the grants form the table data)
        // link to role:workflowmanager was wrong in build.159, escidoc:role6
        // instead of escidoc:role workflowmanager. Needs to be fixed.
        final String roleGrantTableName = "aa.role_grant";
        final String roleGrantWhereClause =
            "WHERE role_id <>'escidoc:role-indexer'";
        // get first chunk
        int offset = 0;
        List<Map<String, Object>> tableData =
            source.retrieveTableData(roleGrantTableName, roleGrantWhereClause,
                offset, LIMIT);
        while (tableData != null && tableData.size() > 0) {
            final Iterator<Map<String, Object>> tableIter =
                tableData.iterator();
            while (tableIter.hasNext()) {
                Map<String, Object> rowData = tableIter.next();
                final Object roleId = rowData.get("role_id");
                if ("escidoc:role6".equals(roleId)) {
                    rowData.put("role_id", "escidoc:role-workflow-manager");
                }
            }
            target.insertTableData(roleGrantTableName, droppedColumns,
                tableData);

            // get next chunk
            offset += tableData.size();
            tableData =
                source.retrieveTableData(roleGrantTableName,
                    roleGrantWhereClause, offset, LIMIT);
        }
    }

    /**
     * Migrates report_definitions table.
     */
    private void migrateSmTables() {

        log.info("Migrating sm tables");
        target
            .executeSqlCommand(StringUtility
                .concatenateToString(
                    "UPDATE sm.report_definitions",
                    " SET id=4, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"4\">    <name>Item retrievals, all users</name>  <scope objid=\"2\" />    <sql>       select object_id as itemId, sum(requests) as itemRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieve'' group by object_id;  </sql> </report-definition>',",
                    " scope_id=2 WHERE id=4;"));
        target
            .executeSqlCommand(StringUtility
                .concatenateToString(
                    "UPDATE sm.report_definitions",
                    " SET id=5, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"5\">    <name>File downloads per Item, all users</name>  <scope objid=\"2\" />    <sql>       select parent_object_id as itemId, sum(requests)    as fileRequests from _1_object_statistics       where parent_object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' group by parent_object_id; </sql> </report-definition>',",
                    " scope_id=2  WHERE id=5;"));
        target
            .executeSqlCommand(StringUtility
                .concatenateToString(
                    "UPDATE sm.report_definitions",
                    " SET id=6, xml='<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"6\">    <name>File downloads, all users</name>  <scope objid=\"2\" /> <sql>       select object_id as fileId, sum(requests) as fileRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' group by object_id;   </sql> </report-definition>',",
                    " scope_id=2 WHERE id=6;"));

        final Object id = target.getMaxOfColumn("sm.report_definitions", "id");
        int nextReportDefinitionId = ((Integer) id).intValue() + 1;

        if (log.isDebugEnabled()) {
            log.debug(StringUtility.concatenateWithBrackets(
                "Determined next available report definition id",
                nextReportDefinitionId));
        }

        target
            .executeSqlCommand(StringUtility
                .concatenateToString(
                    "INSERT INTO sm.report_definitions",
                    " (id, xml, scope_id) VALUES (",
                    nextReportDefinitionId++,
                    ", '<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"7\">    <name>Item retrievals, anonymous users</name>  <scope objid=\"2\" />  <sql>       select object_id as itemId, sum(requests) as itemRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieve'' and user_id='''' group by object_id; </sql> </report-definition>',",
                    " 2);"));
        target
            .executeSqlCommand(StringUtility
                .concatenateToString(
                    "INSERT INTO sm.report_definitions",
                    " (id, xml, scope_id) VALUES (",
                    nextReportDefinitionId++,
                    ", '<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"8\">    <name>File downloads per Item, anonymous users</name>  <scope objid=\"2\" />  <sql>       select parent_object_id as itemId, sum(requests)    as fileRequests from _1_object_statistics       where parent_object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' and user_id='''' group by parent_object_id;    </sql> </report-definition>',",
                    " 2);"));
        target
            .executeSqlCommand(StringUtility
                .concatenateToString(
                    "INSERT INTO sm.report_definitions",
                    " (id, xml, scope_id) VALUES (",
                    nextReportDefinitionId++,
                    ", '<?xml version=\"1.0\" encoding=\"UTF-8\"?><report-definition xmlns=\"http://www.escidoc.de/schemas/reportdefinition/0.3\" objid=\"9\">    <name>File downloads, anonymous users</name>  <scope objid=\"2\" />   <sql>       select object_id as fileId, sum(requests) as fileRequests       from _1_object_statistics       where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' and user_id='''' group by object_id;  </sql> </report-definition>',",
                    " 2);"));

        // xml columns have been renamed to xml_data
        target.renameTableColumn("sm.statistic_data", "xml", "xml_data");
        target.renameTableColumn("sm.scopes", "xml", "xml_data");
        target.renameTableColumn("sm.aggregation_definitions", "xml",
            "xml_data");
        target.renameTableColumn("sm.report_definitions", "xml", "xml_data");

        target
            .renameTableColumn("sm.statistic_data", "timestamp", "timemarker");

        target
            .executeSqlCommand("create table sm.ESCIDOC_SM_IDS (tablename VARCHAR(255) unique not null primary key, id INTEGER);");
        target
            .executeSqlCommand("CREATE INDEX sm_ids_table_idx ON sm.ESCIDOC_SM_IDS (TABLENAME);");

        final Object maxId =
            target.getMaxOfColumn("sm.aggregation_definitions", "id");
        int nextAggregationDefinitionId = ((Integer) maxId).intValue() + 1;
        if (log.isDebugEnabled()) {
            log.debug(StringUtility.concatenateWithBrackets(
                "Determined next available aggregation definition id",
                nextAggregationDefinitionId));
        }

        target
            .executeSqlCommand(StringUtility
                .concatenateToString(
                    "INSERT INTO sm.ESCIDOC_SM_IDS (TABLENAME, ID) VALUES ('AGGREGATION_DEFINITIONS', ",
                    nextAggregationDefinitionId++, ");"));
    }

    /**
     * Drops policy_Actions table, migrates escidoc_role, scope_def and
     * escidoc_policies tables.
     */
    private void migrateRolesAndPolicies() {

        log.info("Migrating table escidoc_role");
        // creator_title and modified_by_title have been dropped from table
        // indexer user has been removed
        final List<String> toBeDropped = new ArrayList<String>(2);
        toBeDropped.add("creator_title");
        toBeDropped.add("modified_by_title");
        copyTableData("aa.escidoc_role", toBeDropped,
            "WHERE id<>'escidoc:role-indexer'");

        log.info("Migrating table escidoc_policies");
        try {
            copyTableData("aa.escidoc_policies", null,
                "WHERE role_id<>'escidoc:role-indexer'");
            target.executeSqlScript("aa.update.policies-xml.sql");
        }
        catch (IOException e) {
            // FIXME: Exception handling
            throw new RuntimeException(e);
        }

        copyTableData("aa.scope_def", null,
            "WHERE role_id<>'escidoc:role-indexer'");

        // some attributes have been renamed, xml of policies have to be changed
        final List<Map<String, Object>> policiesData = target.getPoliciesData();
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
                    target.executeSqlCommand(StringUtility.concatenateToString(
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
        log
            .info("Migrating tables action, method-mappings and invocation_mappings");
        // These tables should not be changed by anyone as action is no
        // resource.
        // Therefore, the tables are initialized from a script.
        try {
            target.executeSqlScript("aa.init.actions.sql");
            // FIXME: generic way needed to identify all method-mappings
            target.executeSqlScript("aa.init.method-mappings.aa.sql");
            target.executeSqlScript("aa.init.method-mappings.cmm.sql");
            target.executeSqlScript("aa.init.method-mappings.om.container.sql");
            target.executeSqlScript("aa.init.method-mappings.om.context.sql");
            target.executeSqlScript("aa.init.method-mappings.om.ingest.sql");
            target.executeSqlScript("aa.init.method-mappings.om.item.sql");
            target
                .executeSqlScript("aa.init.method-mappings.om.semantic-store.sql");
            target.executeSqlScript("aa.init.method-mappings.om.toc.sql");
            target.executeSqlScript("aa.init.method-mappings.oum.sql");
            target.executeSqlScript("aa.init.method-mappings.sb.sql");
            target.executeSqlScript("aa.init.method-mappings.sm.sql");
            target.executeSqlScript("aa.init.method-mappings.st.sql");
            target.executeSqlScript("aa.init.method-mappings.tme.jhove.sql");
            target.executeSqlScript("aa.init.method-mappings.wm.sql");

            if (log.isInfoEnabled()) {
                log.info(StringUtility.concatenateToString(
                    "Number of method-mappings: ", target
                        .getNumberOfRows("aa.method_mappings")));
            }
        }
        catch (IOException e) {
            // FIXME: Exception handling
            throw new RuntimeException(e);
        }
    }

    /**
     * Performs some tests on the migrated data. <br>
     * If skipTests is set to <code>true</code>, no test is performed.
     */
    private void selfTest() {

        if (skipTests) {
            return;
        }

        log.warn("");
        log.warn("Perfoming some tests on the migrated database");
        log.warn("To skip these tests, use the admin-tool property");
        log.warn("dbmigration.skipTests (set to true)");
        log.warn("");

        try {
            // aa tests
            assertEquals("Checking number of actions...", 119, target
                .getNumberOfRows("aa.actions"));
            assertEquals("Checking number of method mappings...", 208, target
                .getNumberOfRows("aa.method_mappings"));
            assertEquals("Checking number of invocation mappings...", 208,
                target.getNumberOfRows("aa.method_mappings"));
            assertEquals("Checking number of user accounts...", source
                .getNumberOfRows("aa.user_account"), target
                .getNumberOfRows("aa.user_account"));
            // escidoc:role-indexer has been removed
            assertEquals("Checking number of roles...", source
                .getNumberOfRows("aa.escidoc_role") - 1, target
                .getNumberOfRows("aa.escidoc_role"));
            assertEquals("Checking number of role scope defs...", source
                .getNumberOfRows("aa.scope_def"), target
                .getNumberOfRows("aa.scope_def"));

            // om tests
            assertEquals("Checking number of object locks...", source
                .getNumberOfRows("om.lockstatus"), target
                .getNumberOfRows("om.lockstatus"));

            // sm tests
            assertEquals("Checking number of statistic data records...", source
                .getNumberOfRows("sm.statistic_data"), target
                .getNumberOfRows("sm.statistic_data"));
            assertEquals("Checking number of scopes...", source
                .getNumberOfRows("sm.scopes"), target
                .getNumberOfRows("sm.scopes"));
            assertEquals("Checking number of aggregation definitions...",
                source.getNumberOfRows("sm.aggregation_definitions"), target
                    .getNumberOfRows("sm.aggregation_definitions"));
            // 3 report definitions have been added since build 159
            assertEquals("Checking number of report definitions...", source
                .getNumberOfRows("sm.report_definitions") + 3, target
                .getNumberOfRows("sm.report_definitions"));

            assertTableExists("Checking table sm.ESCIDOC_SM_IDS...",
                "sm.ESCIDOC_SM_IDS");
            // FIXME: check aggregation data tables

            // st tests
            assertEquals("Checking number of staging files...", source
                .getNumberOfRows("st.staging_file"), target
                .getNumberOfRows("st.staging_file"));
        }
        catch (RuntimeException e) {
            log.error(e.getMessage());
            log.error("To skip the tests, set the property skipTests");
            log.error("true in the admin-tool.properties file");
            throw e;
        }
    }

    /**
     * Asserts the provided values are equal. Otherwise an Exception is thrown
     * containing the provided message.
     * 
     * @param message
     *            The assertion failed message.
     * @param expected
     *            The expected value.
     * @param toBeAsserted
     *            The value to check.
     */
    private void assertEquals(
        final String message, final Object expected, final Object toBeAsserted) {

        log.info(message);

        if ((expected == null && toBeAsserted != null)
            || (!expected.equals(toBeAsserted))) {
            throw new RuntimeException(StringUtility
                .concatenateWithBracketsToString(message + " failed", expected,
                    toBeAsserted));
        }
    }

    /**
     * Asserts a table with the provided name exists in the target database.
     * 
     * @param message
     *            The assertion failed message.
     * @param tableName
     *            The name of the table including the schema name.
     */
    private void assertTableExists(final String message, final String tableName) {

        log.info(message);

        if (!target.existsTable(tableName)) {
            throw new RuntimeException(StringUtility.concatenateToString(
                message, " failed. Table not found."));
        }
    }

    // CHECKSTYLE:JAVADOC-ON

    /**
     * Injects the {@link SourceDbDaoInterface} of the original database.
     * 
     * @param source
     *            the {@link SourceDbDaoInterface} implementation to inject.
     */
    public void setSource(final SourceDbDaoInterface source) {
        this.source = source;
    }

    /**
     * Injects the {@link TargetDbDaoInterface} of the new database.
     * 
     * @param target
     *            the {@link TargetDbDaoInterface} implementation to inject.
     */
    public void setTarget(final TargetDbDaoInterface target) {
        this.target = target;
    }

    /**
     * Injects the value for skipTests.
     * 
     * @param skipTests
     *            The flag indicating if the etsts shall be skipped.
     */
    public void setSkipTests(final boolean skipTests) {

        this.skipTests = skipTests;
    }

}
