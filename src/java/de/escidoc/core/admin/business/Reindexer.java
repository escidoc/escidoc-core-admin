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
package de.escidoc.core.admin.business;

import java.io.ByteArrayInputStream;
import java.util.Vector;

import javax.jms.MessageProducer;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.jms.Session;

import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.admin.common.util.JndiHandler;
import de.escidoc.core.admin.common.util.stax.handler.ContainerHrefHandler;
import de.escidoc.core.admin.common.util.stax.handler.ItemHrefHandler;
import de.escidoc.core.common.business.Constants;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.xml.XmlUtility;

/**
 * Provides Methods used for Reindexing.
 * 
 * @admin
 */
public class Reindexer {

    private final String INDEXER_QUEUE_NAME = "queue/IndexerMessageQueue";
    
    private final String ITEM_FILTER_URL = "/ir/items/filter/refs";

    private final String CONTAINER_FILTER_URL = "/ir/containers/filter/refs";

    private final String RELEASED_ITEMS_FILTER = 
    	"<param><filter name=\"http://escidoc.de/core/01/properties/public-status\">released</filter></param>";

    private final String RELEASED_CONTAINERS_FILTER = 
    	"<param><filter name=\"http://escidoc.de/core/01/properties/public-status\">released</filter></param>";
	
	private static AppLogger log =
        new AppLogger(Reindexer.class.getName());
    
    private EscidocCoreHandler escidocHandler;
    private JndiHandler jndiHandler;
    private String escidocOmUrl;
    private QueueConnectionFactory factory;
    private QueueConnection queueConnection;
    private QueueSession queueSession;
    private Queue queue;
    private MessageProducer messageProducer;

    /**
     * Constructor with no arguments is not allowed.
     * 
     * @admin
     */
    private Reindexer() {
    	
    }
    
    /**
     * Constructor that takes url of om 
     * and url of naming-service of SB.
     * 
     * @admin
     */
    public Reindexer(
    		final String escidocOmUrl, 
    		final String escidocSbUrl) 
    		throws ApplicationServerSystemException {
    	if (escidocOmUrl == null || escidocSbUrl == null) {
    		throw new ApplicationServerSystemException(
    						"providerUrls may not be null");
    	}
    	jndiHandler = new JndiHandler(escidocSbUrl);
    	escidocHandler = new EscidocCoreHandler();
    	this.escidocOmUrl = escidocOmUrl;
    	establishQueueConnection();
    }
    
    /**
     * Close Connection to SB-Indexing-Queue.
     * 
     * @admin
     */
    public void close() {
    	disposeQueueConnection();
    }
    
    /**
     * Get all released Items from OM and put hrefs into Vector.
     * 
     * @param resource
     *            String resource.
     * @return String response
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    public Vector<String> getReleasedItems()
        throws ApplicationServerSystemException {
        try {
            String result =
                escidocHandler.requestEscidoc(ITEM_FILTER_URL, RELEASED_ITEMS_FILTER,
                    escidocOmUrl);

            StaxParser sp = new StaxParser();
            ItemHrefHandler handler = new ItemHrefHandler(sp);
            sp.addHandler(handler);

            try {
                sp.parse(new ByteArrayInputStream(result
                    .getBytes(XmlUtility.CHARACTER_ENCODING)));
            }
            catch (Exception e) {
                e.printStackTrace();
            }

            return handler.getHrefs();
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }

    /**
     * Get all released Containers from OM and put hrefs into Vector.
     * 
     * @param resource
     *            String resource.
     * @return String response
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    public Vector<String> getReleasedContainers()
        throws ApplicationServerSystemException {
        try {
            String result =
                escidocHandler.requestEscidoc(CONTAINER_FILTER_URL, RELEASED_CONTAINERS_FILTER,
                    escidocOmUrl);

            StaxParser sp = new StaxParser();
            ContainerHrefHandler handler = new ContainerHrefHandler(sp);
            sp.addHandler(handler);

            try {
                sp.parse(new ByteArrayInputStream(result
                    .getBytes(XmlUtility.CHARACTER_ENCODING)));
            }
            catch (Exception e) {
                e.printStackTrace();
            }

            return handler.getHrefs();
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }
    
    /**
     * Send delete-index Message to SB.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    public void sendDeleteIndexMessage()
        throws ApplicationServerSystemException {
        try {
            // Delete Indexes
            ObjectMessage message = queueSession.createObjectMessage();
            message.setStringProperty(Constants.INDEXER_QUEUE_ACTION_PARAMETER,
                Constants.INDEXER_QUEUE_ACTION_PARAMETER_CREATE_EMPTY_VALUE);
            messageProducer.send(message);
            Thread.sleep(5000);
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }
    
    /**
     * Send update-index Message to SB.
     * 
     * @param resource
     *            String resource.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    public void sendUpdateIndexMessage(final String resource)
        throws ApplicationServerSystemException {
        try {
            // Send message to
            // Queue///////////////////////////////////////////
        	ObjectMessage message = queueSession.createObjectMessage();
            message.setStringProperty(
                Constants.INDEXER_QUEUE_ACTION_PARAMETER,
                Constants.INDEXER_QUEUE_ACTION_PARAMETER_UPDATE_VALUE);
            message.setStringProperty(
                Constants.INDEXER_QUEUE_RESOURCE_PARAMETER, resource);
            messageProducer.send(message);
        }
        catch (Exception e) {
            log.error(e);
            throw new ApplicationServerSystemException(e);
        }
    }
    
    /**
     * establish connection to SB-indexing-queue.
     * 
     * @throws ApplicationServerSystemException
     *             e
     * @admin
     */
    private void establishQueueConnection() throws ApplicationServerSystemException {
        try {
        	// Get Connection to Queue
            factory =
                (QueueConnectionFactory) jndiHandler
                    .getJndiObject("ConnectionFactory");
            queueConnection = factory.createQueueConnection();
            queueSession =
                queueConnection.createQueueSession(false,
                    Session.AUTO_ACKNOWLEDGE);
            queue =
                (Queue) jndiHandler.getJndiObject(INDEXER_QUEUE_NAME);
            messageProducer =
                queueSession.createProducer(queue);

        } catch (Exception e) {
            log.error(e);
        	throw new ApplicationServerSystemException(e);
        }

    }

    /**
     * close connection to SB-indexing-queue.
     * 
     * @throws ApplicationServerSystemException
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

}
