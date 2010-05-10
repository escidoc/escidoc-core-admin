UPDATE aa.invocation_mappings SET value='user-account' WHERE id='escidoc-im-user-account-create-grant-1';

UPDATE aa.invocation_mappings
  SET attribute_id='info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on-new', path='extractObjid:/grant/properties/assigned-on/@href|/grant/properties/assigned-on/@objid'
  WHERE id='escidoc-im-user-account-create-grant-3';

UPDATE aa.method_mappings SET action_name='info:escidoc/names:aa:1.0:action:retrieve-objects-filtered' WHERE id='escidoc:mm-user-account-retrieve-current-grants';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-user-account-retrieve-current-grants-map-1';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-user-account-retrieve-current-grants-map';

UPDATE aa.method_mappings SET action_name='info:escidoc/names:aa:1.0:action:retrieve-objects-filtered' WHERE id='escidoc:mm-user-account-revoke-grants';

UPDATE aa.invocation_mappings SET value='user-account' WHERE id='escidoc-im-user-group-create-grant-1';

UPDATE aa.invocation_mappings
  SET attribute_id='info:escidoc/names:aa:1.0:resource:user-group:grant:assigned-on-new', path='extractObjid:/grant/properties/assigned-on/@href|/grant/properties/assigned-on/@objid'
  WHERE id='escidoc-im-user-group-create-grant-3';

UPDATE aa.method_mappings SET action_name='info:escidoc/names:aa:1.0:action:retrieve-objects-filtered' WHERE id='escidoc:mm-user-group-retrieve-current-grants';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-user-group-retrieve-current-grants-map-1';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-user-group-retrieve-current-grants-map';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-user-group-retrieve-grant-1';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-user-group-retrieve-grant-2';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-user-group-retrieve-grants-1';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-user-group-retrieve-grant';

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-user-group-retrieve-user-group-grant', 'de.escidoc.core.aa.service.UserGroupHandler', 'retrieveGrant',
  'info:escidoc/names:aa:1.0:action:retrieve-user-group-grant', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.GrantNotFoundException');

DELETE FROM aa.method_mappings WHERE id='escidoc-im-user-group-retrieve-grant-1';

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-user-group-grant-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-user-group-grant');

DELETE FROM aa.method_mappings WHERE id='escidoc-im-user-group-retrieve-grant-2';

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-retrieve-user-group-grant-2', 'info:escidoc/names:aa:1.0:resource:grant-id', '', 1,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-user-group-retrieve-user-group-grant');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-aa-init-handle-expiry-timestamp', 'de.escidoc.core.aa.service.UserManagementWrapper', 'initHandleExpiryTimestamp', 
  'info:escidoc/names:aa:1.0:action:initHandleExpiryTimestamp', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-user-group-retrieve-grants-1';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-user-group-retrieve-grants';

UPDATE aa.method_mappings SET action_name='info:escidoc/names:aa:1.0:action:retrieve-objects-filtered' WHERE id='escidoc:mm-user-group-revoke-grants';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-roles-retrieve';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-roles-retrieve-1';

