INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-update-password' AS id,
             'info:escidoc/names:aa:1.0:action:update-password' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-update-password'));
    
INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-create-user-account-attribute' AS id,
             'info:escidoc/names:aa:1.0:action:create-user-account-attribute' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-create-user-account-attribute'));
    
INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-update-user-account-attribute' AS id,
             'info:escidoc/names:aa:1.0:action:update-user-account-attribute' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-update-user-account-attribute'));
    
INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-delete-user-account-attribute' AS id,
             'info:escidoc/names:aa:1.0:action:delete-user-account-attribute' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-delete-user-account-attribute'));
    
INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-retrieve-user-account-attribute' AS id,
             'info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-retrieve-user-account-attribute'));
    
INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-create-user-account-preference' AS id,
             'info:escidoc/names:aa:1.0:action:create-user-account-preference' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-create-user-account-preference'));
    
INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-update-user-account-preference' AS id,
             'info:escidoc/names:aa:1.0:action:update-user-account-preference' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-update-user-account-preference'));
    
INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-delete-user-account-preference' AS id,
             'info:escidoc/names:aa:1.0:action:delete-user-account-preference' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-delete-user-account-preference'));
    
INSERT INTO aa.actions
    (id, name)
    (SELECT  'escidoc:action-retrieve-user-account-preference' AS id,
             'info:escidoc/names:aa:1.0:action:retrieve-user-account-preference' AS name
			WHERE NOT EXISTS (SELECT 1 FROM aa.actions WHERE id='escidoc:action-retrieve-user-account-preference'));
    
UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:update-password' 
	WHERE id = 'escidoc:mm-user-account-update-password';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:create-user-account-preference' 
	WHERE id = 'escidoc:mm-user-account-create-preference';

