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
 * Copyright 2006-2007 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.  
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.sb.gsearch.business;

import java.util.HashSet;

/**
 * Constants for Search and Browse.
 * 
 * @author MIH
 */
public class Constants {

    /**
     * Spring Object-Names.
     */
    public static final String SB_SPRING_CONTEXT_NAME = "Sb.spring.ejb.context";

    public static final String INDEXING_ERROR_QUEUE_NAME =
        "sb.indexingErrorQueue";

    /**
     * common gsearch Constants.
     */
    public static final String ESCIDOC_FEDORA_REPOSITORY = "escidocrepository";

    public static final String GSEARCH_CREATE_EMPTY_INDEX_PARAMS =
        "?operation=updateIndex&action=createEmpty&repositoryName="
            + ESCIDOC_FEDORA_REPOSITORY + "&indexName=${INDEX_NAME}";

    public static final String GSEARCH_UPDATE_INDEX_PARAMS =
        "?operation=updateIndex&action=fromPid&repositoryName="
            + ESCIDOC_FEDORA_REPOSITORY
            + "&indexName=${INDEX_NAME}&value=${VALUE}";

    public static final String GSEARCH_DELETE_INDEX_PARAMS =
        "?operation=updateIndex&action=deletePid&repositoryName="
            + ESCIDOC_FEDORA_REPOSITORY
            + "&indexName=${INDEX_NAME}&value=${VALUE}";

    public static final String GSEARCH_STYLESHEET_PARAMS =
        "&indexDocXslt=(LANGUAGE=${LANGUAGE}"
    	+ ",SUPPORTED_MIMETYPES=${SUPPORTED_MIMETYPES})";

    public static final String GSEARCH_GET_INDEX_CONFIGURATION_PARAMS =
        "?operation=getIndexConfigInfo";

    public static final String GSEARCH_GET_REPOSITORY_INFO_PARAMS =
        "?operation=getRepositoryInfo";

    public static final String GSEARCH_OPTIMIZE_INDEX_PARAMS =
        "?operation=updateIndex&action=optimize&repositoryName="
    	+ ESCIDOC_FEDORA_REPOSITORY
    	+ "&indexName=${INDEX_NAME}";
    	
    public static final String INDEX_NAME_PREFIX = "escidoc_";

    public static final String ALL_INDEX_NAME_SUFFIX = "all";

    /**
     * optimize index after each OPTIMIZE_DOCUMENT_COUNT-th document.
     */
    public static final int OPTIMIZE_DOCUMENT_COUNT = 100;

    /**
     * XML Constants.
     */
    public static final String LANGUAGE_NAMESPACE =
        "http://purl.org/dc/elements/1.1/";

    public static final String ITEM_MDRECORD_PATH =
        "/item/md-records/md-record";

    public static final String CONTAINER_MDRECORD_PATH =
        "/container/md-records/md-record";

    public static final String MDRECORD_NAME_ATTRIBUTE_NAME = "name";

    public static final String INTERNAL_MDRECORD_NAME_ATTRIBUTE_VALUE =
        "escidoc";

    public static final String LANGUAGE_ATTRIBUTE_NAME = "xml:lang";

    public static final String INTERNAL_MDRECORD_LANGUAGE_ELEMENT_NAME =
        "language";

}
