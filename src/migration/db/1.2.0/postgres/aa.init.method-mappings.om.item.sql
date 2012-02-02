INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-item-retrieve-resources-resource', 'de.escidoc.core.om.service.ItemHandler', 'retrieveResource', 
  'info:escidoc/names:aa:1.0:action:retrieve-item', true, true, 
  'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-retrieve-resources-resource', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-retrieve-resources-resource');

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-container-retrieve-item-list';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-container-retrieve-item-refs';
