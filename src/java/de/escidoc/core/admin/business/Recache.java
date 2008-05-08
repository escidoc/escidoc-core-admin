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

import de.escidoc.core.admin.business.interfaces.RecacheInterface;
import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;

import fedora.client.FedoraClient;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.springframework.jdbc.core.support.JdbcDaoSupport;

import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;

/**
 * Provides methods used for recaching.
 * 
 * @spring.bean id="de.escidoc.core.admin.Recache"
 * 
 * @admin
 */
public class Recache extends JdbcDaoSupport implements RecacheInterface {

    private static final String CHARSET = "UTF-8";

    private static AppLogger log = new AppLogger(Recache.class.getName());

    /**
     * SQL statements.
     */
    private static final String DELETE_ALL = "DELETE FROM list.item";
    private static final String INSERT_ITEM = "INSERT INTO list.item (id, content_model, context_id, creation_date, created_by, description, pid, public_status, title, version_number, version_status, rest_content, soap_content) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    /**
     * SQL date formats.
     */
    private final SimpleDateFormat dateFormat1 =
        new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.S'Z'");
    private final SimpleDateFormat dateFormat2 =
        new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

    /**
     * Triplestore properties.
     */
    private static final String CONTENT_MODEL = "<http://escidoc.de/core/01/structural-relations/content-model>";
    private static final String CONTEXT_ID = "<http://escidoc.de/core/01/structural-relations/context>";
    private static final String CREATED_BY = "<http://escidoc.de/core/01/structural-relations/created-by>";
    private static final String CREATION_DATE = "<info:fedora/fedora-system:def/model#createdDate>";
    private static final String DESCRIPTION = "<http://purl.org/dc/elements/1.1/description>";
    private static final String PID = "<http://escidoc.de/core/01/properties/pid>";
    private static final String PUBLIC_STATUS = "<http://escidoc.de/core/01/properties/public-status>";
    private static final String TITLE = "<http://purl.org/dc/elements/1.1/title>";
    private static final String VERSION_NUMBER = "<http://escidoc.de/core/01/properties/version/number>";
    private static final String VERSION_STATUS = "<http://escidoc.de/core/01/properties/version/status>";

    /**
     * Triplestore queries.
     */
    private static final String ITEM_LIST_QUERY = "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3chttp://escidoc.de/core/01/resources/Item%3e";
    private static final String ITEM_PROPERTIES_QUERY = "/risearch?type=triples&lang=spo&format=N-Triples&query=%3cinfo:fedora/{0}%3e%20*%20*";

    /**
     * Axis URLs.
     */
    private static final String AXIS_ITEM_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ItemHandlerService";

    /**
     * Axis method names.
     */
    private static final String RETRIEVE_METHOD_NAME = "retrieve";

    /**
     * eSciDoc item URL.
     */
    private static final String ITEM_URL = "/ir/item/";

    /**
     * Properties from configuration file.
     */
    private final String fedoraUser;
    private final String fedoraPassword;
    private final String fedoraUrl;

    /**
     * Spring beans.
     */
    private EscidocCoreHandler escidocCoreHandler = null;

    /**
     * Object which provides methods to get SOAP stubs for Fedora APIs.
     */
    private FedoraClient fc = null;

    /**
     * Construct a new Recache object.
     * 
     * @param fedoraUser priviledged Fedora user
     * @param fedoraPassword password of a priviledged Fedora user
     * @param fedoraUrl Fedora base URL 
     */
    public Recache(
        final String fedoraUser,
        final String fedoraPassword,
        final String fedoraUrl) {
        this.fedoraUser = fedoraUser;
        this.fedoraPassword = fedoraPassword;
        this.fedoraUrl = fedoraUrl;
    }

    /**
     * Clear the whole item cache.
     */
    public void clearCache() {
        getJdbcTemplate().update(DELETE_ALL);
    }

