    /**
     * Role Collaborator-Modifier-Container-Add-Remove-Members
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-collaborator-modifier-container-add-remove-members', 'Collaborator-Modifier-Container-Add-Remove-Members', 
    '@creator_id@', CURRENT_TIMESTAMP, '@creator_id@',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role Collaborator-Modifier-Container-Add-Remove-Members Scope
         */  
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-modifier-container-add-remove-members-1', 
    'escidoc:role-collaborator-modifier-container-add-remove-members', 'container', 
     'info:escidoc/names:aa:1.0:resource:container-id');

        /**
         * Role Collaborator-Modifier-Container-Add-Remove-Members Policies
         */
            /**
             * An Collaborator-Modifier-Container-Add-Remove-Members is allowed to retrieve container.
             */
            /**
             * An Collaborator-Modifier-Container-Add-Remove-Members is allowed to update containers.
             */
            /**
             * An Collaborator-Modifier-Container-Add-Remove-Members is allowed to lock/unlock containers.
             */
            /**
             * An Collaborator-Modifier-Container-Add-Remove-Members is allowed to add items to a container.
             */
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:collaborator-modifier-container-add-remove-members-policy-1', 'escidoc:role-collaborator-modifier-container-add-remove-members',
'<Policy PolicyId="Collaborator-Modifier-Container-Add-Remove-Members-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
                                info:escidoc/names:aa:1.0:action:update-container 
                                info:escidoc/names:aa:1.0:action:lock-container 
                                info:escidoc/names:aa:1.0:action:unlock-container 
                                info:escidoc/names:aa:1.0:action:add-members-to-container
          </AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Collaborator-modifier-Container-Add-Remove-Members-policy-rule-0" Effect="Permit">
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
