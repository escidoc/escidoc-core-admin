    /**
     * Role Audience
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
    (SELECT  'escidoc:role-audience' AS id,
             'Audience' AS role_name,
             '@creator_id@' AS creator_id,
             CURRENT_TIMESTAMP AS creation_date,
             '@creator_id@' AS modified_by_id,
             CURRENT_TIMESTAMP AS last_modification_date WHERE NOT EXISTS (SELECT 1 FROM aa.escidoc_role WHERE id='escidoc:role-audience'));
    
        /** 
         * Role Audience Scope
         */  
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
    (SELECT 'escidoc:scope-def-role-audience' AS id,
            'escidoc:role-audience' AS role_id,
            'component' AS object_type, 
            'info:escidoc/names:aa:1.0:resource:component-id' AS attribute_id WHERE NOT EXISTS (SELECT 1 FROM aa.scope_def WHERE id='escidoc:scope-def-role-audience'));

        /**
         * Role Audience Policies
         */
            /**
             * An Audience is allowed to retrieve content of components of released items 
             * if visibility of component is 'audience'.
             */
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
  (SELECT 'escidoc:audience-policy-1' AS id,
          'escidoc:role-audience' AS role_id,
          '<Policy PolicyId="Audience-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>

    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-content</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Audience-policy-rule-0" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>

      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
        <Action>
          <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-content</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:component:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>

          </Apply>
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">withdrawn</AttributeValue>
        </Apply>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:component:visibility" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">audience</AttributeValue>
      </Apply>

      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:component:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
      </Apply>
    </Condition>
  </Rule>
</Policy>' AS xml WHERE NOT EXISTS (SELECT 1 FROM aa.escidoc_policies WHERE id='escidoc:audience-policy-1'));
DROP INDEX IF EXISTS aa.user_login_data_idx;
CREATE INDEX user_login_data_idx
ON aa.user_login_data (handle);

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-load-examples', 'info:escidoc/names:aa:1.0:action:load-examples');

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

DELETE FROM aa.actions WHERE id = 'escidoc:action-retrieve-current-user-account';
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-retrieve-current-user-account', 'info:escidoc/names:aa:1.0:action:retrieve-current-user-account');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-aa-evaluate-1', 'info:escidoc/names:aa:1.0:resource:subject-id', '/requests/Request/Subject/Attribute/AttributeValue', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, true, '', 'escidoc:mm-aa-evaluate');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-aa-evaluate-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'evaluate', 'escidoc:mm-aa-evaluate');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-get-datastream-dissimination-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-get-datastream-dissimination-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-item-retrieve-dc-record-content-2';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-container-retrieve-dc-record-content-2';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-get-datastream-dissimination';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-get-datastream-dissimination', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'getDatastreamDissemination', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-get-datastream-dissimination', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-get-datastream-dissimination-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-get-datastream-dissimination');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-get-datastream-dissimination-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-get-datastream-dissimination');
  
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-get-fedora-description-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-get-fedora-description-2';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-get-fedora-description';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-get-fedora-description', 'de.escidoc.core.om.service.interfaces.FedoraDescribeDeviationHandlerInterface', 'getFedoraDescription', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-get-fedora-description', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-get-fedora-description-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-get-fedora-description');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-get-fedora-description-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-get-fedora-description');
  
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-export-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-export-2';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-export';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-export', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'export', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-export', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-export-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-export');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-export-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-export');
  
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-cache-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-cache-2';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-cache';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-cache', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'cache', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-cache', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-cache-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-cache');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-cache-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-cache');
  
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-remove-from-cache-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-remove-from-cache-2';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-remove-from-cache';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-remove-from-cache', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'removeFromCache', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-remove-from-cache', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-remove-from-cache-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-remove-from-cache');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-remove-from-cache-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-remove-from-cache');
  
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-replace-in-cache-1';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-fedora-deviation-replace-in-cache-2';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-fedora-deviation-replace-in-cache';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-fedora-deviation-replace-in-cache', 'de.escidoc.core.om.service.interfaces.FedoraRestDeviationHandlerInterface', 'replaceInCache', 
  'info:escidoc/names:aa:1.0:action:fedora-deviation-replace-in-cache', true, true);
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-replace-in-cache-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-replace-in-cache');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-fedora-deviation-replace-in-cache-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'fedora-deviation', 'escidoc:mm-fedora-deviation-replace-in-cache');
  
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-aa-init-handle-expiry-timestamp';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-aa-init-handle-expiry-timestamp', 'de.escidoc.core.aa.service.UserManagementWrapper', 'initHandleExpiryTimestamp', 
  'info:escidoc/names:aa:1.0:action:initHandleExpiryTimestamp', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-adm-load-examples';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-adm-load-examples', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'none', 'escidoc:mm-adm-load-examples');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-current-user-account-retrieve';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-current-user-account-retrieve';

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-current-user-account-retrieve', 'de.escidoc.core.aa.service.UserAccountHandler', 'retrieveCurrentUser', 
  'info:escidoc/names:aa:1.0:action:retrieve-current-user-account', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.UserAccountNotFoundException');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-current-user-account-retrieve', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'user-account', 'escidoc:mm-current-user-account-retrieve');
  
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

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-adm-get-index-configuration';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-adm-get-index-configuration';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-adm-get-index-configuration', 'de.escidoc.core.adm.service.interfaces.AdminHandlerInterface', 'getIndexConfiguration', 'info:escidoc/names:aa:1.0:action:get-index-configuration',
  true, true);                                  
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-adm-get-index-configuration', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'none', 'escidoc:mm-adm-get-index-configuration');

DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-content-model-retrieve-content-models';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-content-model-retrieve-content-models', 'de.escidoc.core.cmm.service.interfaces.ContentModelHandlerInterface', 'retrieveContentModels',
          'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-container-retrieve-parents';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-container-retrieve-parents';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-container-retrieve-parents', 'de.escidoc.core.om.service.interfaces.ContainerHandlerInterface', 'retrieveParents', 
  'info:escidoc/names:aa:1.0:action:retrieve-container', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ContainerNotFoundException');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-container-retrieve-parents', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-container-retrieve-parents');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-item-retrieve-parents';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-item-retrieve-parents';
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-item-retrieve-parents', 'de.escidoc.core.om.service.interfaces.ItemHandlerInterface', 'retrieveParents', 
  'info:escidoc/names:aa:1.0:action:retrieve-item', true, true,
  'de.escidoc.core.common.exceptions.application.notfound.ItemNotFoundException');
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

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc:im-ingest-1';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc:im-ingest-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'ingest', 'escidoc:mm-ingest');

DELETE FROM aa.invocation_mappings WHERE id = 'escidoc:im-ingest-2';
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc:im-ingest-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'ingest', 'escidoc:mm-ingest');

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
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-ingest-item-1';

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


DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-collaborator-3';
    
DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-collaborator-7';
    
DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-collaborator-10';
    
DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-moderator-6';
    
DELETE FROM aa.scope_def WHERE id='escidoc:scope-def-role-moderator-7';
    
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

/** 
 * New Role OuAdministrator:
 * 
*/
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-ou-administrator', 'OU-Administrator', '@creator_id@', CURRENT_TIMESTAMP, '@creator_id@',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role OU-Administrator Scope
         */  
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id, attribute_object_type)
     VALUES
    ('escidoc:scope-def-role-ou-administrator', 'escidoc:role-ou-administrator', 'organizational-unit', 
     'info:escidoc/names:aa:1.0:resource:organizational-unit:hierarchical-parents',
     'organizational-unit');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id, attribute_object_type)
     VALUES
    ('escidoc:scope-def-role-ou-administrator-2', 'escidoc:role-ou-administrator', 'user-account', 
     null,
     null);

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id, attribute_object_type)
     VALUES
    ('escidoc:scope-def-role-ou-administrator-3', 'escidoc:role-ou-administrator', 'user-group', 
     null,
     null);

     
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:policy-ou-administrator', 'escidoc:role-ou-administrator',
'<Policy PolicyId="OU-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>
    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
            info:escidoc/names:aa:1.0:action:create-organizational-unit 
            info:escidoc/names:aa:1.0:action:delete-organizational-unit 
            info:escidoc/names:aa:1.0:action:retrieve-organizational-unit 
            info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit 
            info:escidoc/names:aa:1.0:action:update-organizational-unit 
            info:escidoc/names:aa:1.0:action:close-organizational-unit 
            info:escidoc/names:aa:1.0:action:open-organizational-unit 
            info:escidoc/names:aa:1.0:action:create-grant 
            info:escidoc/names:aa:1.0:action:revoke-grant 
            info:escidoc/names:aa:1.0:action:create-user-group-grant 
            info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="OU-Administrator-policy-rule-1" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
        <Action>
            <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                    info:escidoc/names:aa:1.0:action:create-organizational-unit 
                    info:escidoc/names:aa:1.0:action:delete-organizational-unit 
                    info:escidoc/names:aa:1.0:action:retrieve-organizational-unit 
                    info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit 
                    info:escidoc/names:aa:1.0:action:close-organizational-unit 
                    info:escidoc/names:aa:1.0:action:open-organizational-unit 
                </AttributeValue>
                <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="OU-Administrator-policy-rule-2" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
        <Action>
            <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                    info:escidoc/names:aa:1.0:action:update-organizational-unit 
                </AttributeValue>
                <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>
        </Action>
      </Actions>
    </Target>    
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of">
        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:organizational-unit:hierarchical-parents-new" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-ou-administrator:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
    </Condition>
  </Rule>
  <Rule RuleId="OU-Administrator-policy-rule-3" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
        <Action>
            <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                    info:escidoc/names:aa:1.0:action:create-grant 
                    info:escidoc/names:aa:1.0:action:revoke-grant 
                </AttributeValue>
                <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on:hierarchical-parents" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-ou-administrator:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OU-Administrator</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="OU-Administrator-policy-rule-4" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
        <Action>
            <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                    info:escidoc/names:aa:1.0:action:create-user-group-grant 
                    info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
                </AttributeValue>
                <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:assigned-on:hierarchical-parents" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-ou-administrator:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">OU-Administrator</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Apply>
    </Condition>
  </Rule>
</Policy>');

DELETE FROM aa.escidoc_policies WHERE id = 'escidoc:policy-context-administrator';
INSERT INTO aa.escidoc_policies 
    (id, role_id, xml) 
    VALUES 
    ('escidoc:policy-context-administrator', 'escidoc:role-context-administrator', 
    '<Policy PolicyId="Context-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
    <Target>
        <Subjects>
            <AnySubject/>
        </Subjects>
        <Resources>
            <AnyResource/>
        </Resources>
        <Actions>
            <Action>
                <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:create-context 
                        info:escidoc/names:aa:1.0:action:retrieve-context 
                        info:escidoc/names:aa:1.0:action:update-context 
                        info:escidoc/names:aa:1.0:action:delete-context 
                        info:escidoc/names:aa:1.0:action:close-context 
                        info:escidoc/names:aa:1.0:action:open-context 
                        info:escidoc/names:aa:1.0:action:retrieve-role 
                    </AttributeValue>
                    <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </ActionMatch>
            </Action>
        </Actions>
    </Target>
    <Rule RuleId="Context-Administrator-policy-rule-1" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:create-context 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
    </Rule>
    <Rule RuleId="Context-Administrator-policy-rule-2" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:retrieve-context 
                            info:escidoc/names:aa:1.0:action:update-context 
                            info:escidoc/names:aa:1.0:action:delete-context 
                            info:escidoc/names:aa:1.0:action:open-context 
                            info:escidoc/names:aa:1.0:action:close-context 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:context:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Context-Administrator-policy-rule-3" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:retrieve-role
                  </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">escidoc:role-audience 
escidoc:role-collaborator-modifier-container-add-remove-any-members escidoc:role-collaborator-modifier-container-add-remove-members escidoc:role-collaborator-modifier-container-update-any-members escidoc:role-collaborator-modifier-container-update-direct-members escidoc:role-collaborator-modifier escidoc:role-collaborator escidoc:role-content-relation-manager escidoc:role-content-relation-modifier escidoc:role-cone-closed-vocabulary-editor escidoc:role-cone-open-vocabulary-editor escidoc:role-moderator escidoc:role-privileged-viewer escidoc:role-depositor</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
</Policy>');

DELETE FROM aa.scope_def WHERE id = 'escidoc:scope-def-role-context-modifier';
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id) 
    VALUES 
    ('escidoc:scope-def-role-context-modifier', 'escidoc:role-context-modifier', 'context', 
    'info:escidoc/names:aa:1.0:resource:context-id');
