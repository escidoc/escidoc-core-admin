ALTER TABLE aa.scope_def ADD COLUMN attribute_object_type VARCHAR (255);

UPDATE aa.scope_def SET attribute_object_type = 'context' 
    WHERE attribute_id LIKE '%context' 
    OR attribute_id LIKE '%context-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'content-model' 
    WHERE attribute_id LIKE '%content-model' 
    OR attribute_id LIKE '%content-model-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'container' 
    WHERE attribute_id LIKE '%container' 
    OR attribute_id LIKE '%container-id'
    OR attribute_id LIKE '%hierarchical-containers';
    
UPDATE aa.scope_def SET attribute_object_type = 'item' 
    WHERE attribute_id LIKE '%item' 
    OR attribute_id LIKE '%item-id';

UPDATE aa.scope_def SET attribute_object_type = 'component' 
    WHERE attribute_id LIKE '%component' 
    OR attribute_id LIKE '%component-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'content-relation' 
    WHERE attribute_id LIKE '%content-relation' 
    OR attribute_id LIKE '%content-relation-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'organizational-unit' 
    WHERE attribute_id LIKE '%organizational-unit' 
    OR attribute_id LIKE '%organizational-unit-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'scope' 
    WHERE attribute_id LIKE '%scope' 
    OR attribute_id LIKE '%scope-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'user-account' 
    WHERE attribute_id LIKE '%user-account' 
    OR attribute_id LIKE '%user-account-id';
    
UPDATE aa.scope_def SET attribute_object_type = 'user-group' 
    WHERE attribute_id LIKE '%user-group' 
    OR attribute_id LIKE '%user-group-id';
    
UPDATE aa.scope_def SET attribute_object_type = object_type 
    WHERE attribute_id LIKE '%resource-id';
    

