INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-oum-retrieve-resource', 'de.escidoc.core.oum.service.OrganizationalUnitHandler', 'retrieveResource',
  'info:escidoc/names:aa:1.0:action:retrieve-organizational-unit', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.OrganizationalUnitNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-oum-retrieve-resource', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-oum-retrieve-resource');

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-oum-retrieve-organizational-unit-refs';
