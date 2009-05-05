CREATE INDEX user_ous_ou_id_idx ON aa.user_account_ous (ou_id);

CREATE TABLE aa.user_group (
  id VARCHAR(255) NOT NULL,
  label VARCHAR(255) NOT NULL UNIQUE,
  active BOOLEAN,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  type VARCHAR(255),
  email VARCHAR(255),
  creator_id VARCHAR(255),
  creation_date TIMESTAMP,
  modified_by_id VARCHAR(255),
  last_modification_date TIMESTAMP,
  primary key (id),
  CONSTRAINT FK_CREATOR FOREIGN KEY (creator_id) REFERENCES aa.user_account (id),
  CONSTRAINT FK_MODIFIED_BY FOREIGN KEY (modified_by_id) REFERENCES aa.user_account (id)
);

CREATE TABLE aa.user_group_member (
  id VARCHAR(255) NOT NULL,
  user_group_id VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(255) NOT NULL,
  value VARCHAR(255) NOT NULL,
  primary key (id),
  CONSTRAINT FK_GROUP_ID FOREIGN KEY (user_group_id) REFERENCES aa.user_group (id)
);

CREATE INDEX group_member_name_value_idx ON aa.user_group_member (type, name, value);

ALTER TABLE aa.role_grant ALTER COLUMN user_id DROP NOT NULL;
ALTER TABLE aa.role_grant ADD COLUMN group_id VARCHAR(255);
ALTER TABLE aa.role_grant DROP CONSTRAINT FK_GRANT;
ALTER TABLE aa.role_grant ADD CONSTRAINT FK_GRANT_USER FOREIGN KEY (user_id) REFERENCES aa.user_account (id);
ALTER TABLE aa.role_grant ADD CONSTRAINT FK_GRANT_GROUP FOREIGN KEY (group_id) REFERENCES aa.user_group (id);

CREATE INDEX group_role_grant_idx ON aa.role_grant (group_id, revocation_date);
CREATE INDEX user_role_role_grant_idx ON aa.role_grant (user_id, role_id);
CREATE INDEX group_role_role_grant_idx ON aa.role_grant (group_id, role_id);

CREATE TABLE aa.user_preference (
  id VARCHAR(255) NOT NULL,
  user_id VARCHAR(255),
  name VARCHAR(255),
  value VARCHAR(255),
  primary key (id),
  CONSTRAINT FK_PREFERENCE_USER FOREIGN KEY (user_id) REFERENCES aa.user_account (id)
);

CREATE TABLE aa.user_attribute (
  id VARCHAR(255) NOT NULL,
  user_id VARCHAR(255),
  name VARCHAR(255),
  value VARCHAR(255),
  internal BOOLEAN,
  primary key (id),
  CONSTRAINT FK_ATTRIBUTE_USER FOREIGN KEY (user_id) REFERENCES aa.user_account (id)
);