    /**
     * Get the latest release number from the item XML.
     * 
     * @param xml item xml
     * @return latest release number or null
     * @throws IOException If the XML couldn't be parsed.
     */
    private String getLatestRelease(final String xml) throws IOException {
        String result = null;

        try {
            SAXParser parser = SAXParserFactory.newInstance().newSAXParser();
            LatestReleaseHandler handler = new LatestReleaseHandler();

            parser.parse(new ByteArrayInputStream(xml.getBytes(CHARSET)), handler);
            result = handler.getLatestRelease();
        }
        catch (Exception e) {
            log.error(e);
            throw new IOException(e.getMessage());
        }
        return result;
    }

    /**
     * Extract the object from the given triple.
     *
     * @param triple the triple from which the object has to be extracted
     *
     * @return the object of the given triple
     */
    private String getObject(final String triple) {
        String result = null;

        if (triple != null) {
            final int count = 3;
            String [] tokens = triple.split(" ", count);

            if ((tokens != null) && tokens.length == count) {
                result = tokens [2].substring(1, tokens [2].length() - count);
            }
        }
        return result;
    }

    /**
     * Extract the predicate from the given triple.
     *
     * @param triple the triple from which the predicate has to be extracted
     *
     * @return the predicate of the given triple
     */
    private String getPredicate(final String triple) {
        String result = null;

        if (triple != null) {
            final int count = 3;
            String [] tokens = triple.split(" ", count);

            if ((tokens != null) && tokens.length == count) {
                result = tokens [1];
            }
        }
        return result;
    }

    /**
     * Get all properties for a given item from Fedora.
     * 
     * @param id item id
     * 
     * @return property map for this item
     * @throws IOException Thrown if an I/O error occured.
     */
    private Map <String, String> getProperties(final String id)
        throws IOException {
        Map <String, String> result = new HashMap <String, String>();

        if (id != null) {
            BufferedReader input = null;

            try {
                MessageFormat queryFormat =
                    new MessageFormat(ITEM_PROPERTIES_QUERY);
                String line;

                input = new BufferedReader(
                    new InputStreamReader(
                     fc.get(queryFormat.format(
                            new Object [] {URLEncoder.encode(id, CHARSET)}),
                            true)));
                while ((line = input.readLine()) != null) {
                    result.put(getPredicate(line), getObject(line));
                }
            }
            finally {
                if (input != null) {
                    input.close();
                }
            }
        }
        return result;
    }

    /**
     * Get all properties for a given item from the item XML.
     * 
     * @param xml item XML
     * 
     * @return property map for this item
     * @throws IOException Thrown if an I/O error occured.
     */
    private Map <String, String> getPropertiesFromXml(final String xml)
        throws IOException {
        Map <String, String> result = null;

        try {
            SAXParser parser = SAXParserFactory.newInstance().newSAXParser();
            FilterHandler handler = new FilterHandler();

            parser.parse(new ByteArrayInputStream(xml.getBytes(CHARSET)), handler);
            result = handler.getProperties();
        }
        catch (Exception e) {
            log.error(e);
            throw new IOException(e.getMessage());
        }
        return result;
    }

    /**
     * Get a specific id value from the property map.
     * 
     * @param properties property map for this item
     * @param property name of the property to get the value for
     * 
     * @return id value of this property
     */
    private String getStringId(
        final Map <String, String> properties, final String property) {
        String result = null;
        String object = (String) properties.get(property);

        if (object != null) {
            result = object.substring(object.indexOf('/') + 1);
        }
        return result;
    }

    /**
     * Extract the subject from the given triple.
     *
     * @param triple the triple from which the subject has to be extracted
     *
     * @return the subject of the given triple
     */
    private String getSubject(final String triple) {
        String result = null;

        if (triple != null) {
            int index = triple.indexOf(' ');

            if (index > 0) {
                result =
                    triple.substring(triple.indexOf('/') + 1, index - 1);
            }
        }
        return result;
    }

