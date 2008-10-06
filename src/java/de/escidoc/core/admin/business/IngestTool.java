package de.escidoc.core.admin.business;

import gnu.getopt.Getopt;

import java.io.BufferedInputStream;
import java.io.StringReader;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.xml.namespace.NamespaceContext;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.xml.sax.InputSource;

import de.escidoc.core.admin.common.util.NameValueBean;
import de.escidoc.core.client.TransportProtocol;
import de.escidoc.core.client.exceptions.EscidocException;
import de.escidoc.core.client.exceptions.InternalClientException;
import de.escidoc.core.common.business.fedora.resources.ResourceType;

/**
 *
 * @author KST
 *
 */
public class IngestTool {

    // XPATH
    public static final String XPATH_OBJID =
        "/result:result/result:objid/text()";

    public static final String XPATH_RESOURCE_TYPE =
        "/result:result/result:objid/@resourceType";

    private static final String SCHEMA_PREFIX_RESULT =
        "http://www.escidoc.de/schemas/result/0.1";

    private static final String NAMESPACE_PREFIX = "result";

    static final Log log = LogFactory.getLog(IngestTool.class.getName());

    private static final String DELETE_METHOD = "delete";

    private static final String INGEST_METHOD = "ingest";

    private static final String PREPEND_REST = "de.escidoc.core.client.rest";

    private static final String PREPEND_SOAP = "de.escidoc.core.client.soap";

    private static final String APPEND_HANDLER = "HandlerClient";

    private Map<String, Object> parameters = null;

    private static final Map<String, Object> classesForDeletion =
        new HashMap<String, Object>();

    private void setParameters(Map<String, Object> map) {
        this.parameters = map;
    }

    /**
     *
     * @param args
     * @return
     */
    public Map<String, Object> processArguments(String[] args) {
        Map<String, Object> params = new HashMap<String, Object>();

        Getopt g =
            new Getopt(this.getClass().getName(), args, "f:h:t:u:H::?::");

        String fileNameArg = new String();
        String handleArg = new String();
        String urlArg = new String();
        String protocolArg = new String();

        int c = -1;
        while ((c = g.getopt()) != -1) {
            switch (c) {
                case 'f':
                    fileNameArg = g.getOptarg();
                    if (StringUtils.isEmpty(fileNameArg)) {
                        exitOnInvalidArgument("file name may not be empty");
                    }
                    break;
                case 'h':
                    handleArg = g.getOptarg();
                    if (StringUtils.isEmpty(handleArg)) {
                        exitOnInvalidArgument("handle may not be empty");
                    }
                    break;
                case 't':
                    protocolArg = g.getOptarg();
                    if (StringUtils.isEmpty(protocolArg)) {
                        exitOnInvalidArgument("transport may not be empty");
                    }
                    if (!TransportProtocol.SOAP.toString().equals(
                        protocolArg.toUpperCase())
                        && !TransportProtocol.REST.toString().equals(
                            protocolArg.toUpperCase())) {
                        exitOnInvalidArgument("transport protocol is invalid, it must be either of SOAP or REST");
                    }
                    break;
                case 'u':
                    urlArg = g.getOptarg();
                    // check if url is valid, when provided
                    if (!StringUtils.isEmpty(urlArg)) {
                        try {
                            new URL(urlArg);
                        }
                        catch (MalformedURLException e) {
                            exitOnInvalidArgument("URL is invalid :" + e);
                        }
                    }
                    break;
                case 'H':
                case '?':
                    printHelpMessage("");
                    System.exit(0);
                    break;
                default:
                    exitOnInvalidArgument();
            }
        }
        params.put("filename", fileNameArg);
        params.put("handle", handleArg);
        params.put("url", urlArg);
        params.put("protocol", protocolArg);
        return params;
    }

    /**
     *
     * @param message
     */
    private void exitOnInvalidArgument(String... message) {
        StringBuilder msgs = new StringBuilder();
        for (String tmp : message) {
            msgs.append(tmp);
        }
        printHelpMessage(msgs.toString());
        System.exit(-1);
    }

