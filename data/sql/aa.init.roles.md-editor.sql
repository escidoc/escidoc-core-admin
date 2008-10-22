    /**
     * MD-Editor
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-md-editor', 'MD-Editor', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
        /** 
         * Role MD-Editor Scope
         */ 
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-md-editor', 'escidoc:role-md-editor', 'context', 
     'info:escidoc/names:aa:1.0:resource:context-id');
        
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-md-editor-2', 'escidoc:role-md-editor', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:context');
     
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-md-editor-3', 'escidoc:role-md-editor', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:context');

        /**
         * Role MD-Editor Policy
         */
            /**
             * Rule MD-Editor-policy-rule-0:
             * An MD-Editor is allowed to retrieve, update and lock containers and items 
             * in the state "submitted" and "released".
             * An MD-Editor is not allowed to add members to a container.
             */
             
            /**
             * Rule MD-Editor-policy-rule-1
             * An MD-Editor is allowed to retrieve, update and lock containers and items 
             * in the state "submitted" and "released".
             * An MD-Editor is not allowed to add members to a container.
             */
             
            /*
             * Rule MD-Editor-policy-rule-2
             * see issue 349
             * An MD-Editor is allowed to submit an item that he/she has modified 
             * exec_before.
             */
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:md-editor-policy-container', 'escidoc:role-md-editor', 
   '<Policy PolicyId="MD-Editor-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:update-container info:escidoc/names:aa:1.0:action:lock-container info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:update-item info:escidoc/names:aa:1.0:action:lock-item info:escidoc/names:aa:1.0:action:submit-item</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="MD-Editor-policy-rule-0" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:update-container info:escidoc/names:aa:1.0:action:lock-container</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
      </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="MD-Editor-policy-rule-1" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:update-item info:escidoc/names:aa:1.0:action:lock-item</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">submitted</AttributeValue>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
      </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="MD-Editor-policy-rule-2" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:submit-item</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:modified-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
        <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>
    </Condition>
  </Rule>
</Policy>');