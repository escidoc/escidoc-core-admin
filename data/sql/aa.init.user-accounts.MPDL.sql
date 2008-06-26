/**
 * User initialization
 */
    /**
     * Super user (roland)
     */   
INSERT INTO aa.user_account
	(id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:user42',
	true,
    'roland',
    'roland@roland',
    'roland',
    'Shibboleth-Handle-1',
    'escidoc:user42',
    CURRENT_TIMESTAMP,
    'escidoc:user42',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:user42','escidoc:persistent1');

    
    /*
     * Inspector (Read only super user)
     */
INSERT INTO aa.user_account
	(id, active, name, email, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:user44',
	true,
    'Inspector (Read Only Super User)',
    'inspector@superuser',
    'inspector',
    'inspector',
    'escidoc:user42',
    CURRENT_TIMESTAMP,
    'escidoc:user42',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:user44','escidoc:persistent1');


    /**
     * Test Depositor Scientist
     */
INSERT INTO aa.user_account
	(id, active, name, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:user1',
	true,
    'Test Depositor Scientist',
    'test_dep_scientist',
    'escidoc',
    'escidoc:user1',
    CURRENT_TIMESTAMP,
    'escidoc:user1',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:user1','escidoc:persistent1');


    /**
     * Test Depositor Library
     */ 
INSERT INTO aa.user_account
	(id, active, name, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:user2',
	true,
    'Test Depositor Library',
    'test_dep_lib',
    'pubman',
    'escidoc:user2',
    CURRENT_TIMESTAMP,
    'escidoc:user2',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:user2','escidoc:persistent1');
    

    /**
     * Test Editor
     */ 
INSERT INTO aa.user_account
	(id, active, name, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:user3',
	true,
    'Test Editor',
    'test_editor',
    'escidoc',
    'escidoc:user3',
    CURRENT_TIMESTAMP,
    'escidoc:user3',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:user3','escidoc:persistent1');


    /**
     * Test Author
     */     
INSERT INTO aa.user_account
	(id, active, name, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:user4',
	true,
    'Test Author',
    'test_author',
    'escidoc',
    'escidoc:user4',
    CURRENT_TIMESTAMP,
    'escidoc:user4',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:user4','escidoc:persistent1');
    

    /**
     * Lexus user
     */  
     //FIXME: check org.unit id and context id 
INSERT INTO aa.user_account
	(id, active, name, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:user5',
	true,
    'Lexus',
    'lexus',
    'lexus',
    'escidoc:user42',
    CURRENT_TIMESTAMP,
    'escidoc:user42',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:user5','escidoc:persistent1');

    /**
     * Test Statistic Editor
     */  
INSERT INTO aa.user_account
	(id, active, name, loginName, password, creator_id, creation_date, modified_by_id, last_modification_date)
	 VALUES
	('escidoc:user6',
	true,
    'TestStatistics Editor',
    'test_statistics_editor',
    'test_statistics_editor',
    'escidoc:user42',
    CURRENT_TIMESTAMP,
    'escidoc:user42',
    CURRENT_TIMESTAMP);
    
INSERT INTO aa.user_account_ous
    (list_index, user_account_id, ou_id)
     VALUES
    (0, 'escidoc:user6','escidoc:persistent1');

    