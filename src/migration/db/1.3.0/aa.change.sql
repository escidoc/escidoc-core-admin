UPDATE aa.method_mappings
SET class_name = REPLACE(class_name, '.service.', '.service.interfaces.') || 'Interface';

ALTER TABLE aa.invocation_mappings ALTER COLUMN path TYPE VARCHAR(255);

ALTER TABLE aa.scope_def ADD COLUMN attribute_object_type VARCHAR (255);

UPDATE aa.scope_def SET attribute_object_type = 'context' 
    WHERE attribute_id LIKE '%context' 
    OR attribute_id LIKE '%context-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'content-model' 
    WHERE attribute_id LIKE '%content-model' 
    OR attribute_id LIKE '%content-model-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'container' 
    WHERE attribute_id LIKE '%container' 
    OR attribute_id LIKE '%container-id'
    OR attribute_id LIKE '%hierarchical-containers';
    
UPDATE aa.scope_def SET attribute_object_type = 'item' 
    WHERE attribute_id LIKE '%item' 
    OR attribute_id LIKE '%item-id';

UPDATE aa.scope_def SET attribute_object_type = 'component' 
    WHERE attribute_id LIKE '%component' 
    OR attribute_id LIKE '%component-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'content-relation' 
    WHERE attribute_id LIKE '%content-relation' 
    OR attribute_id LIKE '%content-relation-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'organizational-unit' 
    WHERE attribute_id LIKE '%organizational-unit' 
    OR attribute_id LIKE '%organizational-unit-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'scope' 
    WHERE attribute_id LIKE '%scope' 
    OR attribute_id LIKE '%scope-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'user-account' 
    WHERE attribute_id LIKE '%user-account' 
    OR attribute_id LIKE '%user-account-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'user-group' 
    WHERE attribute_id LIKE '%user-group' 
    OR attribute_id LIKE '%user-group-id';
    
UPDATE aa.scope_def SET attribute_object_type = object_type 
    WHERE attribute_id LIKE '%resource-id';
    
DELETE FROM aa.actions WHERE id = 'escidoc:mm-aa-retrieve-permission-filter-query';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:mm-aa-retrieve-permission-filter-query', 'info:escidoc/names:aa:1.0:action:retrieve-permission-filter-query');

DELETE FROM aa.actions WHERE id = 'escidoc:action-get-index-configuration';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-get-index-configuration', 'info:escidoc/names:aa:1.0:action:get-index-configuration');

DELETE FROM aa.actions WHERE id = 'escidoc:action-fedora-deviation-get-datastream-dissimination';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-fedora-deviation-get-datastream-dissimination', 'info:escidoc/names:aa:1.0:action:fedora-deviation-get-datastream-dissimination');

DELETE FROM aa.actions WHERE id = 'escidoc:action-fedora-deviation-export';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-fedora-deviation-export', 'info:escidoc/names:aa:1.0:action:fedora-deviation-export');

DELETE FROM aa.actions WHERE id = 'escidoc:action-fedora-deviation-get-fedora-description';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-fedora-deviation-get-fedora-description', 'info:escidoc/names:aa:1.0:action:fedora-deviation-get-fedora-description');

DELETE FROM aa.actions WHERE id = 'escidoc:action-fedora-deviation-cache';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-fedora-deviation-cache', 'info:escidoc/names:aa:1.0:action:fedora-deviation-cache');

DELETE FROM aa.actions WHERE id = 'escidoc:action-fedora-deviation-remove-from-cache';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-fedora-deviation-remove-from-cache', 'info:escidoc/names:aa:1.0:action:fedora-deviation-remove-from-cache');

DELETE FROM aa.actions WHERE id = 'escidoc:action-fedora-deviation-replace-in-cache';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-fedora-deviation-replace-in-cache', 'info:escidoc/names:aa:1.0:action:fedora-deviation-replace-in-cache');

DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-get-datastream-dissimination';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-get-datastream-dissimination-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-get-datastream-dissimination-2';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-get-datastream-dissimination', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'getDatastreamDissemination', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-get-datastream-dissimination', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-get-datastream-dissimination-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-get-datastream-dissimination');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-get-datastream-dissimination-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-get-datastream-dissimination');
  
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-get-fedora-description';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-get-fedora-description-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-get-fedora-description-2';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-get-fedora-description', 'de.escidoc.core.om.service.interfaces.FedoraDescribeDeviationHandlerInterface', 'getFedoraDescription', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-get-fedora-description', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-get-fedora-description-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-get-fedora-description');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-get-fedora-description-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-get-fedora-description');
  
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-export';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-export-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-export-2';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-export', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'export', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-export', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-export-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-export');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-export-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-export');
  
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-cache';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-cache-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-cache-2';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-cache', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'cache', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-cache', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-cache-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-cache');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-cache-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-cache');
  
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-remove-from-cache';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-remove-from-cache-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-remove-from-cache-2';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-remove-from-cache', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'removeFromCache', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-remove-from-cache', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-remove-from-cache-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-remove-from-cache');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-remove-from-cache-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-remove-from-cache');
  
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-replace-in-cache';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-replace-in-cache-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-replace-in-cache-2';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-replace-in-cache', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'replaceInCache', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-replace-in-cache', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-replace-in-cache-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-replace-in-cache');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-replace-in-cache-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-replace-in-cache');
  
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-user-account-create-grant-4';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-account-create-grant-4', 'info:escidoc/names:aa:1.0:resource:user-account:grant:role-new', 
  'extractObjid:/grant/properties/role/@href|/grant/properties/role/@objid', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 12, false, '', 'escidoc:mm-user-account-create-grant');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-user-group-create-grant-4';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-user-group-create-grant-4', 'info:escidoc/names:aa:1.0:resource:user-group:grant:role-new', 
  'extractObjid:/grant/properties/role/@href|/grant/properties/role/@objid', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 12, false, '', 'escidoc:mm-user-group-create-grant');

DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-aa-retrieve-permission-filter-query';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-aa-retrieve-permission-filter-query', 'de.escidoc.core.aa.service.interfaces.UserAccountHandlerInterface', 'retrievePermissionFilterQuery',
  'info:escidoc/names:aa:1.0:action:retrieve-permission-filter-query', false, true);

DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-adm-get-index-configuration';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-adm-get-index-configuration', 'de.escidoc.core.adm.service.interfaces.AdminHandlerInterface', 'getIndexConfiguration', 'info:escidoc/names:aa:1.0:action:get-index-configuration',
  true, true);                                  

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-adm-get-index-configuration';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-adm-get-index-configuration', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'none', 'escidoc:mm-adm-get-index-configuration');

DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-content-model-retrieve-content-models';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-content-model-retrieve-content-models', 'de.escidoc.core.cmm.service.interfaces.ContentModelHandlerInterface', 'retrieveContentModels',
          'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-container-retrieve-parents';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-container-retrieve-parents', 'de.escidoc.core.om.service.interfaces.ContainerHandlerInterface', 'retrieveParents', 
  'info:escidoc/names:aa:1.0:action:retrieve-container', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-container-retrieve-parents';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-retrieve-parents', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-container-retrieve-parents');

DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-item-retrieve-parents';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-item-retrieve-parents', 'de.escidoc.core.om.service.interfaces.ItemHandlerInterface', 'retrieveParents', 
  'info:escidoc/names:aa:1.0:action:retrieve-item', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-item-retrieve-parents';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-retrieve-parents', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-item-retrieve-parents');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-oum-create-2';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-oum-create-2', 'info:escidoc/names:aa:1.0:resource:organizational-unit:parent-new', 
  'extractObjid:/organizational-unit/parents/parent/@href|/organizational-unit/parents/parent/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 12, true, '', 'escidoc:mm-oum-create');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-oum-update-2';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-oum-update-2', 'info:escidoc/names:aa:1.0:resource:organizational-unit:parent-new', 
  'extractObjid:/organizational-unit/parents/parent/@href|/organizational-unit/parents/parent/@objid', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 12, true, '', 'escidoc:mm-oum-update');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-oum-update-parent-ous-2';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-oum-update-parent-ous-2', 'info:escidoc/names:aa:1.0:resource:organizational-unit:parent-new', 
  'extractObjid:/parents/parent/@href|/parents/parent/@objid', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 12, true, '', 'escidoc:mm-oum-update-parent-ous');