    /**
     * @param args
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws SecurityException
     * @throws IllegalArgumentException
     * @throws InternalClientException
     */
    public static void main(String[] args) throws IllegalArgumentException,
        SecurityException, IllegalAccessException, InvocationTargetException,
        NoSuchMethodException {
        IngestTool ingestTool = new IngestTool();
        Map<String, Object> map = ingestTool.processArguments(args);
        ingestTool.setParameters(map);
        ingestTool.ingest();
    }

    /**
     *
     * @param detail
     */
    private void printHelpMessage(String detail) {
        System.out.println("\n" + detail);
        System.out
            .println("eSciDoc Ingest Tool. This tool takes a zip file containing valid resources and ingests each resource.");
        System.out.println("Valid Usage :");
        System.out
            .println("ingestTool -f <filename> -h <handle> -t <transport protocol (SOAP|REST)> [-u <valid url to eSciDoc>]. If no url is provided, http://localhost:8080 is assumed.");
    }

    public void ingest(String[] args) {
        Map<String, Object> map = processArguments(args);
        setParameters(map);
        ingest();
    }

    /**
     *
     * @param parameters
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws SecurityException
     * @throws IllegalArgumentException
     */
    public void ingest() {
        try {
            long t1 = System.nanoTime();
            multiFromZip((String) parameters.get("filename"));
            long t2 = System.nanoTime();
            log.info("done. total runtime: " + ((t2 - t1) / 1000000) + " ms");
        }
        catch (Exception e) {
            printHelpMessage(e.toString());
        }
    }

    /**
     *
     * @param filename
     * @param user
     * @param pwd
     * @param host
     * @throws InternalClientException
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws SecurityException
     * @throws IllegalArgumentException
     */
    private void multiFromZip(String filename) throws InternalClientException,
        IllegalArgumentException, SecurityException, IllegalAccessException,
        InvocationTargetException, NoSuchMethodException {
        List<NameValueBean> ingestedResources = new ArrayList<NameValueBean>();
        String latestFileName = null;
        int BUFFER = 2048;
        List<String> pids = new ArrayList<String>();
        try {
            ZipFile zipFile = new ZipFile(filename);
            Enumeration<? extends ZipEntry> e = zipFile.entries();
            List<String> fileNames = new ArrayList<String>();

            while (e.hasMoreElements()) {
                ZipEntry entry = e.nextElement();
                fileNames.add(entry.getName());
            }
            // TODO: Sort entries ? Collections.sort(...)

            for (String entryName : fileNames) {
                ZipEntry entry = zipFile.getEntry(entryName);
                if (entry.isDirectory()) {
                    continue;
                }
                latestFileName = entry.getName();
                BufferedInputStream is =
                    new BufferedInputStream(zipFile.getInputStream(entry));
                int count;
                byte data[] = new byte[BUFFER];
                String xmlstr = new String();
                while ((count = is.read(data, 0, BUFFER)) != -1) {
                    xmlstr = xmlstr.concat(new String(data, 0, count));
                }
                is.close();

                long t1 = System.nanoTime();
                String result = executeIngest(xmlstr);
                long t2 = System.nanoTime();
                String objectId = executeXPath(result, XPATH_OBJID);
                String objectType = executeXPath(result, XPATH_RESOURCE_TYPE);
                ingestedResources.add(new NameValueBean(latestFileName,
                    objectId, ResourceType.valueOf(objectType),
                    TransportProtocol.valueOf((String) parameters
                        .get("protocol"))));

                log.info("Resource successfully ingested; Filename;"
                    + latestFileName + ",type;" + objectType + ",id;"
                    + objectId + ",time;" + ((t2 - t1) / 1000000) + " ms");

            }
            zipFile.close();
        }
        // TODO: Fix exception handling, adapt for SOAP
        catch (Exception e) {
            Throwable t = e.getCause();
            if (t instanceof EscidocException) {
                int statusCode = ((EscidocException) t).getHttpStatusCode();
                String line = ((EscidocException) t).getHttpStatusLine();
                String msg = ((EscidocException) t).getHttpStatusMsg();
                log.error("Resource could not be ingested. HTTP status code: "
                    + statusCode + ", HTTP status line: " + line
                    + ", HTTP status message: " + msg);
            }
            else {
                log.error("Resource could not be ingested: " + e.getCause());
            }

            // "roll back" any resource that has been ingested to this point
            for (NameValueBean bean : ingestedResources) {
                try {
                    deleteResource(bean);
                    log.info("Resource successfully deleted; Filename;"
                        + bean.getFileName() + ",type;" + bean.getType()
                        + ",id;" + bean.getObjectId());
                }
                catch (Exception ex) {
                    Throwable t1 = ex.getCause();
                    if (t1 instanceof EscidocException) {
                        int statusCode =
                            ((EscidocException) t1).getHttpStatusCode();
                        String line =
                            ((EscidocException) t1).getHttpStatusLine();
                        String msg = ((EscidocException) t).getHttpStatusMsg();
                        log
                            .error("Resource could not be deleted. HTTP status code: "
                                + statusCode
                                + ", HTTP status line: "
                                + line
                                + ", HTTP status message: " + msg);
                    }
                    else {
                        log.error("Resource could not be ingested: "
                            + ex.getCause());
                    }
                }
            }
        }
    }

