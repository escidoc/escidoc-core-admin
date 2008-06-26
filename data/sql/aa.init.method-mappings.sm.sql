    /*
     * SM method mappings
     */
        /**
         * AggregationDefinitionHandler mm - create
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-aggregation-definition-create', 'de.escidoc.core.sm.service.AggregationDefinitionHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-aggregation-definition', true, true);

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-aggregation-definition-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'aggregation-definition', 'escidoc:mm-aggregation-definition-create');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-aggregation-definition-create-2', 'info:escidoc/names:aa:1.0:resource:aggregation-definition:scope-new', 'extractObjid:/aggregation-definition/scope/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-aggregation-definition-create');

        /**
         * AggregationDefinitionHandler mm - delete
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-aggregation-definition-delete', 'de.escidoc.core.sm.service.AggregationDefinitionHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-aggregation-definition', true, true, 'de.escidoc.core.common.exceptions.application.notfound.AggregationDefinitionNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-aggregation-definition-delete-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-aggregation-definition-delete');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-aggregation-definition-delete-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'aggregation-definition', 'escidoc:mm-aggregation-definition-delete');

        /**
         * AggregationDefinitionHandler mm - retrieve
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-aggregation-definition-retrieve', 'de.escidoc.core.sm.service.AggregationDefinitionHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-aggregation-definition', true, true, 'de.escidoc.core.common.exceptions.application.notfound.AggregationDefinitionNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-aggregation-definition-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-aggregation-definition-retrieve');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-aggregation-definition-retrieve-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'aggregation-definition', 'escidoc:mm-aggregation-definition-retrieve');


INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-aggregation-definition-retrieve-list', 'de.escidoc.core.sm.service.AggregationDefinitionHandler', 'retrieveAggregationDefinitions', 'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

        /**
         * ReportDefinitionHandler mm - create
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-report-definition-create', 'de.escidoc.core.sm.service.ReportDefinitionHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-report-definition', true, true);

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-report-definition-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'report-definition', 'escidoc:mm-report-definition-create');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-report-definition-create-2', 'info:escidoc/names:aa:1.0:resource:report-definition:scope-new', 'extractObjid:/report-definition/scope/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-report-definition-create');

        /**
         * ReportDefinitionHandler mm - delete
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-report-definition-delete', 'de.escidoc.core.sm.service.ReportDefinitionHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-report-definition', true, true, 'de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-report-definition-delete-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-report-definition-delete');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-report-definition-delete-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'report-definition', 'escidoc:mm-report-definition-delete');

        /**
         * ReportDefinitionHandler mm - retrieve
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-report-definition-retrieve', 'de.escidoc.core.sm.service.ReportDefinitionHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-report-definition', true, true, 'de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-report-definition-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-report-definition-retrieve');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-report-definition-retrieve-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'report-definition', 'escidoc:mm-report-definition-retrieve');

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-report-definition-retrieve-list', 'de.escidoc.core.sm.service.ReportDefinitionHandler', 'retrieveReportDefinitions', 'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

        /**
         * ReportDefinitionHandler mm - update
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-report-definition-update', 'de.escidoc.core.sm.service.ReportDefinitionHandler', 'update', 'info:escidoc/names:aa:1.0:action:update-report-definition', true, true, 'de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-report-definition-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-report-definition-update');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-report-definition-update-2', 'info:escidoc/names:aa:1.0:resource:report-definition:scope-new', 'extractObjid:/report-definition/scope/@objid', 1, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-report-definition-update');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-report-definition-update-3', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'report-definition', 'escidoc:mm-report-definition-update');

          
        /**
         * ReportHandler mm - retrieve
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-report-retrieve', 'de.escidoc.core.sm.service.ReportHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-report', true, true, 'de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-report-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', 'extractObjid:report-parameters/report-definition/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-report-retrieve');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-reportretrieve-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'report', 'escidoc:mm-report-retrieve');
          
        /**
         * StatisticDataHandler mm - create
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-statistic-data-create', 'de.escidoc.core.sm.service.StatisticDataHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-statistic-data', true, true);


INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-statistic-data-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'statistic-data', 'escidoc:mm-statistic-data-create');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-statistic-data-create-2', 'info:escidoc/names:aa:1.0:resource:statistic-data:scope-new', 'extractObjid:/statistic-record/scope/@objid', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 2, false, '', 'escidoc:mm-statistic-data-create');

        /**
         * ScopeHandler mm - create
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-scope-create', 'de.escidoc.core.sm.service.ScopeHandler', 'create', 'info:escidoc/names:aa:1.0:action:create-scope', true, true);

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-scope-create-1', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'scope', 'escidoc:mm-scope-create');

        /**
         * ScopeHandler mm - delete
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-scope-delete', 'de.escidoc.core.sm.service.ScopeHandler', 'delete', 'info:escidoc/names:aa:1.0:action:delete-scope', true, true, 'de.escidoc.core.common.exceptions.application.notfound.ScopeNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-scope-delete-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-scope-delete');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-scope-delete-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'scope', 'escidoc:mm-scope-delete');

        /**
         * ScopeHandler mm - retrieve
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-scope-retrieve', 'de.escidoc.core.sm.service.ScopeHandler', 'retrieve', 'info:escidoc/names:aa:1.0:action:retrieve-scope', true, true, 'de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-scope-retrieve-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-scope-retrieve');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-scope-retrieve-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'scope', 'escidoc:mm-scope-retrieve');
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-scope-retrieve-list', 'de.escidoc.core.sm.service.ScopeHandler', 'retrieveScopes', 'info:escidoc/names:aa:1.0:action:retrieve-objects-filtered', false, true);

        /**
         * ScopeHandler mm - update
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-scope-update', 'de.escidoc.core.sm.service.ScopeHandler', 'update', 'info:escidoc/names:aa:1.0:action:update-scope', true, true, 'de.escidoc.core.common.exceptions.application.notfound.ReportDefinitionNotFoundException');

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-scope-update-1', 'urn:oasis:names:tc:xacml:1.0:resource:resource-id', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 0, false, '', 'escidoc:mm-scope-update');
INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-scope-update-2', 'info:escidoc/names:aa:1.0:resource:object-type', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'scope', 'escidoc:mm-scope-update');


          