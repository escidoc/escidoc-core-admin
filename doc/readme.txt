eSciDoc Infrastructure Administration Tool
===========================================

The Administration Tool supports update of cache, reindex for search, migration 
of object representation and migration of the Fedora repository. 
 
Reindex and recache might by necessary without updating eSciDoc. E.g. the used 
hardware or OS infrastructure has changed. Therefore are these task separated 
into independent sub tasks.

Index
	1.) Migration of the eSciDoc Core Infrastructure
	2.) Migration of Fedora Repository
	3.) Reload of objects to Cache
	4.) Re-Index for Search


1.) Migration of the eSciDoc Core Infrastructure
-------------------------------------------------

Migration of 1.0beta3 -> 1.0beta4

Fedora data objects are stored in Fedora, Cache System and the index for 
search. Each of these storages has to be migrated for an software update.
The migration of the eSciDoc infrastructure from eSciDoc 1.0beta3 to 1.0beta4 
is subdivided into following ordered tasks:

	1.) Stop all Systems
		- stop eSciDoc (at least eSciDoc Core)
		- stop current used Fedora
		- stop new Fedora
	2.) Install new Software
		- install the new Fedora (see installation document)
		- install new eSciDoc (see installation document) 
	3.) Migration of Fedora Repository
		- see section 2.) Migration of Fedora Repository
	4.) Reload of objects to Cache
		- see section 3.) Reload of objects to Cache
	5.) Re-Index for Search
		- see section 4.) Re-Index for Search
	6.) Restart Systems

A migration of a running eSciDoc and/or Fedora is currently not supported.
Furthermore migration is only supported between the last stable release and 
the new stable release. The migration between developer builds may work but 
will never be supported. If you migrate non supported versions you do it at 
your own risk and without any support.

eSciDoc 1.0beta3 is based on Fedora 3.0 beta1 and eSciDoc 1.0beta4 makes usage
of Fedora 3.0 (final release). 


2.) Migration of Fedora Repository 
------------------------------------
Fedora 3.0beta1 -> Fedora 3.0
eSciDoc 1.0beta3 -> eSciDoc 1.0beta4

The migration procedure first backups the folders 
${FEDORA_HOME}/data/datastreams and ${FEDORA_HOME}/data/objects from the new
Fedora repository. Then all datastreams from the existing Fedora repository are
copied into the new Fedora repository. After that all relevant FOXML files are
migrated from the existing Fedora to the new Fedora repository. The migration
may also contain a transformation of the objects itself. 

    Prerequisites:
    - Ant in version 1.7.0
    - Newly installed Fedora 3.0 repository in directory fedora3.home
	- stopped eSciDoc
	- stopped old and new Fedora 
	
    - Usage:
	    1) Modify admin-tool.properties
	      - define the location of the old repository in the property fedora-src.home
	      	e.g. fedora-src.home=/repository/fedora30b1 
	      	or on Windows
	      	fedora-src.home=C:/repository/fedora30b1 
	      - define the location of the new repository in the property fedora-target.home
	      	e.g. fedora-target.home=/repository/fedora30
        
        2) Increase the available memory by setting the system property ANT_OPTS.
          At least to following values:
          ANT_OPTS=-Xmx1024m -Xms512m -XX:MaxPermSize=256m

      	3) The admin-tool.properties has to be placed in the same directory where  
          the admin tool is going to be executed.
          Execute target foxml-migration of ant file build.xml
          
       	4) Rebuild the Fedora 3.0 resource index and SQL database. 
       	   It is assumed that the new Fedora make usage of the same Fedora 
       	   database like the old Fedora installation. Therefore all tables from
       	   Fedora database to drop and automatically recreated during the 
       	   rebuild procedure. This step is not necessary if a new database is 
       	   used. Connect to your Fedora database and drop all tables.
       	   
          The index and SQL database rebuild is supported by tools from Fedora.
          Call fedora-rebuild script, located in 
          fedora3.home/server/bin, and follow the instructions.
          (For SQL and index rebuild see also 
          http://fedora-commons.org/confluence/display/FCR30/
              Command-Line+Utilities#Command-LineUtilities-rebuild)

        5) Check the highest id value for escidoc in the fedora 3 database, 
          table public.pidgen. This value should be the highest id that has been 
          reported during the previous rebuild step. Sometimes, this value is 
          less than the maximum id. In this case, either retry rebuilding index 
          and database, or set this to a value higher than the maximum id.


3.) Regenerate cache for filter methods (fast lists)
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


4.) Regenerate index for search
--------------------------------

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
