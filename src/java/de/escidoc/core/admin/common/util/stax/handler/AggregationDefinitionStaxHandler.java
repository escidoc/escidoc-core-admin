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
 * Copyright 2006-2008 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.  
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.common.util.stax.handler;

import java.util.ArrayList;
import java.util.Collection;

import de.escidoc.core.admin.common.util.vo.AggregationDefinitionVo;
import de.escidoc.core.admin.common.util.vo.AggregationStatisticDataSelectorVo;
import de.escidoc.core.admin.common.util.vo.AggregationTableFieldVo;
import de.escidoc.core.admin.common.util.vo.AggregationTableIndexFieldVo;
import de.escidoc.core.admin.common.util.vo.AggregationTableIndexVo;
import de.escidoc.core.admin.common.util.vo.AggregationTableVo;
import de.escidoc.core.common.exceptions.system.SystemException;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.xml.stax.events.Attribute;
import de.escidoc.core.common.util.xml.stax.events.EndElement;
import de.escidoc.core.common.util.xml.stax.events.StartElement;
import de.escidoc.core.common.util.xml.stax.handler.DefaultHandler;

/**
 * Fills xml-data into hibernate object.
 * 
 * @author MIH
 * @sm
 */
public class AggregationDefinitionStaxHandler extends DefaultHandler {

    private AggregationDefinitionVo aggregationDefinition =
            new AggregationDefinitionVo();

    private Collection<AggregationStatisticDataSelectorVo> 
                aggregationStatisticDataSelectors =
            new ArrayList<AggregationStatisticDataSelectorVo>();

    private Collection<AggregationTableVo> aggregationTables =
            new ArrayList<AggregationTableVo>();
    
    private final String rootPath = "/aggregation-definition";
    
    private final String tablePath = "/aggregation-definition/aggregation-table";
    
    private final String tableFieldPath = 
            "/aggregation-definition/aggregation-table/field";
    
    private final String tableIndexPath = 
        "/aggregation-definition/aggregation-table/index";
    
    private final String statisticDataSelectorPath = 
                "/aggregation-definition/statistic-data";
    
    private int tableIndex = 0;
    
    private int tableFieldIndex = 0;
    
    private int tableIndexIndex = 0;
    
    private int tableIndexFieldIndex = 0;
    
    private int statisticDataSelectorIndex = 0;

    private boolean inTable = false;
    
    private boolean inTableField = false;
    
    private boolean inTableIndex = false;
    
    private boolean inStatisticDataSelector = false;
    
    private AggregationTableFieldVo aggregationTableField = null;

    private AggregationTableIndexVo aggregationTableIndex = null;

    private AggregationTableVo aggregationTable = null;

    private AggregationStatisticDataSelectorVo 
                aggregationStatisticDataSelector = null;

    private StaxParser parser;

    /**
     * Constructor with StaxParser.
     * 
     * @param parser
     *            StaxParser
     * 
     * @sm
     */
    public AggregationDefinitionStaxHandler(final StaxParser parser) {
        this.parser = parser;
    }

    /**
     * Handle the character section of an element.
     * 
     * @param s
     *            The contents of the character section.
     * @param element
     *            The element.
     * @return The character section.
     * @throws Exception
     *             e
     * @see de.escidoc.core.common.util.xml.stax.handler.DefaultHandler#characters
     *      (java.lang.String,
     *      de.escidoc.core.common.util.xml.stax.events.StartElement)
     * @sm
     */
    public String characters(
            final String s,
            final StartElement element)
            throws Exception {
        if (inTable) {
            if (inTableField) {
                if ("name".equals(element.getLocalName())) {
                    aggregationTableField.setName(s);
                }
                else if ("type".equals(element.getLocalName())) {
                    aggregationTableField.setDataType(s);
                }
                else if ("xpath".equals(element.getLocalName())) {
                    aggregationTableField.setXpath(s);
                }
                else if ("reduce-to".equals(element.getLocalName())) {
                    aggregationTableField.setReduceTo(s);
                }
            } 
            else if (inTableIndex) {
                if ("name".equals(element.getLocalName())) {
                    aggregationTableIndex.setName(s);
                } 
                else if ("field".equals(element.getLocalName())) {
                    tableIndexFieldIndex++;
                    AggregationTableIndexFieldVo indexField = 
                        new AggregationTableIndexFieldVo();
                    indexField.setField(s);
                    indexField.setListIndex(tableIndexFieldIndex);
                    indexField.setId(aggregationTableIndex.getId() 
                                    + ":field" + tableIndexFieldIndex);
                    aggregationTableIndex
                        .getAggregationTableIndexFields().add(indexField);
                }
            }
            else {
                if ("name".equals(element.getLocalName())) {
                    aggregationTable.setName(s);
                } 
            }
        }
        else if (inStatisticDataSelector) {
            if ("xpath".equals(element.getLocalName())) {
                aggregationStatisticDataSelector
                    .setXpath(s);
            }
        }
        else {
        }
        return s;
    }

