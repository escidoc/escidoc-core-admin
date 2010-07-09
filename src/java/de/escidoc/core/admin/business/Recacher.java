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
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.sql.DataSource;

import org.springframework.core.io.InputStreamResource;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.test.jdbc.SimpleJdbcTestUtils;

import de.escidoc.core.admin.business.interfaces.RecacherInterface;
import de.escidoc.core.admin.common.util.EscidocCoreHandler;
import de.escidoc.core.common.business.fedora.resources.DbResourceCache;
import de.escidoc.core.common.business.fedora.resources.ResourceType;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.exceptions.system.SystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.string.StringUtility;
import fedora.client.FedoraClient;

/**
 * Provides methods used for recaching.
 * 
 * @spring.bean id="de.escidoc.core.admin.Recacher"
 */
public class Recacher extends DbResourceCache implements RecacherInterface {

    /**
     * Logging goes here.
     */
    private static AppLogger log = new AppLogger(Recacher.class.getName());

    /**
     * SQL statement to insert a container.
     */
    private static final String INSERT_CONTAINER =
        "INSERT INTO list.container (id, rest_content, soap_content) VALUES "
            + "(?, ?, ?)";

    /**
     * SQL statement to insert a content model.
     */
    private static final String INSERT_CONTENT_MODEL =
        "INSERT INTO list.content_model (id, rest_content, soap_content) "
            + "VALUES (?, ?, ?)";

    /**
     * SQL statement to insert a content relation.
     */
    private static final String INSERT_CONTENT_RELATION =
        "INSERT INTO list.content_relation (id, rest_content, soap_content) "
            + "VALUES (?, ?, ?)";

    /**
     * SQL statement to insert a context.
     */
    private static final String INSERT_CONTEXT =
        "INSERT INTO list.context (id, rest_content, soap_content) VALUES "
            + "(?, ?, ?)";

    /**
     * SQL statement to insert an item.
     */
    private static final String INSERT_ITEM =
        "INSERT INTO list.item (id, rest_content, soap_content) VALUES (?, ?, ?)";

    /**
     * SQL statement to insert an organizational unit.
     */
    private static final String INSERT_OU =
        "INSERT INTO list.ou (id, rest_content, soap_content) VALUES (?, ?, ?)";

    /**
     * Triple store query to get a list of all containers.
     */
    private static final String CONTAINER_LIST_QUERY =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=*%20%3chttp://"
            + "www.w3.org/1999/02/22-rdf-syntax-ns%23type%3e%20%3c"
            + CONTAINER_OBJECT_TYPE + "%3e";

    /**
     * Triple store query to get a list of all content models.
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

    /**
     * Axis URI to the container handler.
     */
    private static final String AXIS_CONTAINER_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ContainerHandlerService";

    /**
     * Axis URI to the content model handler.
     */
    private static final String AXIS_CONTENT_MODEL_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ContentModelHandlerService";

    /**
     * Axis URI to the content relation handler.
     */
    private static final String AXIS_CONTENT_RELATION_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ContentRelationHandlerService";

    /**
     * Axis URI to the context handler.
     */
    private static final String AXIS_CONTEXT_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ContextHandlerService";

    /**
     * Axis URI to the item handler.
     */
    private static final String AXIS_ITEM_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/ItemHandlerService";

    /**
     * Axis URI to the organizational unit handler.
     */
    private static final String AXIS_OU_HANDLER_TARGET_NAMESPACE =
        "http://localhost:8080/axis/services/OrganizationalUnitHandlerService";

    /**
     * Axis method names.
     */
    private static final String RETRIEVE_METHOD_NAME = "retrieve";

    /**
     * eSciDoc URL to the container handler.
     */
    private static final String CONTAINER_URL = "/ir/container/";

    /**
     * eSciDoc URL to the content model handler.
     */
    private static final String CONTENT_MODEL_URL = "/cmm/content-model/";

    /**
     * eSciDoc URL to the content relation handler.
     */
    private static final String CONTENT_RELATION_URL = "/ir/content-relation/";

    /**
     * eSciDoc URL to the context handler.
     */
    private static final String CONTEXT_URL = "/ir/context/";

    /**
     * eSciDoc URL to the item handler.
     */
    private static final String ITEM_URL = "/ir/item/";

    /**
     * eSciDoc URL to the organizational unit handler.
     */
    private static final String OU_URL = "/oum/organizational-unit/";

    /**
     * Pattern to identify body of resource representation.
     */
    private static final Pattern PATTERN_BODY =
        Pattern.compile("(<[^?].*)", Pattern.MULTILINE | Pattern.DOTALL);

    /**
     * Property "fedoraUser" from configuration file.
     */
    private final String fedoraUser;

