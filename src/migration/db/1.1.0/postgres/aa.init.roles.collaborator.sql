DELETE FROM aa.scope_def WHERE role_id='escidoc:role-collaborator';
DELETE FROM aa.escidoc_policies WHERE role_id='escidoc:role-collaborator';
DELETE FROM list.filter;
DELETE FROM aa.escidoc_role WHERE role_name='Collaborator';

    /**
     * Role Collaborator
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-collaborator', 'Collaborator', '@creator_id@', CURRENT_TIMESTAMP, '@creator_id@',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role Collaborator Scope
         */  
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator', 'escidoc:role-collaborator', 'component', 
     'info:escidoc/names:aa:1.0:resource:component-id');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-2', 'escidoc:role-collaborator', 'component', 
     'info:escidoc/names:aa:1.0:resource:component:item');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-3', 'escidoc:role-collaborator', 'component', 
     'info:escidoc/names:aa:1.0:resource:component:item:container');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-4', 'escidoc:role-collaborator', 'component', 
     'info:escidoc/names:aa:1.0:resource:component:item:context');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-5', 'escidoc:role-collaborator', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:component');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-6', 'escidoc:role-collaborator', 'item', 
     'info:escidoc/names:aa:1.0:resource:item-id');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-7', 'escidoc:role-collaborator', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:container');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-8', 'escidoc:role-collaborator', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:context');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-9', 'escidoc:role-collaborator', 'container', 
     'info:escidoc/names:aa:1.0:resource:container-id');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-10', 'escidoc:role-collaborator', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:container');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-collaborator-11', 'escidoc:role-collaborator', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:context');

        /**
         * Role Collaborator Policies
         */
            /**
             * An Collaborator is allowed to retrieve items.
             */
            /**
             * An Collaborator is allowed to retrieve containers.
             */
            /**
             * An Collaborator is allowed to retrieve content of components.
             */
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:collaborator-policy-1', 'escidoc:role-collaborator',
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                                info:escidoc/names:aa:1.0:action:retrieve-item 
                                info:escidoc/names:aa:1.0:action:retrieve-container 
                                info:escidoc/names:aa:1.0:action:retrieve-content
          </AttributeValue>
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                                        info:escidoc/names:aa:1.0:action:retrieve-item 
                                        info:escidoc/names:aa:1.0:action:retrieve-container 
                                        info:escidoc/names:aa:1.0:action:retrieve-content
            </AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
</Policy>');
