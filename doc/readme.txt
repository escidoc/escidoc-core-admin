eSciDoc infrastructure administration tool
==========================================

Migrate the Fedora content of the eSciDoc Core infrastructure 
--------------------------------------------------------------

This tool first backups the folder ${FEDORA_HOME}/data/datastreams from the 
existing Fedora repository.
Afterwards the tool migrates all relevant FOXML files from the existing Fedora 
to the new Fedora repository.

1.0beta3 -> 1.0beta4
---------------------

1.0beta3 based on Fedora 3.0 beta1 and 10.beta4 make usage of Fedora 3.0 (final release). 

    Prerequisites:
    - Ant in version 1.7.0
    - Newly installed Fedora 3.0 repository in directory fedora3.home

    - Usage:
	    1) Modify admin-tool.properties to define the property value fedora-3.home
        
        2) increase the available memory by setting the system property ANT_OPT
          (ANT_OPTS=-Xmx1024m -Xms512m -XX:MaxPermSize=256m)

 		3) stop eSciDoc
 		4) stop Fedora (both, the productive and the new one)
         
       	5) The admin-tool.properties has to be placed in the same directory where  
          the admin tool is going to be executed.
          Execute target foxml-migration of ant file build.xml
          
       	6) Rebuild the Fedora 3.0 resource index and SQL database. 
          The index and SQL database rebuild is supported by tools from Fedora.
          Call fedora-rebuild script, located in 
          fedora3.home/server/bin, and follow the instructions.
          (For SQL and index rebuild see also 
          http://fedora-commons.org/confluence/display/FCR30/
              Command-Line+Utilities#Command-LineUtilities-rebuild)

        7) check the highest id value for escidoc in the fedora 3 database, 
          table public.pidgen. This value should be the highest id that has been 
          reported during the previous rebuild step. Sometimes, this value is 
          less than the maximum id. In this case, either retry rebuilding index 
          and database, or set this to a value higher than the maximum id.

		8) start new Fedora
		9) restart eSciDoc

Regenerate cache for filter methods (fast lists)
------------------------------------------------

	Use this when 
	- structure/schema of containers, contexts, items or organizational units changed,
	- structure of cache database changed
	
	Prerequisites for recaching:
        - Database has been migrated (if necessary)
        - Fedora has been migrated (if necessary)
        - eSciDocCore Services including fedora repository are started

	- Workflow:
		- delete all resources from cache database
		- get all resources from eSciDoc
		- put these resources into the cache database

	- Usage:
		- modify admin-tool.properties:
			- escidocOmUrl : URL of OM
                        - fedora.user : Fedora admin user name
                        - fedora.password : Fedora admin password
                        - fedora.url : URL of Fedora
                        - new.datasource.* : JDBC properties for eSciDoc database
                        - login: eSciDoc admin login name
                        - password : eSciDoc admin password

        - Execute 
            - java -jar eSciDocCoreAdmin.jar recache
            or
            - target recache of ant file build.xml
          The admin-tool.properties must be placed in the directory from that 
          the admin tool is executed.


Regenerate index for search
---------------------------

    Prerequisites for reindexing:
    - Database has been migrated (if necessary)
    - Fedora has been migrated (if necessary)
    - Object cache has been regenerated (if necessary)
    - eSciDocCore Services including fedora repository are started

    Use this when 
    - structure/schema of items or containers changes
    - Structure of index-database changed (new index etc.)
    
    - Workflow:
        - get all items/container-hrefs from om where status = released
        - delete index-databases
        - put item-hrefs in SB-indexing queue -> reindex items
        - put container-hrefs in SB-indexing queue -> reindex containers
        
    - Usage:
        - modify admin-tool.properties:
            - escidocOmUrl : URL of OM
            - escidocSbUrl: URL of naming-service of SB
        - Execute 
            - java -jar eSciDocCoreAdmin.jar reindex 
            or
            - target reindex of ant file build.xml
          The admin-tool.properties must be placed in the directory from that 
          the admin tool is executed.
        

