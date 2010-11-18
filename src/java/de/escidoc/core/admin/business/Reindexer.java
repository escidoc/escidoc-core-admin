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

import static de.escidoc.core.common.business.Constants.CONTAINER_OBJECT_TYPE;
import static de.escidoc.core.common.business.Constants.CONTENT_MODEL_OBJECT_TYPE;
import static de.escidoc.core.common.business.Constants.CONTENT_RELATION2_OBJECT_TYPE;
import static de.escidoc.core.common.business.Constants.CONTEXT_OBJECT_TYPE;
import static de.escidoc.core.common.business.Constants.ITEM_OBJECT_TYPE;
import static de.escidoc.core.common.business.Constants.ORGANIZATIONAL_UNIT_OBJECT_TYPE;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.jms.MessageProducer;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.jms.Session;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpConnectionManager;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;

import de.escidoc.core.admin.business.interfaces.ReindexerInterface;
import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.common.business.Constants;
import de.escidoc.core.common.business.fedora.FedoraUtility;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.exceptions.system.SystemException;
import de.escidoc.core.common.util.configuration.EscidocConfiguration;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.stax.handler.IndexConfigurationStaxHandler;
import de.escidoc.core.common.util.xml.XmlUtility;

/**
 * Provides Methods used for Reindexing.
 * 
 * @spring.bean id="de.escidoc.core.admin.Reindexer"
 * 
 * @admin
 */
public class Reindexer implements ReindexerInterface {

    /**
     * Triple store query to get a list of all containers.
     */
    private static final String CONTAINER_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + CONTAINER_OBJECT_TYPE + "%3e";

    /**
     * Triple store query to get a list of all Content Models.
     */
    private static final String CONTENT_MODEL_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + CONTENT_MODEL_OBJECT_TYPE + "%3e";

    /**
     * Triple store query to get a list of all content relations.
     */
    private static final String CONTENT_RELATION_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + CONTENT_RELATION2_OBJECT_TYPE + "%3e";

    /**
     * Triple store query to get a list of all contexts.
     */
    private static final String CONTEXT_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + CONTEXT_OBJECT_TYPE + "%3e";

    /**
     * Triple store query to get a list of all items.
     */
    private static final String ITEM_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + ITEM_OBJECT_TYPE + "%3e";

    /**
     * Triple store query to get a list of all organizational units.
     */
    private static final String OU_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + ORGANIZATIONAL_UNIT_OBJECT_TYPE + "%3e";

    private static final String INDEX_CONFIGURATION_URL =
        "/adm/admin/get-index-configuration";

    private static final String FEDORA_ACCESS_DEVIATION_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/access";

    private static final String FEDORA_MANAGEMENT_DEVIATION_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/management";

    private static final String EXPORT_METHOD_NAME = "export";

    private static final String DATASTREAM_DISSEMINATION_METHOD_NAME =
        "getDatastreamDissemination";

    private HashMap<String, HashMap<String, HashMap<String, Object>>> indexConfiguration =
        null;

    private static AppLogger log = new AppLogger(Reindexer.class.getName());

    private EscidocCoreHandler escidocCoreHandler;

    private QueueConnectionFactory queueConnectionFactory;

    private QueueConnection queueConnection = null;

    private QueueSession queueSession;

    private Queue indexerMessageQueue;

    private MessageProducer messageProducer;

    private String queueUser;

    private String queuePassword;

    /**
     * Property "clearIndex" from configuration file.
     */
    private final boolean clearIndex;

    /**
     * Property "indexName" from configuration file.
     */
    private final String indexName;

