    /**
     * Role WorkflowManager
     */
  
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-workflow-manager', 'WorkflowManager', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role WorkflowManager Scope
         */
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:rlc-scope-def-workflow-manager', 'escidoc:role-workflow-manager', 'context', 
     'info:escidoc/names:aa:1.0:resource:context-id');
