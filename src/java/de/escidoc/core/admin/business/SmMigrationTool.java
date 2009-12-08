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

import java.io.ByteArrayInputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.tools.ant.Project;
import org.apache.tools.ant.Target;

import de.escidoc.core.admin.business.interfaces.SmMigrationInterface;
import de.escidoc.core.admin.common.util.stax.handler.AggregationDefinitionStaxHandler;
import de.escidoc.core.admin.common.util.stax.handler.ReportDefinitionStaxHandler;
import de.escidoc.core.admin.common.util.vo.AggregationDefinitionVo;
import de.escidoc.core.admin.common.util.vo.AggregationStatisticDataSelectorVo;
import de.escidoc.core.admin.common.util.vo.AggregationTableFieldVo;
import de.escidoc.core.admin.common.util.vo.AggregationTableIndexFieldVo;
import de.escidoc.core.admin.common.util.vo.AggregationTableIndexVo;
import de.escidoc.core.admin.common.util.vo.AggregationTableVo;
import de.escidoc.core.admin.common.util.vo.ReportDefinitionRoleVo;
import de.escidoc.core.admin.common.util.vo.ReportDefinitionVo;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.xml.XmlUtility;

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
    
    private final String creatorId;

    /**
     * Attributes needed to call an Ant target.
     */
    private Project project = new Project();

    private Target target = new Target();

    /**
     * Queries.
     */
    private final String QUERY_AGGREGATION_DEFINITIONS = 
                "select * from sm.aggregation_definitions;";

    private final String QUERY_REPORT_DEFINITIONS = 
        "select * from sm.report_definitions;";

    private final String UPDATE_AGGREGATION_TABLES = 
            "insert into sm.aggregation_tables "
            + "(id, aggregation_definition_id, name, list_index) "
            + "values (?, ?, ?, ?)";

    private final String UPDATE_AGGREGATION_TABLE_FIELDS = 
        "insert into sm.aggregation_table_fields "
        + "(id, aggregation_table_id, field_type_id, name, feed, xpath, data_type, reduce_to, list_index) "
        + "values (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private final String UPDATE_AGGREGATION_TABLE_INDEXES = 
        "insert into sm.aggregation_table_indexes "
        + "(id, aggregation_table_id, name, list_index) "
        + "values (?, ?, ?, ?)";

    private final String UPDATE_AGGREGATION_TABLE_INDEX_FIELDS = 
        "insert into sm.aggregation_table_index_fields "
        + "(id, aggregation_table_index_id, field, list_index) "
        + "values (?, ?, ?, ?)";

    private final String UPDATE_AGGREGATION_STATISTIC_DATA_SELECTORS = 
        "insert into sm.aggregation_statistic_data_selectors "
        + "(id, aggregation_definition_id, selector_type, xpath, list_index) "
        + "values (?, ?, ?, ?, ?)";

    private final String UPDATE_REPORT_DEFINITION_ROLES = 
        "insert into sm.report_definition_roles "
        + "(id, report_definition_id, role_id, list_index) "
        + "values (?, ?, ?, ?)";

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
        handleAggregationDefinitions();
        handleReportDefinitions();
    }
    
    private void handleAggregationDefinitions() throws ApplicationServerSystemException {
        try {
            List result = getJdbcTemplate().queryForList(
                                QUERY_AGGREGATION_DEFINITIONS);
            for (Iterator iter = result.iterator(); iter.hasNext();) {
                Map map = (Map) iter.next();
                String xml = (String) map.get("xml_data");
                StaxParser sp = new StaxParser();
                AggregationDefinitionStaxHandler handler =
                        new AggregationDefinitionStaxHandler(sp);
                sp.addHandler(handler);

                sp.parse(new ByteArrayInputStream(xml
                        .getBytes(XmlUtility.CHARACTER_ENCODING)));
                AggregationDefinitionVo aggregationDefinitionVo = 
                                handler.getAggregationDefinition();
                writeTables(aggregationDefinitionVo);
                writeStatisticDataSelectors(aggregationDefinitionVo);
            }
        } catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }
    
    private void handleReportDefinitions() throws ApplicationServerSystemException {
        try {
            List result = getJdbcTemplate().queryForList(
                                QUERY_REPORT_DEFINITIONS);
            for (Iterator iter = result.iterator(); iter.hasNext();) {
                Map map = (Map) iter.next();
                String xml = (String) map.get("xml_data");
                StaxParser sp = new StaxParser();
                ReportDefinitionStaxHandler handler =
                        new ReportDefinitionStaxHandler(sp);
                sp.addHandler(handler);

                sp.parse(new ByteArrayInputStream(xml
                        .getBytes(XmlUtility.CHARACTER_ENCODING)));
                ReportDefinitionVo reportDefinitionVo = 
                                handler.getReportDefinitionVo();
                writeAllowedRoles(reportDefinitionVo);
            }
        } catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }
    
    private void writeTables(AggregationDefinitionVo aggregationDefinitionVo) {
        for (AggregationTableVo aggregationTableVo : aggregationDefinitionVo
                .getAggregationTables()) {
            getJdbcTemplate().update(UPDATE_AGGREGATION_TABLES,
                    new Object[] { aggregationTableVo.getId(),
                    aggregationDefinitionVo.getId(),
                    aggregationTableVo.getName(),
                    aggregationTableVo.getListIndex() });
            for (AggregationTableFieldVo aggregationTableFieldVo : aggregationTableVo
                    .getAggregationTableFields()) {
                getJdbcTemplate().update(UPDATE_AGGREGATION_TABLE_FIELDS,
                        new Object[] { aggregationTableFieldVo.getId(),
                        aggregationTableVo.getId(),
                        aggregationTableFieldVo.getFieldTypeId(),
                        aggregationTableFieldVo.getName(),
                        aggregationTableFieldVo.getFeed(),
                        aggregationTableFieldVo.getXpath(),
                        aggregationTableFieldVo.getDataType(),
                        aggregationTableFieldVo.getReduceTo(),
                        aggregationTableFieldVo.getListIndex() });

            }
            for (AggregationTableIndexVo aggregationTableIndexVo : aggregationTableVo
                    .getAggregationTableIndexes()) {
                getJdbcTemplate().update(UPDATE_AGGREGATION_TABLE_INDEXES,
                        new Object[] { aggregationTableIndexVo.getId(),
                        aggregationTableVo.getId(),
                        aggregationTableIndexVo.getName(),
                        aggregationTableIndexVo.getListIndex() });
                for (AggregationTableIndexFieldVo aggregationTableIndexFieldVo 
                        : aggregationTableIndexVo.getAggregationTableIndexFields()) {
                    getJdbcTemplate().update(UPDATE_AGGREGATION_TABLE_INDEX_FIELDS,
                        new Object[] { aggregationTableIndexFieldVo.getId(),
                        aggregationTableIndexVo.getId(),
                        aggregationTableIndexFieldVo.getField(),
                        aggregationTableIndexFieldVo.getListIndex() });
                }

            }
        }
    }
    
    private void writeStatisticDataSelectors(
            AggregationDefinitionVo aggregationDefinitionVo) {
        for (AggregationStatisticDataSelectorVo aggregationStatisticDataSelectorVo : aggregationDefinitionVo
                .getAggregationStatisticDataSelectors()) {
            getJdbcTemplate()
                    .update(
                            UPDATE_AGGREGATION_STATISTIC_DATA_SELECTORS,
                            new Object[] {
                                    aggregationStatisticDataSelectorVo.getId(),
                                    aggregationDefinitionVo.getId(),
                                    aggregationStatisticDataSelectorVo
                                            .getSelectorType(),
                                    aggregationStatisticDataSelectorVo
                                            .getXpath(),
                                    aggregationStatisticDataSelectorVo
                                            .getListIndex() });
        }
    }
    
    private void writeAllowedRoles(
            ReportDefinitionVo reportDefinitionVo) {
        for (ReportDefinitionRoleVo reportDefinitionRoleVo : reportDefinitionVo
                .getReportDefinitionRoles()) {
            getJdbcTemplate()
                    .update(
                    UPDATE_REPORT_DEFINITION_ROLES,
                    new Object[] {
                    reportDefinitionRoleVo.getId(),
                    reportDefinitionVo.getId(),
                    reportDefinitionRoleVo
                    .getRoleId(),
                    reportDefinitionRoleVo
                    .getListIndex() });
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