    /**
     * Create a timestamp from the given string. Two different date formats are
     * supported.
     * 
     * @param properties map containing all properties
     * @param property string containing a date
     * 
     * @return the timestamp object
     * @throws ParseException The given string cannot be parsed.
     */
    private Timestamp getTimestamp(
        final Map <String, String> properties, final String property)
        throws ParseException {
        Timestamp result = null;
        String object = (String) properties.get(property);

        if (object != null) {
            java.util.Date date = null;
            String dateString = null;

            if (object.indexOf('"') > 0) {
                dateString = object.substring(0, object.indexOf('"'));
            }
            else {
                dateString = object;
            }
            try {
                date = dateFormat1.parse(dateString);
            }
            catch (ParseException e) {
                date = dateFormat2.parse(dateString);
            }
            result = new Timestamp(date.getTime());
        }
        return result;
    }

    /**
     * Retrieve a single item from eSciDoc (REST form).
     * 
     * @param id item id
     * 
     * @return XML representation of this item
     * @throws ApplicationServerSystemException Thrown if eSciDoc failed to receive the item.
     */
    private String retrieveItemRest(final String id)
        throws ApplicationServerSystemException {
        return escidocCoreHandler.getRequestEscidoc(ITEM_URL + id);
    }

    /**
     * Retrieve a single item from eSciDoc (SOAP form).
     * 
     * @param id item id
     * 
     * @return XML representation of this item
     * @throws ApplicationServerSystemException Thrown if eSciDoc failed to receive the item.
     */
    private String retrieveItemSoap(final String id)
        throws ApplicationServerSystemException {
        Object[] arguments = new Object[1];
        arguments[0] = id;

        return (String) escidocCoreHandler.soapRequestEscidoc(
            AXIS_ITEM_HANDLER_TARGET_NAMESPACE, RETRIEVE_METHOD_NAME, arguments);
    }

    /**
     * @param escidocCoreHandler the escidocCoreHandler to set
     */
    public void setEscidocCoreHandler(
        final EscidocCoreHandler escidocCoreHandler) {
        this.escidocCoreHandler = escidocCoreHandler;
    }

    /**
     * Injects the data source.
     *
     * @spring.property ref="escidoc-core.DataSource"
     * @param myDataSource data source from Spring
     */
    public void setMyDataSource(final DataSource myDataSource) {
        super.setDataSource(myDataSource);
    }

    /**
     * Store the item in the database cache.
     * 
     * @param id item id
     * @param properties map containing all filter properties
     * @param xmlDataRest complete item as XML (REST form)
     * @param xmlDataSoap complete item as XML (SOAP form)
     * 
     * @throws IOException Thrown if an I/O error occured.
     * @throws ParseException A date string cannot be parsed.
     */
    private void storeItem(
        final String id, final Map <String, String> properties,
        final String xmlDataRest, final String xmlDataSoap)
        throws IOException, ParseException {
        getJdbcTemplate().update(
            INSERT_ITEM,
            new Object[]
            {id,
             getStringId(properties, CONTENT_MODEL),
             getStringId(properties, CONTEXT_ID),
             getTimestamp(properties, CREATION_DATE),
             getStringId(properties, CREATED_BY),
             properties.get(DESCRIPTION),
             properties.get(PID),
             getStringId(properties, PUBLIC_STATUS),
             properties.get(TITLE),
             getStringId(properties, VERSION_NUMBER),
             getStringId(properties, VERSION_STATUS),
             xmlDataRest,
             xmlDataSoap});
    }

