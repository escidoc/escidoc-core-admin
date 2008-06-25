   /**
    * Ingest method mappings
    * FIXME Exceptions
    */
    
        /**
         * Ingest mm - setConfiguration
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-set-configuration', 'de.escidoc.core.om.service.IngestHandler', 'setConfiguration', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-set-configuration-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-set-configuration');

        /**
         * Ingest mm - getConfiguration
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-get-configuration', 'de.escidoc.core.om.service.IngestHandler', 'getConfiguration', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-get-configuration-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-get-configuration');

        /**
         * Ingest mm - lockedList
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-locked-list', 'de.escidoc.core.om.service.IngestHandler', 'lockedList', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-locked-list-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-locked-list');

        /**
         * Ingest mm - commit
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-commit', 'de.escidoc.core.om.service.IngestHandler', 'commit', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-commit-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-commit');

        /**
         * Ingest mm - rollback
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-rollback', 'de.escidoc.core.om.service.IngestHandler', 'rollback', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-rollback-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-rollback');

        /**
         * Ingest mm - getNextObjids
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-get-next-objids', 'de.escidoc.core.om.service.IngestHandler', 'getNextObjids', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-get-next-objids-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-get-next-objids');

        /**
         * Ingest mm - ingest Item
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-item', 'de.escidoc.core.om.service.IngestHandler', 'ingestItem', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-item-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-item');

        /**
         * Ingest mm - ingest Container
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-container', 'de.escidoc.core.om.service.IngestHandler', 'ingestContainer', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-container-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-container');

        /**
         * Ingest mm - ingest Context
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-context', 'de.escidoc.core.om.service.IngestHandler', 'ingestContext', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-context-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-context');

        /**
         * Ingest mm - ingest OU (Orgnaizational-Unit)
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-ingest-organizational-unit', 'de.escidoc.core.om.service.IngestOU', 'ingestOU', 'info:escidoc/names:aa:1.0:action:ingest', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
         
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-ingest-organizational-unit-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-ingest-organizational-unit');
          