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

import java.lang.reflect.InvocationTargetException;
import java.util.Vector;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.access.BeanFactoryLocator;
import org.springframework.beans.factory.access.SingletonBeanFactoryLocator;
import org.springframework.transaction.CannotCreateTransactionException;

import de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface;
import de.escidoc.core.admin.business.interfaces.RecacheInterface;
import de.escidoc.core.admin.business.interfaces.ReindexerInterface;
import de.escidoc.core.admin.common.util.spring.SpringConstants;
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
        SingletonBeanFactoryLocator
            .getInstance(SpringConstants.BEAN_REF_FACTORY);

    private final BeanFactory beanFactory =
        beanFactoryLocator.useBeanFactory(
            SpringConstants.ID_APPLICATION_CONTEXT).getFactory();

    /**
     * Main Method, depends on args[0] which method is executed.
     * 
     * @param args
     *            arguments given on commandline
     */
    public static void main(final String[] args) {
        AdminMain admin = new AdminMain();
        if (args != null && args.length > 0) {
            log.info(args[0]);
            if (args[0].equals("reindex")) {
                admin.reindex(args);
            }
            else if (args[0].equals("recache")) {
                admin.recache(args);
            }
            else if (args[0].equals("test")) {
                admin.test(args);
            }
            else if (args[0].equals("db-migration")) {
                admin.migrateDataBase(args);
            }
            else {
                log.error("method-argument unknown: " + args[0]);
            }
        }
        else {
            log.error("please provide method-argument");
        }
    }

    /**
     * Migrate the content of the escidoc-core database.
     * 
     * @param args
     *            The arguments.
     * @see de.escidoc.core.admin.business.interfaces.DataBaseMigrationInterface#migrate()
     */
    private void migrateDataBase(final String[] args) {

        log.info("Database migration invoked");

        DataBaseMigrationInterface dbm =
            (DataBaseMigrationInterface) beanFactory
                .getBean(SpringConstants.ID_DATA_BASE_MIGRATION_TOOL);
        try {
            dbm.migrate();
            log.info("");
            log.info("Migration successfully completed.\n");
            log.warn("");
            log.warn("Recaching needed");
            log.warn("================");
            log.warn("Now, after the object");
            log.warn("cache tables have been");
            log.warn("created during the migration,");
            log.warn("this cache has to be synchronized");
            log.warn("with the existing resource objects");
            log.warn("using the recache method from the");
            log.warn("admin tool.");
            log.warn("Please, see readme.txt.");
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
        RecacheInterface recache =
            (RecacheInterface) beanFactory.getBean(SpringConstants.ID_RECACHE);

        try {
            recache.clearCache();
            recache.storeResources();
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
            (ReindexerInterface) beanFactory
                .getBean(SpringConstants.ID_REINDEXER);

        try {
            // Get all released Items
            Vector<String> itemHrefs = reindexer.getReleasedItems();
            // Get all released Containers
            Vector<String> containerHrefs = reindexer.getReleasedContainers();

            // Delete index
            reindexer.sendDeleteIndexMessage();

            log
                .info("scheduling " + itemHrefs.size()
                    + " items for reindexing");
            log.info("scheduling " + containerHrefs.size()
                + " containers for reindexing");

            // Reindex released items
            for (String itemHref : itemHrefs) {
                reindexer.sendUpdateIndexMessage(itemHref);
                try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {}
            }

            // reindex released containers
            for (String containerHref : containerHrefs) {
                reindexer.sendUpdateIndexMessage(containerHref);
                try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {}
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