    /**
     * Delete the resource, call the respective handler class.
     *
     * @param bean
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws SecurityException
     * @throws IllegalArgumentException
     */
    private void deleteResource(NameValueBean bean)
        throws IllegalArgumentException, SecurityException,
        IllegalAccessException, InvocationTargetException,
        NoSuchMethodException {
        executeDelete(bean.getType(), bean.getObjectId(), bean.getTransport());
    }

    /**
     * Get an instance of the class with the given name.
     *
     * @param className
     *            the string containing the name of the class
     * @return
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws SecurityException
     * @throws IllegalArgumentException
     */
    private synchronized Object getClass(final String className)
        throws IllegalArgumentException, SecurityException,
        InvocationTargetException, NoSuchMethodException {
        Object neededClassInstance = null;
        try {
            neededClassInstance = getAndConfigure(className);
            // TODO: Does the type of exception matter in this case ?
        }
        catch (Exception e) {
            log.error(e);
        }
        return neededClassInstance;
    }

    /**
     * Configure each class as needed. Set handle and serviceUrl. Then cache
     *
     * @param className
     * @return
     * @throws ClassNotFoundException
     * @throws IllegalAccessException
     * @throws InstantiationException
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws SecurityException
     * @throws IllegalArgumentException
     */
    private Object getAndConfigure(final String className)
        throws ClassNotFoundException, InstantiationException,
        IllegalAccessException, IllegalArgumentException, SecurityException,
        InvocationTargetException, NoSuchMethodException {
        Object neededClassInstance = classesForDeletion.get(className);
        if (neededClassInstance == null) {
            Class neededClass = Class.forName(className);
            neededClassInstance = neededClass.newInstance();
            callMethodOnClass(neededClassInstance, "setHandle",
                new Class[] { String.class }, new Object[] { parameters.get(
                    "handle").toString() });
            callMethodOnClass(neededClassInstance, "setServiceAddress",
                new Class[] { String.class }, new Object[] { parameters.get(
                    "url").toString() });
            classesForDeletion.put(className, neededClassInstance);
        }
        return neededClassInstance;

    }