    /**
     * Property "fedoraPassword" from configuration file.
     */
    private final String fedoraPassword;

    /**
     * Property "fedoraUrl" from configuration file.
     */
    private final String fedoraUrl;

    /**
     * Property "scriptPrefix" from configuration file.
     */
    private final String scriptPrefix;

    /**
     * Property "clearCache" from configuration file.
     */
    private final boolean clearCache;

    /**
     * Spring beans.
     */
    private EscidocCoreHandler escidocCoreHandler = null;

    /**
     * Object which provides methods to get SOAP stubs for Fedora APIs.
     */
    private FedoraClient fc = null;

    /**
     * Construct a new Recacher object.
     * 
     * @param aFedoraUser
     *            privileged Fedora user
     * @param aFedoraPassword
     *            password of a privileged Fedora user
     * @param aFedoraUrl
     *            Fedora base URL
     * @param aScriptPrefix
     *            prefix for database script names (mainly for MySQL)
     * @param clearCache
     *            clear the cache before adding objects to it
     * 
     * @throws IOException
     *             Thrown if reading the configuration failed.
     */
    public Recacher(final String aFedoraUser, final String aFedoraPassword,
        final String aFedoraUrl, final String aScriptPrefix,
        final String clearCache) throws IOException {
        this.fedoraUser = aFedoraUser;
        this.fedoraPassword = aFedoraPassword;
        this.fedoraUrl = aFedoraUrl;
        this.scriptPrefix =
            ((aScriptPrefix != null) && (aScriptPrefix.length() > 0))
            ? aScriptPrefix + "." : "";
        this.clearCache = Boolean.valueOf(clearCache);
    }

    /**
     * Clear all resources from cache.
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
     */
    public void clearCache() throws IOException {
        if (clearCache) {
            executeSqlScript(scriptPrefix + "list.clear.sql");
        }
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
     * @param scriptName
     *            SQL script name (loaded from class path)
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
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
     *            target name space
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
     * @param aEscidocCoreHandler
     *            the escidocCoreHandler to set
     */
    public final void setEscidocCoreHandler(
        final EscidocCoreHandler aEscidocCoreHandler) {
        this.escidocCoreHandler = aEscidocCoreHandler;
    }

    /**
     * Injects the data source.
     * 
     * @spring.property ref="escidoc-core.DataSource"
     * @param myDataSource
     *            data source from Spring
     */
    public final void setMyDataSource(final DataSource myDataSource) {
        super.setDataSource(myDataSource);
    }

    /**
     * Store all available resources of the given type in the database cache.
     * 
     * @param type
     *            resource type
     * @param listQuery
     *            Fedora query to get a list of all resources of the given type
     * @param resourceUrl
     *            eSciDoc URL to retrieve a resource of the given type
     * @param resourceNamespace
     *            target name space for the given resource type
     * 
     * @throws SystemException
     *             Thrown if eSciDoc failed to receive a resource.
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             The given string cannot be parsed.
     */
    private void store(
        final ResourceType type, final String listQuery,
        final String resourceUrl, final String resourceNamespace)
        throws IOException, ParseException, SystemException {
        BufferedReader input = null;

        resourceType = type;
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
                    final String id =
                        subject.substring(subject.indexOf('/') + 1);

                    if (!clearCache && exists(id)) {
                        log.info(type.getLabel() + " " + subject
                            + " already exists");
                    }
                    else {
                        log.info("store " + type.getLabel() + " " + subject);

                        String xmlDataRest =
                            retrieveResourceRest(resourceUrl, id);
                        String xmlDataSoap =
                            retrieveResourceSoap(resourceNamespace, id);

                        storeProperties(getProperties(id, xmlDataRest));
                        storeResource(type, id, xmlDataRest, xmlDataSoap);
                        count++;
                    }
                }
            }

            long time = (new Date().getTime() - now) / 1000;

