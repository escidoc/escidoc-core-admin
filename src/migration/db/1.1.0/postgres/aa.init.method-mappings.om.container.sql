   /**
         * Container mm - retrieve metadata record CONTENT
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-container-retrieve-metadata-record-content', 'de.escidoc.core.om.service.ContainerHandler', 'retrieveMdRecordContent', 
  'info:escidoc/names:aa:1.0:action:retrieve-container', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-retrieve-metadata-record-content', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-container-retrieve-metadata-record-content');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-retrieve-metadata-record-content-2', 'info:escidoc/names:aa:1.0:resource:metadata-record-id', '', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-container-retrieve-metadata-record-content');



     /**
         * Container mm - retrieve dc record CONTENT
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-container-retrieve-dc-record-content', 'de.escidoc.core.om.service.ContainerHandler', 'retrieveDcRecordContent', 
  'info:escidoc/names:aa:1.0:action:retrieve-container', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-retrieve-dc-record-content', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-container-retrieve-dc-record-content');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-retrieve-dc-record-content-2', 'info:escidoc/names:aa:1.0:resource:dc', '', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-container-retrieve-dc-record-content');