    /**
     * Call a method of a class. Class and method can be of arbitrary name and
     * type.
     *
     * @param clazz
     *            the class on which the method is to be called
     * @param methodName
     *            the string containing the method name
     * @param types
     *            the Class[] array of types containing the parameter types for
     *            the method to be called
     * @param parameters
     *            the Object[] array containing the parameters of type given in
     *            the types Array for the method to be called
     * @return returns the return value of the method call
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws SecurityException
     * @throws IllegalArgumentException
     */
    public Object callMethodOnClass(
        Object instance, final String methodName, final Class[] types,
        final Object[] params) throws IllegalArgumentException,
        SecurityException, IllegalAccessException, InvocationTargetException,
        NoSuchMethodException {
        Method method = null;
        Object returnValue = null;

        returnValue =
            instance.getClass().getMethod(methodName, types).invoke(instance,
                params);

        return returnValue;
    }

    /**
     *
     * @param transport
     * @param resourceType
     * @return
     */
    public String getCombinedClassName(String transport, String resourceType) {

        String prependPackage = null;
        if (transport.toString().equalsIgnoreCase(
            TransportProtocol.REST.toString())) {
            prependPackage = PREPEND_REST;
        }
        else {
            prependPackage = PREPEND_SOAP;
        }

        return prependPackage + "."
            + StringUtils.capitalize(transport.toString().toLowerCase())
            + StringUtils.capitalize(resourceType.toString().toLowerCase())
            + APPEND_HANDLER;
    }

    /**
     * Execute the delete Method on the resource handler. The resource handler
     * is obtained via reflection. It uses the Resource Type and the Transport
     * Protocol to get the respective class.
     *
     * Handler names conform to <Transport><Resourcename>HandlerClient (e.g.
     * SoapItemHandlerClient). Each handler has a delete method with the same
     * signature (public void delete(String string))
     *
     * As long as these conventions stay that way we can safely facilitate
     * reflection mechanisms to obtain an instance of the respective class...
     *
     * @param valueOf
     * @param objectId
     * @param transport
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws SecurityException
     * @throws IllegalArgumentException
     */
    private void executeDelete(
        ResourceType valueOf, String objectId, TransportProtocol transport)
        throws IllegalArgumentException, SecurityException,
        IllegalAccessException, InvocationTargetException,
        NoSuchMethodException {
        String className =
            getCombinedClassName(transport.toString(), valueOf.toString());
        Object instance = getClass(className);
        callMethodOnClass(instance, DELETE_METHOD,
            new Class[] { String.class }, new Object[] { objectId });
    }

    /**
     * Execute the ingest.
     *
     * @param transportProtocol
     * @param resource
     * @param handle
     * @param url
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     * @throws SecurityException
     * @throws IllegalArgumentException
     * @throws IllegalAccessException
     */
    private String executeIngest(final String resource)
        throws IllegalArgumentException, SecurityException,
        InvocationTargetException, NoSuchMethodException,
        IllegalAccessException {

        String className =
            getCombinedClassName(parameters.get("protocol").toString(),
                StringUtils.capitalize(INGEST_METHOD));
        Object instance = getClass(className);
        return (String) callMethodOnClass(instance, INGEST_METHOD,
            new Class[] { String.class }, new Object[] { resource });
    }

    /**
     * Execute an xpath expression on an input xml string.
     *
     * @param xml
     *            the string which contains the xml.
     * @param xpathExpression
     *            the string which contains the xpath expression
     * @return returns the extracted value
     */
    public String executeXPath(final String xml, final String xpathExpression) {
        String value = null;
        try {
            NamespaceContext ctx = new NamespaceContext() {
                public String getNamespaceURI(String prefix) {
                    if (prefix.equals(NAMESPACE_PREFIX))
                        return SCHEMA_PREFIX_RESULT;
                    return null;
                }

                public String getPrefix(String namespaceURI) {
                    return null;
                }

                public Iterator getPrefixes(String namespaceURI) {
                    return null;
                }
            };
            InputSource inputSource = new InputSource(new StringReader(xml));
            XPath xpath = XPathFactory.newInstance().newXPath();
            xpath.setNamespaceContext(ctx);
            return (String) xpath.evaluate(xpathExpression, inputSource,
                XPathConstants.STRING);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return value;
    }
}
