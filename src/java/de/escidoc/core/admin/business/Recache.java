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
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.text.MessageFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.sql.DataSource;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.springframework.core.io.InputStreamResource;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.test.jdbc.SimpleJdbcTestUtils;

import de.escidoc.core.admin.business.interfaces.RecacheInterface;
import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.common.business.fedora.TripleStoreUtility;
import de.escidoc.core.common.business.fedora.resources.DbResourceCache;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.exceptions.system.SystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.string.StringUtility;
import fedora.client.FedoraClient;

/**
 * Provides methods used for recaching.
 * 
 * @spring.bean id="de.escidoc.core.admin.Recache"
 * 
 * @admin
 */
public class Recache extends DbResourceCache implements RecacheInterface {

    private static final String CHARSET = "UTF-8";

    private static AppLogger log = new AppLogger(Recache.class.getName());

    /**
     * SQL statements.
     */
    private static final String INSERT_CONTAINER =
        "INSERT INTO list.container (id, content_model_id, content_model_title, context_id, context_title, created_by_id, created_by_title, creation_date, description, last_modification_date, modified_by_id, modified_by_title, pid, public_status, public_status_comment, title, version_number, version_status, rest_content, soap_content) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String INSERT_CONTEXT =
        "INSERT INTO list.context (id, created_by_id, created_by_title, creation_date, description, last_modification_date, modified_by_id, modified_by_title, ou, public_status, public_status_comment, title, type, rest_content, soap_content) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String INSERT_ITEM =
        "INSERT INTO list.item (id, content_model_id, content_model_title, context_id, context_title, created_by_id, created_by_title, creation_date, description, last_modification_date, modified_by_id, modified_by_title, pid, public_status, public_status_comment, title, version_number, version_status, rest_content, soap_content) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String INSERT_MEMBER =
        "INSERT INTO list.member (member, parent) VALUES (?, ?)";

    private static final String INSERT_PROPERTY =
        "INSERT INTO list.property (resource_id, local_path, value) VALUES (?, ?, ?)";

    private static final String INSERT_OU =
        "INSERT INTO list.ou (id, created_by_id, created_by_title, creation_date, description, last_modification_date, modified_by_id, modified_by_title, public_status, public_status_comment, title, rest_content, soap_content) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    /**
     * Triplestore queries.
     */
    private static final String CONTAINER_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3chttp://escidoc.de/core/01/resources/Container%3e";

    private static final String CONTEXT_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3chttp://escidoc.de/core/01/resources/Context%3e";

    private static final String ITEM_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3chttp://escidoc.de/core/01/resources/Item%3e";

    private static final String OU_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3chttp://escidoc.de/core/01/resources/OrganizationalUnit%3e";

    private static final String MEMBERS_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=%3cinfo:fedora/{0}%3e%20%3chttp://escidoc.de/core/01/structural-relations/member%3e%20*";

    private static final String PARENTS_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=%3cinfo:fedora/{0}%3e%20%3chttp://escidoc.de/core/01/structural-relations/parent%3e%20*";

    private static final String PROPERTIES_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=%3cinfo:fedora/{0}%3e%20*%20*";

    /**
     * Axis URLs.
     */
    private static final String AXIS_CONTAINER_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ContainerHandlerService";

    private static final String AXIS_CONTEXT_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ContextHandlerService";

    private static final String AXIS_ITEM_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ItemHandlerService";

    private static final String AXIS_OU_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/OrganizationalUnitHandlerService";

    /**
     * Axis method names.
     */
    private static final String RETRIEVE_METHOD_NAME = "retrieve";

    /**
     * eSciDoc URLs.
     */
    private static final String CONTAINER_URL = "/ir/container/";

    private static final String CONTEXT_URL = "/ir/context/";

    private static final String ITEM_URL = "/ir/item/";

    private static final String OU_URL = "/oum/organizational-unit/";

