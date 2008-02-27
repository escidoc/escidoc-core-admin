/** 
 * Updates the xml field of the policies of the predefined roles.
 */

UPDATE "aa"."escidoc_policies" SET "xml" = 
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
</Policy>'
WHERE id = 'escidoc:administrator-policy-1';




UPDATE "aa"."escidoc_policies" SET xml =
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
</Policy>' WHERE id = 'escidoc:author-policy-1';

DELETE FROM "aa"."escidoc_policies" WHERE id <> 'escidoc:author-policy-1' AND id like 'escidoc:author-policy%';



UPDATE "aa"."escidoc_policies" SET xml =
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-context info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:retrieve-content info:escidoc/names:aa:1.0:action:retrieve-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-content-model info:escidoc/names:aa:1.0:action:unlock-container info:escidoc/names:aa:1.0:action:unlock-item info:escidoc/names:aa:1.0:action:logout info:escidoc/names:aa:1.0:action:retrieve-user-account info:escidoc/names:aa:1.0:action:retrieve-grant info:escidoc/names:aa:1.0:action:retrieve-object-refs info:escidoc/names:aa:1.0:action:retrieve-objects-filtered info:escidoc/names:aa:1.0:action:retrieve-staging-file info:escidoc/names:aa:1.0:action:retrieve-xml-schema info:escidoc/names:aa:1.0:action:query-semantic-store info:escidoc/names:aa:1.0:action:fmdh-export info:escidoc/names:aa:1.0:action:fadh-get-datastream-dissemination</AttributeValue>
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
  <Rule RuleId="Default-User-policy-rule-12" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-xml-schema</AttributeValue>

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
  <Rule RuleId="Default-User-policy-rule-14" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:fmdh-export info:escidoc/names:aa:1.0:action:fadh-get-datastream-dissemination</AttributeValue>

            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
</Policy>' WHERE id = 'escidoc:default-policy-1';

DELETE FROM "aa"."escidoc_policies" WHERE id<>'escidoc:default-policy-1' AND id like 'escidoc:default-policy-%';








UPDATE "aa"."escidoc_policies" SET xml =
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
</PolicySet>' WHERE id='escidoc:depositor-policy-1';

DELETE FROM "aa"."escidoc_policies" WHERE id<>'escidoc:depositor-policy-1' AND id like 'escidoc:depositor-policy%';





UPDATE "aa"."escidoc_policies" SET xml =
'<Policy PolicyId="Indexer-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">

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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:fmdh-export info:escidoc/names:aa:1.0:action:fadh-get-datastream-dissemination info:escidoc/names:aa:1.0:action:retrieve-content</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Indexer-policy-rule-0" Effect="Permit">

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
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">

      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">

          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:container:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">withdrawn</AttributeValue>
      </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="Indexer-policy-rule-1" Effect="Permit">
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
    <Condition FunctionId="urn:oasis:names:tc:xacml:1.0:function:or">
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">

        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">released</AttributeValue>
      </Apply>
      <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-equal">
        <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">
          <ResourceAttributeDesignator AttributeId="info:escidoc/names:aa:1.0:resource:item:latest-version-status" DataType="http://www.w3.org/2001/XMLSchema#string"/>

        </Apply>
        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">withdrawn</AttributeValue>
      </Apply>
    </Condition>
  </Rule>
  <Rule RuleId="Indexer-policy-rule-2" Effect="Permit">
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
            <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:fmdh-export info:escidoc/names:aa:1.0:action:fadh-get-datastream-dissemination</AttributeValue>

            <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
          </ActionMatch>
        </Action>
      </Actions>
    </Target>
  </Rule>
  <Rule RuleId="Indexer-policy-rule-3" Effect="Permit">
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
</Policy>' WHERE id = 'escidoc:policy-indexer-1';

DELETE FROM "aa"."escidoc_policies" WHERE id <> 'escidoc:policy-indexer-1' AND id like 'escidoc:policy-indexer%';







UPDATE "aa"."escidoc_policies" SET xml =
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
</Policy>' WHERE id = 'escidoc:md-editor-policy-container';

DELETE FROM "aa"."escidoc_policies" WHERE id <> 'escidoc:md-editor-policy-container' AND id like 'escidoc:md-editor-policy%';




UPDATE "aa"."escidoc_policies" SET xml =
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
</Policy>' WHERE id = 'escidoc:moderator-policy-1';

