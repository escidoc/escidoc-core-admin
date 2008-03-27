    /*
     * WM method mappings
     */
        /**
         * WorkflowTypeHandler mm - create
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-type-create', 'de.escidoc.core.wm.service.WorkflowTypeHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-workflow-type', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-workflow-type-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'workflow-type', 'escidoc:mm-workflow-type-create');

        /**
         * WorkflowTypeHandler mm - delete
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-type-delete', 'de.escidoc.core.wm.service.WorkflowTypeHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-workflow-type', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-type-delete-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-type-delete');

        /**
         * WorkflowTypeHandler mm - retrieve
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-type-retrieve', 'de.escidoc.core.wm.service.WorkflowTypeHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-workflow-type', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-type-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-type-retrieve');

        /**
         * WorkflowTypeHandler mm - retrieveWorkflowTypes
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-type-retrieve-list', 'de.escidoc.core.wm.service.WorkflowTypeHandler', 'retrieveWorkflowTypes', 'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

        /**
         * WorkflowTypeHandler mm - update
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-type-update', 'de.escidoc.core.wm.service.WorkflowTypeHandler', 'update', 'info:escidoc/names:aa:1.0:action:update-workflow-type', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-type-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-type-update');


        /**
         * WorkflowTemplateHandler mm - create
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-template-create', 'de.escidoc.core.wm.service.WorkflowTemplateHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-workflow-template', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-workflow-template-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'workflow-template', 'escidoc:mm-workflow-template-create');

        /**
         * WorkflowTemplateHandler mm - delete
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-template-delete', 'de.escidoc.core.wm.service.WorkflowTemplateHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-workflow-template', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-template-delete-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-template-delete');

        /**
         * WorkflowTemplateHandler mm - retrieve
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-template-retrieve', 'de.escidoc.core.wm.service.WorkflowTemplateHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-workflow-template', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-template-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-template-retrieve');

        /**
         * WorkflowTemplateHandler mm - retrieveWorkflowTemplates
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-template-retrieve-list', 'de.escidoc.core.wm.service.WorkflowTemplateHandler', 'retrieveWorkflowTemplates', 'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

        /**
         * WorkflowTemplateHandler mm - update
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-template-update', 'de.escidoc.core.wm.service.WorkflowTemplateHandler', 'update', 'info:escidoc/names:aa:1.0:action:update-workflow-template', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-template-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-template-update');

        /**
         * WorkflowDefinitionHandler mm - create
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-definition-create', 'de.escidoc.core.wm.service.WorkflowDefinitionHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-workflow-definition', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-workflow-definition-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'workflow-definition', 'escidoc:mm-workflow-definition-create');

        /**
         * WorkflowDefinitionHandler mm - delete
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-definition-delete', 'de.escidoc.core.wm.service.WorkflowDefinitionHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-workflow-definition', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-definition-delete-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-definition-delete');

        /**
         * WorkflowDefinitionHandler mm - retrieve
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-definition-retrieve', 'de.escidoc.core.wm.service.WorkflowDefinitionHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-workflow-definition', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-definition-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-definition-retrieve');

        /**
         * WorkflowDefinitionHandler mm - retrieveWorkflowDefinitions
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-definition-retrieve-list', 'de.escidoc.core.wm.service.WorkflowDefinitionHandler', 'retrieveWorkflowDefinitions', 'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

        /**
         * WorkflowDefinitionHandler mm - update
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-definition-update', 'de.escidoc.core.wm.service.WorkflowDefinitionHandler', 'update', 'info:escidoc/names:aa:1.0:action:update-workflow-definition', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-definition-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-definition-update');

        /**
         * WorkflowInstanceHandler mm - create
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-instance-create', 'de.escidoc.core.wm.service.WorkflowInstanceHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-workflow-instance', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-workflow-instance-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'workflow-instance', 'escidoc:mm-workflow-instance-create');

        /**
         * WorkflowInstanceHandler mm - delete
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-instance-delete', 'de.escidoc.core.wm.service.WorkflowInstanceHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-workflow-instance', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-instance-delete-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-instance-delete');

        /**
         * WorkflowInstanceHandler mm - retrieve
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-instance-retrieve', 'de.escidoc.core.wm.service.WorkflowInstanceHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-workflow-instance', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-instance-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-instance-retrieve');

        /**
         * WorkflowInstanceHandler mm - retrieveWorkflowInstances
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-instance-retrieve-list', 'de.escidoc.core.wm.service.WorkflowInstanceHandler', 'retrieveWorkflowInstances', 'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

        /**
         * WorkflowInstanceHandler mm - update
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource)
  VALUES ('escidoc:mm-workflow-instance-update', 'de.escidoc.core.wm.service.WorkflowInstanceHandler', 'update', 'info:escidoc/names:aa:1.0:action:update-workflow-instance', true, true);

INSERT INTO "aa"."invocation_mappings" (id, attribute_id, path, "position", attribute_type, mapping_type, multi_value, "value", method_mapping)
  VALUES ('escidoc-im-workflow-instance-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-workflow-instance-update');

         