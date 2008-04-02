    /**
     * Role Author
     */
INSERT INTO "aa"."escidoc_role"
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-author', 'Author', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role Author Scope
         */  
INSERT INTO "aa"."scope_def" 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-author', 'escidoc:role-author', 'container', 
     'info:escidoc/names:aa:1.0:resource:container.collection:id');

INSERT INTO "aa"."scope_def" 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-author-2', 'escidoc:role-author', 'item', 
     'info:escidoc/names:aa:1.0:resource:item:container.collection');

INSERT INTO "aa"."scope_def" 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-author-3', 'escidoc:role-author', 'container', 
     'info:escidoc/names:aa:1.0:resource:container:container.collection');

INSERT INTO "aa"."scope_def" 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-author-4', 'escidoc:role-author', 'staging-file', 
     null);

        /**
         * Role Author Policies
         */
            /**
             * An Author is allowed to create containers and items.
             */
            /**
             * An Author is allowed to retrieve containers and items.
             */
            /**
             * An Author is allowed to update, delete, submit, and lock 
             * containers in the state "pending" or in the state "in-revision".
             * This includes the adding/removing of members to/from a container.
             */
            /**
             * An Author is allowed to update, delete, submit, and lock
             * items in the state "pending" or in the state "in-revision".
             */
            /**
             * An author is allowed to retrieve binary content of an item.
             */
            /**
             * An Author is allowed to upload files to the staging area.
             */
INSERT INTO "aa"."escidoc_policies" 
  (id, role_id, xml)
     VALUES
  ('escidoc:author-policy-1', 'escidoc:role-author',
'<Policy PolicyId="Author-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:create-container info:escidoc/names:aa:1.0:action:create-item info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:update-container info:escidoc/names:aa:1.0:action:delete-container info:escidoc/names:aa:1.0:action:submit-container info:escidoc/names:aa:1.0:action:add-members-to-container info:escidoc/names:aa:1.0:action:remove-members-from-container info:escidoc/names:aa:1.0:action:lock-container info:escidoc/names:aa:1.0:action:update-item info:escidoc/names:aa:1.0:action:delete-item info:escidoc/names:aa:1.0:action:submit-item info:escidoc/names:aa:1.0:action:lock-item info:escidoc/names:aa:1.0:action:retrieve-content info:escidoc/names:aa:1.0:action:create-staging-file</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Author-policy-rule-0" Effect="Permit">
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
  <Rule RuleId="Author-policy-rule-1" Effect="Permit">
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
  </Rule>
  <Rule RuleId="Author-policy-rule-2" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:update-container info:escidoc/names:aa:1.0:action:delete-container info:escidoc/names:aa:1.0:action:submit-container info:escidoc/names:aa:1.0:action:add-members-to-container info:escidoc/names:aa:1.0:action:remove-members-from-container info:escidoc/names:aa:1.0:action:lock-container</AttributeValue>

            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
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
    </Condition>
  </Rule>
  <Rule RuleId="Author-policy-rule-3" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:update-item info:escidoc/names:aa:1.0:action:delete-item info:escidoc/names:aa:1.0:action:submit-item info:escidoc/names:aa:1.0:action:lock-item</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>

        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
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
    </Condition>

  </Rule>
  <Rule RuleId="Author-policy-rule-4" Effect="Permit">
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
  </Rule>
  <Rule RuleId="Author-policy-rule-5" Effect="Permit">
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
  </Rule>
</Policy>');
