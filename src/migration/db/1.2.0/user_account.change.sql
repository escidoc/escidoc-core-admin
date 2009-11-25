INSERT INTO aa.user_attribute (id, user_id, name, value,internal)
SELECT user_account_id || '_ou' || list_index, user_account_id, 'o', ou_id, 'TRUE' FROM aa.user_account_ous WHERE ou_id IS NOT NULL;

INSERT INTO aa.user_attribute (id, user_id, name, value,internal)
SELECT id || '_email', id, 'email', email, 'TRUE' FROM aa.user_account WHERE email IS NOT NULL;

ALTER TABLE aa.user_account DROP COLUMN email;

ALTER TABLE aa.user_account DROP COLUMN person_ref;

DROP TABLE aa.user_account_ous;