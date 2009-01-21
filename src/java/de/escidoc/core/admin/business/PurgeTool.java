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
 * Copyright 2009 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin.business;

import de.escidoc.core.common.util.logger.AppLogger;

import fedora.client.FedoraClient;
import fedora.server.management.FedoraAPIM;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.lang.reflect.Method;
import java.net.URLEncoder;

/**
 * Provides an API to purge Fedora items from the repository.
 *
 * @author Andr&eacute; Schenk
 */
public class PurgeTool {
    /**
     * Logging goes here.
     */
    private static AppLogger log = new AppLogger(PurgeTool.class.getName());

    /**
     * Character set used to communicate with the outside.
     */
    private static final String CHARSET = "utf-8";

    /**
     * Prefix used for Fedora identifiers.
     */
    private static final String FEDORA_PREFIX = "info:fedora/";

    /**
     * Prefix used for Fedora RISearch URLs.
     */
    private static final String QUERY_PREFIX =
        "/risearch?type=triples&lang=spo&format=N-Triples&query=";

    /**
     * RISearch query to force a triple store sync.
     */
    private static final String SYNC_QUERY = "/risearch?flush=true";

    /**
     * Object which provides methods to get SOAP stubs for Fedora APIs.
     */
    private final FedoraClient fc;

    /**
     * SOAP stub for API-M.
     */
    private final FedoraAPIM apim;

    /**
     * Construct a new PurgeTool object.
     *
     * @param fedoraUser
     *            privileged Fedora user
     * @param fedoraPassword
     *            password of a privileged Fedora user
     * @param fedoraUrl
     *            Fedora base URL
     *
     * @throws Exception thrown if the connection to Fedora couldn't be
     *         established
     */
    public PurgeTool(final String fedoraUser, final String fedoraPassword,
        final String fedoraUrl) throws Exception {
        fc = new FedoraClient(fedoraUrl, fedoraUser, fedoraPassword);
        apim = fc.getAPIM();
    }

    /**
     * Extract the object id from the given Fedora identifier.
     *
     * @param pid Fedora PID
     *
     * @return object id
     */
    private String extractId(final String pid) {
        return pid.substring(FEDORA_PREFIX.length() + 1, pid.length() - 1);
    }

    /**
     * Check whether or not the given resource is an item.
     *
     * @param pid Fedora PID
     *
     * @return true if the object is an item
     * @throws Exception thrown if the connection to Fedora failed or some
     *                   internal error occurred
     */
    private boolean isItem(final String pid) throws Exception {
        return query(pid,
                     "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>",
                     "<http://escidoc.de/core/01/resources/Item>",
                     null,
                     null);
    }

    /**
     * Purge the object with the given object id.
     *
     * @param id object id
     *
     * @param out Some status info will be written there.
     * @throws IOException thrown if the connection to Fedora failed or some
     *                     internal error occurred
     */
    private void purge(final String id, final Writer out) throws IOException {
        log.debug("purge object \"" + id + "\"");
        if (out != null) {
            out.write("purging object \"" + id + "\" ... ");
        }
        apim.purgeObject(id, "", false);
        sync();
        if (out != null) {
            out.write("ok<br/>\n");
            out.flush();
        }
    }

    /**
     * Purge components identified by the object taken from an RDF triple.
     *
     * @param s subject from the RDF triple
     * @param p predicate from the RDF triple
     * @param o object from the RDF triple
     * @param out Some status info will be written there.
     *
     * @throws Exception thrown if the connection to Fedora failed or some
     *                   internal error occurred
     */
    private void purgeComponentsByObjectMethod(
        final String s, final String p, final String o, final Writer out)
        throws Exception {
        if (o != null) {
            purge(extractId(o), out);
        }
    }

