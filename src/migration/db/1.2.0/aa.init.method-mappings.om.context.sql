INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-context-retrieve-resource', 'de.escidoc.core.om.service.ContextHandler', 'retrieveResource',
  'info:escidoc/names:aa:1.0:action:retrieve-context', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ContextNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-context-retrieve-resource', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-context-retrieve-resource');

UPDATE aa.method_mappings SET action_name='info:escidoc/names:aa:1.0:action:retrieve-objects-filtered' WHERE id='escidoc:mm-context-retrieve-members';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-context-retrieve-member-refs-1';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-context-retrieve-member-refs';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-context-retrieve-context-refs';
