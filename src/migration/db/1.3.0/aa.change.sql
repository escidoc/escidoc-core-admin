INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id, attribute_object_type)
     VALUES
    ('escidoc:scope-def-role-audience1', 'escidoc:role-audience', 'component', 
     'info:escidoc/names:aa:1.0:resource:component:item:context',
     'component');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:mm-aa-retrieve-permission-filter-query', 'info:escidoc/names:aa:1.0:action:retrieve-permission-filter-query');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-fedora-deviation-replace-in-cache', 'info:escidoc/names:aa:1.0:action:fedora-deviation-replace-in-cache');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-aa-retrieve-permission-filter-query', 'de.escidoc.core.aa.service.interfaces.UserAccountHandlerInterface', 'retrievePermissionFilterQuery',
  'info:escidoc/names:aa:1.0:action:retrieve-permission-filter-query', false, true);

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-adm-get-recache-status';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-adm-get-recache-status';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-adm-get-recache-status';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-adm-get-recache-status';

DELETE FROM aa.method_mappings WHERE id='escidoc:mm-adm-recache';

DELETE FROM aa.invocation_mappings WHERE id='escidoc-im-adm-recache';

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-create-3', 'info:escidoc/names:aa:1.0:resource:container:content-model-new', 'extractObjid:/container/properties/content-model/@href|/container/properties/content-model/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-container-create');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-container-retrieve-parents', 'de.escidoc.core.om.service.interfaces.ContainerHandlerInterface', 'retrieveParents', 
  'info:escidoc/names:aa:1.0:action:retrieve-container', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-retrieve-parents', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-container-retrieve-parents');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-create-3', 'info:escidoc/names:aa:1.0:resource:item:content-model-new', 'extractObjid:/item/properties/content-model/@href|/item/properties/content-model/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-item-create');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-item-retrieve-parents', 'de.escidoc.core.om.service.interfaces.ItemHandlerInterface', 'retrieveParents', 
  'info:escidoc/names:aa:1.0:action:retrieve-item', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-retrieve-parents', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-retrieve-parents');

DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-moderator-7';
    
DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-moderator-8';