DELETE FROM "aa"."escidoc_policies" WHERE id <> 'escidoc:moderator-policy-1' AND id like 'escidoc:moderator-policy%';





UPDATE "aa"."escidoc_policies" SET xml = 
'<Policy PolicyId="System-Administrator-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-method-mappings info:escidoc/names:aa:1.0:action:check-user-privilege info:escidoc/names:aa:1.0:action:create-role info:escidoc/names:aa:1.0:action:delete-role info:escidoc/names:aa:1.0:action:retrieve-role info:escidoc/names:aa:1.0:action:update-role info:escidoc/names:aa:1.0:action:evaluate info:escidoc/names:aa:1.0:action:find-attribute info:escidoc/names:aa:1.0:action:retrieve-roles info:escidoc/names:aa:1.0:action:create-user-account info:escidoc/names:aa:1.0:action:delete-user-account info:escidoc/names:aa:1.0:action:retrieve-user-account info:escidoc/names:aa:1.0:action:update-user-account info:escidoc/names:aa:1.0:action:activate-user-account info:escidoc/names:aa:1.0:action:deactivate-user-account info:escidoc/names:aa:1.0:action:create-grant info:escidoc/names:aa:1.0:action:retrieve-grant info:escidoc/names:aa:1.0:action:retrieve-current-grants info:escidoc/names:aa:1.0:action:revoke-grant info:escidoc/names:aa:1.0:action:logout info:escidoc/names:aa:1.0:action:create-unsecured-actions info:escidoc/names:aa:1.0:action:delete-unsecured-actions info:escidoc/names:aa:1.0:action:retrieve-unsecured-actions info:escidoc/names:aa:1.0:action:create-metadata-schema info:escidoc/names:aa:1.0:action:delete-metadata-schema info:escidoc/names:aa:1.0:action:retrieve-metadata-schema info:escidoc/names:aa:1.0:action:update-metadata-schema info:escidoc/names:aa:1.0:action:create-container info:escidoc/names:aa:1.0:action:delete-container info:escidoc/names:aa:1.0:action:update-container info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:submit-container info:escidoc/names:aa:1.0:action:release-container info:escidoc/names:aa:1.0:action:revise-container info:escidoc/names:aa:1.0:action:withdraw-container info:escidoc/names:aa:1.0:action:container-move-to-context info:escidoc/names:aa:1.0:action:add-members-to-container info:escidoc/names:aa:1.0:action:remove-members-from-container info:escidoc/names:aa:1.0:action:lock-container info:escidoc/names:aa:1.0:action:unlock-container info:escidoc/names:aa:1.0:action:create-content-model info:escidoc/names:aa:1.0:action:delete-content-model info:escidoc/names:aa:1.0:action:retrieve-content-model info:escidoc/names:aa:1.0:action:update-content-model info:escidoc/names:aa:1.0:action:create-context info:escidoc/names:aa:1.0:action:delete-context info:escidoc/names:aa:1.0:action:retrieve-context info:escidoc/names:aa:1.0:action:update-context info:escidoc/names:aa:1.0:action:close-context info:escidoc/names:aa:1.0:action:open-context info:escidoc/names:aa:1.0:action:create-item info:escidoc/names:aa:1.0:action:delete-item info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:update-item info:escidoc/names:aa:1.0:action:submit-item info:escidoc/names:aa:1.0:action:release-item info:escidoc/names:aa:1.0:action:revise-item info:escidoc/names:aa:1.0:action:withdraw-item info:escidoc/names:aa:1.0:action:retrieve-content info:escidoc/names:aa:1.0:action:item-move-to-context info:escidoc/names:aa:1.0:action:lock-item info:escidoc/names:aa:1.0:action:unlock-item info:escidoc/names:aa:1.0:action:query-semantic-store info:escidoc/names:aa:1.0:action:create-xml-schema info:escidoc/names:aa:1.0:action:delete-xml-schema info:escidoc/names:aa:1.0:action:retrieve-xml-schema info:escidoc/names:aa:1.0:action:update-xml-schema info:escidoc/names:aa:1.0:action:create-organizational-unit info:escidoc/names:aa:1.0:action:delete-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit info:escidoc/names:aa:1.0:action:update-organizational-unit info:escidoc/names:aa:1.0:action:open-organizational-unit info:escidoc/names:aa:1.0:action:close-organizational-unit info:escidoc/names:aa:1.0:action:fmdh-export info:escidoc/names:aa:1.0:action:fadh-get-datastream-dissemination info:escidoc/names:aa:1.0:action:fddh-get-fedora-description info:escidoc/names:aa:1.0:action:create-aggregation-definition info:escidoc/names:aa:1.0:action:delete-aggregation-definition info:escidoc/names:aa:1.0:action:retrieve-aggregation-definition info:escidoc/names:aa:1.0:action:update-aggregation-definition info:escidoc/names:aa:1.0:action:create-report-definition info:escidoc/names:aa:1.0:action:delete-report-definition info:escidoc/names:aa:1.0:action:retrieve-report-definition info:escidoc/names:aa:1.0:action:update-report-definition info:escidoc/names:aa:1.0:action:retrieve-report info:escidoc/names:aa:1.0:action:create-statistic-data info:escidoc/names:aa:1.0:action:create-scope info:escidoc/names:aa:1.0:action:delete-scope info:escidoc/names:aa:1.0:action:retrieve-scope info:escidoc/names:aa:1.0:action:update-scope info:escidoc/names:aa:1.0:action:create-workflow-type info:escidoc/names:aa:1.0:action:delete-workflow-type info:escidoc/names:aa:1.0:action:retrieve-workflow-type info:escidoc/names:aa:1.0:action:update-workflow-type info:escidoc/names:aa:1.0:action:create-workflow-template info:escidoc/names:aa:1.0:action:delete-workflow-template info:escidoc/names:aa:1.0:action:retrieve-workflow-template info:escidoc/names:aa:1.0:action:update-workflow-template info:escidoc/names:aa:1.0:action:create-workflow-definition info:escidoc/names:aa:1.0:action:delete-workflow-definition info:escidoc/names:aa:1.0:action:retrieve-workflow-definition info:escidoc/names:aa:1.0:action:update-workflow-definition info:escidoc/names:aa:1.0:action:create-workflow-instance info:escidoc/names:aa:1.0:action:delete-workflow-instance info:escidoc/names:aa:1.0:action:retrieve-workflow-instance info:escidoc/names:aa:1.0:action:update-workflow-instance info:escidoc/names:aa:1.0:action:create-staging-file info:escidoc/names:aa:1.0:action:retrieve-staging-file</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="System-Administrator-policy-rule-0" Effect="Permit">
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
</Policy>' WHERE id = 'escidoc:policy-system-administrator';





