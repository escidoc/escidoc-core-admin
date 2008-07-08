-- ##########################
-- # container filter rules #
-- ##########################
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-system-administrator', 'container', 'id is not null');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-system-inspector',     'container', 'id is not null');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-administrator',        'container', 'context_id in (select object_id from aa.role_grant where user_id = ''{0}'')');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-moderator',            'container', 'context_id in (select object_id from aa.role_grant where user_id = ''{0}'')');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-depositor',            'container', 'context_id in (select object_id from aa.role_grant where user_id = ''{0}'') and created_by_id = ''{0}''');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-md-editor',            'container', 'context_id in (select object_id from aa.role_grant where user_id = ''{0}'') and public_status = ''submitted''');
INSERT INTO list.filter (role_id, type, rule) VALUES (null,                                'container', 'public_status = ''released''');

-- ########################
-- # context filter rules #
-- ########################
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-system-administrator', 'context', 'id is not null');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-system-inspector',     'context', 'id is not null');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-administrator',        'context', 'id in (select object_id from aa.role_grant where user_id = ''{0}'')');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-moderator',            'context', 'id in (select object_id from aa.role_grant where user_id = ''{0}'')');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-depositor',            'context', 'id in (select object_id from aa.role_grant where user_id = ''{0}'')');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-md-editor',            'context', 'id in (select object_id from aa.role_grant where user_id = ''{0}'')');
INSERT INTO list.filter (role_id, type, rule) VALUES (null,                                'context', 'public_status = ''opened''');

-- #####################
-- # item filter rules #
-- #####################
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-system-administrator', 'item', 'id is not null');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-system-inspector',     'item', 'id is not null');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-administrator',        'item', 'context_id in (select object_id from aa.role_grant where user_id = ''{0}'')');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-moderator',            'item', 'context_id in (select object_id from aa.role_grant where user_id = ''{0}'')');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-depositor',            'item', 'context_id in (select object_id from aa.role_grant where user_id = ''{0}'') and created_by_id = ''{0}''');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-md-editor',            'item', 'context_id in (select object_id from aa.role_grant where user_id = ''{0}'') and public_status = ''submitted''');
INSERT INTO list.filter (role_id, type, rule) VALUES (null,                                'item', 'public_status = ''released''');

-- ###################
-- # OU filter rules #
-- ###################
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-system-administrator', 'ou', 'id is not null');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-system-inspector',     'ou', 'id is not null');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-administrator',        'ou', 'public_status = ''opened''');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-moderator',            'ou', 'public_status = ''opened''');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-depositor',            'ou', 'public_status = ''opened''');
INSERT INTO list.filter (role_id, type, rule) VALUES ('escidoc:role-md-editor',            'ou', 'public_status = ''opened''');
INSERT INTO list.filter (role_id, type, rule) VALUES (null,                                'ou', 'public_status = ''opened''');
