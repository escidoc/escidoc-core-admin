   /**
    * Adminhandler method mappings
    */

        /**
         * DeleteObjects
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-adm-delete-objects', 'de.escidoc.core.adm.service.AdminHandler', 'deleteObjects', 'info:escidoc/names:aa:1.0:action:delete-objects',
  true, true);

        /**
         * Recache
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-adm-recache', 'de.escidoc.core.adm.service.AdminHandler', 'recache', 'info:escidoc/names:aa:1.0:action:recache', 
  true, true);

        /**
         * Reindex
         */
INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-adm-reindex', 'de.escidoc.core.adm.service.AdminHandler', 'reindex', 'info:escidoc/names:aa:1.0:action:reindex',
  true, true);
