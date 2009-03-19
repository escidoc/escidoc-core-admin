    /**
     * Role Collaborator-Modifier
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-collaborator-modifier', 'Collaborator-Modifier', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role Collaborator-Modifier Scope
         */  
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier', 'escidoc:role-collaborator-modifier', 'component', 
     'info:escidoc/names:aa:1.0:resource:component-id');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier-2', 'escidoc:role-collaborator-modifier', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:component');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier-3', 'escidoc:role-collaborator-modifier', 'item', 
     'info:escidoc/names:aa:1.0:resource:item-id');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier-4', 'escidoc:role-collaborator-modifier', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:container');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier-5', 'escidoc:role-collaborator-modifier', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:context');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier-6', 'escidoc:role-collaborator-modifier', 'container', 
     'info:escidoc/names:aa:1.0:resource:container-id');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier-7', 'escidoc:role-collaborator-modifier', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:container');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier-8', 'escidoc:role-collaborator-modifier', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:context');

        /**
         * Role Collaborator-Modifier Policies
         */
            /**
             * An Collaborator-Modifier is allowed to retrieve container.
             */
            /**
             * An Collaborator-Modifier is allowed to retrieve items.
             */
            /**
             * An Collaborator-Modifier is allowed to retrieve content of components.
             */
            /**
             * An Collaborator-Modifier is allowed to change container + items.
             */
            /**
             * An Collaborator-Modifier is allowed to lock/unlock containers + items.
             */
            /**
             * An Collaborator-Modifier is allowed to add items to a container.
             */
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:collaborator-modifier-policy-1', 'escidoc:role-collaborator-modifier',
'<Policy PolicyId="Collaborator-Modifier-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:lock-item info:escidoc/names:aa:1.0:action:unlock-item info:escidoc/names:aa:1.0:action:retrieve-content info:escidoc/names:aa:1.0:action:update-item info:escidoc/names:aa:1.0:action:update-container info:escidoc/names:aa:1.0:action:lock-container info:escidoc/names:aa:1.0:action:unlock-container info:escidoc/names:aa:1.0:action:add-members-to-container</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Collaborator-modifier-policy-rule-0" Effect="Permit">
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