UPDATE "aa"."escidoc_policies" SET xml =
'<Policy PolicyId="System-Inspector-policy" RuleCombiningAlgId="urn:oasis:names:tc:xacml:1.0:rule-combining-algorithm:ordered-permit-overrides">
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">info:escidoc/names:aa:1.0:action:retrieve-role info:escidoc/names:aa:1.0:action:retrieve-roles info:escidoc/names:aa:1.0:action:evaluate info:escidoc/names:aa:1.0:action:retrieve-user-account info:escidoc/names:aa:1.0:action:retrieve-grant info:escidoc/names:aa:1.0:action:retrieve-current-grants info:escidoc/names:aa:1.0:action:logout info:escidoc/names:aa:1.0:action:retrieve-unsecured-actions info:escidoc/names:aa:1.0:action:retrieve-metadata-schema info:escidoc/names:aa:1.0:action:retrieve-container info:escidoc/names:aa:1.0:action:retrieve-content-model info:escidoc/names:aa:1.0:action:retrieve-context info:escidoc/names:aa:1.0:action:retrieve-item info:escidoc/names:aa:1.0:action:retrieve-content info:escidoc/names:aa:1.0:action:query-semantic-store info:escidoc/names:aa:1.0:action:retrieve-xml-schema info:escidoc/names:aa:1.0:action:retrieve-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-children-of-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-parents-of-organizational-unit info:escidoc/names:aa:1.0:action:retrieve-aggregation-definition info:escidoc/names:aa:1.0:action:retrieve-report-definition info:escidoc/names:aa:1.0:action:retrieve-report info:escidoc/names:aa:1.0:action:retrieve-scope info:escidoc/names:aa:1.0:action:retrieve-staging-file</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="System-Inspector-policy-rule-0" Effect="Permit">
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
</Policy>' WHERE id = 'escidoc:policy-system-inspector';
 