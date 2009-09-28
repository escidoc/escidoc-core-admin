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
package de.escidoc.core.admin;

import static de.escidoc.core.admin.common.util.spring.SpringConstants.BEAN_REF_FACTORY;
import static de.escidoc.core.admin.common.util.spring.SpringConstants.ID_APPLICATION_CONTEXT;
import static de.escidoc.core.admin.common.util.spring.SpringConstants.ID_DATA_BASE_MIGRATION_TOOL;
import static de.escidoc.core.admin.common.util.spring.SpringConstants.ID_RECACHER;
import static de.escidoc.core.admin.common.util.spring.SpringConstants.ID_REINDEXER;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.Vector;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.access.BeanFactoryLocator;
import org.springframework.beans.factory.access.SingletonBeanFactoryLocator;
import org.springframework.transaction.CannotCreateTransactionException;

import de.escidoc.core.admin.business.FoxmlMigrationTool;
import de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface;
import de.escidoc.core.admin.business.interfaces.RecacherInterface;
import de.escidoc.core.admin.business.interfaces.ReindexerInterface;
import de.escidoc.core.common.business.Constants;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.exceptions.system.IntegritySystemException;
import de.escidoc.core.common.util.logger.AppLogger;
import de.escidoc.core.common.util.string.StringUtility;

/**
 * Main Class for the Admin-Tool.
 * 
 * @admin
 */
public class AdminMain {

    private static AppLogger log = new AppLogger(AdminMain.class.getName());

    private final BeanFactoryLocator beanFactoryLocator =
        SingletonBeanFactoryLocator.getInstance(BEAN_REF_FACTORY);

    private final BeanFactory beanFactory =
        beanFactoryLocator.useBeanFactory(ID_APPLICATION_CONTEXT).getFactory();

    private static final int REINDEXER_WAIT_TIME = 1000;

    private static final Map<String, String> methods =
        new HashMap<String, String>();

    // call parameter name -> method name
    static {
        methods.put("reindex", "reindex");
        methods.put("recache", "recache");
        methods.put("test", "test");
        methods.put("db-migration", "migrateDataBase");
        methods.put("foxml-migration", "migrateFoxml");
    }

    /**
     * Main Method, depends on args[0] which method is executed.
     * 
     * @param args
     *            arguments given on commandline
     * @throws NoSuchMethodException
     *             e
     * @throws InvocationTargetException
     *             e
     * @throws IllegalAccessException
     *             e
     */
    public static void main(final String[] args) throws NoSuchMethodException,
        IllegalAccessException, InvocationTargetException {
        AdminMain admin = new AdminMain();

        // call has to have at least one argument
        if (args.length == 0 || StringUtils.isEmpty(args[0])) {
            admin.failMessage();
            System.exit(-1);
        }

        String methodToCall = methods.get(args[0]);
        if (StringUtils.isEmpty(methodToCall)) {
            admin.failMessage("provided tool name: "
                + StringUtils.join(args, " "));
            System.exit(-1);
        }

        log.info("memory (free / max. available): "
            + Runtime.getRuntime().freeMemory() / 1024 / 1024 + " MB" + " / "
            + Runtime.getRuntime().maxMemory() / 1024 / 1024 + " MB");

        Class< ? >[] paramTypes = { String[].class };
        Method thisMethod =
            admin.getClass().getDeclaredMethod(methodToCall, paramTypes);
        thisMethod.invoke(admin, new Object[] { args });

    }

    /**
     * Print the message indicating a failure.
     */
    private void failMessage(final String... message) {
        for (String m : message) {
            log.error(m);
        }
        log
            .error("Invalid argument. The tool you specified could not be found.");
        log
            .error("Invoke the tool of your choice using this command : java -jar"
                + " eSciDocCoreAdmin.jar <tool> [<arguments>].");
        log.error("The follwoing tools are available:");
        for (String method : new TreeMap<String, Object>(methods).keySet()) {
            log.error(method);
        }
    }