    /**
     * Pattern to identify body of resource representation.
     */
    private static final Pattern PATTERN_BODY =
        Pattern.compile("(<[^?].*)", Pattern.MULTILINE | Pattern.DOTALL);

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
     * @param fedoraUser
     *            privileged Fedora user
     * @param fedoraPassword
     *            password of a privileged Fedora user
     * @param fedoraUrl
     *            Fedora base URL
     */
    public Recache(final String fedoraUser, final String fedoraPassword,
        final String fedoraUrl) {
        this.fedoraUser = fedoraUser;
        this.fedoraPassword = fedoraPassword;
        this.fedoraUrl = fedoraUrl;
    }

    /**
     * Clear all resources from cache.
     *
     * @throws IOException Thrown if an I/O error occurred.
     */
    public void clearCache() throws IOException {
        executeSqlScript("list.drop.sql");
        executeSqlScript("list.create.sql");
    }

    /**
     * Delete a resource from the database cache.
     *
     * @param id
     *            resource id
     */
    protected void deleteResource(final String id) {
    }

    /**
     * Execute an SQL script, continue on error.
     *
     * @param scriptName SQL script name (loaded from class path)
     *
     * @throws IOException Thrown if an I/O error occurred.
     */
    private void executeSqlScript(final String scriptName) throws IOException {
        InputStream resource =
            getClass().getClassLoader().getResourceAsStream(scriptName);

        if (resource == null) {
            throw new IOException(StringUtility
                .concatenateWithBracketsToString("Resource not found",
                    scriptName));
        }
        SimpleJdbcTestUtils.executeSqlScript(new SimpleJdbcTemplate(
            getJdbcTemplate()), new InputStreamResource(resource), true);
    }

    /**
     * Get the objid from a Fedora identifier, e.g. from
     * &lt;info:fedora/escidoc:1&gt;.
     * 
     * @param uri
     *            the value to get the objid from
     * 
     * @return the extracted objid
     */
    private String getIdFromUri(final String uri) {
        String result = null;

        if (uri != null) {
            result = uri.substring(uri.indexOf('/') + 1);
        }
        return result;
    }

