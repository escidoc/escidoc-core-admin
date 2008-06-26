    /**
     * Role Administrator
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-administrator', 'Administrator', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role Administrator Scope
         */
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-administrator', 'escidoc:role-administrator', 'context', 
     'info:escidoc/names:aa:1.0:resource:context-id');
       
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-administrator-2', 'escidoc:role-administrator', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:context');
     
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-administrator-3', 'escidoc:role-administrator', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:context');
     
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-administrator-5', 'escidoc:role-administrator', 'grant', 
     'info:escidoc/names:aa:1.0:resource:user-account:grant:object-ref');
    
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-administrator-6', 'escidoc:role-administrator', 'grant', 
     'info:escidoc/names:aa:1.0:resource:user-account:grant:object-ref:container:context');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:rlc-scope-def-administrator-user-account', 'escidoc:role-administrator', 'user-account', 
     null);


        /**
         * Role Administrator Policies
         */
            /**
             * An Administrator is allowed to 
             * - retrieve, update, open, and close the context,
             * - create, retrieve and revoke grants for objects,
             * - retrieve, revise, and withdraw containers and items, and
             * - retrieve user-accounts.
             */
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:administrator-policy-1', 'escidoc:role-administrator',
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:update-context info:escidoc/names:aa:1.0:action:retrieve-context info:escidoc/names:aa:1.0:action:close-context info:escidoc/names:aa:1.0:action:open-context info:escidoc/names:aa:1.0:action:create-grant info:escidoc/names:aa:1.0:action:revoke-grant info:escidoc/names:aa:1.0:action:retrieve-grant info:escidoc/names:aa:1.0:action:withdraw-container info:escidoc/names:aa:1.0:action:withdraw-item info:escidoc/names:aa:1.0:action:revise-container info:escidoc/names:aa:1.0:action:revise-item info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:retrieve-user-account</AttributeValue>

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
</Policy>');