    /**
     * AA method mappings
     */
     
        /**
         * AA mm - findAttribute
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-aa-find-attribute', 'de.escidoc.core.aa.service.PolicyDecisionPoint', 'findAttribute', 'info:escidoc/names:aa:1.0:action:find-attribute', true, true);    


        /**
         * AA mm - evaluate
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-aa-evaluate', 'de.escidoc.core.aa.service.PolicyDecisionPoint', 'evaluate', 'info:escidoc/names:aa:1.0:action:evaluate', true, true);    
     
     
        /**
         * AA mm - retrieveMethodMappings
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-aa-1', 'de.escidoc.core.aa.service.PolicyDecisionPoint', 'retrieveMethodMappings', 'info:escidoc/names:aa:1.0:action:retrieve-method-mappings', true, true);
  

        /**
         * AA mm - checkUserPrivilege
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-aa-2', 'de.escidoc.core.aa.service.PolicyDecisionPoint', 'checkUserPrivilege', 'info:escidoc/names:aa:1.0:action:check-user-privilege', true, true);
  

        /**
         * AA mm - checkUserPrivilegeOnListofObjects
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-aa-3', 'de.escidoc.core.aa.service.PolicyDecisionPoint', 'checkUserPrivilegeOnListofObjects', 'info:escidoc/names:aa:1.0:action:check-user-privilege', 
  true, true);


        /**
         * AA mm - retrieve roles
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-roles-retrieve', 'de.escidoc.core.aa.service.RoleHandler', 'retrieveRoleList', 'info:escidoc/names:aa:1.0:action:retrieve-roles', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-roles-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-roles-retrieve');

        /**
         * AA mm - create role
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-role-create', 'de.escidoc.core.aa.service.RoleHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-role', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-role-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'role', 'escidoc:mm-role-create');


        /**
         * AA mm - delete role
         */

INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-role-delete', 'de.escidoc.core.aa.service.RoleHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-role', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-role-delete-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-role-delete');
 
  
        /**
         * AA mm - retrieve role
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-role-retrieve', 'de.escidoc.core.aa.service.RoleHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-role', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-role-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-role-retrieve');


        /**
         * AA mm - retrieve resources role
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-role-retrieve-resources', 'de.escidoc.core.aa.service.RoleHandler', 'retrieveResources', 'info:escidoc/names:aa:1.0:action:retrieve-role', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-role-retrieve-resources-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-role-retrieve-resources');

        /**
         * AA mm - retrieve role list
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-role-retrieve-role-list', 'de.escidoc.core.aa.service.RoleHandler', 'retrieveRoleList', 
  'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

        /**
         * AA mm - update role
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-role-update', 'de.escidoc.core.aa.service.RoleHandler', 'update', 'info:escidoc/names:aa:1.0:action:update-role', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.RoleNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-role-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-role-update');


        /**
         * AA mm - create user account
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-user-account-create', 'de.escidoc.core.aa.service.UserAccountHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-user-account', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'user-account', 'escidoc:mm-user-account-create');

        /**
         * AA mm - delete user account
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-delete', 'de.escidoc.core.aa.service.UserAccountHandler', 'delete', 
  'info:escidoc/names:aa:1.0:action:delete-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-delete', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-delete');

        /**
         * AA mm - retrieve user account
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-retrieve', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieve', 
  'info:escidoc/names:aa:1.0:action:retrieve-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-retrieve');

        /**
         * AA mm - retrieve user accounts
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-role-retrieve-user-account-list', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveUserAccountList', 
  'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);
  
        /**
         * AA mm - update user account
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-update', 'de.escidoc.core.aa.service.UserAccountHandler', 'update', 
  'info:escidoc/names:aa:1.0:action:update-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-update');
         
        /**
         * AA mm - activate user account
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-activate', 'de.escidoc.core.aa.service.UserAccountHandler', 'activate', 
  'info:escidoc/names:aa:1.0:action:activate-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-activate-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-activate');

        /**
         * AA mm - deactivate user account
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-deactivate', 'de.escidoc.core.aa.service.UserAccountHandler', 'deactivate', 
  'info:escidoc/names:aa:1.0:action:deactivate-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-deactivate-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-deactivate');


        /**
         * AA mm - retrieve resources of user account
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-retrieve-resources', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveResources', 
  'info:escidoc/names:aa:1.0:action:retrieve-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-retrieve-resources', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-retrieve-resources');


        /**
         * AA mm - create grant
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-create-grant', 'de.escidoc.core.aa.service.UserAccountHandler', 'createGrant', 
  'info:escidoc/names:aa:1.0:action:create-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-create-grant-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'grant', 'escidoc:mm-user-account-create-grant');
          
INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-create-grant-2', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-create-grant');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-create-grant-3', 'info:escidoc/names:aa:1.0:resource:user-account:grant:object-new', '/grant/properties/object/@objid', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 12, false, '', 'escidoc:mm-user-account-create-grant');


        /**
         * AA mm - retrieve current grants
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-retrieve-current-grants', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveCurrentGrants', 
  'info:escidoc/names:aa:1.0:action:retrieve-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-retrieve-current-grants-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-retrieve-current-grants');


        /**
         * AA mm - retrieve current grants as map
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-retrieve-current-grants-map', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveCurrentGrantsAsMap', 
  'info:escidoc/names:aa:1.0:action:retrieve-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-retrieve-current-grants-map-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-retrieve-current-grants-map');


        /**
         * AA mm - retrieve grant
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-retrieve-grant', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveGrant', 
  'info:escidoc/names:aa:1.0:action:retrieve-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.GrantNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-retrieve-grant-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-retrieve-grant');
INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-retrieve-grant-2', 'info:escidoc/names:aa:1.0:resource:grant-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-retrieve-grant');


        /**
         * AA mm - revoke grant
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-revoke-grant', 'de.escidoc.core.aa.service.UserAccountHandler', 'revokeGrant', 
  'info:escidoc/names:aa:1.0:action:revoke-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.GrantNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-revoke-grant-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-revoke-grant');
INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-user-account-revoke-grant-2', 'info:escidoc/names:aa:1.0:resource:grant-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-revoke-grant');

		/**
		 * AA mm - logout
		 */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-aa-logout', 'de.escidoc.core.aa.service.UserManagementWrapper', 'logout', 
  'info:escidoc/names:aa:1.0:action:logout', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

        /**
         * AA mm - create unsecured actions
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-aa-create-unsecured-actions', 'de.escidoc.core.aa.service.ActionHandler', 'createUnsecuredActions', 
  'info:escidoc/names:aa:1.0:action:create-unsecured-actions', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException');

        /**
         * AA mm - delete unsecured actions
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-aa-delete-unsecured-actions', 'de.escidoc.core.aa.service.ActionHandler', 'deleteUnsecuredActions', 
  'info:escidoc/names:aa:1.0:action:delete-unsecured-actions', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException');

        /**
         * AA mm - retrieve unsecured actions
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-aa-retrieve-unsecured-actions', 'de.escidoc.core.aa.service.ActionHandler', 'retrieveUnsecuredActions', 
  'info:escidoc/names:aa:1.0:action:retrieve-unsecured-actions', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException');
 
