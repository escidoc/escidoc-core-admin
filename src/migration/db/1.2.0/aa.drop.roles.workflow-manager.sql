DELETE FROM list.filter WHERE role_id = 'escidoc:role-workflow-manager';

DELETE FROM aa.escidoc_policies WHERE role_id = 'escidoc:role-workflow-manager';

DELETE FROM aa.role_grant WHERE role_id = 'escidoc:role-workflow-manager';

DELETE FROM aa.scope_def WHERE role_id = 'escidoc:role-workflow-manager';

DELETE FROM aa.escidoc_role WHERE id = 'escidoc:role-workflow-manager';
