/**
 * System-Administrator: 
 *      -No scope-defs, role valid for all object-types
 *      -May do everything
 * System-Inspector: 
 *      -No Scope-Defs, role valid for all object-types
 *      -May do all retrieve-operations
 * Administrator: 
 *      -Scope-Defs on item, container, context with attribute context
 *      -Scope-defs on grant with attribute object-ref + context
 *      -retrieve, update, open, and close the context,
 *      -create, retrieve and revoke grants for objects,
 *      -retrieve, revise, and withdraw containers and items
 *      -retrieve user-accounts.
 * Author: 
 *      -Scope-Defs on container, item with attribute collection
 *      -Scope-Def on staging-file with no attributes
 *      -May create and retrieve container and items
 *      -May update,delete... items and containers in status pending or in-revision
 *      -May retrieve content
 * Collaborator: 
 *      -Scope-Def on item with attributes context, container, item, component
 *      -Scope-Def on component with attribute component
 *      -May retrieve items and content
 * Audience: 
 *      -Scope-Def on component with attribute component
 *      -May retrieve content with visibility='audience'
 * Depositor: 
 *      -Scope-Defs on context, container, item, component with attribute context
 *      -Scope-Def on staging-file with no attributes
 *      -May create containers and items
 *      -May update, delete items + containers in status pending or in-revision he created
 *      -May submit items + containers
 *      -May retrieve the items, containers he created
 * Ingester: 
 *      -No Scope-Defs, role valid for all object-types
 *      -May ingest
 * MD-Editor: 
 *      -Scope-Defs on context, container, item, component with attribute context
 *      -May retrieve, update and lock containers + items in state submitted + released
 *      -May submit an item he modified
 * Moderator: 
 *      -Scope-Defs on context, container, item, component with attribute context
 *      -May retrieve + release containers + items
 * Privileged-Viewer: 
 *      -Scope-Def on component with attribute context
 *      -May retrieve content
 * Statistics-Editor: 
 *      -Scope-Defs on scope, aggregation-definition, report-definition, statistic-data with attribute scope
 *      -May create, retrieve, update + delete scopes, aggregation-definitions, report-definitions + statistic-data
 * Statistics-Reader: 
 *      -Scope-def on report with attribute scope
 *      -May retrieve Reports
 * Workflow-Manager: 
 *      -Scope-Def on context with attribute context
 */

/**
 * Used persistent objects:
 * context: /ir/context/escidoc:persistent3
 * orgUnit: /oum/organizational-unit/escidoc:persistent31
 */
/**
 * User initialization
 */
    /**
     * System Administrator user (Super user).
     */   
