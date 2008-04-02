/**
 * Role Grant initialization.
 */

        /**
         * The super user gets the role System-Administrator
         */
INSERT INTO "aa"."role_grant" 
    (id, user_id, role_id, creator_id, creation_date)
     VALUES
    ('escidoc:grant4242', 'escidoc:user42', 'escidoc:role-system-administrator', 'escidoc:user42', CURRENT_TIMESTAMP);


        /**
         * The inspector user gets the role System-Inspector
         */
INSERT INTO "aa"."role_grant" 
    (id, user_id, role_id, creator_id, creation_date)
     VALUES
    ('escidoc:grant4444', 'escidoc:user44', 'escidoc:role-system-inspector', 'escidoc:user42', CURRENT_TIMESTAMP);
     
     
        /**
         * Grants of Test Depositor Scientist
         */
INSERT INTO "aa"."role_grant"
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href) 
    values
    ('escidoc:grant4201', 'escidoc:user1', 'escidoc:role-administrator', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');    	    			
    
INSERT INTO "aa"."role_grant"
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href) 
    values
    ('escidoc:grant4202', 'escidoc:user1', 'escidoc:role-depositor', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');   
    
INSERT INTO "aa"."role_grant"
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href) 
    values
    ('escidoc:grant4203', 'escidoc:user1', 'escidoc:role-workflow-manager', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');    
    
// This has been added as temporarily fix for the problem of issue #172
INSERT INTO "aa"."role_grant"
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href) 
    values
    ('escidoc:grant4204', 'escidoc:user1', 'escidoc:role-moderator', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');   


        /**
         * Grants of Test Depositor Library
         */
INSERT INTO "aa"."role_grant"
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href) 
    values
    ('escidoc:grant4205', 'escidoc:user2', 'escidoc:role-administrator', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');   
    
INSERT INTO "aa"."role_grant"
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href) 
    values
    ('escidoc:grant4206', 'escidoc:user2', 'escidoc:role-workflow-manager', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');      
    
INSERT INTO "aa"."role_grant" 
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href)
     VALUES
    ('escidoc:grant4207', 'escidoc:user2', 'escidoc:role-depositor', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');


// This has been added as temporarily fix for the problem of issue #172
INSERT INTO "aa"."role_grant" 
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href)
     VALUES
    ('escidoc:grant4208', 'escidoc:user2', 'escidoc:role-moderator', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');

// This has been added on request, see issue #334
INSERT INTO "aa"."role_grant" 
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href)
     VALUES
    ('escidoc:grant4209', 'escidoc:user2', 'escidoc:role-md-editor', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent3', 'PubMan Test Collection', '/ir/context/escidoc:persistent3');




        /**
         * Grants of Lexus user
         */
INSERT INTO "aa"."role_grant" 
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href)
     VALUES
    ('escidoc:grant501', 'escidoc:user5', 'escidoc:role-depositor', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent15', 'context escidoc:persistent15', '/ir/context/escidoc:persistent15');

INSERT INTO "aa"."role_grant" 
    (id, user_id, role_id, creator_id, creation_date, object_id, object_title, object_href)
     VALUES
    ('escidoc:grant502', 'escidoc:user5', 'escidoc:role-moderator', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:persistent15', 'context escidoc:persistent15', '/ir/context/escidoc:persistent15');
 

   