    /**
     * Store all available items in the database cache.
     * 
     * @throws ApplicationServerSystemException Thrown if eSciDoc failed to receive the item.
     * @throws IOException Thrown if an I/O error occured.
     * @throws ParseException The given string cannot be parsed.
     */
    public void storeItems()
        throws ApplicationServerSystemException, IOException, ParseException {
        BufferedReader input = null;

        try {
            // dummy call to prevent "org.apache.commons.discovery.DiscoveryException: No implementation defined for org.apache.commons.logging.LogFactory"
            try {
                retrieveItemSoap("escidoc:1");
            }
            catch (Exception e) {
            }

            fc = new FedoraClient(fedoraUrl, fedoraUser, fedoraPassword);

            input = new BufferedReader(
                new InputStreamReader(fc.get(ITEM_LIST_QUERY, true)));

            int itemCount = 0;
            long now = new Date().getTime();
            String line;

            while ((line = input.readLine()) != null) {
                final String subject = getSubject(line);

                if (subject != null) {
                    log.info("store item " + subject);

                    final String id = subject.substring(subject.indexOf('/') + 1);
                    String xmlDataRest = retrieveItemRest(id);
                    String xmlDataSoap = retrieveItemSoap(id);
                    Map <String, String> properties = getProperties(id);
                    final String versionNumber =
                        getStringId(properties, VERSION_NUMBER);
                    final String latestRelease = getLatestRelease(xmlDataRest);

                    storeItem(id, properties, xmlDataRest, xmlDataSoap);
                    if ((latestRelease != null) && (
                        !latestRelease.equals(versionNumber))) {
                        final String versionId = id + ":" + latestRelease;

                        log.info("store item " + versionId);
                        xmlDataRest = retrieveItemRest(versionId);
                        xmlDataSoap = retrieveItemSoap(versionId);
                        properties = getPropertiesFromXml(xmlDataSoap);
                        storeItem(id, properties, xmlDataRest, xmlDataSoap);
                        itemCount++;
                    }
                    itemCount++;
                }
            }

            long time = (new Date().getTime() - now) / 1000;

            if (time > 0) {
                log.info("stored " + itemCount + " items in " + time + "s ("
                    + (itemCount / time) + "." + (itemCount % time) + " items/s)");
            }
        }
        finally {
            if (input != null) {
                input.close();
            }
        }
    }

    /**
     * SAX event handler to get the latest release from an item.
     * 
     * @author SCHE
     */
    private class LatestReleaseHandler extends DefaultHandler {
        private boolean foundLatestRelease = false;
        private boolean foundReleaseNumber = false;
        private String latestRelease = null;

        /**
         * Receive notification of character data inside an element.
         * 
         * @param ch The whitespace characters.
         * @param start The start position in the character array.
         * @param length The number of characters to use from the character array.
         * 
         * @see org.xml.sax.helpers.DefaultHandler#characters(char [], int, int)
         */
        public void characters(final char [] ch, final int start,
            final int length) {
            if (foundReleaseNumber) {
                latestRelease = new String(ch, start, length).trim();
                foundReleaseNumber = false;
            }
        }

        /**
         * Get the latest release number.
         * 
         * @return latest release number
         */
        public String getLatestRelease() {
            return latestRelease;
        }

        /**
         * Receive notification of the start of an element.
         * 
         * @param uri The Namespace URI, or the empty string if the element has
         *            no Namespace URI or if Namespace processing is not being
         *            performed.
         * @param localName The local name (without prefix), or the empty string
         *                  if Namespace processing is not being performed.
         * @param qName The qualified name (with prefix), or the empty string if
         *              qualified names are not available.
         * @param attributes The attributes attached to the element. If there are
         *                   no attributes, it shall be an empty Attributes
         *                   object.
         * 
         * @see org.xml.sax.helpers.DefaultHandler#startElement(String, String,
         *                                                      String, Attributes)
         */
        public void startElement(final String uri, final String localName,
            final String qName, final Attributes attributes) {
            if (qName.equals("prop:latest-release")) {
                foundLatestRelease = true;
            }
            else if (foundLatestRelease && (qName.equals("release:number"))) {
                foundReleaseNumber = true;
                foundLatestRelease = false;
            }
        }
    }

    /**
     * SAX event handler to get all filter criteria from an item.
     * 
     * @author SCHE
     */
    private class FilterHandler extends DefaultHandler {
        private boolean foundCreationDate = false;
        private boolean foundDescription = false;
        private boolean foundPid = false;
        private boolean foundPublicStatus = false;
        private boolean foundTitle = false;
        private boolean foundVersion = false;
        private boolean foundVersionNumber = false;
        private boolean foundVersionStatus = false;
        private Map <String, String> properties = new HashMap <String, String>();

