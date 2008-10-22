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

import java.io.ByteArrayInputStream;
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

import de.escidoc.core.admin.business.interfaces.ReindexerInterface;
import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.admin.common.util.stax.handler.ListHrefHandler;
import de.escidoc.core.common.business.Constants;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.xml.XmlUtility;

/**
 * Provides Methods used for Reindexing.
 * 
 * @spring.bean id="de.escidoc.core.admin.Reindexer"
 * 
 * @admin
 */
public class Reindexer implements ReindexerInterface {
	
    private static final String ITEM_FILTER_URL = "/ir/items/filter";

    private static final String CONTAINER_FILTER_URL = "/ir/containers/filter";

    private static final String ORG_UNIT_FILTER_URL = 
    			"/oum/organizational-units/filter";
    
    private static final String ITEM_LIST_ELEMENT_NAME = "item-list";

    private static final String ITEM_ELEMENT_NAME = "item";

    private static final String CONTAINER_LIST_ELEMENT_NAME = "container-list";

    private static final String CONTAINER_ELEMENT_NAME = "container";

    private static final String ORG_UNIT_LIST_ELEMENT_NAME = 
                                        "organizational-unit-list";

    private static final String ORG_UNIT_ELEMENT_NAME = "organizational-unit";

    private static final String RELEASED_ITEMS_FILTER =
        "<param>"
        + "<filter name=\"http://escidoc.de/core/01/properties/public-status\">"
        + "released"
        + "</filter><limit>0</limit><offset>0</offset></param>";

    private static final String RELEASED_CONTAINERS_FILTER =
        "<param>"
        + "<filter name=\"http://escidoc.de/core/01/properties/public-status\">"
        + "released"
        + "</filter><limit>0</limit><offset>0</offset></param>";
    
    private static final String OPEN_CLOSED_ORG_UNITS_FILTER =
        "<param>"
        + "<filter name=\"http://escidoc.de/core/01/properties/public-status\">"
        + "opened"
        + "</filter>"
        + "<filter name=\"http://escidoc.de/core/01/properties/public-status\">"
        + "closed"
        + "</filter>"
        + "<limit>0</limit><offset>0</offset></param>";
    
    private static final int FILTER_LIMIT = 5000;
    
    private static final String 
        FEDORA_ACCESS_DEVIATION_HANDLER_TARGET_NAMESPACE =
    	"http://localhost:8080/axis/services/access";
    
    private static final String 
        FEDORA_MANAGEMENT_DEVIATION_HANDLER_TARGET_NAMESPACE =
    	"http://localhost:8080/axis/services/management";
    
    private static final String EXPORT_METHOD_NAME = "export";
    
    private static final String DATASTREAM_DISSEMINATION_METHOD_NAME = 
    								"getDatastreamDissemination";
    
    private static final Pattern LIMIT_PATTERN = 
        Pattern.compile("(.*?<limit>).*?(<\\/limit>.*?)");
    
    private static Matcher LIMIT_MATCHER = LIMIT_PATTERN.matcher("");

    private static final Pattern OFFSET_PATTERN = 
        Pattern.compile("(.*?<offset>).*?(<\\/offset>.*?)");
    
    private static Matcher OFFSET_MATCHER = OFFSET_PATTERN.matcher("");

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
     * @return Vector item-hrefs
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *  .interfaces.ReindexerInterface#getPublicItems()
     */
    public Vector<String> getFilteredItems()
        throws ApplicationServerSystemException {
        return getFilteredObjects(
                RELEASED_ITEMS_FILTER, 
                ITEM_FILTER_URL, 
                ITEM_LIST_ELEMENT_NAME, 
                ITEM_ELEMENT_NAME);
    }

    /**
     * 
     * @return Vector container-hrefs
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *  .interfaces.ReindexerInterface#getPublicContainers()
     */
    public Vector<String> getFilteredContainers()
        throws ApplicationServerSystemException {
        return getFilteredObjects(
                RELEASED_CONTAINERS_FILTER, 
                CONTAINER_FILTER_URL, 
                CONTAINER_LIST_ELEMENT_NAME, 
                CONTAINER_ELEMENT_NAME);
    }

    /**
     * 
     * @return Vector org-unit-hrefs
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *  .interfaces.ReindexerInterface#getPublicOrganizationalUnits()
     */
    public Vector<String> getFilteredOrganizationalUnits()
        throws ApplicationServerSystemException {
        return getFilteredObjects(
                OPEN_CLOSED_ORG_UNITS_FILTER, 
                ORG_UNIT_FILTER_URL, 
                ORG_UNIT_LIST_ELEMENT_NAME, 
                ORG_UNIT_ELEMENT_NAME);
    }

