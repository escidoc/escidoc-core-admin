/**
 * User initialization
 */
    /**
     * System Administrator user (Super user).
     */   
INSERT INTO aa.user_account
	(id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:exuser1',
	true,
    'System Administrator User',
    'system.administrator@superuser',
    'sysadmin',
    'eSciDoc',
    'escidoc:exuser1',
    CURRENT_TIMESTAMP,
    'escidoc:exuser1',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:exuser1','escidoc:ex3');


    /*
     * System Inspector user (Read only super user).
     */
INSERT INTO aa.user_account
	(id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:exuser2',
	true,
    'System Inspector User (Read Only Super User)',
    'system.inspector@superuser',
    'sysinspector',
    'eSciDoc',
    'escidoc:exuser1',
    CURRENT_TIMESTAMP,
    'escidoc:exuser1',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:exuser2','escidoc:ex3');
    
    
    /**
     * Depositor user.
     */
INSERT INTO aa.user_account
	(id, active, name, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:exuser4',
	true,
    'Depositor User',
    'depositor',
    'eSciDoc',
    'escidoc:exuser1',
    CURRENT_TIMESTAMP,
    'escidoc:exuser1',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:exuser4','escidoc:ex3');
    
    /**
     * Ingestor user.
     */
INSERT INTO aa.user_account
	(id, active, name, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:exuser5',
	true,
    'Ingestor User',
    'ingester',
    'eSciDoc',
    'escidoc:exuser1',
    CURRENT_TIMESTAMP,
    'escidoc:exuser1',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:exuser5','escidoc:ex3');
    
    
   	  