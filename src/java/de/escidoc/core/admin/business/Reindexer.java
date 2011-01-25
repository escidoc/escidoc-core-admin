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

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;

import de.escidoc.core.admin.business.interfaces.ReindexerInterface;
import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.common.business.Constants;
import de.escidoc.core.common.business.fedora.FedoraUtility;
import de.escidoc.core.common.business.fedora.resources.ResourceType;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.exceptions.system.SystemException;
import de.escidoc.core.common.util.configuration.EscidocConfiguration;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.stax.handler.IndexConfigurationStaxHandler;
import de.escidoc.core.common.util.xml.XmlUtility;
import de.escidoc.core.index.IndexRequest;
import de.escidoc.core.index.IndexRequestBuilder;
import de.escidoc.core.index.IndexService;

/**
 * Provides Methods used for Reindexing.
 * 
 * @spring.bean id="de.escidoc.core.admin.Reindexer"
 */
public class Reindexer implements ReindexerInterface {

    private static final int HTTP_CONNECTION_TIMEOUT = 5000;

    /**
     * Triple store query to get a list of all containers.
     */
    private static final String CONTAINER_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + ResourceType.CONTAINER.getUri() + "%3e";

    /**
     * Triple store query to get a list of all Content Models.
     */
    private static final String CONTENT_MODEL_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + ResourceType.CONTENT_MODEL.getUri() + "%3e";

    /**
     * Triple store query to get a list of all content relations.
     */
    private static final String CONTENT_RELATION_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + ResourceType.CONTENT_RELATION.getUri() + "%3e";

    /**
     * Triple store query to get a list of all contexts.
     */
    private static final String CONTEXT_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + ResourceType.CONTEXT.getUri() + "%3e";

    /**
     * Triple store query to get a list of all items.
     */
    private static final String ITEM_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + ResourceType.ITEM.getUri() + "%3e";

    /**
     * Triple store query to get a list of all organizational units.
     */
    private static final String OU_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + ResourceType.OU.getUri() + "%3e";

    private static final String INDEX_CONFIGURATION_URL =
        "/adm/admin/get-index-configuration";

    private static final AppLogger LOG = new AppLogger(
        Reindexer.class.getName());

    private HashMap<String, HashMap<String, HashMap<String, Object>>> indexConfiguration =
        null;

    private EscidocCoreHandler escidocCoreHandler = null;

    private FedoraUtility fedoraUtility = null;

    private IndexService indexService = null;

    /**
     * Property "clearIndex" from configuration file.
     */
    private final boolean clearIndex;

    /**
     * Property "indexName" from configuration file.
     */
    private final String indexName;

    /**
     * Construct a new Reindexer object.
     * 
     * @param clearIndex
     *            clear the index before adding objects to it
     * @param indexName
     *            name of the index (may be null for "all indexes")
     * 
     * @throws SystemException
     *             Thrown if a framework internal error occurs.
     */
    public Reindexer(final String clearIndex, final String indexName)
        throws SystemException {
        this.clearIndex = Boolean.valueOf(clearIndex);
        this.indexName = indexName;
    }

    /**
     * Clear all resources from index.
     * 
     * @throws ApplicationServerSystemException
     *             Thrown if an internal error occurred.
     */
    public void clearIndex() throws ApplicationServerSystemException {
        if (clearIndex) {
            sendDeleteIndexMessage(ResourceType.CONTAINER, indexName);
            sendDeleteIndexMessage(ResourceType.CONTENT_MODEL, indexName);
            sendDeleteIndexMessage(ResourceType.CONTENT_RELATION, indexName);
            sendDeleteIndexMessage(ResourceType.CONTEXT, indexName);
            sendDeleteIndexMessage(ResourceType.ITEM, indexName);
            sendDeleteIndexMessage(ResourceType.OU, indexName);
        }
    }

    /**
     * 
     * @return Collection of container-hrefs
     * 
     * @throws SystemException
     *             e
     */
    private Collection<String> getFilteredContainers() throws SystemException {
        return removeExistingIds(getHrefs(CONTAINER_LIST_QUERY),
            ResourceType.CONTAINER);
    }