    /**
     * Migrate the content of the escidoc-core database.
     * 
     * @param args
     *            The arguments.
     * @see de.escidoc.core.admin.business
     *      .interfaces.DataBaseMigrationInterface#migrate()
     */
    private void migrateDataBase(final String[] args) {

        log.info("Database migration invoked");

        DataBaseMigrationInterface dbm =
            (DataBaseMigrationInterface) beanFactory
                .getBean(ID_DATA_BASE_MIGRATION_TOOL);
        try {
            dbm.migrate();
            log.info("Migration successfully completed.\n");
        }
        catch (IntegritySystemException e) {
            log.error(e);
        }
        catch (CannotCreateTransactionException e) {
            final StringBuffer errorMsg =
                StringUtility.concatenate(
                    "\nFailed to create transaction for database access.",
                    "\nPlease check your database settings in your",
                    " admin-tool.properties file.");
            log.error(errorMsg, e);
        }
        catch (Exception e) {
            if (e instanceof InvocationTargetException) {
                if (e.getCause() != null) {
                    log.error(e.getCause().getMessage(), e.getCause());
                    return;
                }
            }
            log.error(e.getMessage(), e);
        }
    }

    /**
     * Migrate the Fedora Foxml files.
     * 
     * @param args
     *            The arguments.
     */
    private void migrateFoxml(final String[] args) {

        log.info("Foxml migration invoked");
        try {
            new FoxmlMigrationTool(args[1], args[2], args[3]);
        }
        catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    private void test(final String[] args) {
        log.info("Test method invoked!");
        String escidocOmUrl = null;
        String escidocSbUrl = null;
        if (args.length > 1 && args[1] != null) {
            escidocOmUrl = args[1];
        }
        if (args.length > 2 && args[2] != null) {
            escidocSbUrl = args[2];
        }

        log.info("escidocOmUrl=" + escidocOmUrl);
        log.info("escidocSbUrl=" + escidocSbUrl);
    }

    /**
     * Clear the item cache, get all items and store them in the item cache.
     * 
     * @param args
     *            The arguments.
     */
    private void recache(final String[] args) {
        RecacherInterface recacher =
            (RecacherInterface) beanFactory.getBean(ID_RECACHER);

        try {
            recacher.clearCache();
            recacher.storeResources();
        }
        catch (Exception e) {
            log.error(e);
            e.printStackTrace();
        }
    }

    /**
     * delete index, get all items and containers that are released and put the
     * resourceIds into the indexer message queue.
     * 
     * @param args
     *            The arguments.
     */
    private void reindex(final String[] args) {
        ReindexerInterface reindexer =
            (ReindexerInterface) beanFactory.getBean(ID_REINDEXER);

        try {
            // Get all released Items
            Vector<String> itemHrefs = reindexer.getFilteredItems();
            // Get all released Containers
            Vector<String> containerHrefs = reindexer.getFilteredContainers();
            // Get all public viewable organizational-units
            Vector<String> orgUnitHrefs =
                reindexer.getFilteredOrganizationalUnits();

            // Delete index
            reindexer.clearIndex();

            log
                .info("scheduling " + itemHrefs.size()
                    + " items for reindexing");
            log.info("scheduling " + containerHrefs.size()
                + " containers for reindexing");
            log.info("scheduling " + orgUnitHrefs.size()
                + " organizational-units for reindexing");

            // Reindex released items
            for (String itemHref : itemHrefs) {
                reindexer.sendUpdateIndexMessage(itemHref,
                    Constants.ITEM_OBJECT_TYPE);
                try {
                    Thread.sleep(REINDEXER_WAIT_TIME);
                }
                catch (InterruptedException e) {
                }
            }

            // reindex released containers
            for (String containerHref : containerHrefs) {
                reindexer.sendUpdateIndexMessage(containerHref,
                    Constants.CONTAINER_OBJECT_TYPE);
                try {
                    Thread.sleep(REINDEXER_WAIT_TIME);
                }
                catch (InterruptedException e) {
                }
            }

            // reindex public viewable organizational-units
            for (String orgUnitHref : orgUnitHrefs) {
                reindexer.sendUpdateIndexMessage(orgUnitHref,
                    Constants.ORGANIZATIONAL_UNIT_OBJECT_TYPE);
                try {
                    Thread.sleep(REINDEXER_WAIT_TIME);
                }
                catch (InterruptedException e) {
                }
            }

        }
        catch (ApplicationServerSystemException e) {
            log.error(e);
        }
        finally {
            if (reindexer != null) {
                reindexer.close();
            }
        }
    }
}