DELETE FROM aa.scope_def WHERE id = 'escidoc:scope-def-role-context-modifier-6';
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id) 
    VALUES 
    ('escidoc:scope-def-role-context-modifier-6', 'escidoc:role-context-modifier', 'role', NULL);
DELETE FROM aa.scope_def WHERE id = 'escidoc:scope-def-role-context-modifier-5';
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id) 
    VALUES 
    ('escidoc:scope-def-role-context-modifier-5', 'escidoc:role-context-modifier', 'user-account', NULL);

DELETE FROM aa.escidoc_policies WHERE id = 'escidoc:policy-context-modifier';        
INSERT INTO aa.escidoc_policies (id, role_id, xml) 
    VALUES 
    ('escidoc:policy-context-modifier', 'escidoc:role-context-modifier', 
    '<Policy PolicyId="Context-Modifier-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
    <Target>
        <Subjects>
            <AnySubject/>
        </Subjects>
        <Resources>
            <AnyResource/>
        </Resources>
        <Actions>
            <Action>
                <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
            info:escidoc/names:aa:1.0:action:retrieve-context 
            info:escidoc/names:aa:1.0:action:update-context 
            info:escidoc/names:aa:1.0:action:delete-context 
            info:escidoc/names:aa:1.0:action:close-context 
            info:escidoc/names:aa:1.0:action:open-context 
            info:escidoc/names:aa:1.0:action:retrieve-role
            info:escidoc/names:aa:1.0:action:create-grant
            info:escidoc/names:aa:1.0:action:create-user-group-grant
          </AttributeValue>
                    <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </ActionMatch>
            </Action>
        </Actions>
    </Target>
    <Rule RuleId="Context-Modifier-policy-rule-1" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:retrieve-context 
                    info:escidoc/names:aa:1.0:action:update-context 
                    info:escidoc/names:aa:1.0:action:delete-context 
                    info:escidoc/names:aa:1.0:action:open-context 
                    info:escidoc/names:aa:1.0:action:close-context 
                  </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
    </Rule>
    <Rule RuleId="Context-Modifier-policy-rule-3" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">                  info:escidoc/names:aa:1.0:action:retrieve-role                  </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">escidoc:role-audience escidoc:role-collaborator-modifier-container-add-remove-any-members escidoc:role-collaborator-modifier-container-add-remove-members escidoc:role-collaborator-modifier-container-update-any-members escidoc:role-collaborator-modifier-container-update-direct-members escidoc:role-collaborator-modifier escidoc:role-collaborator escidoc:role-content-relation-manager escidoc:role-content-relation-modifier escidoc:role-cone-closed-vocabulary-editor escidoc:role-cone-open-vocabulary-editor escidoc:role-moderator escidoc:role-privileged-viewer escidoc:role-depositor escidoc:role-context-modifier</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Context-modifier-policy-rule-grant-create" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">                            info:escidoc/names:aa:1.0:action:create-grant  </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-context-modifier:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>        </Condition>
    </Rule>
    
    <Rule RuleId="Context-modifier-policy-rule-grant-create" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">                            info:escidoc/names:aa:1.0:action:create-user-group-grant  </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-grant:grant:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-context-modifier:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Condition>
    </Rule>
</Policy>');

DELETE FROM aa.escidoc_policies WHERE id = 'escidoc:policy-user-account-administrator';
INSERT INTO aa.escidoc_policies 
    (id, role_id, xml) 
    VALUES 
    ('escidoc:policy-user-account-administrator', 'escidoc:role-user-account-administrator', 
    '<Policy PolicyId="User-Account-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
    <Target>
        <Subjects>
            <AnySubject/>
        </Subjects>
        <Resources>
            <AnyResource/>
        </Resources>
        <Actions>
            <Action>
                <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:create-user-account 
                            info:escidoc/names:aa:1.0:action:retrieve-user-account 
                            info:escidoc/names:aa:1.0:action:update-user-account 
                            info:escidoc/names:aa:1.0:action:activate-user-account 
                            info:escidoc/names:aa:1.0:action:deactivate-user-account 
                            info:escidoc/names:aa:1.0:action:revoke-grant 
                            info:escidoc/names:aa:1.0:action:retrieve-grant  
                    </AttributeValue>
                    <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </ActionMatch>
            </Action>
        </Actions>
    </Target>
    <Rule RuleId="User-Account-Administrator-policy-rule-1" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:create-user-account 
                          </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
    </Rule>
    <Rule RuleId="User-Account-Administrator-policy-rule-2" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:retrieve-user-account 
                            info:escidoc/names:aa:1.0:action:update-user-account 
                            info:escidoc/names:aa:1.0:action:activate-user-account 
                            info:escidoc/names:aa:1.0:action:deactivate-user-account 
                            info:escidoc/names:aa:1.0:action:retrieve-grant  
                    </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of">
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:organizational-unit" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:organizational-unit" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Condition>
    </Rule>
    <Rule RuleId="User-Account-Administrator-policy-rule-3" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:revoke-grant
                          </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:organizational-unit" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:organizational-unit" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                        </Apply>
                        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                            <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                        </Apply>
                    </Apply>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
</Policy>');

DELETE FROM aa.scope_def WHERE id = 'escidoc:scope-def-role-user-account-inspector';
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id) 
    VALUES 
    ('escidoc:scope-def-role-user-account-inspector', 'escidoc:role-user-account-inspector', 'user-account', 
    'urn:oasis:names:tc:xacml:1.0:resource:resource-id');

DELETE FROM aa.escidoc_policies WHERE id = 'escidoc:policy-user-account-inspector';
INSERT INTO aa.escidoc_policies (id, role_id, xml) VALUES ('escidoc:policy-user-account-inspector', 'escidoc:role-user-account-inspector', '<Policy PolicyId="User-Account-Inspector-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
    <Target>
        <Subjects>
            <AnySubject/>
        </Subjects>
        <Resources>
            <AnyResource/>
        </Resources>
        <Actions>
            <Action>
                <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:retrieve-user-account
                   </AttributeValue>
                    <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </ActionMatch>
            </Action>
        </Actions>
    </Target>
  <Rule RuleId="Depositor-policy-rule-1a" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <AnyAction/>
            </Actions>
        </Target>
    </Rule>
</Policy>');

/** 
 * Changes to Role ContextAdministrator:
 * 
*/
UPDATE aa.escidoc_policies
  SET xml='<Policy PolicyId="Context-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>
    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
            info:escidoc/names:aa:1.0:action:create-context 
            info:escidoc/names:aa:1.0:action:retrieve-context 
            info:escidoc/names:aa:1.0:action:update-context 
            info:escidoc/names:aa:1.0:action:delete-context 
            info:escidoc/names:aa:1.0:action:close-context 
            info:escidoc/names:aa:1.0:action:open-context 
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Context-Administrator-policy-rule-1" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:create-context 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Context-Administrator-policy-rule-2" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:retrieve-context 
                    info:escidoc/names:aa:1.0:action:update-context 
                    info:escidoc/names:aa:1.0:action:delete-context 
                    info:escidoc/names:aa:1.0:action:open-context 
                    info:escidoc/names:aa:1.0:action:close-context 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:context:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
    </Condition>
  </Rule>
</Policy>' WHERE id = 'escidoc:policy-context-administrator';

/** 
 * Changes to Role ContextModifier:
 * 
*/
UPDATE aa.escidoc_policies
  SET xml='<Policy PolicyId="Context-Modifier-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>
    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
            info:escidoc/names:aa:1.0:action:retrieve-context 
            info:escidoc/names:aa:1.0:action:update-context 
            info:escidoc/names:aa:1.0:action:delete-context 
            info:escidoc/names:aa:1.0:action:close-context 
            info:escidoc/names:aa:1.0:action:open-context 
            info:escidoc/names:aa:1.0:action:create-grant 
            info:escidoc/names:aa:1.0:action:revoke-grant 
            info:escidoc/names:aa:1.0:action:create-user-group-grant 
            info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Context-Modifier-policy-rule-1" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:retrieve-context 
                    info:escidoc/names:aa:1.0:action:update-context 
                    info:escidoc/names:aa:1.0:action:delete-context 
                    info:escidoc/names:aa:1.0:action:open-context 
                    info:escidoc/names:aa:1.0:action:close-context 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Context-Modifier-policy-rule-2" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:create-grant 
                        info:escidoc/names:aa:1.0:action:revoke-grant 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-context-modifier:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Context-Modifier</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="Context-Modifier-policy-rule-3" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:create-user-group-grant 
                        info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-at-least-one-member-of">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-context-modifier:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">Context-Modifier</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Apply>
    </Condition>
  </Rule>
</Policy>' WHERE id = 'escidoc:policy-context-modifier';

UPDATE aa.escidoc_policies SET xml='<Policy PolicyId="Default-User-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
    <Target>
        <Subjects>
            <AnySubject/>
        </Subjects>
        <Resources>
            <AnyResource/>
        </Resources>
        <Actions>
            <Action>
                <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                    info:escidoc/names:aa:1.0:action:retrieve-container 
                    info:escidoc/names:aa:1.0:action:retrieve-context 
                    info:escidoc/names:aa:1.0:action:retrieve-item 
                    info:escidoc/names:aa:1.0:action:retrieve-content 
                    info:escidoc/names:aa:1.0:action:retrieve-organizational-unit 
                    info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit 
                    info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit 
                    info:escidoc/names:aa:1.0:action:retrieve-content-model 
                    info:escidoc/names:aa:1.0:action:retrieve-content-relation 
                    info:escidoc/names:aa:1.0:action:unlock-container 
                    info:escidoc/names:aa:1.0:action:unlock-item 
                    info:escidoc/names:aa:1.0:action:logout 
                    info:escidoc/names:aa:1.0:action:retrieve-user-account 
                    info:escidoc/names:aa:1.0:action:retrieve-current-user-account 
                    info:escidoc/names:aa:1.0:action:update-user-account 
                    info:escidoc/names:aa:1.0:action:retrieve-objects-filtered 
                    info:escidoc/names:aa:1.0:action:retrieve-staging-file 
                    info:escidoc/names:aa:1.0:action:query-semantic-store 
                    info:escidoc/names:aa:1.0:action:retrieve-report 
                    info:escidoc/names:aa:1.0:action:retrieve-set-definition 
                    info:escidoc/names:aa:1.0:action:get-repository-info 
                    info:escidoc/names:aa:1.0:action:retrieve-grant 
                    info:escidoc/names:aa:1.0:action:create-grant 
                    info:escidoc/names:aa:1.0:action:revoke-grant 
                    info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
                    info:escidoc/names:aa:1.0:action:create-user-group-grant 
                    info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
					info:escidoc/names:aa:1.0:action:retrieve-registered-predicates 
                    info:escidoc/names:aa:1.0:action:fedora-deviation-get-fedora-description 
                    info:escidoc/names:aa:1.0:action:retrieve-role 
                    info:escidoc/names:aa:1.0:action:retrieve-user-group 
                    info:escidoc/names:aa:1.0:action:retrieve-permission-filter-query 
              		info:escidoc/names:aa:1.0:action:evaluate 
                    </AttributeValue>
                    <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </ActionMatch>
            </Action>
        </Actions>
    </Target>
    <Rule RuleId="Default-User-policy-rule-0" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-content-model 
                        info:escidoc/names:aa:1.0:action:logout 
                        info:escidoc/names:aa:1.0:action:retrieve-objects-filtered 
                        info:escidoc/names:aa:1.0:action:retrieve-staging-file 
                        info:escidoc/names:aa:1.0:action:retrieve-report 
                        info:escidoc/names:aa:1.0:action:retrieve-set-definition 
                        info:escidoc/names:aa:1.0:action:get-repository-info
						info:escidoc/names:aa:1.0:action:retrieve-registered-predicates 
                        info:escidoc/names:aa:1.0:action:fedora-deviation-get-fedora-description 
                        info:escidoc/names:aa:1.0:action:retrieve-current-user-account 
                        info:escidoc/names:aa:1.0:action:retrieve-permission-filter-query 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-1" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-container 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-2" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-context 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">opened closed</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:context:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-3" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-item 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-4" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-content 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:component:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">withdrawn</AttributeValue>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:component:visibility" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">public</AttributeValue>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:component:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-5" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-organizational-unit 
                        info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit 
                        info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">opened closed</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:organizational-unit:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-5-1" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-content-relation 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:content-relation:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-6" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:unlock-container 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:lock-owner" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-7" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:unlock-item 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:lock-owner" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-8" Effect="Permit">
        <Target>
        <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-user-account 
                        info:escidoc/names:aa:1.0:action:retrieve-grant 
                        info:escidoc/names:aa:1.0:action:update-user-account
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:handle" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:login-name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-8-1" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                           info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
                         </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:group-membership" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
        <Rule RuleId="Default-User-policy-rule-8-1-1" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                               info:escidoc/names:aa:1.0:action:retrieve-user-group 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:group-membership" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-8-2" Effect="Permit">
        <Target>
        <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:retrieve-grant 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-9" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                        info:escidoc/names:aa:1.0:action:query-semantic-store 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-10" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                            info:escidoc/names:aa:1.0:action:create-grant 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">User-Account-Inspector</AttributeValue>
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-11" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                            info:escidoc/names:aa:1.0:action:create-user-group-grant 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:assigned-on:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">User-Account-Inspector</AttributeValue>
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-12" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                            info:escidoc/names:aa:1.0:action:revoke-grant 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-13" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"> 
                            info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-14" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                         info:escidoc/names:aa:1.0:action:retrieve-role 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">escidoc:role-audience escidoc:role-collaborator-modifier-container-add-remove-any-members escidoc:role-collaborator-modifier-container-add-remove-members escidoc:role-collaborator-modifier-container-update-any-members escidoc:role-collaborator-modifier-container-update-direct-members escidoc:role-user-account-inspector escidoc:role-collaborator-modifier escidoc:role-collaborator escidoc:role-content-relation-manager escidoc:role-content-relation-modifier</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Default-User-policy-rule-15" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:evaluate  
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
        	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                	<SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            	</Apply>
            	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                	<ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            	</Apply>
        	</Apply>
        	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
            	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                	<ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            	</Apply>
        	</Apply>
		</Condition>
    </Rule>
</Policy>' WHERE id='escidoc:default-policy-1';

UPDATE aa.escidoc_policies SET xml='<Policy PolicyId="Moderator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
    <Target>
        <Subjects>
            <AnySubject/>
        </Subjects>
        <Resources>
            <AnyResource/>
        </Resources>
        <Actions>
            <Action>
                <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:retrieve-item 
                    info:escidoc/names:aa:1.0:action:update-item 
                    info:escidoc/names:aa:1.0:action:lock-item 
                    info:escidoc/names:aa:1.0:action:submit-item 
                    info:escidoc/names:aa:1.0:action:revise-item 
                    info:escidoc/names:aa:1.0:action:release-item 
                    info:escidoc/names:aa:1.0:action:retrieve-content 
                    info:escidoc/names:aa:1.0:action:retrieve-container 
                    info:escidoc/names:aa:1.0:action:update-container 
                    info:escidoc/names:aa:1.0:action:lock-container 
                    info:escidoc/names:aa:1.0:action:add-members-to-container 
                    info:escidoc/names:aa:1.0:action:remove-members-from-container  
                    info:escidoc/names:aa:1.0:action:submit-container 
                    info:escidoc/names:aa:1.0:action:revise-container 
                    info:escidoc/names:aa:1.0:action:release-container 
                    info:escidoc/names:aa:1.0:action:create-grant 
                    info:escidoc/names:aa:1.0:action:create-user-group-grant 
                    </AttributeValue>
                    <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </ActionMatch>
            </Action>
        </Actions>
    </Target>
    <Rule RuleId="Moderator-policy-rule-si" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:submit-item
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
                </Apply>
            </Apply>
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending submitted</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-revisei" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:revise-item
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-ri" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:release-item
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-retrievei" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:retrieve-item
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted released in-revision withdrawn</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending submitted released in-revision</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-mi" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:update-item 
                        info:escidoc/names:aa:1.0:action:lock-item
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted released</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
                <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted released</AttributeValue>
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-modified-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                        </Apply>
                        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                        </Apply>
                    </Apply>
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                        </Apply>
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending</AttributeValue>
                    </Apply>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-rcontent" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:retrieve-content
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:component:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending</AttributeValue>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-sc" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:submit-container
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
                </Apply>
            </Apply>
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending submitted</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-revisec" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:revise-container
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-rc" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:release-container
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-retrievec" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:retrieve-container
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted released in-revision withdrawn</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending submitted released in-revision</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-mc" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                        info:escidoc/names:aa:1.0:action:update-container 
                        info:escidoc/names:aa:1.0:action:lock-container 
                        info:escidoc/names:aa:1.0:action:add-members-to-container 
                        info:escidoc/names:aa:1.0:action:remove-members-from-container
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted released</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
                <Apply FunctionId="info:escidoc/names:aa:1.0:function:string-contains">
                    <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted released</AttributeValue>
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </Apply>
                </Apply>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-modified-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                        </Apply>
                        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                        </Apply>
                    </Apply>
                    <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                        </Apply>
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending</AttributeValue>
                    </Apply>
                </Apply>
            </Apply>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-grant-create" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:create-grant 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on:context" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-moderator:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Condition>
    </Rule>
    <Rule RuleId="Moderator-policy-rule-user-group-grant-create" Effect="Permit">
        <Target>
            <Subjects>
                <AnySubject/>
            </Subjects>
            <Resources>
                <AnyResource/>
            </Resources>
            <Actions>
                <Action>
                    <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                            info:escidoc/names:aa:1.0:action:create-user-group-grant 
                        </AttributeValue>
                        <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                    </ActionMatch>
                </Action>
            </Actions>
        </Target>
        <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:assigned-on:context" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:role-grant:escidoc:role-moderator:assigned-on" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Condition>
    </Rule>
</Policy>' WHERE id='escidoc:moderator-policy-1';

UPDATE aa.escidoc_policies
  SET xml='<Policy PolicyId="System-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>
    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
              info:escidoc/names:aa:1.0:action:retrieve-method-mappings 
              info:escidoc/names:aa:1.0:action:ingest 
              info:escidoc/names:aa:1.0:action:check-user-privilege 
              info:escidoc/names:aa:1.0:action:create-role 
              info:escidoc/names:aa:1.0:action:delete-role 
              info:escidoc/names:aa:1.0:action:retrieve-role 
              info:escidoc/names:aa:1.0:action:update-role 
              info:escidoc/names:aa:1.0:action:evaluate 
              info:escidoc/names:aa:1.0:action:find-attribute 
              info:escidoc/names:aa:1.0:action:retrieve-roles 
              info:escidoc/names:aa:1.0:action:create-user-account 
              info:escidoc/names:aa:1.0:action:delete-user-account 
              info:escidoc/names:aa:1.0:action:retrieve-user-account 
              info:escidoc/names:aa:1.0:action:update-user-account 
              info:escidoc/names:aa:1.0:action:activate-user-account 
              info:escidoc/names:aa:1.0:action:deactivate-user-account 
              info:escidoc/names:aa:1.0:action:create-grant 
              info:escidoc/names:aa:1.0:action:retrieve-grant 
              info:escidoc/names:aa:1.0:action:retrieve-current-grants 
              info:escidoc/names:aa:1.0:action:revoke-grant 
              info:escidoc/names:aa:1.0:action:create-user-group 
              info:escidoc/names:aa:1.0:action:delete-user-group 
              info:escidoc/names:aa:1.0:action:retrieve-user-group 
              info:escidoc/names:aa:1.0:action:update-user-group 
              info:escidoc/names:aa:1.0:action:activate-user-group 
              info:escidoc/names:aa:1.0:action:deactivate-user-group 
              info:escidoc/names:aa:1.0:action:add-user-group-selectors 
              info:escidoc/names:aa:1.0:action:remove-user-group-selectors 
              info:escidoc/names:aa:1.0:action:create-user-group-grant 
              info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
              info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
              info:escidoc/names:aa:1.0:action:logout 
              info:escidoc/names:aa:1.0:action:create-unsecured-actions 
              info:escidoc/names:aa:1.0:action:delete-unsecured-actions 
              info:escidoc/names:aa:1.0:action:retrieve-unsecured-actions 
              info:escidoc/names:aa:1.0:action:create-metadata-schema 
              info:escidoc/names:aa:1.0:action:delete-metadata-schema 
              info:escidoc/names:aa:1.0:action:retrieve-metadata-schema 
              info:escidoc/names:aa:1.0:action:update-metadata-schema 
              info:escidoc/names:aa:1.0:action:create-container 
              info:escidoc/names:aa:1.0:action:delete-container 
              info:escidoc/names:aa:1.0:action:update-container 
              info:escidoc/names:aa:1.0:action:retrieve-container 
              info:escidoc/names:aa:1.0:action:submit-container 
              info:escidoc/names:aa:1.0:action:release-container 
              info:escidoc/names:aa:1.0:action:revise-container 
              info:escidoc/names:aa:1.0:action:withdraw-container 
              info:escidoc/names:aa:1.0:action:container-move-to-context 
              info:escidoc/names:aa:1.0:action:add-members-to-container 
              info:escidoc/names:aa:1.0:action:remove-members-from-container 
              info:escidoc/names:aa:1.0:action:lock-container 
              info:escidoc/names:aa:1.0:action:unlock-container 
              info:escidoc/names:aa:1.0:action:create-content-model 
              info:escidoc/names:aa:1.0:action:delete-content-model 
              info:escidoc/names:aa:1.0:action:retrieve-content-model 
              info:escidoc/names:aa:1.0:action:update-content-model 
              info:escidoc/names:aa:1.0:action:create-context 
              info:escidoc/names:aa:1.0:action:delete-context 
              info:escidoc/names:aa:1.0:action:retrieve-context 
              info:escidoc/names:aa:1.0:action:update-context 
              info:escidoc/names:aa:1.0:action:close-context 
              info:escidoc/names:aa:1.0:action:open-context 
              info:escidoc/names:aa:1.0:action:create-item 
              info:escidoc/names:aa:1.0:action:delete-item 
              info:escidoc/names:aa:1.0:action:retrieve-item 
              info:escidoc/names:aa:1.0:action:update-item 
              info:escidoc/names:aa:1.0:action:submit-item 
              info:escidoc/names:aa:1.0:action:release-item 
              info:escidoc/names:aa:1.0:action:revise-item 
              info:escidoc/names:aa:1.0:action:withdraw-item 
              info:escidoc/names:aa:1.0:action:retrieve-content 
              info:escidoc/names:aa:1.0:action:item-move-to-context 
              info:escidoc/names:aa:1.0:action:lock-item 
              info:escidoc/names:aa:1.0:action:unlock-item 
              info:escidoc/names:aa:1.0:action:create-toc 
              info:escidoc/names:aa:1.0:action:delete-toc 
              info:escidoc/names:aa:1.0:action:retrieve-toc 
              info:escidoc/names:aa:1.0:action:update-toc 
              info:escidoc/names:aa:1.0:action:submit-toc 
              info:escidoc/names:aa:1.0:action:release-toc 
              info:escidoc/names:aa:1.0:action:revise-toc 
              info:escidoc/names:aa:1.0:action:withdraw-toc 
              info:escidoc/names:aa:1.0:action:create-content-relation 
              info:escidoc/names:aa:1.0:action:delete-content-relation 
              info:escidoc/names:aa:1.0:action:retrieve-content-relation 
              info:escidoc/names:aa:1.0:action:update-content-relation 
              info:escidoc/names:aa:1.0:action:submit-content-relation 
              info:escidoc/names:aa:1.0:action:release-content-relation 
              info:escidoc/names:aa:1.0:action:revise-content-relation 
              info:escidoc/names:aa:1.0:action:withdraw-content-relation 
              info:escidoc/names:aa:1.0:action:lock-content-relation 
              info:escidoc/names:aa:1.0:action:unlock-content-relation 
              info:escidoc/names:aa:1.0:action:query-semantic-store 
              info:escidoc/names:aa:1.0:action:create-xml-schema 
              info:escidoc/names:aa:1.0:action:delete-xml-schema 
              info:escidoc/names:aa:1.0:action:retrieve-xml-schema 
              info:escidoc/names:aa:1.0:action:update-xml-schema 
              info:escidoc/names:aa:1.0:action:create-organizational-unit 
              info:escidoc/names:aa:1.0:action:delete-organizational-unit 
              info:escidoc/names:aa:1.0:action:retrieve-organizational-unit 
              info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit 
              info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit 
              info:escidoc/names:aa:1.0:action:update-organizational-unit 
              info:escidoc/names:aa:1.0:action:open-organizational-unit 
              info:escidoc/names:aa:1.0:action:close-organizational-unit 
              info:escidoc/names:aa:1.0:action:fmdh-export 
              info:escidoc/names:aa:1.0:action:fadh-get-datastream-dissemination 
              info:escidoc/names:aa:1.0:action:fddh-get-fedora-description 
              info:escidoc/names:aa:1.0:action:create-aggregation-definition 
              info:escidoc/names:aa:1.0:action:delete-aggregation-definition 
              info:escidoc/names:aa:1.0:action:retrieve-aggregation-definition 
              info:escidoc/names:aa:1.0:action:update-aggregation-definition 
              info:escidoc/names:aa:1.0:action:create-report-definition 
              info:escidoc/names:aa:1.0:action:delete-report-definition 
              info:escidoc/names:aa:1.0:action:retrieve-report-definition 
              info:escidoc/names:aa:1.0:action:update-report-definition 
              info:escidoc/names:aa:1.0:action:retrieve-report 
              info:escidoc/names:aa:1.0:action:create-statistic-data 
              info:escidoc/names:aa:1.0:action:create-scope 
              info:escidoc/names:aa:1.0:action:delete-scope 
              info:escidoc/names:aa:1.0:action:retrieve-scope 
              info:escidoc/names:aa:1.0:action:update-scope 
              info:escidoc/names:aa:1.0:action:preprocess-statistics 
              info:escidoc/names:aa:1.0:action:create-staging-file 
              info:escidoc/names:aa:1.0:action:retrieve-staging-file 
              info:escidoc/names:aa:1.0:action:extract-metadata 
              info:escidoc/names:aa:1.0:action:delete-objects 
              info:escidoc/names:aa:1.0:action:get-purge-status 
              info:escidoc/names:aa:1.0:action:get-reindex-status 
              info:escidoc/names:aa:1.0:action:decrease-reindex-status 
              info:escidoc/names:aa:1.0:action:reindex 
              info:escidoc/names:aa:1.0:action:get-index-configuration 
              info:escidoc/names:aa:1.0:action:load-examples 
    		  info:escidoc/names:aa:1.0:action:create-set-definition 
    		  info:escidoc/names:aa:1.0:action:update-set-definition 
			  info:escidoc/names:aa:1.0:action:delete-set-definition
              info:escidoc/names:aa:1.0:action:fedora-deviation-get-datastream-dissimination 
              info:escidoc/names:aa:1.0:action:fedora-deviation-export 
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="System-Administrator-policy-rule-0" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
        <AnyAction/>
      </Actions>
    </Target>
  </Rule>
</Policy>' WHERE id='escidoc:policy-system-administrator';

UPDATE aa.escidoc_policies
  SET xml='<Policy PolicyId="User-Account-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>
    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
            info:escidoc/names:aa:1.0:action:create-user-account 
            info:escidoc/names:aa:1.0:action:retrieve-user-account 
            info:escidoc/names:aa:1.0:action:update-user-account 
            info:escidoc/names:aa:1.0:action:activate-user-account 
            info:escidoc/names:aa:1.0:action:deactivate-user-account 
            info:escidoc/names:aa:1.0:action:create-user-group-grant 
            info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
            info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
            info:escidoc/names:aa:1.0:action:create-grant 
            info:escidoc/names:aa:1.0:action:retrieve-grant 
            info:escidoc/names:aa:1.0:action:revoke-grant 
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="User-Account-Administrator-policy-rule-1" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:create-user-account 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="User-Account-Administrator-policy-rule-2" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:retrieve-user-account 
                    info:escidoc/names:aa:1.0:action:update-user-account 
                    info:escidoc/names:aa:1.0:action:activate-user-account 
                    info:escidoc/names:aa:1.0:action:deactivate-user-account 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="User-Account-Administrator-policy-rule-3" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:create-grant 
                    info:escidoc/names:aa:1.0:action:revoke-grant 
                    info:escidoc/names:aa:1.0:action:retrieve-grant 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
    	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            	<SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        	</Apply>
        	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            	<ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        	</Apply>
    	</Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        		<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            		<SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        		</Apply>
        		<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            		<ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        		</Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">User-Account-Inspector</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Apply>
	</Condition>
  </Rule>
  <Rule RuleId="User-Account-Administrator-policy-rule-4" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:create-user-group-grant 
                    info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
                    info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
      		<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          		<SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      		</Apply>
        	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            	<ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:assigned-on:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        	</Apply>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">User-Account-Inspector</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Apply>
    </Condition>
  </Rule>
</Policy>' WHERE id='escidoc:policy-user-account-administrator';

UPDATE aa.escidoc_policies
  SET xml='<Policy PolicyId="User-Group-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>
    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
            info:escidoc/names:aa:1.0:action:create-user-group 
            info:escidoc/names:aa:1.0:action:retrieve-user-group 
            info:escidoc/names:aa:1.0:action:update-user-group 
            info:escidoc/names:aa:1.0:action:delete-user-group 
            info:escidoc/names:aa:1.0:action:activate-user-group 
            info:escidoc/names:aa:1.0:action:deactivate-user-group 
            info:escidoc/names:aa:1.0:action:create-user-group-grant 
            info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
            info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
            info:escidoc/names:aa:1.0:action:create-grant 
            info:escidoc/names:aa:1.0:action:retrieve-grant 
            info:escidoc/names:aa:1.0:action:revoke-grant 
            info:escidoc/names:aa:1.0:action:add-user-group-selectors 
            info:escidoc/names:aa:1.0:action:remove-user-group-selectors 
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="User-Group-Administrator-policy-rule-1" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:create-user-group 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="User-Group-Administrator-policy-rule-2" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:retrieve-user-group 
                    info:escidoc/names:aa:1.0:action:update-user-group 
                    info:escidoc/names:aa:1.0:action:delete-user-group 
                    info:escidoc/names:aa:1.0:action:activate-user-group 
                    info:escidoc/names:aa:1.0:action:deactivate-user-group 
                    info:escidoc/names:aa:1.0:action:add-user-group-selectors 
                    info:escidoc/names:aa:1.0:action:remove-user-group-selectors 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="User-Group-Administrator-policy-rule-3" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:create-user-group-grant 
                    info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
                    info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
    	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            	<SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        	</Apply>
        	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            	<ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        	</Apply>
    	</Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        		<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            		<SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        		</Apply>
        		<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            		<ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:assigned-on:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        		</Apply>
            </Apply>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
                <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">User-Group-Inspector</AttributeValue>
                <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                    <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-group:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
                </Apply>
            </Apply>
        </Apply>
	</Condition>
  </Rule>
  <Rule RuleId="User-Group-Administrator-policy-rule-4" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
          <Action>
              <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
                  <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                    info:escidoc/names:aa:1.0:action:create-grant 
                    info:escidoc/names:aa:1.0:action:revoke-grant 
                    info:escidoc/names:aa:1.0:action:retrieve-grant 
                  </AttributeValue>
                  <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
              </ActionMatch>
          </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
      		<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          		<SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      		</Apply>
        	<Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            	<ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:assigned-on:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        	</Apply>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">User-Group-Inspector</AttributeValue>
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
                <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:user-account:grant:role:name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
        </Apply>
    </Condition>
  </Rule>
</Policy>' WHERE id='escidoc:policy-user-group-administrator';

UPDATE aa.escidoc_policies
  SET xml='<Policy PolicyId="System-Inspector-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>
    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
            info:escidoc/names:aa:1.0:action:retrieve-role 
            info:escidoc/names:aa:1.0:action:retrieve-roles 
            info:escidoc/names:aa:1.0:action:evaluate 
            info:escidoc/names:aa:1.0:action:retrieve-user-account 
            info:escidoc/names:aa:1.0:action:retrieve-grant 
            info:escidoc/names:aa:1.0:action:retrieve-user-group 
            info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
            info:escidoc/names:aa:1.0:action:logout 
            info:escidoc/names:aa:1.0:action:retrieve-unsecured-actions 
            info:escidoc/names:aa:1.0:action:retrieve-metadata-schema 
            info:escidoc/names:aa:1.0:action:retrieve-container 
            info:escidoc/names:aa:1.0:action:retrieve-content-model 
            info:escidoc/names:aa:1.0:action:retrieve-context 
            info:escidoc/names:aa:1.0:action:retrieve-item 
            info:escidoc/names:aa:1.0:action:retrieve-content 
            info:escidoc/names:aa:1.0:action:retrieve-toc 
            info:escidoc/names:aa:1.0:action:retrieve-content-relation 
            info:escidoc/names:aa:1.0:action:query-semantic-store 
            info:escidoc/names:aa:1.0:action:retrieve-xml-schema 
            info:escidoc/names:aa:1.0:action:retrieve-organizational-unit 
            info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit 
            info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit 
            info:escidoc/names:aa:1.0:action:retrieve-aggregation-definition 
            info:escidoc/names:aa:1.0:action:retrieve-report-definition 
            info:escidoc/names:aa:1.0:action:retrieve-report 
            info:escidoc/names:aa:1.0:action:retrieve-scope 
            info:escidoc/names:aa:1.0:action:retrieve-staging-file 
            info:escidoc/names:aa:1.0:action:get-index-configuration 
            info:escidoc/names:aa:1.0:action:fedora-deviation-get-datastream-dissimination 
            info:escidoc/names:aa:1.0:action:fedora-deviation-export 
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="System-Inspector-policy-rule-0" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
        <AnyAction/>
      </Actions>
    </Target>
  </Rule>
</Policy>' WHERE id='escidoc:policy-system-inspector';

UPDATE aa.escidoc_policies
  SET xml='<Policy PolicyId="User-Account-Inspector-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
  <Target>
    <Subjects>
      <AnySubject/>
    </Subjects>
    <Resources>
      <AnyResource/>
    </Resources>
    <Actions>
      <Action>
        <ActionMatch MatchId="info:escidoc/names:aa:1.0:function:string-contains">
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
            info:escidoc/names:aa:1.0:action:retrieve-user-account 
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Depositor-policy-rule-1a" Effect="Permit">
    <Target>
      <Subjects>
        <AnySubject/>
      </Subjects>
      <Resources>
        <AnyResource/>
      </Resources>
      <Actions>
        <AnyAction/>
      </Actions>
    </Target>
  </Rule>
</Policy>' WHERE id='escidoc:policy-user-account-inspector';



