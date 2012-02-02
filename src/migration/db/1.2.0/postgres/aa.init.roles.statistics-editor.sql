UPDATE aa.escidoc_policies SET xml=
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
          <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">
                                    info:escidoc/names:aa:1.0:action:create-aggregation-definition 
                                    info:escidoc/names:aa:1.0:action:create-report-definition 
                                    info:escidoc/names:aa:1.0:action:create-statistic-data 
                                    info:escidoc/names:aa:1.0:action:delete-aggregation-definition 
                                    info:escidoc/names:aa:1.0:action:delete-report-definition 
                                    info:escidoc/names:aa:1.0:action:retrieve-scope 
                                    info:escidoc/names:aa:1.0:action:retrieve-aggregation-definition 
                                    info:escidoc/names:aa:1.0:action:retrieve-report-definition 
                                    info:escidoc/names:aa:1.0:action:update-scope 
                                    info:escidoc/names:aa:1.0:action:update-report-definition 
                                    info:escidoc/names:aa:1.0:action:preprocess-statistics</AttributeValue>
          <ActionAttributeDesignator AttributeId="urn:oasis:names:tc:xacml:1.0:action:action-id" DataType="http://www.w3.org/2001/XMLSchema#string"/>
        </ActionMatch>
      </Action>
    </Actions>
  </Target>
  <Rule RuleId="Statistics-Editor-policy-rule-0" Effect="Permit">
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
WHERE id='escidoc:statistics-editor-policy-1';
