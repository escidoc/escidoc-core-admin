    /**
     * Role Statistics Editor
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-statistics-editor', 'Statistics-Editor', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role Statistics Editor Scope
         */  
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-statistics-editor', 'escidoc:role-statistics-editor', 'aggregation-definition', 
     'info:escidoc/names:aa:1.0:resource:aggregation-definition:scope');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-statistics-editor-2', 'escidoc:role-statistics-editor', 'report-definition', 
     'info:escidoc/names:aa:1.0:resource:report-definition:scope');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-statistics-editor-3', 'escidoc:role-statistics-editor', 'report', 
     'info:escidoc/names:aa:1.0:resource:report-definition:scope');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-statistics-editor-4', 'escidoc:role-statistics-editor', 'statistic-data', 
     'info:escidoc/names:aa:1.0:resource:statistic-data:scope');

INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-statistics-editor-5', 'escidoc:role-statistics-editor', 'scope', 
     'info:escidoc/names:aa:1.0:resource:scope-id');

        /**
         * Role Statistics Editor Policies
         */
            /**
             * An Statistics Editor is allowed to create aggregation-definitions and report-definitions.
             */
            /**
             * An Statistics Editor is allowed to retrieve scopes, aggregation-definitions and report-definitions.
             */
            /**
             * An Statistics Editor is allowed to update scopes, aggregation-definitions and report-definitions.
             */
            /**
             * An Statistics Editor is allowed to write statistic-data.
             */
            /**
             * An Statistics Editor is allowed to delete aggregation-definitions and report-definitions.
             */
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:statistics-editor-policy-1', 'escidoc:role-statistics-editor',
'<Policy PolicyId="Statistics-editor-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:create-aggregation-definition info:escidoc/names:aa:1.0:action:create-report-definition info:escidoc/names:aa:1.0:action:create-statistic-data info:escidoc/names:aa:1.0:action:delete-aggregation-definition info:escidoc/names:aa:1.0:action:delete-report-definition info:escidoc/names:aa:1.0:action:retrieve-scope info:escidoc/names:aa:1.0:action:retrieve-aggregation-definition info:escidoc/names:aa:1.0:action:retrieve-report-definition info:escidoc/names:aa:1.0:action:retrieve-report info:escidoc/names:aa:1.0:action:update-scope info:escidoc/names:aa:1.0:action:update-report-definition</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Statistics-editor-policy-rule-0" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:create-aggregation-definition info:escidoc/names:aa:1.0:action:create-report-definition info:escidoc/names:aa:1.0:action:create-statistic-data</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Statistics-editor-policy-rule-1" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-scope info:escidoc/names:aa:1.0:action:retrieve-aggregation-definition info:escidoc/names:aa:1.0:action:retrieve-report-definition info:escidoc/names:aa:1.0:action:retrieve-report</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Statistics-editor-policy-rule-2" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:update-scope info:escidoc/names:aa:1.0:action:update-aggregation-definition info:escidoc/names:aa:1.0:action:update-report-definition</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Statistics-editor-policy-rule-3" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:delete-aggregation-definition info:escidoc/names:aa:1.0:action:delete-report-definition</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
</Policy>');
