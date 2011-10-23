/**
  * Item mm - retrieve metadata record CONTENT
  */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-item-retrieve-metadata-record-content', 'de.escidoc.core.om.service.ItemHandler', 'retrieveMdRecordContent', 
          'info:escidoc/names:aa:1.0:action:retrieve-item', 
           true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-retrieve-metadata-record-content', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-retrieve-metadata-record-content');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-retrieve-metadata-record-content-2', 'info:escidoc/names:aa:1.0:resource:metadata-record-id', '', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-retrieve-metadata-record-content');

/**
  * Item mm - retrieve dc record CONTENT
  */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-item-retrieve-dc-record-content', 'de.escidoc.core.om.service.ItemHandler', 'retrieveDcRecordContent', 
          'info:escidoc/names:aa:1.0:action:retrieve-item', 
           true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-retrieve-dc-record-content', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-retrieve-dc-record-content');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-retrieve-dc-record-content-2', 'info:escidoc/names:aa:1.0:resource:dc', '', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-retrieve-dc-record-content');

/**
  * Item - update metadata record content
  */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-item-md-record-content-update', 'de.escidoc.core.om.service.ItemHandler', 'updateMdRecordContent', 'info:escidoc/names:aa:1.0:action:update-item', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-md-record-content-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-md-record-content-update');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-item-retrieve-content-2';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-retrieve-content-2', 'info:escidoc/names:aa:1.0:resource:component:item', '', 0,
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-retrieve-content');
