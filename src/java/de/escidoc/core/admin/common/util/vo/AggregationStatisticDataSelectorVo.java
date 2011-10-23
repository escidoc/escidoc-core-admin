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

public class AggregationStatisticDataSelectorVo {

    String id = null;
    String selectorType = null;
    String xpath = null;
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
     * @return the selectorType
     */
    public String getSelectorType() {
        return selectorType;
    }
    /**
     * @param selectorType the selectorType to set
     */
    public void setSelectorType(String selectorType) {
        this.selectorType = selectorType;
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
