INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:rlc-scope-def-administrator-user-group', 'escidoc:role-administrator', 'user-group', 
     null);

UPDATE aa.escidoc_policies SET xml=
'<Policy PolicyId="Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:update-context info:escidoc/names:aa:1.0:action:retrieve-context info:escidoc/names:aa:1.0:action:close-context info:escidoc/names:aa:1.0:action:open-context info:escidoc/names:aa:1.0:action:create-grant info:escidoc/names:aa:1.0:action:revoke-grant info:escidoc/names:aa:1.0:action:revoke-grants info:escidoc/names:aa:1.0:action:retrieve-grant info:escidoc/names:aa:1.0:action:create-user-group-grant info:escidoc/names:aa:1.0:action:revoke-user-group-grant info:escidoc/names:aa:1.0:action:revoke-user-group-grants info:escidoc/names:aa:1.0:action:retrieve-user-group-grants info:escidoc/names:aa:1.0:action:add-user-group-selectors info:escidoc/names:aa:1.0:action:remove-user-group-selectors info:escidoc/names:aa:1.0:action:withdraw-container info:escidoc/names:aa:1.0:action:withdraw-item info:escidoc/names:aa:1.0:action:revise-container info:escidoc/names:aa:1.0:action:revise-item info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:retrieve-user-account info:escidoc/names:aa:1.0:action:retrieve-user-group</AttributeValue>

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
WHERE id='escidoc:administrator-policy-1';
