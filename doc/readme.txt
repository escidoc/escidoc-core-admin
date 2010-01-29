eSciDoc Infrastructure Administration Tool
===========================================

The Administration Tool supports update of cache, reindex for search, migration 
of the eSciDocCore database and migration of the Fedora repository. 
 
Reindex and recache might by necessary without updating eSciDoc. E.g. the used 
hardware or OS infrastructure has changed. Therefore these tasks are separated 
into independent sub tasks.

Index
	1.) Migration of the eSciDocCore database
	2.) Migration of Fedora Repository
	3.) Reload of objects to Cache
	4.) Re-Index for Search


1.) Migration of the eSciDocCore database
-----------------------------------------

Migration to 1.2

There were several changes to the eSciDocCore database between earlier releases and
1.2. To start the migration process the following tasks are necessary:

	1.) Stop eSciDoc (at least eSciDocCore)
	2.) Install new Software (see installation document)
		- install new eSciDocCore
	3.) Migration of eSciDocCore database
            - java -jar eSciDocCoreAdmin.jar db-migration
            or
            - target "db-migration" of ant file build.xml
	    The admin-tool.properties must be placed in the directory from that 
	    the admin tool is executed.
	4.) Restart eSciDoc

A migration of a running eSciDoc is currently not supported. Furthermore
migration is only supported between stable releases. The migration between
developer builds may work but will never be supported. If you migrate non supported
versions you do it at your own risk and without any support.

Warning:

The migration tool cannot migrate the the XACML policies. If they did change then they
will be overwritten with the new content. Please be sure to do a backup of your policies
if you had modified them in the meantime.


2.) Migration of Fedora Repository 
----------------------------------

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


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Migration of 1.1 -> 1.2
The migration procedure first copies the folder 
${FEDORA_HOME}/data/datastreams and backups the folder ${FEDORA_HOME}/data/objects from the current
Fedora repository. After that all FOXML files are transformed to the requirements of 1.2 and their DC-records are conform to
the unqualified  DC-schema (http://purl.org/dc/elements/1.1/). Furthermore, the migration procedure
repairs wrongly encoded charactes in the version history of Items amd Containers, 
caused by bug INFR-792 in the release 1.1.1 and previous releases.. 

    Prerequisites:
    - Ant in version 1.7.0
	- stopped eSciDoc
	- stopped Fedora 
	
    - Usage:
	    1) Modify admin-tool.properties
	      - define the location of the current repository in the property fedora-src.home
	      	e.g. fedora-src.home=/repository/fedora3.2.1 
	      	or on Windows
	      	fedora-src.home=C:/repository/fedora3.2.1
	   2) Increase the available memory by setting the system property ANT_OPTS.
          At least to following values:
          ANT_OPTS=-Xmx1024m -Xms512m -XX:MaxPermSize=256m

      	3) The admin-tool.properties has to be placed in the same directory where  
          the admin tool is going to be executed.
          Execute target foxml-migration-from1.1-to1.2 of ant file build.xml
          
       	4) Rebuild the Fedora 3.2 resource index and SQL database. 
       	   
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
----------------------------------------------------

	Use this when 
	- structure/schema of containers, contexts, items or organizational units changed,
	- structure of cache database changed
	
	Prerequisites for recaching:
        - Database has been migrated (if necessary)
        - Fedora has been migrated (if necessary)
        - eSciDocCore Services including fedora repository are started

	Workflow:
	- delete all resources from cache database
	- get all resources from eSciDoc
	- put these resources into the cache database

	Usage:
	- modify admin-tool.properties:
		- escidocOmUrl : URL of OM
		- fedora.user : Fedora admin user name
		- fedora.password : Fedora admin password
		- fedora.url : URL of Fedora
		- datasource.* : JDBC properties for eSciDoc database
		- persistentHandle: persistent handle of eSciDoc systemadmin
		- clearCache: set to false if the cache should not be emptied before adding
		  objects to it
        - execute 
            - java -Xmx1024m -Xms512m -XX:MaxPermSize=1024m -jar eSciDocCoreAdmin.jar recache
            or
            - target recache of ant file build.xml
            The admin-tool.properties must be placed in the directory from that 
            the admin tool is executed.


4.) Regenerate index for search
-------------------------------

	Prerequisites for reindexing:
	- Database has been migrated (if necessary)
	- Fedora has been migrated (if necessary)
	- Object cache has been regenerated (if necessary)
	- eSciDocCore Services including fedora repository are started

	Use this when 
	- structure/schema of items or containers changes
	- Structure of index-database changed (new index etc.)
    
	Workflow:
	- get all items/container-hrefs from om where status = released
	- delete index-databases
	- put item-hrefs in SB-indexing queue -> reindex items
	- put container-hrefs in SB-indexing queue -> reindex containers
        
	Usage:
        - modify admin-tool.properties:
		- escidocOmUrl : URL of OM
		- escidocSbUrl: URL of naming-service of SB
		- persistentHandle: persistent handle of eSciDoc systemadmin
		- clearIndex: set to false if the index should not be emptied before adding
		  objects to it
		- indexNamePrefix: set to "escidoc", "escidocou", "escidocoaipmh" if you want
		  to rebuild only one specific index, "all" otherwise
        - execute 
            - java -jar eSciDocCoreAdmin.jar reindex 
            or
            - target reindex of ant file build.xml
            The admin-tool.properties must be placed in the directory from that 
            the admin tool is executed.
