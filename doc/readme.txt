eSciDocCore-Admin-Tool

-Tool to regenerate index for search.
	Use this when 
	-structure/schema of items or containers changes
	-Structure of index-database changed (new index etc.)
	
	-Workflow:
		-get all items/container-hrefs from om where status = released
		-delete index-databases
		-put item-hrefs in SB-indexing queue -> reindex items
		-put container-hrefs in SB-indexing queue -> reindex containers
		
	-Usage:
		-modify admin-tool.properties:
			-escidocOmUrl : URL of OM
			-escidocSbUrl: URL of naming-service of SB
		-execute target reindex of build.xml
		