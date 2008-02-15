package de.escidoc.core.admin;

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
import de.escidoc.core.admin.common.util.stax.handler.ItemHrefHandler;
import de.escidoc.core.common.business.Constants;
import de.escidoc.core.common.util.stax.StaxParser;
import de.escidoc.core.common.util.xml.XmlUtility;

public class AdminMain {

    String escidocOmUrl = "http://localhost:8080";

    String escidocSbUrl = "jnp://localhost:1099";

    /**
     * TODO: Describe Method
     * 
     * @param args
     */
    public static void main(String[] args) {
        AdminMain admin = new AdminMain();
        if (args != null && args.length > 0) {
            System.out.println(args[0]);
            if (args[0].equals("reindex")) {
                admin.reindex(args);
            }
            else if (args[0].equals("test")) {
                admin.test(args);
            }
        }
        else {
            System.out.println("please provide method-argument");
        }
    }

    private void test(String[] args) {
        System.out.println("Test method invoked!");
        if (args.length > 1 && args[1] != null) {
            escidocOmUrl = args[1];
        }
        if (args.length > 2 && args[2] != null) {
            escidocSbUrl = args[2];
        }

        System.out.println("escidocOmUrl=" + getEscidocOmUrl());
        System.out.println("escidocSbUrl=" + getEscidocSbUrl());
    }

    /**
     * TODO: Describe Method
     * 
     * @param args
     */
    private void reindex(String[] args) {
        // args[1] can be om-url (eg http://escidev5:8080)
        // args[2] can be sb-url (eg jnp://escidev6:1098)

        if (args.length > 1 && args[1] != null) {
            escidocOmUrl = args[1];
        }
        if (args.length > 2 && args[2] != null) {
            escidocSbUrl = args[2];
        }

        if (!escidocOmUrl.startsWith("http://")) {
            escidocOmUrl = "http://" + escidocOmUrl;
        }

        // get all released items from om
        EscidocCoreHandler escidocHandler = new EscidocCoreHandler();

        try {
            String filter =
                "<param><filter name=\"http://escidoc.de/core/01/properties/public-status\">released</filter></param>";
            String result =
                escidocHandler.requestEscidoc("/ir/items/filter/refs", filter,
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

            Vector<String> hrefs = handler.getHrefs();
            JndiHandler jndiHandler = new JndiHandler();
            jndiHandler.setInitialContext(escidocSbUrl);

            // Get Connection to Queue
            QueueConnectionFactory factory =
                (QueueConnectionFactory) jndiHandler
                    .getJndiObject("ConnectionFactory");
            QueueConnection queueConnection = factory.createQueueConnection();
            QueueSession queueSession =
                queueConnection.createQueueSession(false,
                    Session.AUTO_ACKNOWLEDGE);
            Queue queue =
                (Queue) jndiHandler.getJndiObject("queue/IndexerMessageQueue");
            MessageProducer messageProducer =
                queueSession.createProducer(queue);

            // Delete Indexes
            ObjectMessage message = queueSession.createObjectMessage();
            message.setStringProperty(Constants.INDEXER_QUEUE_ACTION_PARAMETER,
                Constants.INDEXER_QUEUE_ACTION_PARAMETER_CREATE_EMPTY_VALUE);
            messageProducer.send(message);
            Thread.sleep(5000);

            for (String resource : hrefs) {
                // Send message to
                // Queue///////////////////////////////////////////
                message = queueSession.createObjectMessage();
                message.setStringProperty(
                    Constants.INDEXER_QUEUE_ACTION_PARAMETER,
                    Constants.INDEXER_QUEUE_ACTION_PARAMETER_UPDATE_VALUE);
                message.setStringProperty(
                    Constants.INDEXER_QUEUE_RESOURCE_PARAMETER, resource);
                messageProducer.send(message);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @return the escidocOmUrl
     */
    public String getEscidocOmUrl() {
        return escidocOmUrl;
    }

    /**
     * @param escidocOmUrl
     *            the escidocOmUrl to set
     */
    public void setEscidocOmUrl(String escidocOmUrl) {
        this.escidocOmUrl = escidocOmUrl;
    }

    /**
     * @return the escidocSbUrl
     */
    public String getEscidocSbUrl() {
        return escidocSbUrl;
    }

    /**
     * @param escidocSbUrl
     *            the escidocSbUrl to set
     */
    public void setEscidocSbUrl(String escidocSbUrl) {
        this.escidocSbUrl = escidocSbUrl;
    }

}