INSERT INTO aa.invocation_mappings
    (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
    (SELECT  'escidoc-im-user-account-create-preference-2' AS id,
             'urn:oasis:names:tc:xacml:1.0:resource:resource-id' AS attribute_id,
             '' AS path,
             0 AS position,
             'http://www.w3.org/2001/XMLSchema#string' AS attribute_type,
             0 AS mapping_type,
             'f' AS multi_value,
             '' AS value,
             'escidoc:mm-user-account-create-preference' AS method_mapping
			WHERE NOT EXISTS (SELECT 1 FROM aa.invocation_mappings WHERE id='escidoc-im-user-account-create-preference-2'));
    
UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:delete-user-account-preference' 
	WHERE id = 'escidoc:mm-user-account-delete-preference';

INSERT INTO aa.invocation_mappings
    (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
    (SELECT  'escidoc-im-user-account-delete-preference-2' AS id,
             'urn:oasis:names:tc:xacml:1.0:resource:resource-id' AS attribute_id,
             '' AS path,
             0 AS position,
             'http://www.w3.org/2001/XMLSchema#string' AS attribute_type,
             0 AS mapping_type,
             'f' AS multi_value,
             '' AS value,
             'escidoc:mm-user-account-delete-preference' AS method_mapping
			WHERE NOT EXISTS (SELECT 1 FROM aa.invocation_mappings WHERE id='escidoc-im-user-account-delete-preference-2'));
    
UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:retrieve-user-account-preference' 
	WHERE id = 'escidoc:mm-user-account-preferences-retrieve';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:retrieve-user-account-preference' 
	WHERE id = 'escidoc:mm-user-account-preference-retrieve';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:update-user-account-preference' 
	WHERE id = 'escidoc:mm-user-account-preference-update';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:update-user-account-preference' 
	WHERE id = 'escidoc:mm-user-account-preferences-update';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:create-user-account-attribute' 
	WHERE id = 'escidoc:mm-user-account-create-attribute';

INSERT INTO aa.invocation_mappings
    (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
    (SELECT  'escidoc-im-user-account-create-attribute-2' AS id,
             'urn:oasis:names:tc:xacml:1.0:resource:resource-id' AS attribute_id,
             '' AS path,
             0 AS position,
             'http://www.w3.org/2001/XMLSchema#string' AS attribute_type,
             0 AS mapping_type,
             'f' AS multi_value,
             '' AS value,
             'escidoc:mm-user-account-create-attribute' AS method_mapping
			WHERE NOT EXISTS (SELECT 1 FROM aa.invocation_mappings WHERE id='escidoc-im-user-account-create-attribute-2'));
    
UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute' 
	WHERE id = 'escidoc:mm-user-account-attributes-retrieve';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute' 
	WHERE id = 'escidoc:mm-user-account-named-attributes-retrieve';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute' 
	WHERE id = 'escidoc:mm-user-account-attribute-retrieve';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:update-user-account-attribute' 
	WHERE id = 'escidoc:mm-user-account-attribute-update';

UPDATE aa.method_mappings SET action_name = 'info:escidoc/names:aa:1.0:action:delete-user-account-attribute' 
	WHERE id = 'escidoc:mm-user-account-attribute-delete';

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:rlc-scope-def-administrator-role', 'escidoc:role-administrator', 'role', 
     null);

UPDATE aa.escidoc_policies SET xml = '<Policy PolicyId="Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
            info:escidoc/names:aa:1.0:action:update-context 
            info:escidoc/names:aa:1.0:action:retrieve-context 
            info:escidoc/names:aa:1.0:action:close-context 
            info:escidoc/names:aa:1.0:action:open-context 
            info:escidoc/names:aa:1.0:action:retrieve-role  
            info:escidoc/names:aa:1.0:action:create-grant 
            info:escidoc/names:aa:1.0:action:revoke-grant 
            info:escidoc/names:aa:1.0:action:retrieve-grant 
            info:escidoc/names:aa:1.0:action:create-user-group-grant 
            info:escidoc/names:aa:1.0:action:retrieve-user-group-grant 
            info:escidoc/names:aa:1.0:action:revoke-user-group-grant 
            info:escidoc/names:aa:1.0:action:add-user-group-selectors 
            info:escidoc/names:aa:1.0:action:remove-user-group-selectors 
            info:escidoc/names:aa:1.0:action:withdraw-container 
            info:escidoc/names:aa:1.0:action:withdraw-item 
            info:escidoc/names:aa:1.0:action:revise-container 
            info:escidoc/names:aa:1.0:action:revise-item 
            info:escidoc/names:aa:1.0:action:retrieve-container 
            info:escidoc/names:aa:1.0:action:retrieve-item 
            info:escidoc/names:aa:1.0:action:retrieve-user-account 
            info:escidoc/names:aa:1.0:action:retrieve-user-account-preference 
            info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute 
            info:escidoc/names:aa:1.0:action:retrieve-user-group 
          </AttributeValue>

          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Administrator-policy-rule-0" Effect="Permit">
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
</Policy>'
	WHERE id = 'escidoc:administrator-policy-1';

UPDATE aa.escidoc_policies SET xml = '<Policy PolicyId="Default-User-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
                    info:escidoc/names:aa:1.0:action:create-user-account-preference 
                    info:escidoc/names:aa:1.0:action:retrieve-user-account-preference 
                    info:escidoc/names:aa:1.0:action:update-user-account-preference 
                    info:escidoc/names:aa:1.0:action:delete-user-account-preference 
                    info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute 
                    info:escidoc/names:aa:1.0:action:update-password 
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
                        info:escidoc/names:aa:1.0:action:retrieve-grant 
                        info:escidoc/names:aa:1.0:action:update-user-account
                        info:escidoc/names:aa:1.0:action:create-user-account-preference 
                        info:escidoc/names:aa:1.0:action:retrieve-user-account-preference 
                        info:escidoc/names:aa:1.0:action:update-user-account-preference 
                        info:escidoc/names:aa:1.0:action:delete-user-account-preference 
                        info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute 
                        info:escidoc/names:aa:1.0:action:update-password 
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
    <Rule RuleId="Default-User-policy-rule-8-0" Effect="Permit">
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
</Policy>'
	WHERE id = 'escidoc:default-policy-1';

UPDATE aa.escidoc_policies SET xml = '<Policy PolicyId="System-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
              info:escidoc/names:aa:1.0:action:create-user-account-preference 
              info:escidoc/names:aa:1.0:action:retrieve-user-account-preference 
              info:escidoc/names:aa:1.0:action:update-user-account-preference 
              info:escidoc/names:aa:1.0:action:delete-user-account-preference 
              info:escidoc/names:aa:1.0:action:create-user-account-attribute 
              info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute 
              info:escidoc/names:aa:1.0:action:update-user-account-attribute 
              info:escidoc/names:aa:1.0:action:delete-user-account-attribute 
              info:escidoc/names:aa:1.0:action:update-password 
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
</Policy>'
	WHERE id = 'escidoc:policy-system-administrator';

UPDATE aa.escidoc_policies SET xml = '<Policy PolicyId="System-Inspector-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
            info:escidoc/names:aa:1.0:action:retrieve-user-account-preference 
            info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute 
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
</Policy>'
	WHERE id = 'escidoc:policy-system-inspector';

UPDATE aa.escidoc_policies SET xml = '<Policy PolicyId="User-Account-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
            info:escidoc/names:aa:1.0:action:create-user-account-preference 
            info:escidoc/names:aa:1.0:action:retrieve-user-account-preference 
            info:escidoc/names:aa:1.0:action:update-user-account-preference 
            info:escidoc/names:aa:1.0:action:delete-user-account-preference 
            info:escidoc/names:aa:1.0:action:create-user-account-attribute 
            info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute 
            info:escidoc/names:aa:1.0:action:update-user-account-attribute 
            info:escidoc/names:aa:1.0:action:delete-user-account-attribute 
            info:escidoc/names:aa:1.0:action:update-password 
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
                    info:escidoc/names:aa:1.0:action:create-user-account-preference 
                    info:escidoc/names:aa:1.0:action:retrieve-user-account-preference 
                    info:escidoc/names:aa:1.0:action:update-user-account-preference 
                    info:escidoc/names:aa:1.0:action:delete-user-account-preference 
                    info:escidoc/names:aa:1.0:action:create-user-account-attribute 
                    info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute 
                    info:escidoc/names:aa:1.0:action:update-user-account-attribute 
                    info:escidoc/names:aa:1.0:action:delete-user-account-attribute 
                    info:escidoc/names:aa:1.0:action:update-password 
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
</Policy>'
	WHERE id = 'escidoc:policy-user-account-administrator';

UPDATE aa.escidoc_policies SET xml = '<Policy PolicyId="User-Account-Inspector-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
            info:escidoc/names:aa:1.0:action:retrieve-user-account-preference 
            info:escidoc/names:aa:1.0:action:retrieve-user-account-attribute 
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
</Policy>'
	WHERE id = 'escidoc:policy-user-account-inspector';