INSERT INTO aa.user_account
	(id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:testsystemadministrator',
	true,
    'Test System Administrator User',
    'test.systemadministrator@user',
    'testsystemadministrator',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testsystemadministrator', 'escidoc:testsystemadministrator', 'testsystemadministrator', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, creator_id, creation_date)
     VALUES
    ('escidoc:testsystemadministratorgrant1', 'escidoc:testsystemadministrator', 'escidoc:role-system-administrator', 'escidoc:testsystemadministrator', CURRENT_TIMESTAMP);



    /**
     * Administrator user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testadministrator',
    true,
    'Test Administrator User',
    'test.administrator@user',
    'testadministrator',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testadministrator', 'escidoc:testadministrator', 'testadministrator', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, object_id, object_title, object_href, creator_id, creation_date)
     VALUES
    ('escidoc:testadministratorgrant1', 
    'escidoc:testadministrator', 
    'escidoc:role-administrator', 
    'escidoc:persistent3', 
    'PubMan Test Collection', 
    '/ir/context/escidoc:persistent3',
    'escidoc:testsystemadministrator', 
    CURRENT_TIMESTAMP);



    /**
     * Audience user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testaudience',
    true,
    'Test Audience User',
    'test.audience@user',
    'testaudience',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testaudience', 'escidoc:testaudience', 'testaudience', 1999999999999);



    /**
     * Author user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testauthor',
    true,
    'Test Author User',
    'test.author@user',
    'testauthor',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testauthor', 'escidoc:testauthor', 'testauthor', 1999999999999);



    /**
     * Collaborator user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testcollaborator',
    true,
    'Test Collaborator User',
    'test.collaborator@user',
    'testcollaborator',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testcollaborator', 'escidoc:testcollaborator', 'testcollaborator', 1999999999999);



    /**
     * Depositor user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testdepositor',
    true,
    'Test Depositor User',
    'test.depositor@user',
    'testdepositor',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testdepositor', 'escidoc:testdepositor', 'testdepositor', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, object_id, object_title, object_href, creator_id, creation_date)
     VALUES
    ('escidoc:testdepositorgrant1', 
    'escidoc:testdepositor', 
    'escidoc:role-depositor', 
    'escidoc:persistent3', 
    'PubMan Test Collection', 
    '/ir/context/escidoc:persistent3',
    'escidoc:testsystemadministrator', 
    CURRENT_TIMESTAMP);



    /**
     * Depositor user2.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testdepositor2',
    true,
    'Test Depositor User2',
    'test.depositor@user2',
    'testdepositor2',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testdepositor2', 'escidoc:testdepositor2', 'testdepositor2', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, object_id, object_title, object_href, creator_id, creation_date)
     VALUES
    ('escidoc:testdepositorgrant2', 
    'escidoc:testdepositor2', 
    'escidoc:role-depositor', 
    'escidoc:persistent3', 
    'PubMan Test Collection', 
    '/ir/context/escidoc:persistent3',
    'escidoc:testsystemadministrator', 
    CURRENT_TIMESTAMP);



    /**
     * Ingester user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testingester',
    true,
    'Test Ingester User',
    'test.ingester@user',
    'testingester',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testingester', 'escidoc:testingester', 'testingester', 1999999999999);



    /**
     * MD-Editor user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testmdeditor',
    true,
    'Test Md-Editor User',
    'test.mdeditor@user',
    'testmdeditor',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testmdeditor', 'escidoc:testmdeditor', 'testmdeditor', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, object_id, object_title, object_href, creator_id, creation_date)
     VALUES
    ('escidoc:testmdeditorgrant1', 
    'escidoc:testmdeditor', 
    'escidoc:role-md-editor', 
    'escidoc:persistent3', 
    'PubMan Test Collection', 
    '/ir/context/escidoc:persistent3',
    'escidoc:testsystemadministrator', 
    CURRENT_TIMESTAMP);



    /**
     * Moderator user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testmoderator',
    true,
    'Test Moderator User',
    'test.moderator@user',
    'testmoderator',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testmoderator', 'escidoc:testmoderator', 'testmoderator', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, object_id, object_title, object_href, creator_id, creation_date)
     VALUES
    ('escidoc:testmoderatorgrant1', 
    'escidoc:testmoderator', 
    'escidoc:role-moderator', 
    'escidoc:persistent3', 
    'PubMan Test Collection', 
    '/ir/context/escidoc:persistent3',
    'escidoc:testsystemadministrator', 
    CURRENT_TIMESTAMP);



    /**
     * Privileged-Viewer user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testprivilegedviewer',
    true,
    'Test Privileged-Viewer User',
    'test.privilegedviewer@user',
    'testprivilegedviewer',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testprivilegedviewer', 'escidoc:testprivilegedviewer', 'testprivilegedviewer', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, object_id, object_title, object_href, creator_id, creation_date)
     VALUES
    ('escidoc:testprivilegedviewergrant1', 
    'escidoc:testprivilegedviewer', 
    'escidoc:role-privileged-viewer', 
    'escidoc:persistent3', 
    'PubMan Test Collection', 
    '/ir/context/escidoc:persistent3',
    'escidoc:testsystemadministrator', 
    CURRENT_TIMESTAMP);



    /**
     * Statistics-Editor user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:teststatisticseditor',
    true,
    'Test Statistics-Editor User',
    'test.statisticseditor@user',
    'teststatisticseditor',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:teststatisticseditor', 'escidoc:teststatisticseditor', 'teststatisticseditor', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, object_id, object_title, object_href, creator_id, creation_date)
     VALUES
    ('escidoc:teststatisticseditorgrant1', 
    'escidoc:teststatisticseditor', 
    'escidoc:role-statistics-editor', 
    '3', 
    'Scope with id 3', 
    '/statistic/scope/3',
    'escidoc:testsystemadministrator', 
    CURRENT_TIMESTAMP);



    /**
     * Statistics-Reader user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:teststatisticsreader',
    true,
    'Test Statistics-Reader User',
    'test.statisticsreader@user',
    'teststatisticsreader',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:teststatisticsreader', 'escidoc:teststatisticsreader', 'teststatisticsreader', 1999999999999);

INSERT INTO aa.role_grant 
    (id, user_id, role_id, object_id, object_title, object_href, creator_id, creation_date)
     VALUES
    ('escidoc:teststatisticsreadergrant1', 
    'escidoc:teststatisticsreader', 
    'escidoc:role-statistics-reader', 
    '3', 
    'Scope with id 3', 
    '/statistic/scope/3',
    'escidoc:testsystemadministrator', 
    CURRENT_TIMESTAMP);



    /**
     * System-Inspector user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testsysteminspector',
    true,
    'Test System-Inspector User',
    'test.systeminspector@user',
    'testsysteminspector',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testsysteminspector', 'escidoc:testsysteminspector', 'testsysteminspector', 1999999999999);



    /**
     * Workflow-Manager user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testworkflowmanager',
    true,
    'Test Workflow-Manager User',
    'test.workflowmanager@user',
    'testworkflowmanager',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:testworkflowmanager', 'escidoc:testworkflowmanager', 'testworkflowmanager', 1999999999999);



    /**
     * Grant Test user.
     */   
INSERT INTO aa.user_account
    (id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:test',
    true,
    'Test User',
    'test@user',
    'test',
    'escidoc',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_login_data
    (id, user_id, handle, expiryts)
     VALUES
    ('escidoc:test', 'escidoc:test', 'test', 1999999999999);

INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:test', 'escidoc:persistent31');


