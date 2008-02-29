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
package de.escidoc.core.admin.test;

import java.io.ByteArrayInputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.regex.Pattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.TransformerException;

import junit.framework.TestCase;

import org.apache.xpath.XPathAPI;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import de.escidoc.core.admin.test.util.ResourceProvider;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.xml.XmlUtility;

public class EscidocAdminTestBase extends TestCase {

    private static AppLogger log =
        new AppLogger(EscidocAdminTestBase.class.getName());

    public static final String ITEM_BASE_URL = "/ir/item";

    public static final String ITEM_SUBMIT_PATH =
        ITEM_BASE_URL + "/${ITEM_ID}/submit";

    public static final String ITEM_RELEASE_PATH =
        ITEM_BASE_URL + "/${ITEM_ID}/release";

    public static final Pattern ITEM_REPLACEMENT_PATTERN =
        Pattern.compile("\\$\\{ITEM_ID\\}");

    public static final String TEMPLATE_BASE_PATH =
        "/de/escidoc/core/admin/test";

    public static final String TEMPLATE_REINDEXER_PATH =
        TEMPLATE_BASE_PATH + "/reindexer/templates";

    public static final String TEMPLATE_REINDEXER_CONTAINER_PATH =
        TEMPLATE_REINDEXER_PATH + "/container";

    public static final String TEMPLATE_REINDEXER_ITEM_PATH =
        TEMPLATE_REINDEXER_PATH + "/item";

    public static final String ITEM_SEARCH_REQUEST =
        "/srw/search/escidoc_all?query=escidoc.objecttype%3Ditem";

    public static final String CONTAINER_SEARCH_REQUEST =
        "/srw/search/escidoc_all?query=escidoc.objecttype%3Dcontainer";

    /**
     * Retrieve a Template as a String.
     * 
     * @param path
     *            The Path of the Template.
     * @param templateName
     *            The name of the template.
     * @return The String representation of the Template.
     * @throws Exception
     *             If anything fails.
     */
    public static String getTemplateAsString(
        final String path, final String templateName) throws Exception {

        return ResourceProvider.getContentsFromInputStream(ResourceProvider
            .getFileInputStreamFromResource(path, templateName));
    }

    /**
     * Gets the value of the specified attribute of the root element from the
     * document.
     * 
     * @param document
     *            The document to retrieve the value from.
     * @param attributeName
     *            The name of the attribute whose value shall be retrieved.
     * @return Returns the attribute value.
     * @throws Exception
     *             If anything fails.
     * @throws TransformerException
     */
    public static String getRootElementAttributeValue(
        final Document document, final String attributeName) throws Exception {

        Node root = getRootElement(document);

        // has not been parsed namespace aware.
        String xPath;
        if (attributeName.startsWith("@")) {
            xPath = "/*/" + attributeName;
        }
        else {
            xPath = "/*/@" + attributeName;
        }
        assertXmlExists("Attribute not found [" + attributeName + "]. ",
            document, xPath);
        final Node attr = selectSingleNode(root, xPath);
        assertNotNull("Attribute not found [" + attributeName + "]. ", attr);
        String value = attr.getTextContent();
        return value;
    }

    /**
     * Gets the root element of the provided document.
     * 
     * @param doc
     *            The document to get the root element from.
     * @return Returns the first child of the document htat is an element node.
     * @throws Exception
     *             If anything fails.
     */
    public static Element getRootElement(final Document doc) throws Exception {

        Node node = doc.getFirstChild();
        while (node != null) {
            if (node != null && node.getNodeType() == Node.ELEMENT_NODE) {
                return (Element) node;
            }
            node = node.getNextSibling();
        }
        return null;
    }

    /**
     * Return the child of the node selected by the xPath.
     * 
     * @param node
     *            The node.
     * 
     * @param xPath
     *            The xPath.
     * @return The child of the node selected by the xPath.
     * @throws TransformerException
     *             If anything fails.
     */
    public static Node selectSingleNode(final Node node, final String xPath)
        throws TransformerException {

        Node result = XPathAPI.selectSingleNode(node, xPath);
        return result;
    }

    /**
     * Assert that the Element/Attribute selected by the xPath exists.
     * 
     * @param message
     *            The message printed if assertion fails.
     * @param node
     *            The Node.
     * @param xPath
     *            The xPath.
     * @throws Exception
     *             If anything fails.
     */
    public static void assertXmlExists(
        final String message, final Node node, final String xPath)
        throws Exception {

        NodeList nodes = selectNodeList(node, xPath);
        assertTrue(message, nodes.getLength() > 0);
    }

    /**
     * Return the list of children of the node selected by the xPath.
     * 
     * @param node
     *            The node.
     * 
     * @param xPath
     *            The xPath.
     * @return The list of children of the node selected by the xPath.
     * @throws TransformerException
     *             If anything fails.
     */
    public static NodeList selectNodeList(final Node node, final String xPath)
        throws TransformerException {
        NodeList result = XPathAPI.selectNodeList(node, xPath);
        return result;
    }

    /**
     * Parse the given xml String into a Document.<br>
     * This is NOT done namespace aware!
     * 
     * @param xml
     *            The xml String.
     * @return The Document.
     * @throws Exception
     *             If anything fails.
     */
    public static Document getDocument(final String xml) throws Exception {

        return getDocument(xml, true);
    }

    /**
     * Parse the given xml String into a Document.<br>
     * This is NOT done namespace aware!
     * 
     * @param xml
     *            The xml String.
     * @param failOnParseError
     *            A flag indicating if method shall fail in case of a parse
     *            error (<code>true</code>) or if the parse exception shall
     *            be thrown (<code>false</code>).
     * @return The Document.
     * @throws Exception
     *             If anything fails.
     */
    public static Document getDocument(
        final String xml, final boolean failOnParseError) throws Exception {

        assertNotNull("Can't create a document without provided XML data. ",
            xml);

        // TODO re work of encoding settings
        String charset = XmlUtility.CHARACTER_ENCODING;
        Document result = null;
        DocumentBuilderFactory docBuilderFactory =
            DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
        try {
            result =
                docBuilder
                    .parse(new ByteArrayInputStream(xml.getBytes(charset)));
        }
        catch (SAXException e) {
            if (failOnParseError) {
                final StringBuffer errorMsg = new StringBuffer("XML invalid. ");
                errorMsg.append(e.getMessage());
                if (log.isDebugEnabled()) {
                    log.debug(errorMsg.toString());
                    log.debug(xml);
                    log.debug("============ End of invalid xml ============");
                    appendStackTrace(errorMsg, e);
                }
                fail(errorMsg.toString());
            }
            else {
                throw e;
            }
        }
        result.getDocumentElement().normalize();
        return result;
    }

    /**
     * Adds the stack trace to the provided string buffer, if debug logging
     * level is enabled.
     * 
     * @param msg
     *            The StringBuffer to append the stack trace to.
     * @param e
     *            The exception for that the stack trace shall be appended.
     */
    private static void appendStackTrace(
        final StringBuffer msg, final Exception e) {

        if (log.isDebugEnabled()) {
            msg.append("\n");
            msg.append(getStackTrace(e));
        }
    }

    /**
     * Retrieve the stack trace from the provided exception and returns it in a
     * <code>String</code>.
     * 
     * @param e
     *            The exception to retrieve the stack trace from.
     * @return Returns the stack trace in a <code>String</code>.
     */
    public static String getStackTrace(final Exception e) {

        StringWriter writer = new StringWriter();
        PrintWriter printwriter = new PrintWriter(writer);
        e.printStackTrace(printwriter);
        return writer.toString();
    }

}
