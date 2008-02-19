package de.escidoc.core.admin;

import java.util.Vector;

import de.escidoc.core.admin.business.Reindexer;
import de.escidoc.core.common.exceptions.system.ApplicationServerSystemException;
import de.escidoc.core.common.util.logger.AppLogger;

public class AdminMain {

    private String escidocOmUrl = "http://localhost:8080";
    private String escidocSbUrl = "jnp://localhost:1099";

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
            System.out.println(args[0]);
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

        log.info("escidocOmUrl=" + getEscidocOmUrl());
        log.info("escidocSbUrl=" + getEscidocSbUrl());
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

        if (!escidocOmUrl.startsWith("http://")) {
            escidocOmUrl = "http://" + escidocOmUrl;
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

    /**
     * @return the escidocOmUrl
     */
    public String getEscidocOmUrl() {
        return escidocOmUrl;
    }

    /**
     * @param escidocOmUrl
     *            the escidocOmUrl to set
     */
    public void setEscidocOmUrl(String escidocOmUrl) {
        this.escidocOmUrl = escidocOmUrl;
    }

    /**
     * @return the escidocSbUrl
     */
    public String getEscidocSbUrl() {
        return escidocSbUrl;
    }

    /**
     * @param escidocSbUrl
     *            the escidocSbUrl to set
     */
    public void setEscidocSbUrl(String escidocSbUrl) {
        this.escidocSbUrl = escidocSbUrl;
    }

}