    /**
     * Get the struct map of a container.
     * 
     * @param id
     *            container id
     * 
     * @return struct map (may contain containers and items)
     * @throws IOException
     *             Thrown if an I/O error occurred.
     */
    private List<String> getMembers(final String id) throws IOException {
        List<String> result = new Vector<String>();

        if (id != null) {
            BufferedReader input = null;

            try {
                MessageFormat queryFormat = new MessageFormat(MEMBERS_QUERY);
                String line;

                input =
                    new BufferedReader(new InputStreamReader(fc.get(queryFormat
                        .format(new Object[] { id }), true)));
                while ((line = input.readLine()) != null) {
                    result.add(getObject(line));
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
     * Extract the object from the given triple.
     * 
     * @param triple
     *            the triple from which the object has to be extracted
     * 
     * @return the object of the given triple
     */
    private String getObject(final String triple) {
        String result = null;

        if (triple != null) {
            final int count = 3;
            String[] tokens = triple.split(" ", count);

            if ((tokens != null) && tokens.length == count) {
                result = tokens[2].substring(1, tokens[2].length() - count);
            }
        }
        return result;
    }

    /**
     * Get the parent ou list of a given ou.
     * 
     * @param id ou id
     * 
     * @return list of parent ous
     * @throws IOException
     *             Thrown if an I/O error occurred.
     */
    private List<String> getParents(final String id) throws IOException {
        List<String> result = new Vector<String>();

        if (id != null) {
            BufferedReader input = null;

            try {
                MessageFormat queryFormat = new MessageFormat(PARENTS_QUERY);
                String line;

                input =
                    new BufferedReader(new InputStreamReader(fc.get(queryFormat
                        .format(new Object[] { id }), true)));
                while ((line = input.readLine()) != null) {
                    result.add(getObject(line));
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
     * Extract the predicate from the given triple.
     * 
     * @param triple
     *            the triple from which the predicate has to be extracted
     * 
     * @return the predicate of the given triple
     */
    private String getPredicate(final String triple) {
        String result = null;

        if (triple != null) {
            final int count = 3;
            String[] tokens = triple.split(" ", count);

            if ((tokens != null) && tokens.length == count) {
                StringBuffer sb = new StringBuffer(tokens[1]);

                sb.deleteCharAt(0);
                sb.deleteCharAt(sb.length() - 1);
                result = sb.toString();
            }
        }
        return result;
    }

    /**
     * Get all properties for a given resource from Fedora.
     * 
     * @param id
     *            resource id
     * 
     * @return property map for this resource
     * @throws IOException
     *             Thrown if an I/O error occurred.
     */
    private Map<String, String> getProperties(final String id)
        throws IOException {
        Map<String, String> result = new HashMap<String, String>();

        if (id != null) {
            BufferedReader input = null;

            try {
                MessageFormat queryFormat = new MessageFormat(PROPERTIES_QUERY);
                String line;

                input =
                    new BufferedReader(new InputStreamReader(fc.get(
                        queryFormat.format(new Object[] { URLEncoder.encode(id,
                            CHARSET) }), true)));
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
     * Get all properties for a given resource from the item XML.
     * 
     * @param id resource id
     * @param xml resource XML
     * 
     * @return property map for this resource
     * @throws IOException Thrown if an I/O error occurred.
     */
    private List <Property> getProperties(final String id, final String xml)
        throws IOException {
        List <Property> result = null;

        try {
            SAXParserFactory spf = SAXParserFactory.newInstance();

            spf.setFeature("http://xml.org/sax/features/namespaces", true);

            SAXParser parser = spf.newSAXParser();
            FilterHandler handler = new FilterHandler(id);

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
     * @param properties
     *            property map for this resource
     * @param property
     *            name of the property to get the value for
     * 
     * @return id value of this property
     */
    private String getStringId(
        final Map<String, String> properties, final String property) {
        return getIdFromUri(properties.get(property));
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
     * Retrieve a single resource from eSciDoc (REST form).
     * 
     * @param url
     *            eScidoc URL to retrieve the resource
     * @param id
     *            resource id
     * 
     * @return XML representation of this resource
     * @throws ApplicationServerSystemException
     *             Thrown if eSciDoc failed to receive the resource.
     */
    private String retrieveResourceRest(final String url, final String id)
        throws ApplicationServerSystemException {

        String result = escidocCoreHandler.getRequestEscidoc(url + id);
        Matcher m = PATTERN_BODY.matcher(result);
        if (m.find()) {
            result = m.group(1);
        }
        return result;
    }

    /**
     * Retrieve a single resource from eSciDoc (SOAP form).
     * 
     * @param namespace
     *            target namespace
     * @param id
     *            resource id
     * 
     * @return XML representation of this resource
     * @throws ApplicationServerSystemException
     *             Thrown if eSciDoc failed to receive the resource.
     */
    private String retrieveResourceSoap(final String namespace, final String id)
        throws ApplicationServerSystemException {
        Object[] arguments = new Object[1];
        arguments[0] = id;

        String result =
            (String) escidocCoreHandler.soapRequestEscidoc(namespace,
                RETRIEVE_METHOD_NAME, arguments);
        Matcher m = PATTERN_BODY.matcher(result);
        if (m.find()) {
            result = m.group(1);
        }
        return result;

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
     * Injects the data source.
     * 
     * @spring.property ref="escidoc-core.DataSource"
     * @param myDataSource
     *            data source from Spring
     */
    public void setMyDataSource(final DataSource myDataSource) {
        super.setDataSource(myDataSource);
    }

    /**
     * Store all available resources of the given type in the database cache.
     * 
     * @param type
     *            must be "container" or "item"
     * @param listQuery
     *            Fedora query to get a list of all resources of the given type
     * @param resourceUrl
     *            eSciDoc URL to retrieve a resource of the given type
     * @param resourceNamespace
     *            target namespace for the given resource type
     * 
     * @throws ApplicationServerSystemException
     *             Thrown if eSciDoc failed to receive a resource.
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             The given string cannot be parsed.
     */
    private void store(
        final String type, final String listQuery, final String resourceUrl,
        final String resourceNamespace)
        throws ApplicationServerSystemException, IOException, ParseException {
        BufferedReader input = null;

        try {
            fc = new FedoraClient(fedoraUrl, fedoraUser, fedoraPassword);
            input =
                new BufferedReader(new InputStreamReader(fc
                    .get(listQuery, true)));

            int count = 0;
            long now = new Date().getTime();
            String line;

            while ((line = input.readLine()) != null) {
                final String subject = getSubject(line);

                if (subject != null) {
                    log.info("store " + type + " " + subject);

                    final String id =
                        subject.substring(subject.indexOf('/') + 1);
                    String xmlDataRest = retrieveResourceRest(resourceUrl, id);
                    String xmlDataSoap =
                        retrieveResourceSoap(resourceNamespace, id);
                    Map<String, String> properties = getProperties(id);


                    storeProperties(getProperties(id, xmlDataRest));


                    storeResource(type, id, properties, xmlDataRest,
                        xmlDataSoap);
                    count++;
                }
            }

            long time = (new Date().getTime() - now) / 1000;

            if (time == 0) {
                time = 1;
            }
            log.info("stored " + count + " " + type + "s in " + time + "s ("
                + (count / time) + "." + (count % time) + " " + type + "s/s)");
        }
        finally {
            if (input != null) {
                input.close();
            }
        }
    }

    /**
     * Store the container in the database cache.
     * 
     * @param id
     *            container id
     * @param properties
     *            map containing all filter properties
     * @param xmlDataRest
     *            complete container as XML (REST form)
     * @param xmlDataSoap
     *            complete container as XML (SOAP form)
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             A date string cannot be parsed.
     */
    private void storeContainer(
        final String id, final Map<String, String> properties,
        final String xmlDataRest, final String xmlDataSoap) throws IOException,
        ParseException {
        getJdbcTemplate()
            .update(
                INSERT_CONTAINER,
                new Object[] { id,
                    getStringId(properties,
                        TripleStoreUtility.PROP_CONTENT_MODEL_ID),
                    properties.get(TripleStoreUtility.PROP_CONTENT_MODEL_TITLE),
                    getStringId(properties, TripleStoreUtility.PROP_CONTEXT_ID),
                    properties.get(TripleStoreUtility.PROP_CONTEXT_TITLE),
                    getStringId(properties, TripleStoreUtility.PROP_CREATED_BY_ID),
                    properties.get(TripleStoreUtility.PROP_CREATED_BY_TITLE),
                    getTimestamp(properties.get(
                        TripleStoreUtility.PROP_CREATION_DATE)),
                    properties.get(TripleStoreUtility.PROP_DC_DESCRIPTION),
                    getTimestamp(properties.get(
                        TripleStoreUtility.PROP_LAST_MODIFICATION_DATE)),
                    getStringId(properties,
                        TripleStoreUtility.PROP_MODIFIED_BY_ID),
                    properties.get(TripleStoreUtility.PROP_MODIFIED_BY_TITLE),
                    properties.get(TripleStoreUtility.PROP_OBJECT_PID),
                    properties.get(TripleStoreUtility.PROP_PUBLIC_STATUS),
                    properties.get(TripleStoreUtility.PROP_PUBLIC_STATUS_COMMENT),
                    properties.get(TripleStoreUtility.PROP_DC_TITLE),
                    properties.get(TripleStoreUtility.PROP_LATEST_VERSION_NUMBER),
                    properties.get(TripleStoreUtility.PROP_LATEST_VERSION_STATUS),
                    xmlDataRest, xmlDataSoap });
        for (String member : getMembers(id)) {
            getJdbcTemplate().update(INSERT_MEMBER,
                new Object[] { getIdFromUri(member), id });
        }
    }

    /**
     * Store the context in the database cache.
     * 
     * @param id
     *            context id
     * @param properties
     *            map containing all filter properties
     * @param xmlDataRest
     *            complete context as XML (REST form)
     * @param xmlDataSoap
     *            complete context as XML (SOAP form)
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             A date string cannot be parsed.
     */
    private void storeContext(
        final String id, final Map<String, String> properties,
        final String xmlDataRest, final String xmlDataSoap) throws IOException,
        ParseException {
        getJdbcTemplate().update(
            INSERT_CONTEXT,
            new Object[] { id,
                getStringId(properties, TripleStoreUtility.PROP_CREATED_BY_ID),
                properties.get(TripleStoreUtility.PROP_CREATED_BY_TITLE),
                getTimestamp(properties.get(
                    TripleStoreUtility.PROP_CREATION_DATE)),
                properties.get(TripleStoreUtility.PROP_DC_DESCRIPTION),
                getTimestamp(properties.get(
                    TripleStoreUtility.PROP_LAST_MODIFICATION_DATE)),
                getStringId(properties, TripleStoreUtility.PROP_MODIFIED_BY_ID),
                properties.get(TripleStoreUtility.PROP_MODIFIED_BY_TITLE),
                getStringId(properties,
                    TripleStoreUtility.PROP_ORGANIZATIONAL_UNIT),
                properties.get(TripleStoreUtility.PROP_PUBLIC_STATUS),
                properties.get(TripleStoreUtility.PROP_PUBLIC_STATUS_COMMENT),
                properties.get(TripleStoreUtility.PROP_DC_TITLE),
                properties.get(TripleStoreUtility.PROP_CONTEXT_TYPE),
                xmlDataRest, xmlDataSoap });
    }

    /**
     * Store the item in the database cache.
     * 
     * @param id
     *            item id
     * @param properties
     *            map containing all filter properties
     * @param xmlDataRest
     *            complete item as XML (REST form)
     * @param xmlDataSoap
     *            complete item as XML (SOAP form)
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             A date string cannot be parsed.
     */
    private void storeItem(
        final String id, final Map<String, String> properties,
        final String xmlDataRest, final String xmlDataSoap) throws IOException,
        ParseException {
        getJdbcTemplate()
            .update(
                INSERT_ITEM,
                new Object[] { id,
                    getStringId(properties,
                        TripleStoreUtility.PROP_CONTENT_MODEL_ID),
                    properties.get(TripleStoreUtility.PROP_CONTENT_MODEL_TITLE),
                    getStringId(properties, TripleStoreUtility.PROP_CONTEXT_ID),
                    properties.get(TripleStoreUtility.PROP_CONTEXT_TITLE),
                    getStringId(properties, TripleStoreUtility.PROP_CREATED_BY_ID),
                    properties.get(TripleStoreUtility.PROP_CREATED_BY_TITLE),
                    getTimestamp(properties.get(
                        TripleStoreUtility.PROP_CREATION_DATE)),
                    properties.get(TripleStoreUtility.PROP_DC_DESCRIPTION),
                    getTimestamp(properties.get(
                        TripleStoreUtility.PROP_LAST_MODIFICATION_DATE)),
                    getStringId(properties,
                        TripleStoreUtility.PROP_MODIFIED_BY_ID),
                    properties.get(TripleStoreUtility.PROP_MODIFIED_BY_TITLE),
                    properties.get(TripleStoreUtility.PROP_OBJECT_PID),
                    properties.get(TripleStoreUtility.PROP_PUBLIC_STATUS),
                    properties.get(TripleStoreUtility.PROP_PUBLIC_STATUS_COMMENT),
                    properties.get(TripleStoreUtility.PROP_DC_TITLE),
                    properties.get(TripleStoreUtility.PROP_LATEST_VERSION_NUMBER),
                    properties.get(TripleStoreUtility.PROP_LATEST_VERSION_STATUS),
                    xmlDataRest, xmlDataSoap });
    }

    /**
     * Store the resource properties and meta data in a separate database table.
     *
     * @param properties resource properties and meta data
     *
     * @throws IOException Thrown if an I/O error occurred.
     */
    private void storeProperties(final List <Property> properties)
    throws IOException {
        for (Property property : properties) {
            getJdbcTemplate().update(INSERT_PROPERTY,
                new Object[] {property.resourceId,
                property.localPath, property.value});
        }
    }

    /**
     * Store the organizational unit in the database cache.
     * 
     * @param id
     *            organizational unit id
     * @param properties
     *            map containing all filter properties
     * @param xmlDataRest
     *            complete organizational unit as XML (REST form)
     * @param xmlDataSoap
     *            complete organizational unit as XML (SOAP form)
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             A date string cannot be parsed.
     */
    private void storeOU(
        final String id, final Map<String, String> properties,
        final String xmlDataRest, final String xmlDataSoap) throws IOException,
        ParseException {
        getJdbcTemplate().update(
            INSERT_OU,
            new Object[] { id,
                getStringId(properties, TripleStoreUtility.PROP_CREATED_BY_ID),
                properties.get(TripleStoreUtility.PROP_CREATED_BY_TITLE),
                getTimestamp(properties.get(
                    TripleStoreUtility.PROP_CREATION_DATE)),
                properties.get(TripleStoreUtility.PROP_DC_DESCRIPTION),
                getTimestamp(properties.get(
                    TripleStoreUtility.PROP_LAST_MODIFICATION_DATE)),
                getStringId(properties, TripleStoreUtility.PROP_MODIFIED_BY_ID),
                properties.get(TripleStoreUtility.PROP_MODIFIED_BY_TITLE),
                properties.get(TripleStoreUtility.PROP_PUBLIC_STATUS),
                properties.get(TripleStoreUtility.PROP_PUBLIC_STATUS_COMMENT),
                properties.get(TripleStoreUtility.PROP_DC_TITLE), xmlDataRest,
                xmlDataSoap });
        for (String parent : getParents(id)) {
            getJdbcTemplate().update(INSERT_MEMBER,
                new Object[] {id, getIdFromUri(parent)});
        }
    }

    /**
     * Store the resource in the database cache.
     *
     * @param id
     *            resource id
     * @param restXml
     *            complete resource as REST XML
     * @param soapXml
     *            complete resource as SOAP XML
     *
     * @throws SystemException
     *             A date string cannot be parsed.
     */
    protected void storeResource(
        final String id, final String restXml, final String soapXml)
        throws SystemException {
    }

    /**
     * Store a resource in the database cache.
     * 
     * @param type
     *            must be "container", "context", "item" or "ou"
     * @param id
     *            resource id
     * @param properties
     *            map containing all filter properties
     * @param xmlDataRest
     *            complete item as XML (REST form)
     * @param xmlDataSoap
     *            complete item as XML (SOAP form)
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             The given string cannot be parsed.
     */
    private void storeResource(
        final String type, final String id,
        final Map<String, String> properties, final String xmlDataRest,
        final String xmlDataSoap) throws IOException, ParseException {

        if (type.equals("container")) {
            storeContainer(id, properties, xmlDataRest, xmlDataSoap);
        }
        else if (type.equals("context")) {
            storeContext(id, properties, xmlDataRest, xmlDataSoap);
        }
        else if (type.equals("item")) {
            storeItem(id, properties, xmlDataRest, xmlDataSoap);
        }
        else if (type.equals("ou")) {
            storeOU(id, properties, xmlDataRest, xmlDataSoap);
        }
    }

    /**
     * Store all available resources in the database cache.
     * 
     * @throws ApplicationServerSystemException
     *             Thrown if eSciDoc failed to receive a resource.
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             The given string cannot be parsed.
     */
    public void storeResources() throws ApplicationServerSystemException,
        IOException, ParseException {
        // dummy call to prevent
        // "org.apache.commons.discovery.DiscoveryException: No implementation
        // defined for org.apache.commons.logging.LogFactory"
        try {
            retrieveResourceSoap(AXIS_ITEM_HANDLER_TARGET_NAMESPACE,
                "escidoc:1");
        }
        catch (Exception e) {
        }
        store("container", CONTAINER_LIST_QUERY, CONTAINER_URL,
            AXIS_CONTAINER_HANDLER_TARGET_NAMESPACE);
        store("context", CONTEXT_LIST_QUERY, CONTEXT_URL,
            AXIS_CONTEXT_HANDLER_TARGET_NAMESPACE);
        store("ou", OU_LIST_QUERY, OU_URL, AXIS_OU_HANDLER_TARGET_NAMESPACE);
        store("item", ITEM_LIST_QUERY, ITEM_URL,
            AXIS_ITEM_HANDLER_TARGET_NAMESPACE);
    }
}