    /**
     * Purge items identified by the subject taken from an RDF triple.
     *
     * @param s subject from the RDF triple
     * @param p predicate from the RDF triple
     * @param o object from the RDF triple
     * @param out Some status info will be written there.
     *
     * @throws Exception thrown if the connection to Fedora failed or some
     *                   internal error occurred
     */
    private void purgeItemsBySubjectMethod(
        final String s, final String p, final String o, final Writer out)
        throws Exception {
        if ((s != null) && isItem(s)) {
            // delete all components of this item
            query(s,
                  "<http://escidoc.de/core/01/structural-relations/component>",
                  "*",
                  "purgeComponentsByObjectMethod",
                  out);

            // delete item
            purge(extractId(s), out);
        }
    }

    /**
     * Purge items from the Fedora repository.
     *
     * The given SPO query will be sent to the Fedora RISearch engine. All
     * returning triples will be split into subject, predicate and object. All
     * items which are identified by the subjects from the RDF triples will
     * then be deleted.
     *
     * @param s subject from the RDF triple
     * @param p predicate from the RDF triple
     * @param o object from the RDF triple
     * @param out Some status info will be written there.
     *
     * @throws Exception thrown if the connection to Fedora failed or some
     *                   internal error occurred
     */
    public final void purgeItemsBySubject(
        final String s, final String p, final String o, final Writer out)
        throws Exception {
        query(s, p, o, "purgeItemsBySubjectMethod", out);
    }

    /**
     * Query the Fedora RISearch engine and start the given method for every
     * triples found in the result list.
     *
     * @param s subject from the RDF triple
     * @param p predicate from the RDF triple
     * @param o object from the RDF triple
     * @param doMethodName This method will be called for every RDF triple from
     *                     the result list.
     * @param out Some status info will be written there.
     *
     * @return True if the search returned at least one triple.
     * @throws Exception thrown if the connection to Fedora failed or some
     *                   internal error occurred
     */
    private boolean query(final String s, final String p, final String o,
        final String doMethodName, final Writer out) throws Exception {
        boolean result = false;
        BufferedReader input = null;

        log.debug("SPO: " + s + " " + p + " " + o);

        String risearchUrl = QUERY_PREFIX + URLEncoder.encode(s, CHARSET)
                                  + "%20" + URLEncoder.encode(p, CHARSET)
                                  + "%20" + URLEncoder.encode(o, CHARSET);

        log.debug("query: " + risearchUrl);
        try {
            input = new BufferedReader(new InputStreamReader(fc.get(risearchUrl,
                true)));

            String line;

            while ((line = input.readLine()) != null) {
                result = true;

                String[] triple = line.split(" ");

                if (doMethodName != null) {
                    Method doMethod = getClass().getDeclaredMethod(
                        doMethodName,
                        String.class,
                        String.class,
                        String.class,
                        Writer.class);

                    doMethod.invoke(this, triple[0], triple[1], triple[2], out);
                }
            }
        } finally {
            if (input != null) {
                input.close();
            }
        }
        return result;
    }

    /**
     * Ask the Fedora RISearch engine to flush its buffers to the repository.
     *
     * @throws IOException thrown if the connection to Fedora failed or some
     *                     internal error occurred
     */
    private void sync() throws IOException {
        fc.get(SYNC_QUERY, true);
    }

    /**
     * Main method for testing.
     *
     * @param args command line arguments
     *
     * @throws Exception thrown if the connection to Fedora failed or some
     *                   internal error occurred
     */
    public static void main(final String [] args) throws Exception {
        PurgeTool tool = new PurgeTool(
            "fedoraAdmin", "fedoraAdmin", "http://localhost:8082/fedora");
        Writer out = new OutputStreamWriter(System.out, CHARSET);

        // delete only items of a specific content model
        tool.purgeItemsBySubject(
            "*",
            "<http://escidoc.de/core/01/structural-relations/content-model>",
            "<info:fedora/escidoc:ex4>",
            out);

        // delete all items within a context
        tool.purgeItemsBySubject(
            "*",
            "<http://escidoc.de/core/01/structural-relations/context>",
            "<info:fedora/escidoc:ex1>",
            out);
    }
}
