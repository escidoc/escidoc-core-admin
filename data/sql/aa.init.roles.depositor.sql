    /**
     * Role Depositor
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-depositor', 'Depositor', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
        /** 
         * Role Depositor Scope
         */
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-depositor', 'escidoc:role-depositor', 'context', 
     'info:escidoc/names:aa:1.0:resource:context-id');
        
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-depositior-2', 'escidoc:role-depositor', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:context');
     
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-depositior-3', 'escidoc:role-depositor', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:context');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:rlc33', 'escidoc:role-depositor', 'staging-file', 
     null);

        /**
         * Role Depositor Policies
         */
            /**
             * A depositor is allowed to create containers and items.
             */
            /**
             * A depositor is allowed to retrieve containers and items 
             * that she/he has created.
             */
            /**
             * A depositor is allowed to update, delete, and lock containers
             * that she/he has created and that are in the latest-version-status pending or
             * in latest-version-status in-revision.
             * This includes the adding/removing of members to/from a container.
             */
            /**
             * A depositor is allowed to update, delete, and lock items 
             * that she/he has created and that are in the status pending
             * or in status in-revision.
             */
            /**
             * A depositor is allowed to retrieve binary content of an item 
             * that she/he has created.
             */
            /**
             * A depositor is allowed to submit containers and items 
             * that she/he has created.
             */
            /**
             * A depositor is allowed to upload files to the staging area.
             */            
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:depositor-policy-1', 'escidoc:role-depositor',
'<PolicySet PolicySetId="Depositor-policies" PolicyCombiningAlgId="urn:oasis:names:tc:xacml:1.0:policy-combining-algorithm:ordered-permit-overrides">
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
  <Policy PolicyId="Depositor-policy-staging-file" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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

            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:create-staging-file</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Rule RuleId="Depositor-policy-staging-file-Rule" Effect="Permit">
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
  </Policy>
  <Policy PolicyId="Depositor-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:create-container info:escidoc/names:aa:1.0:action:create-item info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:update-container info:escidoc/names:aa:1.0:action:delete-container info:escidoc/names:aa:1.0:action:add-members-to-container info:escidoc/names:aa:1.0:action:remove-members-from-container info:escidoc/names:aa:1.0:action:lock-container info:escidoc/names:aa:1.0:action:update-item info:escidoc/names:aa:1.0:action:delete-item info:escidoc/names:aa:1.0:action:lock-item info:escidoc/names:aa:1.0:action:retrieve-content info:escidoc/names:aa:1.0:action:submit-container info:escidoc/names:aa:1.0:action:withdraw-container info:escidoc/names:aa:1.0:action:submit-item info:escidoc/names:aa:1.0:action:withdraw-item</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>

        </Action>
      </Actions>
    </Target>
    <Rule RuleId="Depositor-policy-rule-0" Effect="Permit">
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
              <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:create-container info:escidoc/names:aa:1.0:action:create-item</AttributeValue>
              <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>

          </Action>
        </Actions>
      </Target>
    </Rule>
    <Rule RuleId="Depositor-policy-rule-1" Effect="Permit">
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
              <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-item</AttributeValue>
              <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

            </ActionMatch>
          </Action>
        </Actions>
      </Target>
      <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </Apply>

          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </Apply>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </Apply>
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">

            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </Apply>
        </Apply>
      </Condition>
    </Rule>
    <Rule RuleId="Depositor-policy-rule-2" Effect="Permit">
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
              <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:update-container info:escidoc/names:aa:1.0:action:delete-container info:escidoc/names:aa:1.0:action:add-members-to-container info:escidoc/names:aa:1.0:action:remove-members-from-container info:escidoc/names:aa:1.0:action:lock-container</AttributeValue>

              <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>
          </Action>
        </Actions>
      </Target>
      <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">

              <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending</AttributeValue>
          </Apply>
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
              <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>

            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">in-revision</AttributeValue>
          </Apply>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </Apply>
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">

            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </Apply>
        </Apply>
      </Condition>
    </Rule>
    <Rule RuleId="Depositor-policy-rule-3" Effect="Permit">
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
              <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:update-item info:escidoc/names:aa:1.0:action:delete-item info:escidoc/names:aa:1.0:action:lock-item</AttributeValue>

              <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>
          </Action>
        </Actions>
      </Target>
      <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">

              <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">pending</AttributeValue>
          </Apply>
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
              <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </Apply>

            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">in-revision</AttributeValue>
          </Apply>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </Apply>
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">

            <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </Apply>
        </Apply>
      </Condition>
    </Rule>
    <Rule RuleId="Depositor-policy-rule-4" Effect="Permit">
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
      <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>

        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
      </Condition>
    </Rule>
    <Rule RuleId="Depositor-policy-rule-5" Effect="Permit">
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
              <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:submit-container info:escidoc/names:aa:1.0:action:withdraw-container</AttributeValue>

              <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>
          </Action>
        </Actions>
      </Target>
      <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>

        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
      </Condition>
    </Rule>
    <Rule RuleId="Depositor-policy-rule-6" Effect="Permit">
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
              <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:submit-item info:escidoc/names:aa:1.0:action:withdraw-item</AttributeValue>

              <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
            </ActionMatch>
          </Action>
        </Actions>
      </Target>
      <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:created-by" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>

        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
      </Condition>
    </Rule>
  </Policy>
</PolicySet>');
  