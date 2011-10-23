DELETE FROM aa.actions WHERE id='escidoc:action-retrieve-object-refs' AND name='info:escidoc/names:aa:1.0:action:retrieve-object-refs';

UPDATE aa.actions SET id='escidoc:action-retrieve-user-group-grant', name='info:escidoc/names:aa:1.0:action:retrieve-user-group-grant' WHERE id='escidoc:action-retrieve-user-group-grants';

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-get-reindex-status', 'info:escidoc/names:aa:1.0:action:get-reindex-status');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-decrease-reindex-status', 'info:escidoc/names:aa:1.0:action:decrease-reindex-status');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-create-content-relation', 'info:escidoc/names:aa:1.0:action:create-content-relation');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-delete-content-relation', 'info:escidoc/names:aa:1.0:action:delete-content-relation');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-retrieve-content-relation', 'info:escidoc/names:aa:1.0:action:retrieve-content-relation');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-update-content-relation', 'info:escidoc/names:aa:1.0:action:update-content-relation');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-submit-content-relation', 'info:escidoc/names:aa:1.0:action:submit-content-relation');
    
INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-release-content-relation', 'info:escidoc/names:aa:1.0:action:release-content-relation');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-revise-content-relation', 'info:escidoc/names:aa:1.0:action:revise-content-relation');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-withdraw-content-relation', 'info:escidoc/names:aa:1.0:action:withdraw-content-relation');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-lock-content-relation', 'info:escidoc/names:aa:1.0:action:lock-content-relation');

INSERT INTO aa.actions (id, name) VALUES
    ('escidoc:action-unlock-content-relation', 'info:escidoc/names:aa:1.0:action:unlock-content-relation');
