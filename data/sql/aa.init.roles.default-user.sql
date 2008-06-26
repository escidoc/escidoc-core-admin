/**
 * Default role encapsulating the default policies.
 */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-default-user', 'Default-User', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
    

    /**
     * Default policies.
     */
        /**
         * Every user is allowed to retrieve container versions in version-status "released". 
         * The version.status is needed as old versions may be retrieved, too.
         */
        
        /**
         * Every user is allowed to retrieve contexts in public-status "opened"
         */
        /**
         * Every user is allowed to retrieve item versions in version-status "released". 
         */
        /**
         * Every user is allowed to retrieve binary content of an item version's component
         * if the item has not been withdrawn, the item version is in state "released", the component is in state "valid",
         *  and if the component's visibility is "public"
         */
        /**
         * Every user is allowed to retrieve organizational-units in public-status "opened"
         * and also the children and parents of these organizational-units.
         */
        /**
         * Every user is allowed to retrieve content models.
         */
        /**
         * Every user is allowed to unlock container that she/he has created.
         */
        /**
         * Every user is allowed to unlock items that she/he has locked.
         */
        /**
         * Every user is allowed to logout.
         */
        /**
         * Every user is allowed to retrieve her/his own user account
         * and to retrieve grants owned by her/his own user-account
         */
        /**
         * Every user is allowed to retrieve list of object-refs and 
         * to retrieve list of objects, as the latter is filtered during 
         * the method call.
         */
        /**
         * Every user is allowed to download a staging file. 
         * This is needed for anonymous access by fedora.
         */
        /**
         * Every user is allowed to query the semantic store if she/he is 
         * authenticated.
         */
       
INSERT INTO aa.escidoc_policies
  (id, role_id, xml)
     VALUES
  ('escidoc:default-policy-1', 'escidoc:role-default-user', 
   '<Policy PolicyId="Default-User-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">

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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-context info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:retrieve-content info:escidoc/names:aa:1.0:action:retrieve-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-content-model info:escidoc/names:aa:1.0:action:unlock-container info:escidoc/names:aa:1.0:action:unlock-item info:escidoc/names:aa:1.0:action:logout info:escidoc/names:aa:1.0:action:retrieve-user-account info:escidoc/names:aa:1.0:action:retrieve-grant info:escidoc/names:aa:1.0:action:retrieve-object-refs info:escidoc/names:aa:1.0:action:retrieve-objects-filtered info:escidoc/names:aa:1.0:action:retrieve-staging-file info:escidoc/names:aa:1.0:action:query-semantic-store info:escidoc/names:aa:1.0:action:fmdh-export info:escidoc/names:aa:1.0:action:fadh-get-datastream-dissemination</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Default-User-policy-rule-0" Effect="Permit">

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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-container</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">

      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>
      <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
    </Condition>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-1" Effect="Permit">
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

            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-context</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">

        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:context:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>
      <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">opened</AttributeValue>
    </Condition>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-2" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-item</AttributeValue>

            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>

      <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
    </Condition>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-3" Effect="Permit">
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
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:and">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
            <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>

          </Apply>
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">withdrawn</AttributeValue>
        </Apply>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:component:valid-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>

        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">valid</AttributeValue>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:component:visibility" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">public</AttributeValue>
      </Apply>

      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
      </Apply>
    </Condition>
  </Rule>

  <Rule RuleId="Default-User-policy-rule-4" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>

    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
        <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:organizational-unit:public-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>
      <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">opened</AttributeValue>
    </Condition>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-5" Effect="Permit">

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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-content-model</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>

  <Rule RuleId="Default-User-policy-rule-6" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:unlock-container</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>

    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
        <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>
      <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:lock-owner" DataType="http://www.w3.org/2001/XMLSchema#string"/>
    </Condition>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-7" Effect="Permit">
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

            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:unlock-item</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">

        <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>
      <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:lock-owner" DataType="http://www.w3.org/2001/XMLSchema#string"/>
    </Condition>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-8" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:logout</AttributeValue>

            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-9" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-user-account info:escidoc/names:aa:1.0:action:retrieve-grant</AttributeValue>

            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-is-in">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>

        <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:handle" DataType="http://www.w3.org/2001/XMLSchema#string"/>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:resource:resource-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="info:escidoc/names:aa:1.0:subject:login-name" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>

      </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-10" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-object-refs info:escidoc/names:aa:1.0:action:retrieve-objects-filtered</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>

        </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-11" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-staging-file</AttributeValue>
            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Default-User-policy-rule-13" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:query-semantic-store</AttributeValue>

            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:not">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <SubjectAttributeDesignator SubjectCategory="urn:oasis:names:tc:xacml:1.0:subject-category:access-subject" AttributeId="urn:oasis:names:tc:xacml:1.0:subject:subject-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>

        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string"></AttributeValue>
      </Apply>
    </Condition>
  </Rule>
</Policy>');
    