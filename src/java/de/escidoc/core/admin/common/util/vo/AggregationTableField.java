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
 * Copyright 2009 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.
 * All rights reserved.  Use is subject to license terms.
 */

package de.escidoc.core.admin.common.util.vo;

public class AggregationTableField {

    String id = null;
    int fieldTypeId = 0;
    String name = null;
    String feed = null;
    String xpath = null;
    String data_type = null;
    String reduceTo = null;
    int listIndex = 0;
    /**
     * @return the id
     */
    public String getId() {
        return id;
    }
    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }
    /**
     * @return the fieldTypeId
     */
    public int getFieldTypeId() {
        return fieldTypeId;
    }
    /**
     * @param fieldTypeId the fieldTypeId to set
     */
    public void setFieldTypeId(int fieldTypeId) {
        this.fieldTypeId = fieldTypeId;
    }
    /**
     * @return the name
     */
    public String getName() {
        return name;
    }
    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * @return the feed
     */
    public String getFeed() {
        return feed;
    }
    /**
     * @param feed the feed to set
     */
    public void setFeed(String feed) {
        this.feed = feed;
    }
    /**
     * @return the xpath
     */
    public String getXpath() {
        return xpath;
    }
    /**
     * @param xpath the xpath to set
     */
    public void setXpath(String xpath) {
        this.xpath = xpath;
    }
    /**
     * @return the data_type
     */
    public String getData_type() {
        return data_type;
    }
    /**
     * @param dataType the data_type to set
     */
    public void setData_type(String dataType) {
        data_type = dataType;
    }
    /**
     * @return the reduceTo
     */
    public String getReduceTo() {
        return reduceTo;
    }
    /**
     * @param reduceTo the reduceTo to set
     */
    public void setReduceTo(String reduceTo) {
        this.reduceTo = reduceTo;
    }
    /**
     * @return the listIndex
     */
    public int getListIndex() {
        return listIndex;
    }
    /**
     * @param listIndex the listIndex to set
     */
    public void setListIndex(int listIndex) {
        this.listIndex = listIndex;
    }
    
}