    /**
     * 
     * @return Collection of content-model-hrefs
     * 
     * @throws SystemException
     *             e
     */
    private Collection<String> getFilteredContentModels()
        throws SystemException {
        return removeExistingIds(getHrefs(CONTENT_MODEL_LIST_QUERY),
            ResourceType.CONTENT_MODEL);
    }

    /**
     * 
     * @return Collection of content-relation-hrefs
     * 
     * @throws SystemException
     *             e
     */
    private Collection<String> getFilteredContentRelations()
        throws SystemException {
        return removeExistingIds(getHrefs(CONTENT_RELATION_LIST_QUERY),
            ResourceType.CONTENT_RELATION);
    }

    /**
     * 
     * @return Collection of context-hrefs
     * 
     * @throws SystemException
     *             e
     */
    private Collection<String> getFilteredContexts() throws SystemException {
        return removeExistingIds(getHrefs(CONTEXT_LIST_QUERY),
            ResourceType.CONTEXT);
    }

    /**
     * 
     * @return Collection of item-hrefs
     * 
     * @throws SystemException
     *             e
     */
    private Collection<String> getFilteredItems() throws SystemException {
        return removeExistingIds(getHrefs(ITEM_LIST_QUERY), ResourceType.ITEM);
    }

    /**
     * 
     * @return Collection of org-unit-hrefs
     * 
     * @throws SystemException
     *             e
     */
    private Collection<String> getFilteredOrganizationalUnits()
        throws SystemException {
        return removeExistingIds(getHrefs(OU_LIST_QUERY), ResourceType.OU);
    }

    /**
     * Extract the subject from the given triple.
     * 
     * @param triple
     *            the triple from which the subject has to be extracted
     * 
     * @return the subject of the given triple
     */
    private String getSubject(final String triple) {
        String result = null;

        if (triple != null) {
            int index = triple.indexOf(' ');

            if (index > 0) {
                result = triple.substring(triple.indexOf('/') + 1, index - 1);
            }
        }
        return result;
    }

    /**
     * Index all Containers.
     * 
     * @return number of Containers
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    public int indexContainers() throws SystemException {
        Collection<String> hrefs = getFilteredContainers();

        for (String href : hrefs) {
            sendUpdateIndexMessage(href, ResourceType.CONTAINER);
        }
        return hrefs.size();
    }

    /**
     * Index all Content Models.
     * 
     * @return number of Content Models
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    public int indexContentModels() throws SystemException {
        Collection<String> hrefs = getFilteredContentModels();

        for (String href : hrefs) {
            sendUpdateIndexMessage(href, ResourceType.CONTENT_MODEL);
        }
        return hrefs.size();
    }

    /**
     * Index all Content Relations.
     * 
     * @return number of Content Relations
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    public int indexContentRelations() throws SystemException {
        Collection<String> hrefs = getFilteredContentRelations();

        for (String href : hrefs) {
            sendUpdateIndexMessage(href, ResourceType.CONTENT_RELATION);
        }
        return hrefs.size();
    }

    /**
     * Index all Contexts.
     * 
     * @return number of Contexts
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    public int indexContexts() throws SystemException {
        Collection<String> hrefs = getFilteredContexts();

        for (String href : hrefs) {
            sendUpdateIndexMessage(href, ResourceType.CONTEXT);
        }
        return hrefs.size();
    }

    /**
     * Index all Items.
     * 
     * @return number of Items
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    public int indexItems() throws SystemException {
        Collection<String> hrefs = getFilteredItems();

        for (String href : hrefs) {
            sendUpdateIndexMessage(href, ResourceType.ITEM);
        }
        return hrefs.size();
    }

    /**
     * Index all Organizational Units.
     * 
     * @return number of Organizational Units
     * 
     * @throws SystemException
     *             Thrown if an internal error occurred.
     */
    public int indexOrganizationalUnits() throws SystemException {
        Collection<String> hrefs = getFilteredOrganizationalUnits();

        for (String href : hrefs) {
            sendUpdateIndexMessage(href, ResourceType.OU);
        }
        return hrefs.size();
    }