    private FedoraUtility fedoraUtility = null;

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
            sendDeleteIndexMessage(Constants.ITEM_OBJECT_TYPE, indexName);
            sendDeleteIndexMessage(Constants.CONTAINER_OBJECT_TYPE, indexName);
            sendDeleteIndexMessage(Constants.ORGANIZATIONAL_UNIT_OBJECT_TYPE,
                indexName);
        }
    }

    /**
     * Close Connection to SB-Indexing-Queue.
     * 
     * @admin
     * @see de.escidoc.core.admin.business.interfaces.ReindexerInterface#close()
     */
    public void close() {
        disposeQueueConnection();
    }

    /**
     * 
     * @return Collection of container-hrefs
     * 
     * @throws SystemException
     *             e
     */
    public Collection<String> getFilteredContainers() throws SystemException {
        return removeExistingIds(getHrefs(CONTAINER_LIST_QUERY),
            Constants.CONTAINER_OBJECT_TYPE);
    }

    /**
     * 
     * @return Collection of item-hrefs
     * 
     * @throws SystemException
     *             e
     */
    public Collection<String> getFilteredItems() throws SystemException {
        return removeExistingIds(getHrefs(ITEM_LIST_QUERY),
            Constants.ITEM_OBJECT_TYPE);
    }

    /**
     * 
     * @return Collection of org-unit-hrefs
     * 
     * @throws SystemException
     *             e
     */
    public Collection<String> getFilteredOrganizationalUnits()
        throws SystemException {
        return removeExistingIds(getHrefs(OU_LIST_QUERY),
            Constants.ORGANIZATIONAL_UNIT_OBJECT_TYPE);
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
     * Remove all ids from the given list which already exist in the given
     * index.
     * 
     * @param ids
     *            list of resource ids
     * @param objectType
     *            String name of the resource (eg Item, Container...).
     * 
     * @return filtered list of resource ids
     * @throws SystemException
     *             Thrown if a framework internal error occurs.
     */
    private Collection<String> removeExistingIds(
        final Collection<String> ids, final String objectType)
        throws SystemException {
        Collection<String> result = null;

        if (clearIndex) {
            result = ids;
        }
        else {
            result = new Vector<String>();
            for (String id : ids) {
                if (!exists(id.substring(id.lastIndexOf('/') + 1), objectType,
                    indexName)) {
                    result.add(id);
                }
            }
        }
        return result;
    }

    /**
     * @param resource
     *            resource
     * @return String resourceXml
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *      .interfaces.ReindexerInterface#retrieveResource(String resource)
     */
    public String retrieveResource(final String resource)
        throws ApplicationServerSystemException {
        try {
            String result = escidocCoreHandler.getRequestEscidoc(resource);
            return result;
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
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
            HttpClient client = new HttpClient();
            HttpConnectionManager connectionManager =
                client.getHttpConnectionManager();
            HttpConnectionManagerParams params = connectionManager.getParams();

            params.setConnectionTimeout(5000);

            GetMethod method =
                new GetMethod(EscidocConfiguration.getInstance().get(
                    EscidocConfiguration.ESCIDOC_CORE_BASEURL)
                    + "/srw/search/" + indexName + "?query=PID=" + id);

            if (client.executeMethod(method) == HttpURLConnection.HTTP_OK) {
                Pattern numberOfRecordsPattern =
                    Pattern.compile("numberOfRecords>(.*?)<");
                Matcher m =
                    numberOfRecordsPattern.matcher(method
                        .getResponseBodyAsString());

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
     *            resource
     * @return Object fedoraObject
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *      .interfaces.ReindexerInterface#fedoraExport(final String resource)
     */
    public Object fedoraExport(final String resource)
        throws ApplicationServerSystemException {
        try {
            Object[] arguments = new Object[3];
            arguments[0] = resource;
            arguments[1] = "";
            arguments[2] = "public";
            Object result =
                escidocCoreHandler.soapRequestEscidoc(
                    FEDORA_MANAGEMENT_DEVIATION_HANDLER_TARGET_NAMESPACE,
                    EXPORT_METHOD_NAME, arguments);
            return result;
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * @param resource
     *            resource
     * @return Object fedoraObject
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *      .interfaces.ReindexerInterface#fedoraGetDatastreamDissemination(
     *      final String resource)
     */
    public Object fedoraGetDatastreamDissemination(final String resource)
        throws ApplicationServerSystemException {
        try {
            Object[] arguments = new Object[3];
            arguments[0] = "";
            arguments[1] = resource;
            arguments[2] = "";
            Object result =
                escidocCoreHandler.soapRequestEscidoc(
                    FEDORA_ACCESS_DEVIATION_HANDLER_TARGET_NAMESPACE,
                    DATASTREAM_DISSEMINATION_METHOD_NAME, arguments);
            return result;
        }
        catch (Exception e) {
            log.error(e);
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
        final String objectType, final String indexName)
        throws ApplicationServerSystemException {
        try {
            if (queueConnection == null) {
                createQueueConnection();
            }
            // Delete Indexes
            ObjectMessage message = queueSession.createObjectMessage();
            message.setStringProperty(Constants.INDEXER_QUEUE_ACTION_PARAMETER,
                Constants.INDEXER_QUEUE_ACTION_PARAMETER_CREATE_EMPTY_VALUE);
            message.setStringProperty(
                Constants.INDEXER_QUEUE_OBJECT_TYPE_PARAMETER, objectType);
            message.setStringProperty(
                Constants.INDEXER_QUEUE_PARAMETER_INDEX_NAME, indexName);
            messageProducer.send(message);
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * @param resource
     *            String resource.
     * @param objectType
     *            type of the resource.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *      .interfaces.ReindexerInterface#sendUpdateIndexMessage(String)
     */
    public void sendUpdateIndexMessage(
        final String resource, final String objectType)
        throws ApplicationServerSystemException {
        try {
            if (queueConnection == null) {
                createQueueConnection();
            }
            // Send message to
            // Queue///////////////////////////////////////////
            ObjectMessage message = queueSession.createObjectMessage();
            message.setStringProperty(Constants.INDEXER_QUEUE_ACTION_PARAMETER,
                Constants.INDEXER_QUEUE_ACTION_PARAMETER_UPDATE_VALUE);
            message.setStringProperty(
                Constants.INDEXER_QUEUE_RESOURCE_PARAMETER, resource);
            message.setStringProperty(
                Constants.INDEXER_QUEUE_OBJECT_TYPE_PARAMETER, objectType);
            message.setStringProperty(
                Constants.INDEXER_QUEUE_PARAMETER_INDEX_NAME, indexName);
            messageProducer.send(message);
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
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
     * @throws Exception
     *             e create connection to SB-indexing-indexerMessageQueue.
     * 
     *             e
     * @admin
     */
    private void createQueueConnection() throws Exception {
        this.queueConnection =
            this.queueConnectionFactory.createQueueConnection(queueUser,
                queuePassword);
        this.queueSession =
            this.queueConnection.createQueueSession(false,
                Session.AUTO_ACKNOWLEDGE);
        this.messageProducer =
            queueSession.createProducer(this.indexerMessageQueue);
    }

    /**
     * close connection to SB-indexing-indexerMessageQueue.
     * 
     * e
     * 
     * @admin
     */
    private void disposeQueueConnection() {
        if (messageProducer != null) {
            try {
                messageProducer.close();
            }
            catch (Exception e1) {
                log.error(e1);
            }
            messageProducer = null;
        }
        if (queueSession != null) {
            try {
                queueSession.close();
            }
            catch (Exception e1) {
                log.error(e1);
            }
            queueSession = null;
        }
        if (queueConnection != null) {
            try {
                queueConnection.close();
            }
            catch (Exception e1) {
                log.error(e1);
            }
            queueConnection = null;
        }
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
     * @param queueConnectionFactory
     *            the queueConnectionFactory to set
     * @throws Exception
     *             e
     */
    public void setQueueConnectionFactory(
        final QueueConnectionFactory queueConnectionFactory) throws Exception {
        this.queueConnectionFactory = queueConnectionFactory;
    }

    /**
     * @param indexerMessageQueue
     *            the indexerMessageQueue to set
     * @throws Exception
     *             e
     */
    public void setIndexerMessageQueue(final Queue indexerMessageQueue)
        throws Exception {
        this.indexerMessageQueue = indexerMessageQueue;
    }

    /**
     * @param queueUser
     *            the queueUser to set
     */
    public void setQueueUser(final String queueUser) {
        this.queueUser = queueUser;
    }

    /**
     * @param queuePassword
     *            the queuePassword to set
     */
    public void setQueuePassword(final String queuePassword) {
        this.queuePassword = queuePassword;
    }

}