    /**
     * Retrieves filtered list of objects (item, container, org-unit),
     * extracts the hrefs to the objects in the list
     * and returns Vector of hrefs.
     * 
     * @param filter filterXml
     * @param filterUrl url for filtered list
     * @param listElementName root-element name of the list
     * @param elementName filterXml element name of one list-entry
     * 
     * @return Vector object-hrefs
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    private Vector<String> getFilteredObjects(
                            final String filter, 
                            final String filterUrl, 
                            final String listElementName, 
                            final String elementName)
                            throws ApplicationServerSystemException {
        Vector<String> hrefs = new Vector<String>();
        int totalSize = Integer.MAX_VALUE;
        try {
            String objectFilter = filter;
            LIMIT_MATCHER.reset(objectFilter);
            objectFilter = LIMIT_MATCHER.replaceFirst(
                                    "$1" + FILTER_LIMIT + "$2");
            for (int i = 0; i < totalSize; i += FILTER_LIMIT) {
                OFFSET_MATCHER.reset(objectFilter);
                objectFilter = OFFSET_MATCHER.replaceAll(
                                                "$1" + i + "$2");
                String result =
                    escidocCoreHandler.postRequestEscidoc(filterUrl,
                            objectFilter);

                StaxParser sp = new StaxParser();
                ListHrefHandler handler = new ListHrefHandler(
                        sp, listElementName, elementName);
                sp.addHandler(handler);

                sp.parse(new ByteArrayInputStream(result
                    .getBytes(XmlUtility.CHARACTER_ENCODING)));
                hrefs.addAll(handler.getHrefs());
                if (totalSize == Integer.MAX_VALUE) {
                    if (handler.getNumberOfRecords() == -1) {
                        throw new Exception(
                                "Attribute numberOfRecords not found");
                    }
                    totalSize = handler.getNumberOfRecords();
                }
            }
            return hrefs;
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * @param resource resource
     * @return String resourceXml
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *  .interfaces.ReindexerInterface#retrieveResource(String resource)
     */
    public String retrieveResource(final String resource)
        throws ApplicationServerSystemException {
        try {
            String result =
                escidocCoreHandler.getRequestEscidoc(resource);
            return result;
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * @param resource resource
     * @return Object fedoraObject
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *  .interfaces.ReindexerInterface#fedoraExport(final String resource)
     */
    public Object fedoraExport(
    					final String resource)
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
     * @param resource resource
     * @return Object fedoraObject
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *  .interfaces.ReindexerInterface#fedoraGetDatastreamDissemination(
     *      final String resource)
     */
    public Object fedoraGetDatastreamDissemination(
    					final String resource)
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
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *  .interfaces.ReindexerInterface#sendDeleteIndexMessage()
     */
    public void sendDeleteIndexMessage()
        throws ApplicationServerSystemException {
        try {
        	if (queueConnection == null) {
        		createQueueConnection();
        	}
            // Delete Indexes
            ObjectMessage message = queueSession.createObjectMessage();
            message.setStringProperty(Constants.INDEXER_QUEUE_ACTION_PARAMETER,
                Constants.INDEXER_QUEUE_ACTION_PARAMETER_CREATE_EMPTY_VALUE);
            messageProducer.send(message);
            Thread.sleep(10000);
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * @param resource
     *            String resource.
     * @param resourceName
     *            name of the resource.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     * @see de.escidoc.core.admin.business
     *  .interfaces.ReindexerInterface#sendUpdateIndexMessage(String)
     */
    public void sendUpdateIndexMessage(final String resource, 
    									final String resourceName)
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
                    Constants.INDEXER_QUEUE_RESOURCE_NAME_PARAMETER
                    , resourceName);
            message.setBooleanProperty(
                    Constants.INDEXER_QUEUE_WRITE_SYNCHRONOUS_PARAMETER
                    , true);
            messageProducer.send(message);
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }


    /**
     * @throws Exception e
     * create connection to SB-indexing-indexerMessageQueue.
     * 
     *             e
     * @admin
     */
    private void createQueueConnection() throws Exception {
		this.queueConnection = 
			this.queueConnectionFactory.createQueueConnection(
										queueUser, queuePassword);
		this.queueSession =
			this.queueConnection.createQueueSession(false,
                Session.AUTO_ACKNOWLEDGE);
        this.messageProducer = 
        	queueSession.createProducer(this.indexerMessageQueue);
    }

    /**
     * close connection to SB-indexing-indexerMessageQueue.
     * 
     *             e
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
	 * @param escidocCoreHandler the escidocCoreHandler to set
	 */
	public void setEscidocCoreHandler(
			final EscidocCoreHandler escidocCoreHandler) {
		this.escidocCoreHandler = escidocCoreHandler;
	}

	/**
	 * @param queueConnectionFactory the queueConnectionFactory to set
	 * @throws Exception e
	 */
	public void setQueueConnectionFactory(
			final QueueConnectionFactory queueConnectionFactory) 
													throws Exception {
		this.queueConnectionFactory = queueConnectionFactory;
	}

	/**
	 * @param indexerMessageQueue the indexerMessageQueue to set
	 * @throws Exception e
	 */
	public void setIndexerMessageQueue(final Queue indexerMessageQueue)
														throws Exception {
		this.indexerMessageQueue = indexerMessageQueue;
	}

	/**
	 * @param queueUser the queueUser to set
	 */
	public void setQueueUser(final String queueUser) {
		this.queueUser = queueUser;
	}

	/**
	 * @param queuePassword the queuePassword to set
	 */
	public void setQueuePassword(final String queuePassword) {
		this.queuePassword = queuePassword;
	}

}
