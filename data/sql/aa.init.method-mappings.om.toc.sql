   /**
    * toc method mappings
    */
    
        /**
         * Toc mm - create
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-toc-create', 'de.escidoc.core.om.service.TocHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-toc', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'toc', 'escidoc:mm-toc-create');
INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-create-2', 'info:escidoc/names:aa:1.0:resource:toc:context-new', 'extractObjid:/toc/properties/context/@href|/toc/properties/context/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-toc-create');


        /**
         * Toc mm - delete
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-toc-2', 'de.escidoc.core.om.service.TocHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-toc', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-2-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-toc-2');


        /**
         * Toc mm - retrieve
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-toc-retrieve', 'de.escidoc.core.om.service.TocHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-toc', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-retrieve', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-toc-retrieve');


        /**
         * Toc mm - update
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-toc-update', 'de.escidoc.core.om.service.TocHandler', 'update', 'info:escidoc/names:aa:1.0:action:update-toc', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-toc-update');



        /**
         * Toc mm - submit
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-toc-submit', 'de.escidoc.core.om.service.TocHandler', 'submit', 'info:escidoc/names:aa:1.0:action:submit-toc',
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-submit-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-toc-submit');


        /**
         * Toc mm - release
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-toc-release', 'de.escidoc.core.om.service.TocHandler', 'release', 'info:escidoc/names:aa:1.0:action:release-toc', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-release-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-toc-release');

        /**
         * Toc mm - revise
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-toc-revise', 'de.escidoc.core.om.service.TocHandler', 'revise', 'info:escidoc/names:aa:1.0:action:revise-toc', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-revise-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-toc-revise');


        /**
         * Toc mm - withdraw
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-toc-withdraw', 'de.escidoc.core.om.service.TocHandler', 'withdraw', 'info:escidoc/names:aa:1.0:action:withdraw-toc', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.TocNotFoundException');

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-toc-withdraw-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-toc-withdraw');

