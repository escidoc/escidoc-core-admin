        /**
         * AA mm - create preference
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-user-account-create-preference', 'de.escidoc.core.aa.service.UserAccountHandler', 'createPreference', 'info:escidoc/names:aa:1.0:action:create-user-account', true, true);

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-create-preference-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'user-account', 'escidoc:mm-user-account-create-preference');
          
        /**
         * AA mm - delete preference
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-user-account-delete-preference', 'de.escidoc.core.aa.service.UserAccountHandler', 'deletePreference', 'info:escidoc/names:aa:1.0:action:update-user-account', true, true);

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-delete-preference-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'user-account', 'escidoc:mm-user-account-delete-preference');

        /**
         * AA mm - retrieve preference
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-preferences-retrieve', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrievePreferences',
  'info:escidoc/names:aa:1.0:action:retrieve-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-preferences-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-preferences-retrieve');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-preference-retrieve', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrievePreference',
  'info:escidoc/names:aa:1.0:action:retrieve-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-preference-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-preference-retrieve');

         /**
          * AA mm - update preference(s)
          */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-preference-update', 'de.escidoc.core.aa.service.UserAccountHandler', 'updatePreference',
  'info:escidoc/names:aa:1.0:action:update-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-preference-update', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-preference-update');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-preferences-update', 'de.escidoc.core.aa.service.UserAccountHandler', 'updatePreferences',
  'info:escidoc/names:aa:1.0:action:update-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-preferences-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-preferences-update');

        /**
         * AA mm - create attribute
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-user-account-create-attribute', 'de.escidoc.core.aa.service.UserAccountHandler', 'createAttribute', 'info:escidoc/names:aa:1.0:action:create-user-account', true, true);

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-create-attribute-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'user-account', 'escidoc:mm-user-account-create-attribute');
          
        /**
         * AA mm - retrieve attributes
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-attributes-retrieve', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveAttributes',
  'info:escidoc/names:aa:1.0:action:retrieve-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-attributes-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-attributes-retrieve');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-named-attributes-retrieve', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveNamedAttributes',
  'info:escidoc/names:aa:1.0:action:retrieve-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-named-attributes-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-named-attributes-retrieve');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-attribute-retrieve', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveAttribute',
  'info:escidoc/names:aa:1.0:action:retrieve-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-attribute-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-attribute-retrieve');

         /**
          * AA mm - update attribute
          */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-attribute-update', 'de.escidoc.core.aa.service.UserAccountHandler', 'updateAttribute',
  'info:escidoc/names:aa:1.0:action:update-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-attribute-update', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-attribute-update');

        /**
         * AA mm - delete attribute
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-account-attribute-delete', 'de.escidoc.core.aa.service.UserAccountHandler', 'deleteAttribute',
  'info:escidoc/names:aa:1.0:action:update-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-attribute-delete', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-account-attribute-delete');

UPDATE aa.method_mappings SET action_name='info:escidoc/names:aa:1.0:action:revoke-grant' WHERE id='escidoc:mm-user-account-revoke-grants';

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-user-group-create', 'de.escidoc.core.aa.service.UserGroupHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-user-group', true, true);

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'user-group', 'escidoc:mm-user-group-create');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-delete', 'de.escidoc.core.aa.service.UserGroupHandler', 'delete', 
  'info:escidoc/names:aa:1.0:action:delete-user-group', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-delete', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-delete');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-retrieve', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieve', 
  'info:escidoc/names:aa:1.0:action:retrieve-user-group', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-user-group-list-retrieve', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieveUserGroups', 
  'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);
  
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-update', 'de.escidoc.core.aa.service.UserGroupHandler', 'update', 
  'info:escidoc/names:aa:1.0:action:update-user-group', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-update');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-activate', 'de.escidoc.core.aa.service.UserGroupHandler', 'activate', 
  'info:escidoc/names:aa:1.0:action:activate-user-group', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-activate-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-activate');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-deactivate', 'de.escidoc.core.aa.service.UserGroupHandler', 'deactivate', 
  'info:escidoc/names:aa:1.0:action:deactivate-user-group', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-deactivate-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-deactivate');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-retrieve-resources', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieveResources', 
          'info:escidoc/names:aa:1.0:action:retrieve-user-group', true, true,
          'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');
 
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-resources', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-resources');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-retrieve-selectors', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieveSelectors',
          'info:escidoc/names:aa:1.0:action:retrieve-user-group', true, true,
          'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-selectors', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-selectors');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-add-selectors', 'de.escidoc.core.aa.service.UserGroupHandler', 'addSelectors', 
  'info:escidoc/names:aa:1.0:action:add-user-group-selectors', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-add-selectors', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-add-selectors');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-remove-selectors', 'de.escidoc.core.aa.service.UserGroupHandler', 'removeSelectors', 
  'info:escidoc/names:aa:1.0:action:remove-user-group-selectors', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-remove-selectors', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-remove-selectors');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-create-grant', 'de.escidoc.core.aa.service.UserGroupHandler', 'createGrant', 
  'info:escidoc/names:aa:1.0:action:create-user-group-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-create-grant-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'grant', 'escidoc:mm-user-group-create-grant');
          
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-create-grant-2', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-create-grant');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-create-grant-3', 'info:escidoc/names:aa:1.0:resource:user-group:grant:object-new', '/grant/properties/object/@objid', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 12, false, '', 'escidoc:mm-user-group-create-grant');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-retrieve-current-grants', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieveCurrentGrants', 
  'info:escidoc/names:aa:1.0:action:retrieve-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-current-grants-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-current-grants');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-retrieve-current-grants-map', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieveCurrentGrantsAsMap', 
  'info:escidoc/names:aa:1.0:action:retrieve-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-current-grants-map-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-current-grants-map');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-retrieve-grant', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieveGrant', 
  'info:escidoc/names:aa:1.0:action:retrieve-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.GrantNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-grant-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-grant');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-grant-2', 'info:escidoc/names:aa:1.0:resource:grant-id', '', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-grant');

       /**
        * AA mm - retrieve grants
        */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-retrieve-grant-list', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveGrants',
  'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-retrieve-grants', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieveGrants', 
  'info:escidoc/names:aa:1.0:action:retrieve-user-group-grants', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-grants-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-grants');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-revoke-grant', 'de.escidoc.core.aa.service.UserGroupHandler', 'revokeGrant', 
  'info:escidoc/names:aa:1.0:action:revoke-user-group-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.GrantNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-revoke-grant-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-revoke-grant');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-revoke-grant-2', 'info:escidoc/names:aa:1.0:resource:grant-id', '', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-revoke-grant');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-revoke-grants', 'de.escidoc.core.aa.service.UserGroupHandler', 'revokeGrants', 
  'info:escidoc/names:aa:1.0:action:revoke-user-group-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserGroupNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-revoke-grants-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-revoke-grants');
