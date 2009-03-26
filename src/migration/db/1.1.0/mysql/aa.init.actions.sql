DELETE FROM aa.actions WHERE id='escidoc:action-retrieve-current-grants';

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-create-user-group', 'info:escidoc/names:aa:1.0:action:create-user-group');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-delete-user-group', 'info:escidoc/names:aa:1.0:action:delete-user-group');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-retrieve-user-group', 'info:escidoc/names:aa:1.0:action:retrieve-user-group');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-update-user-group', 'info:escidoc/names:aa:1.0:action:update-user-group');
    
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-activate-user-group', 'info:escidoc/names:aa:1.0:action:activate-user-group');
    
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-deactivate-user-group', 'info:escidoc/names:aa:1.0:action:deactivate-user-group');

DELETE FROM aa.actions WHERE id='escidoc:action-revoke-grants';

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-add-user-group-selectors', 'info:escidoc/names:aa:1.0:action:add-user-group-selectors');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-remove-user-group-selectors', 'info:escidoc/names:aa:1.0:action:remove-user-group-selectors');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-create-user-group-grant', 'info:escidoc/names:aa:1.0:action:create-user-group-grant');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-retrieve-user-group-grants', 'info:escidoc/names:aa:1.0:action:retrieve-user-group-grants');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-revoke-user-group-grant', 'info:escidoc/names:aa:1.0:action:revoke-user-group-grant');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-delete-objects', 'info:escidoc/names:aa:1.0:action:delete-objects');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-recache', 'info:escidoc/names:aa:1.0:action:recache');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-reindex', 'info:escidoc/names:aa:1.0:action:reindex');

-- OM set-definition
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:create-set-definition', 'info:escidoc/names:aa:1.0:action:create-set-definition');
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:update-set-definition', 'info:escidoc/names:aa:1.0:action:update-set-definition');
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:retrieve-set-definition', 'info:escidoc/names:aa:1.0:action:retrieve-set-definition');
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:delete-set-definition', 'info:escidoc/names:aa:1.0:action:delete-set-definition');

