    /**
     * Role Statistics Reader
     */
INSERT INTO aa.escidoc_role
    (id, role_name, creator_id, creation_date, modified_by_id, last_modification_date)
     VALUES
    ('escidoc:role-statistics-reader', 'Statistics-Reader', 'escidoc:user42', CURRENT_TIMESTAMP, 'escidoc:user42',
    CURRENT_TIMESTAMP);
    
        /** 
         * Role Statistics Reader Scope
         */  
INSERT INTO aa.scope_def 
    (id, role_id, object_type, attribute_id)
     VALUES
    ('escidoc:scope-def-role-statistics-reader', 'escidoc:role-statistics-reader', 'report', 
     'info:escidoc/names:aa:1.0:resource:aggregation-definition.scope');

