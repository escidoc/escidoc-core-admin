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

import de.escidoc.core.admin.common.util.vo.ReportDefinitionRoleVo;
import de.escidoc.core.admin.common.util.vo.ReportDefinitionVo;
import de.escidoc.core.common.exceptions.application.missing.MissingAttributeValueException;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;
import de.escidoc.core.common.exceptions.system.SystemException;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.xml.XmlUtility;
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
public class ReportDefinitionStaxHandler extends DefaultHandler {

    private ReportDefinitionVo reportDefinitionVo = new ReportDefinitionVo();

    private StaxParser parser;
    
    private int allowedRolesIndex = 0;
    
    /**
     * Cosntructor with StaxParser.
     * 
     * @param parser
     *            StaxParser
     * 
     * @sm
     */
    public ReportDefinitionStaxHandler(final StaxParser parser) {
        this.parser = parser;
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
        if ("allowed-role".equals(element.getLocalName())) {
            String objId = XmlUtility.getIdFromStartElement(element);
            if (objId != null) {
                allowedRolesIndex++;
                ReportDefinitionRoleVo reportDefinitionRoleVo = 
                                        new ReportDefinitionRoleVo();
                reportDefinitionRoleVo.setId(
                        reportDefinitionVo.getId() + "role" + allowedRolesIndex);
                reportDefinitionRoleVo.setRoleId(objId);
                reportDefinitionRoleVo.setListIndex(allowedRolesIndex);
                reportDefinitionVo.getReportDefinitionRoles()
                                    .add(reportDefinitionRoleVo);
            }
        }
        else if ("report-definition".equals(element.getLocalName())) {
            try {
                String reportDefinitionId = 
                    XmlUtility.getIdFromStartElement(element);
                reportDefinitionVo.setId(reportDefinitionId);
            } catch (MissingAttributeValueException e) {}
        }
        return element;
    }

    /**
     * @return the reportDefinition
     */
    public ReportDefinitionVo getReportDefinitionVo() {
        return reportDefinitionVo;
    }

}
