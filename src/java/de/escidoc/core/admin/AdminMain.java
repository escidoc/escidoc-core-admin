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
 * Copyright 2006-2007 Fachinformationszentrum Karlsruhe Gesellschaft
 * fuer wissenschaftlich-technische Information mbH and Max-Planck-
 * Gesellschaft zur Foerderung der Wissenschaft e.V.  
 * All rights reserved.  Use is subject to license terms.
 */
package de.escidoc.core.admin;

import java.util.Vector;

import de.escidoc.core.admin.business.Reindexer;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;

public class AdminMain {

    private String escidocOmUrl = null;
    private String escidocSbUrl = null;

	private static AppLogger log =
        new AppLogger(AdminMain.class.getName());
    
    /**
     * TODO: Describe Method
     * 
     * @param args
     */
    public static void main(String[] args) {
    	AdminMain admin = new AdminMain();
        if (args != null && args.length > 0) {
            log.info(args[0]);
            if (args[0].equals("reindex")) {
                admin.reindex(args);
            }
            else if (args[0].equals("test")) {
                admin.test(args);
            }
        }
        else {
        	log.error("please provide method-argument");
        }
    }

    private void test(String[] args) {
    	log.info("Test method invoked!");
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
     * TODO: Describe Method
     * 
     * @param args
     */
    private void reindex(String[] args) {
        if (args.length > 1 && args[1] != null) {
            escidocOmUrl = args[1];
        }
        if (args.length > 2 && args[2] != null) {
            escidocSbUrl = args[2];
        }

        Reindexer reindexer = null;
        try {
        	//initialize Reindexer
            reindexer = new Reindexer(escidocOmUrl, escidocSbUrl);
            
            //Get all released Items
            Vector<String> itemHrefs = reindexer.getReleasedItems();
            //Get all released Containers
            Vector<String> containerHrefs = reindexer.getReleasedContainers();
            
            //Delete index
            reindexer.sendDeleteIndexMessage();
            
            //Reindex released items
            for (String itemHref : itemHrefs) {
            	reindexer.sendUpdateIndexMessage(itemHref);
            }

            //reindex released containers
            for (String containerHref : containerHrefs) {
            	reindexer.sendUpdateIndexMessage(containerHref);
            }

        } catch (ApplicationServerSystemException e) {
        	log.error(e);
        } finally {
        	if (reindexer != null) {
            	reindexer.close();
        	}
        }
    }

}
