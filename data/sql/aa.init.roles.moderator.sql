    /**
     * Moderator
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-moderator', 'Moderator', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
        /** 
         * Role Moderator Scope
         */ 
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-moderator', 'escidoc:role-moderator', 'context', 
     'info:escidoc/names:aa:1.0:resource:context-id');
        
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:rlc-scope-def-moderator-2', 'escidoc:role-moderator', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:context');
     
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:rlc-scope-def-moderator-3', 'escidoc:role-moderator', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:context');
     

        /**
         * Role Moderator Policies
         */
            /**
             * A Moderator is allowed to retrieve and release containers and items.
             */
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:moderator-policy-1', 'escidoc:role-moderator',
'<Policy PolicyId="Moderator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:release-container info:escidoc/names:aa:1.0:action:release-item info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-item</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Moderator-policy-rule-0" Effect="Permit">
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