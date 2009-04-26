/**
 * Create groups where the test-user always belongs to.
 *
 */

/**
 * Used persistent objects:
 * orgUnit: /oum/organizational-unit/escidoc:persistent13
 */
/**
 * Group + GroupMember initialization
 */
    /**
     * Group that contains a user as member.
     */   
INSERT INTO aa.user_group
	(id, label, active, name, description, type, email, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:testgroupwithuser',
	'escidoc:testgroupwithuser',
	true,
    'Test Group with User',
    'Test Group that contains a user as member',
    'USER',
    'test.systemadministrator@user',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_group_member
    (id, user_group_id, name, type, value)
     VALUES
    ('escidoc:testgroupwithusermember', 'escidoc:testgroupwithuser', 'user-account', 'internal', 'escidoc:test');


    /**
     * Group that contains a orgUnit as member.
     */   
INSERT INTO aa.user_group
    (id, label, active, name, description, type, email, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testgroupwithorgunit',
    'escidoc:testgroupwithorgunit',
    true,
    'Test Group with OrgUnit',
    'Test Group that contains an org unit as member',
    'OU',
    'test.systemadministrator@user',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_group_member
    (id, user_group_id, name, type, value)
     VALUES
    ('escidoc:testgroupwithorgunitmember', 'escidoc:testgroupwithorgunit', 'organizational-unit', 'internal', 'escidoc:persistent13');


    /**
     * Group that contains a group as member.
     */   
INSERT INTO aa.user_group
    (id, label, active, name, description, type, email, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:testgroupwithgroup',
    'escidoc:testgroupwithgroup',
    true,
    'Test Group with Group',
    'Test Group that contains a Group as member',
    'GROUP',
    'test.systemadministrator@user',
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP,
    'escidoc:testsystemadministrator',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_group_member
    (id, user_group_id, name, type, value)
     VALUES
    ('escidoc:testgroupwithgroupmember', 'escidoc:testgroupwithgroup', 'user-group', 'internal', 'escidoc:testgroupwithorgunit');