    /**
     * Remove all ids from the given list which already exist in the given
     * index.
     * 
     * @param ids
     *            list of resource ids
     * @param type
     *            resource type
     * 
     * @return filtered list of resource ids
     * @throws SystemException
     *             Thrown if a framework internal error occurs.
     */
    private Collection<String> removeExistingIds(
        final Collection<String> ids, final ResourceType type)
        throws SystemException {
        Collection<String> result = null;

        if (clearIndex) {
            result = ids;
        }
        else {
            result = new Vector<String>();
            for (String id : ids) {
                if (!exists(id.substring(id.lastIndexOf('/') + 1),
                    type.getUri(), indexName)) {
                    result.add(id);
                }
            }
        }
        return result;
    }

    /**
     * Check if the given id already exists in the given index.
     * 
     * @param id
     *            resource id
     * @param objectType
     *            String name of the resource (eg Item, Container...).
     * @param indexName
     *            name of the index (null or "all" means to search in all
     *            indexes)
     * 
     * @return true if the resource already exists
     * @throws SystemException
     *             Thrown if a framework internal error occurs.
     */
    private boolean exists(
        final String id, final String objectType, final String indexName)
        throws SystemException {
        boolean result = false;
        HashMap<String, HashMap<String, Object>> resourceParameters =
            getIndexConfiguration().get(objectType);

        if ((id != null) && (resourceParameters != null)) {
            if (indexName == null || indexName.trim().length() == 0
                || indexName.equalsIgnoreCase("all")) {
                for (String indexName2 : resourceParameters.keySet()) {
                    result = exists(id, indexName2);
                    if (result) {
                        break;
                    }
                }
            }
            else {
                result = exists(id, indexName);
            }
        }
        return result;
    }

    /**
     * Check if the given id already exists in the given index.
     * 
     * @param id
     *            resource id
     * @param indexName
     *            name of the index
     * 
     * @return true if the resource already exists
     * @throws SystemException
     *             Thrown if a framework internal error occurs.
     */
    private boolean exists(final String id, final String indexName)
        throws SystemException {
        boolean result = false;
        try {
            DefaultHttpClient httpClient = new DefaultHttpClient();
            HttpParams params = httpClient.getParams();
            HttpConnectionParams.setConnectionTimeout(params,
                HTTP_CONNECTION_TIMEOUT);
            HttpGet method =
                new HttpGet((new StringBuilder())
                    .append(
                        EscidocConfiguration.getInstance().get(
                            "escidoc-core.baseurl")).append("/srw/search/")
                    .append(indexName).append("?query=PID=").append(id)
                    .toString());
            HttpResponse httpResponse = httpClient.execute(method);

            if (httpResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                Pattern numberOfRecordsPattern =
                    Pattern.compile("numberOfRecords>(.*?)<");
                Matcher m =
                    numberOfRecordsPattern.matcher(EntityUtils.toString(
                        httpResponse.getEntity(), "UTF-8"));
                if (m.find()) {
                    result = Integer.parseInt(m.group(1)) > 0;
                }
            }
        }
        catch (IOException e) {
            throw new SystemException(e);
        }
        return result;
    }

