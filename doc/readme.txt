eSciDoc infrastructure administration tool

- Tool to regenerate index for search.
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
		
- Tool to migrate the escidoc-core database from build 0.9.0159 to Release 1.0
    
    - Usage:
        - Backup the database
        - If the default value for the escidoc database are used, rename 
          database escidoc to escidoc-core
        - Modify admin-tool.properties to define the database values  
        - Execute 
            - java -jar eSciDocCoreAdmin.jar db-migration 
            or
            - target db-migration of ant file build.xml
          The admin-tool.properties must be placed in the directory from that 
          the admin tool is executed.
		
- Tool to migrate the fedora content of a eSciDoc repository from build 0.9.0159 
  to Release 1.0 		
	
    - Usage:
        - Modify admin-tool.properties to define the values for properties fedora-2.home and fedora-3.home
        - execute target foxml-migration of ant file build.xml
          The admin-tool.properties must be placed in the directory from that 
          the admin tool is executed.
        