        /**
         * Receive notification of character data inside an element.
         * 
         * @param ch The whitespace characters.
         * @param start The start position in the character array.
         * @param length The number of characters to use from the character array.
         * 
         * @see org.xml.sax.helpers.DefaultHandler#characters(char [], int, int)
         */
        public void characters(final char [] ch, final int start,
            final int length) {
            if (foundCreationDate) {
                properties.put(CREATION_DATE, new String(ch, start, length));
                foundCreationDate = false;
            }
            else if (foundDescription) {
                properties.put(DESCRIPTION, new String(ch, start, length));
                foundDescription = false;
            }
            else if (foundPid) {
                properties.put(PID, new String(ch, start, length));
                foundPid = false;
            }
            else if (foundPublicStatus) {
                properties.put(PUBLIC_STATUS, new String(ch, start, length));
                foundPublicStatus = false;
            }
            else if (foundTitle) {
                properties.put(TITLE, new String(ch, start, length));
                foundTitle = false;
            }
            else if (foundVersionNumber) {
                properties.put(VERSION_NUMBER, new String(ch, start, length));
                foundVersionNumber = false;
            }
            else if (foundVersionStatus) {
                properties.put(VERSION_STATUS, new String(ch, start, length));
                foundVersionStatus = false;
            }
        }

        /**
         * Receive notification of the end of an element.
         *
         * @param uri The Namespace URI, or the empty string if the element has
         *            no Namespace URI or if Namespace processing is not being
         *            performed.
         * @param localName The local name (without prefix), or the empty string
         *                  if Namespace processing is not being performed.
         * @param qName The qualified name (with prefix), or the empty string if
         *              qualified names are not available.
         * 
         * @see org.xml.sax.helpers.DefaultHandler#endElement(String, String, String)
         */
        public void endElement(final String uri, final String localName,
            final String qName) {
            if (qName.equals("prop:version")) {
                foundVersion = false;
            }
        }

        /**
         * Get a map of all filter properties.
         * 
         * @return map of all filter properties
         */
        public Map <String, String> getProperties() {
            return properties;
        }

        /**
         * Receive notification of the start of an element.
         * 
         * @param uri The Namespace URI, or the empty string if the element has
         *            no Namespace URI or if Namespace processing is not being
         *            performed.
         * @param localName The local name (without prefix), or the empty string
         *                  if Namespace processing is not being performed.
         * @param qName The qualified name (with prefix), or the empty string if
         *              qualified names are not available.
         * @param attributes The attributes attached to the element. If there are
         *                   no attributes, it shall be an empty Attributes
         *                   object.
         * 
         * @see org.xml.sax.helpers.DefaultHandler#startElement(String, String,
         *                                                      String, Attributes)
         */
        public void startElement(final String uri, final String localName,
            final String qName, final Attributes attributes) {
            if (qName.equals("srel:content-model")) {
                storeProperty(attributes, "objid", CONTENT_MODEL);
            }
            else if (qName.equals("srel:context")) {
                storeProperty(attributes, "objid", CONTEXT_ID);
            }
            else if (qName.equals("srel:created-by")) {
                storeProperty(attributes, "objid", CREATED_BY);
            }
            else if (qName.equals("prop:creation-date")) {
                foundCreationDate = true;
            }
            else if (qName.equals("prefix-dc:description")) {
                foundDescription = true;
            }
            else if (qName.equals("prop:pid")) {
                foundPid = true;
            }
            else if (qName.equals("prop:public-status")) {
                foundPublicStatus = true;
            }
            else if (qName.equals("prefix-dc:title")) {
                foundTitle = true;
            }
            else if (qName.equals("prop:version")) {
                foundVersion = true;
            }
            else if (foundVersion && qName.equals("version:number")) {
                foundVersionNumber = true;
            }
            else if (foundVersion && qName.equals("version:status")) {
                foundVersionStatus = true;
            }
        }

        /**
         * Extract the value for the given "qName" from the attibute list and
         * put it into the map of all filter properties using "key" as key value.
         *  
         * @param attributes attribute list
         * @param qName qualified name
         * @param key key to be used as key value in the properties map
         */
        private void storeProperty(final Attributes attributes,
            final String qName, final String key) {
            if (attributes != null) {
                for (int index = 0; index < attributes.getLength();
                     index++) {
                    if (attributes.getQName(index).equals(qName)) {
                        properties.put(key, attributes.getValue(index));
                        break;
                    }
                }
            }
        }
    }
}