    /**
     * @param resource
     *            String resource.
     * @param objectType
     *            type of the resource.
     * @param indexName
     *            name of the index (may be null for "all indexes")
     * 
     * @throws ApplicationServerSystemException
     *             e
     */
    private void sendUpdateIndexMessage(
        final String resource, final ResourceType objectType,
        final String indexName) throws ApplicationServerSystemException {
        try {
            IndexRequest indexRequest =
                IndexRequestBuilder
                    .createIndexRequest()
                    .withAction(
                        Constants.INDEXER_QUEUE_ACTION_PARAMETER_UPDATE_VALUE)
                    .withIndexName(indexName).withResource(resource)
                    .withObjectType(objectType.getUri())
                    .withIsReindexerCaller(true).build();
            this.indexService.index(indexRequest);
        }
        catch (Exception e) {
            LOG.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * @param objectType
     *            type of the resource.
     * @param indexName
     *            name of the index (may be null for "all indexes")
     * 
     * @throws ApplicationServerSystemException
     *             e
     */
    private void sendDeleteIndexMessage(
        final ResourceType objectType, final String indexName)
        throws ApplicationServerSystemException {
        try {
            IndexRequestBuilder
                .createIndexRequest()
                .withAction(
                    Constants.INDEXER_QUEUE_ACTION_PARAMETER_CREATE_EMPTY_VALUE)
                .withIndexName(indexName)
                .withObjectType(objectType.getUri())
                .withIsReindexerCaller(true)
                .build();
        }
        catch (Exception e) {
            LOG.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * @param resource
     *            String resource.
     * @param type
     *            type of the resource.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @see de.escidoc.core.admin.business
     *      .interfaces.ReindexerInterface#sendUpdateIndexMessage(String)
     */
    private void sendUpdateIndexMessage(
        final String resource, final ResourceType type)
        throws ApplicationServerSystemException {
        sendUpdateIndexMessage(resource, type, indexName);
    }

    /**
     * Get a list of all available resources from Fedora.
     * 
     * @param listQuery
     *            Fedora query to get a list of all resources of the given type
     * 
     * @return list of resource hrefs
     * @throws SystemException
     *             Thrown if eSciDoc failed to receive a resource.
     */
    private Collection<String> getHrefs(final String listQuery)
        throws SystemException {
        Collection<String> result = new LinkedList<String>();

        BufferedReader input = null;

        try {
            input =
                new BufferedReader(new InputStreamReader(
                    fedoraUtility.query(listQuery)));

            String line;

            while ((line = input.readLine()) != null) {
                final String subject = getSubject(line);

                if (subject != null) {
                    result.add(subject);
                }
            }
        }
        catch (IOException e) {
            throw new SystemException(e);
        }
        finally {
            if (input != null) {
                try {
                    input.close();
                }
                catch (IOException e) {
                    throw new SystemException(e);
                }
            }
        }
        return result;
    }

    /**
     * @return the indexConfiguration
     * 
     * @throws ApplicationServerSystemException
     *             Thrown if the index configuration could not be read from
     *             eSciDoc.
     */
    public HashMap<String, HashMap<String, HashMap<String, Object>>> getIndexConfiguration()
        throws ApplicationServerSystemException {
        if (indexConfiguration == null) {
            String indexConfigurationXml =
                escidocCoreHandler.getRequestEscidoc(INDEX_CONFIGURATION_URL);
            StaxParser sp = new StaxParser();
            IndexConfigurationStaxHandler handler =
                new IndexConfigurationStaxHandler(sp);
            sp.addHandler(handler);
            try {
                sp.parse(new ByteArrayInputStream(indexConfigurationXml
                    .getBytes(XmlUtility.CHARACTER_ENCODING)));
            }
            catch (Exception e) {
                throw new ApplicationServerSystemException(e);
            }
            indexConfiguration = handler.getIndexConfiguration();
        }
        return indexConfiguration;
    }

    /**
     * @param escidocCoreHandler
     *            the escidocCoreHandler to set
     */
    public void setEscidocCoreHandler(
        final EscidocCoreHandler escidocCoreHandler) {
        this.escidocCoreHandler = escidocCoreHandler;
    }

    /**
     * @param fedoraUtility
     *            the FedoraUtility to set
     */
    public void setFedoraUtility(final FedoraUtility fedoraUtility) {
        this.fedoraUtility = fedoraUtility;
    }

    /**
     * 
     * @param indexService
     *            index service
     * @spring.property ref="de.escidoc.core.index.IndexService"
     */
    public void setIndexService(final IndexService indexService) {
        this.indexService = indexService;
    }
}