UPDATE aa.invocation_mappings SET path = 'extractObjid:/aggregation-definition/scope/@objid|/aggregation-definition/scope/@href' WHERE id = 'escidoc-im-aggregation-definition-create-2';
UPDATE aa.invocation_mappings SET path = 'extractObjid:/report-definition/scope/@objid|/report-definition/scope/@href' WHERE id = 'escidoc-im-report-definition-create-2';
UPDATE aa.invocation_mappings SET path = 'extractObjid:/report-definition/scope/@objid|/report-definition/scope/@href' WHERE id = 'escidoc-im-report-definition-update-2';
UPDATE aa.invocation_mappings SET path = 'extractObjid:report-parameters/report-definition/@objid|report-parameters/report-definition/@href' WHERE id = 'escidoc-im-report-retrieve-1';
UPDATE aa.invocation_mappings SET path = 'extractObjid:/statistic-record/scope/@objid|/statistic-record/scope/@href' WHERE id = 'escidoc-im-statistic-data-create-2';

DELETE FROM aa.scope_def WHERE id = 'escidoc:scope-def-role-audience1';
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id, attribute_object_type)
     VALUES
    ('escidoc:scope-def-role-audience1', 'escidoc:role-audience', 'component', 
     'info:escidoc/names:aa:1.0:resource:component:item:context',
     'component');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-container-create-3';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-create-3', 'info:escidoc/names:aa:1.0:resource:container:content-model-new', 'extractObjid:/container/properties/content-model/@href|/container/properties/content-model/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-container-create');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-item-create-3';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-item-create-3', 'info:escidoc/names:aa:1.0:resource:item:content-model-new', 'extractObjid:/item/properties/content-model/@href|/item/properties/content-model/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-item-create');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-adm-get-recache-status';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-adm-recache';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-type-create-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-type-create-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-type-delete-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-type-delete-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-type-retrieve-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-type-retrieve-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-type-update-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-type-update-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-template-create-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-template-create-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-template-delete-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-template-delete-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-template-retrieve-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-template-retrieve-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-template-update-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-template-update-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-definition-create-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-definition-create-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-definition-delete-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-definition-delete-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-definition-retrieve-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-definition-retrieve-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-definition-update-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-definition-update-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-instance-create-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-instance-create-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-instance-delete-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-instance-delete-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-instance-retrieve-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-instance-retrieve-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-instance-update-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-workflow-instance-update-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-roles-retrieve-1';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-roles-retrieve';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-adm-get-recache-status';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-adm-recache';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-type-create';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-type-delete';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-type-retrieve';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-type-retrieve-list';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-type-update';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-template-create';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-template-delete';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-template-retrieve';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-template-retrieve-list';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-template-update';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-definition-create';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-definition-delete';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-definition-retrieve';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-definition-retrieve-list';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-definition-update';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-instance-create';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-instance-delete';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-instance-retrieve';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-instance-retrieve-list';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-workflow-instance-update';


DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-moderator-7';
    
DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-moderator-8';

DELETE FROM aa.role_grant WHERE role_id = 'escidoc:role-workflow-manager';

DELETE FROM aa.scope_def WHERE role_id = 'escidoc:role-workflow-manager';

DELETE FROM aa.escidoc_role WHERE id = 'escidoc:role-workflow-manager';

DELETE FROM aa.actions WHERE id='escidoc:action-create-workflow-type';
DELETE FROM aa.actions WHERE id='escidoc:action-delete-workflow-type';
DELETE FROM aa.actions WHERE id='escidoc:action-retrieve-workflow-type';
DELETE FROM aa.actions WHERE id='escidoc:action-update-workflow-type';
DELETE FROM aa.actions WHERE id='escidoc:action-create-workflow-definition';
DELETE FROM aa.actions WHERE id='escidoc:action-delete-workflow-definition';
DELETE FROM aa.actions WHERE id='escidoc:action-retrieve-workflow-definition';
DELETE FROM aa.actions WHERE id='escidoc:action-update-workflow-definition';
DELETE FROM aa.actions WHERE id='escidoc:action-create-workflow-template';
DELETE FROM aa.actions WHERE id='escidoc:action-delete-workflow-template';
DELETE FROM aa.actions WHERE id='escidoc:action-retrieve-workflow-template';
DELETE FROM aa.actions WHERE id='escidoc:action-update-workflow-template';
DELETE FROM aa.actions WHERE id='escidoc:action-create-workflow-instance';
DELETE FROM aa.actions WHERE id='escidoc:action-delete-workflow-instance';
DELETE FROM aa.actions WHERE id='escidoc:action-retrieve-workflow-instance';
DELETE FROM aa.actions WHERE id='escidoc:action-update-workflow-instance';
DELETE FROM aa.actions WHERE id='escidoc:action-get-recache-status';
DELETE FROM aa.actions WHERE id='escidoc:action-recache';