    /**
     * Handle startElement event.
     * 
     * @param element startElement
     * @return StartElement startElement
     * @throws Exception e
     * 
     * @sm
     */
    public StartElement startElement(final StartElement element) throws Exception {
        String currentPath = parser.getCurPath();
        boolean fieldRootElement = false;
        if (tablePath.equals(currentPath)) {
            inTable = true;
            tableIndex++;
            tableFieldIndex = 0;
            tableIndexIndex = 0;
            aggregationTable = new AggregationTableVo();
            aggregationTable.setListIndex(tableIndex);
            aggregationTable.setId(
                    aggregationDefinition.getId() + ":table" + tableIndex);
        }
        else if (tableFieldPath.equals(currentPath)) {
            inTableField = true;
            tableFieldIndex++;
            aggregationTableField = new AggregationTableFieldVo();
            aggregationTableField.setListIndex(tableFieldIndex);
            aggregationTableField.setId(
                    aggregationTable.getId() + ":field" + tableFieldIndex);
        }
        else if (tableIndexPath.equals(currentPath)) {
            inTableIndex = true;
            tableIndexIndex++;
            tableIndexFieldIndex = 0;
            aggregationTableIndex = new AggregationTableIndexVo();
            aggregationTableIndex.setListIndex(tableIndexIndex);
            aggregationTableIndex.setId(
                    aggregationDefinition.getId() + ":index" + tableIndexIndex);
        }
        else if (statisticDataSelectorPath.equals(currentPath)) {
            inStatisticDataSelector = true;
            statisticDataSelectorIndex++;
            aggregationStatisticDataSelector = 
                        new AggregationStatisticDataSelectorVo();
            aggregationStatisticDataSelector.setListIndex(
                                    statisticDataSelectorIndex);
            aggregationStatisticDataSelector.setId(
                    aggregationDefinition.getId() 
                    + ":selector" + statisticDataSelectorIndex);
        }
        else if ("info-field".equals(element.getLocalName())) {
            aggregationTableField.setFieldTypeId(1);
            fieldRootElement = true;
        } 
        else if ("time-reduction-field".equals(element.getLocalName())) {
            aggregationTableField.setFieldTypeId(2);
            fieldRootElement = true;
        }
        else if ("count-cumulation-field".equals(element.getLocalName())) {
            aggregationTableField.setFieldTypeId(3);
            fieldRootElement = true;
        }
        else if ("difference-cumulation-field"
                    .equals(element.getLocalName())) {
            aggregationTableField.setFieldTypeId(4);
            fieldRootElement = true;
        }
        else if ("statistic-table".equals(element.getLocalName())) {
            aggregationStatisticDataSelector
                    .setSelectorType("statistic-table");
        } 
        else if (rootPath.equals(currentPath)) {
            int indexOfAttribute = element.indexOfAttribute("", "objid");
            if (indexOfAttribute != (-1)) {
                Attribute att = element.getAttribute(indexOfAttribute);
                aggregationDefinition.setId(att.getValue());
            }
        }
        if (fieldRootElement) {
            int indexOfAttribute = element.indexOfAttribute("", "feed");
            if (indexOfAttribute != (-1)) {
                Attribute att = element.getAttribute(indexOfAttribute);
                aggregationTableField.setFeed(att.getValue());
            }
        }
        return element;
    }

    /**
     * Handle endElement event.
     * 
     * @param element endElement
     * @return EndElement endElement
     * @throws Exception e
     * 
     * @sm
     */
    public EndElement endElement(final EndElement element) throws Exception {
        String currentPath = parser.getCurPath();
        if (tablePath.equals(currentPath)) {
            inTable = false;
            aggregationTables.add(aggregationTable);
        }
        else if (tableFieldPath.equals(currentPath)) {
            inTableField = false;
            aggregationTable.getAggregationTableFields()
                                .add(aggregationTableField);
        }
        else if (tableIndexPath.equals(currentPath)) {
            inTableIndex = false;
            aggregationTable.getAggregationTableIndexes()
            .add(aggregationTableIndex);
        }
        else if (statisticDataSelectorPath.equals(currentPath)) {
            inStatisticDataSelector = false;
            aggregationStatisticDataSelectors
                                    .add(aggregationStatisticDataSelector);
        }
        else if (rootPath.equals(currentPath)) {
            //check objects
            aggregationDefinition
                .setAggregationStatisticDataSelectors(
                        aggregationStatisticDataSelectors);
            aggregationDefinition
                .setAggregationTables(aggregationTables);
            if (aggregationStatisticDataSelectors == null
                    || aggregationStatisticDataSelectors.isEmpty()
                    || aggregationTables == null
                    || aggregationTables.isEmpty()) {
                throw new SystemException("DataIntegrity violated");
            }
        }
        return element;
    }

    /**
     * @return the aggregationDefinition
     */
    public AggregationDefinitionVo getAggregationDefinition() {
        return aggregationDefinition;
    }

    /**
     * @return the aggregationStatisticDataSelectors
     */
    public Collection<AggregationStatisticDataSelectorVo> 
                getAggregationStatisticDataSelectors() {
        return aggregationStatisticDataSelectors;
    }

    /**
     * @return the aggregationTables
     */
    public Collection<AggregationTableVo> getAggregationTables() {
        return aggregationTables;
    }

}