            if (time == 0) {
                time = 1;
            }
            log.info("stored " + count + " " + type.getLabel() + "s in " + time
                + "s (" + (count / time) + "." + (count % time) + " "
                + type.getLabel() + "s/s)");
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
        final String id, final String xmlDataRest, final String xmlDataSoap)
        throws IOException, ParseException {
        getJdbcTemplate().update(INSERT_CONTAINER,
            new Object[] { id, xmlDataRest, xmlDataSoap });
    }

    /**
     * Store the content model in the database cache.
     * 
     * @param id
     *            content model id
     * @param xmlDataRest
     *            complete content model as XML (REST form)
     * @param xmlDataSoap
     *            complete content model as XML (SOAP form)
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             A date string cannot be parsed.
     */
    private void storeContentModel(
        final String id, final String xmlDataRest, final String xmlDataSoap)
        throws IOException, ParseException {
        getJdbcTemplate().update(INSERT_CONTENT_MODEL,
            new Object[] { id, xmlDataRest, xmlDataSoap });
    }

    /**
     * Store the content relation in the database cache.
     * 
     * @param id
     *            content relation id
     * @param xmlDataRest
     *            complete content relation as XML (REST form)
     * @param xmlDataSoap
     *            complete content relation as XML (SOAP form)
     * 
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             A date string cannot be parsed.
     */
    private void storeContentRelation(
        final String id, final String xmlDataRest, final String xmlDataSoap)
        throws IOException, ParseException {
        getJdbcTemplate().update(INSERT_CONTENT_RELATION,
            new Object[] { id, xmlDataRest, xmlDataSoap });
    }

    /**
     * Store the context in the database cache.
     * 
     * @param id
     *            context id
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
        final String id, final String xmlDataRest, final String xmlDataSoap)
        throws IOException, ParseException {
        getJdbcTemplate().update(INSERT_CONTEXT,
            new Object[] { id, xmlDataRest, xmlDataSoap });
    }

    /**
     * Store the item in the database cache.
     * 
     * @param id
     *            item id
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
        final String id, final String xmlDataRest, final String xmlDataSoap)
        throws IOException, ParseException {
        getJdbcTemplate().update(INSERT_ITEM,
            new Object[] { id, xmlDataRest, xmlDataSoap });
    }

    /**
     * Store the organizational unit in the database cache.
     * 
     * @param id
     *            organizational unit id
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
        final String id, final String xmlDataRest, final String xmlDataSoap)
        throws IOException, ParseException {
        getJdbcTemplate().update(INSERT_OU,
            new Object[] { id, xmlDataRest, xmlDataSoap });
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
        final ResourceType type, final String id, final String xmlDataRest,
        final String xmlDataSoap) throws IOException, ParseException {

        if (type == ResourceType.CONTAINER) {
            storeContainer(id, xmlDataRest, xmlDataSoap);
        }
        else if (type == ResourceType.CONTENT_MODEL) {
            storeContentModel(id, xmlDataRest, xmlDataSoap);
        }
        else if (type == ResourceType.CONTENT_RELATION) {
            storeContentRelation(id, xmlDataRest, xmlDataSoap);
        }
        else if (type == ResourceType.CONTEXT) {
            storeContext(id, xmlDataRest, xmlDataSoap);
        }
        else if (type == ResourceType.ITEM) {
            storeItem(id, xmlDataRest, xmlDataSoap);
        }
        else if (type == ResourceType.OU) {
            storeOU(id, xmlDataRest, xmlDataSoap);
        }
    }

    /**
     * Store all available resources in the database cache.
     * 
     * @throws SystemException
     *             Thrown if eSciDoc failed to receive a resource.
     * @throws IOException
     *             Thrown if an I/O error occurred.
     * @throws ParseException
     *             The given string cannot be parsed.
     */
    public final void storeResources() throws IOException, ParseException,
        SystemException {
        setSelfUrl(escidocCoreHandler.getEscidocCoreUrl());
        // dummy call to prevent
        // "org.apache.commons.discovery.DiscoveryException: No implementation
        // defined for org.apache.commons.logging.LogFactory"
        try {
            retrieveResourceSoap(AXIS_ITEM_HANDLER_TARGET_NAMESPACE,
                "escidoc:1");
        }
        catch (Exception e) {
        }
        store(ResourceType.CONTAINER, CONTAINER_LIST_QUERY, CONTAINER_URL,
            AXIS_CONTAINER_HANDLER_TARGET_NAMESPACE);
        store(ResourceType.CONTENT_MODEL, CONTENT_MODEL_LIST_QUERY,
            CONTENT_MODEL_URL, AXIS_CONTENT_MODEL_HANDLER_TARGET_NAMESPACE);
        store(ResourceType.CONTENT_RELATION, CONTENT_RELATION_LIST_QUERY,
            CONTENT_RELATION_URL,
            AXIS_CONTENT_RELATION_HANDLER_TARGET_NAMESPACE);
        store(ResourceType.CONTEXT, CONTEXT_LIST_QUERY, CONTEXT_URL,
            AXIS_CONTEXT_HANDLER_TARGET_NAMESPACE);
        store(ResourceType.OU, OU_LIST_QUERY, OU_URL,
            AXIS_OU_HANDLER_TARGET_NAMESPACE);
        store(ResourceType.ITEM, ITEM_LIST_QUERY, ITEM_URL,
            AXIS_ITEM_HANDLER_TARGET_NAMESPACE);
    }
}
