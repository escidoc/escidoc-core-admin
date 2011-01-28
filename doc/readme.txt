eSciDoc Infrastructure Administration Tool
===========================================

The Administration Tool supports reindex for search, migration 
of the eSciDocCore database and migration of the Fedora repository. 
 
Reindex might by necessary without updating eSciDoc. E.g. the used hardware
or OS infrastructure has changed. Therefore these tasks are separated into
independent sub tasks.

Index
	1.) Migration of the eSciDocCore database
	2.) Migration of Fedora Repository
	3.) Re-Index for filters and search


1.) Migration of the eSciDocCore database
-----------------------------------------

Migration to 1.3

There were several changes to the eSciDocCore database between earlier releases and
1.3. To start the migration process the following tasks are necessary:

	1.) Stop eSciDoc (at least eSciDocCore)
	2.) Install new Software (see installation document)
            - install new eSciDocCore
	3.) Migration of eSciDocCore database
            - call target "db-migration" of ant file build.xml
	    The admin-tool.properties must be placed in the directory from that 
	    the admin tool is executed.
	4.) Restart eSciDoc

A migration of a running eSciDoc is currently not supported. Furthermore
migration is only supported between stable releases. The migration between
developer builds may work but will never be supported. If you migrate non supported
versions you do it at your own risk and without any support.

Warning:

The migration tool cannot migrate the XACML policies. If they did change then they
will be overwritten with the new content. Please be sure to do a backup of your policies
if you had modified them in the meantime.


2.) Migration of Fedora Repository 
----------------------------------

There is no migration necessary when upgrading from eSciDocCore 1.2.x to 1.3.


3.) Regenerate index for filters and search
-------------------------------------------

	Prerequisites for reindexing:
	- Database has been migrated (if necessary)
	- Fedora has been migrated (if necessary)
	- eSciDocCore Services including fedora repository are started

	Use this when 
	- structure/schema of eSciDoc resources has changed
	- structure of index-database has changed (new index etc.)
    
	Workflow:
	- get all resource hrefs from Fedora
	- delete index-databases
	- put hrefs in SB-indexing queue -> reindex resource
        
	Usage:
        - modify admin-tool.properties:
		- escidocUrl, persistentHandle : admin access to eSciDocCore
		- fedora.user, fedora.password, fedora.url : admin access to Fedora
		- clearIndex: set to false if the index should not be emptied before adding
		  objects to it
		- indexNamePrefix: set to "escidoc", "escidocou", "escidocoaipmh" if you want
		  to rebuild only one specific index, "all" otherwise
        - execute 
            - call target "reindex" of ant file build.xml
            The admin-tool.properties must be placed in the directory from that 
            the admin tool is executed.
