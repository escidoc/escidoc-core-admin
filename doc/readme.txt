eSciDoc infrastructure administration tool
==========================================


Regenerate index for search
---------------------------

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
		

Migrate the escidoc-core database from build 0.9.0159 / 0.9.1.x to Release 1.0
------------------------------------------------------------------------------

   Prerequisites for migration: Ant in version 1.7.0 

    - Usage:
        - Create new (empty) database as the target of the migration.
        - Modify admin-tool.properties to define the database values
          - Values for existing database (source)
          - Values for new database (target)
        - Execute 
            - java -jar eSciDocCoreAdmin.jar db-migration 
            or
            - target db-migration of ant file build.xml
          The admin-tool.properties must be placed in the directory from that 
          the admin tool is executed.
		

Migrate the fedora content of a eSciDoc repository from build 0.9.0159 to Release 1.0
-------------------------------------------------------------------------------------

    - Usage:
        - Modify admin-tool.properties to define the values for properties fedora-2.home and fedora-3.home
        - execute target foxml-migration of ant file build.xml
          The admin-tool.properties must be placed in the directory from that 
          the admin tool is executed.


Regenerate cache for filter methods (fast lists)
------------------------------------------------

	Use this when 
	- structure/schema of containers or items changed,
	- structure of cache database changed

	- Workflow:
		- delete all containers and items from cache database
		- get all containers and items from om
		- put these containers and items into the cache database

	- Usage:
		- modify admin-tool.properties:
			- escidocOmUrl : URL of OM
                        - fedora.user : Fedora admin user name
                        - fedora.password : Fedora admin password
                        - fedora.url : URL of Fedora
                        - new.datasource.* : JDBC properties for eSciDoc database
                        - password : eSciDoc admin password

        - Execute 
            - java -jar eSciDocCoreAdmin.jar recache
            or
            - target recache of ant file build.xml
          The admin-tool.properties must be placed in the directory from that 
          the admin tool is executed.
