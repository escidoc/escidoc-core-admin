DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-container-add-tocs';
DELETE FROM aa.invocation_mappings WHERE id = 'escidoc-im-container-retrieve-tocs-1';

DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-container-add-tocs';
DELETE FROM aa.method_mappings WHERE id = 'escidoc:mm-container-retrieve-tocs';

INSERT INTO aa.method_mappings (id, class_name, method_name, action_name, exec_before, single_resource)
  VALUES ('escidoc:mm-adm-check-database-consistency', 'de.escidoc.core.adm.service.interfaces.AdminHandlerInterface', 'checkDatabaseConsistency', 'info:escidoc/names:aa:1.0:action:get-repository-info',
  true, true);                  

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-adm-check-database-consistency', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'none', 'escidoc:mm-adm-check-database-consistency');
