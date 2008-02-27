   /**
    * FedoraManagementDeviationHandler method mappings
    */
        /**
         * ManagementDeviationHandler mm - export
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-fmdh-export', 'de.escidoc.core.om.service.FedoraManagementDeviationHandler', 'export', 'info:escidoc/names:aa:1.0:action:fmdh-export', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException');

   /**
    * FedoraAccessDeviationHandler method mappings
    */
        /**
         * FedoraAccessDeviationHandler mm - getDatastreamDissemination
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-fadh-export', 'de.escidoc.core.om.service.FedoraAccessDeviationHandler', 'getDatastreamDissemination', 'info:escidoc/names:aa:1.0:action:fadh-get-datastream-dissemination', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException');

   /**
    * FedoraDescribeDeviationHandler method mappings
    */
        /**
         * DescribeDeviationHandler mm - getFedoraDescription
         */
INSERT INTO "aa"."method_mappings" (id, class_name, method_name, action_name, before, single_resource, resource_not_found_exception)
  VALUES ('escidoc:mm-fddh-get-fedora-description', 'de.escidoc.core.om.service.FedoraDescribeDeviationHandler', 'getFedoraDescription', 'info:escidoc/names:aa:1.0:action:fddh-get-fedora-description', 
  true, true, 'de.escidoc.core.common.exceptions.application.notfound.ResourceNotFoundException');

  