package de.escidoc.core.admin.test;

import java.io.IOException;
import java.io.StringReader;
import java.util.Iterator;

import javax.xml.namespace.NamespaceContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import de.escidoc.core.admin.business.IngestTool;
import de.escidoc.core.client.TransportProtocol;
import de.escidoc.core.client.soap.SoapItemHandlerClient;
import de.escidoc.core.common.business.fedora.resources.ResourceType;
import junit.framework.TestCase;

public class IngestToolTests extends TestCase {

    /**
     * Negative test, checks if wrong/insufficient arguments yield expected
     */
    public void testArgumentsFail() {
        IngestTool tool = new IngestTool();

        // No arguments
        String[] arguments = new String[] {};
        tool.processArguments(arguments);
    }

    public void testXpathDetectObjid() {
        IngestTool tool = new IngestTool();
        String objId = "escidoc:1234";
        String objIdFromFramework =
            tool
                .executeXPath(
                    "<?xml version=\"1.0\" encoding=\"UTF-8\"?><result><objid resourceType=\"ITEM\">"
                        + objId + "</objid></result>", IngestTool.XPATH_OBJID);
        assertEquals(objIdFromFramework, objId);
    }

    public void testXpathDetectResourceType() {
        IngestTool tool = new IngestTool();
        String objId = "escidoc:1234";
        String resourceType = "ITEM";
        String resourceTypeFromFramework =
            tool.executeXPath(
                "<?xml version=\"1.0\" encoding=\"UTF-8\"?><result><objid resourceType=\""
                    + resourceType + "\">" + objId + "</objid></result>",
                IngestTool.XPATH_RESOURCE_TYPE);
        assertEquals(resourceType, resourceTypeFromFramework);
    }

    public void testXpathNothingFound() throws ParserConfigurationException,
        SAXException, IOException {
        IngestTool tool = new IngestTool();

        String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        xml +=
            "<?xml-stylesheet type=\"text/xsl\" href=\"http://localhost:8080/xsl/Resource2Html.xsl\"?>"
                + "<result xmlns=\"http://www.escidoc.de/schemas/result/0.1\" >"
                + "<objid resourceType=\"\"></objid></result>";


        String objIdFromFramework =
                executeXPath(xml, IngestTool.XPATH_OBJID);

        String resourceTypeFromFramework =
                executeXPath(xml, IngestTool.XPATH_RESOURCE_TYPE);
        assertEquals(objIdFromFramework,"");
        assertEquals(resourceTypeFromFramework,"");
    }

    public String executeXPath(final String doc, final String xpathExpression) {
        String value = null;
        try {
            NamespaceContext ctx = new NamespaceContext() {
                public String getNamespaceURI(String prefix) {
                    if (prefix.equals("result"))
                        return "http://www.escidoc.de/schemas/result/0.1";
                    return null;
                }

                public String getPrefix(String namespaceURI) {
                    return null;
                }

                public Iterator getPrefixes(String namespaceURI) {
                    return null;
                }
            };

            XPath xpath = XPathFactory.newInstance().newXPath();

            xpath.setNamespaceContext(ctx);
            InputSource inputSource = new InputSource(new StringReader(doc));
            return (String) xpath.evaluate(xpathExpression, inputSource);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return value;
    }


    public void testXpathEmptyXml() {
        IngestTool tool = new IngestTool();
        String objId = "escidoc:1234";
        String resourceType = "";
        String resourceTypeFromFramework =
            tool.executeXPath("", IngestTool.XPATH_RESOURCE_TYPE);
        assertEquals(null, resourceTypeFromFramework);

    }

    public void testGetCombinedClassNameOk() {
        IngestTool tool = new IngestTool();
        String className =
            tool.getCombinedClassName(TransportProtocol.SOAP.toString(),
                ResourceType.ITEM.toString());
        try {
            SoapItemHandlerClient.class.getName();
            Class clazz = Class.forName(className);
            assert (clazz.getName().endsWith(className));

        }
        catch (ClassNotFoundException e) {
            e.printStackTrace();
            fail();
        }
    }

    public void testMethodCallOnClass() {
        IngestTool tool = new IngestTool();
        String className =
            tool.getCombinedClassName(TransportProtocol.SOAP.toString(),
                ResourceType.ITEM.toString());
        try {
            SoapItemHandlerClient.class.getName();
            Class clazz = Class.forName(className);
            tool.callMethodOnClass(clazz, "ingest",
                new Class[] { String.class }, new Object[] { "test" });

        }
        catch (Exception e) {
            e.printStackTrace();
            fail();
        }
    }
}
