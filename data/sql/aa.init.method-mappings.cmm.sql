   /**
    * Content model method mappings
    */
        /**
         * Content model mm - retrieve
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-content-model-retrieve', 'de.escidoc.core.cmm.service.ContentModelHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-content-model',
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ContentModelNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-mm-content-model-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-content-model-retrieve');
         
        /**
         * Content model mm - create
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-content-model-create', 'de.escidoc.core.cmm.service.ContentModelHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-content-model',
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ContentModelNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-mm-content-model-create-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-content-model-create');
         