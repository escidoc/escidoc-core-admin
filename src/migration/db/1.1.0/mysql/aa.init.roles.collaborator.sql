INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-6', 'escidoc:role-collaborator', 'container', 
     'info:escidoc/names:aa:1.0:resource:container-id');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-7', 'escidoc:role-collaborator', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:container');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-8', 'escidoc:role-collaborator', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:context');

UPDATE aa.escidoc_policies SET xml=
'<Policy PolicyId="Collaborator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-content</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Collaborator-policy-rule-0" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-content</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
</Policy>'
WHERE id='escidoc:collaborator-policy-1';
