CREATE SCHEMA list;

CREATE TABLE list.container (
  id				TEXT NOT NULL,
  content_model_id		TEXT,
  content_model_title		TEXT,
  context_id			TEXT,
  context_title			TEXT,
  created_by_id			TEXT,
  created_by_title		TEXT,
  creation_date			TIMESTAMP,
  description			TEXT,
  last_modification_date	TIMESTAMP,
  lock_date			TIMESTAMP,
  lock_owner			TEXT,
  lock_status			TEXT,
  modified_by_id		TEXT,
  modified_by_title		TEXT,
  pid				TEXT,
  public_status			TEXT,
  title				TEXT,
  version_number        	TEXT,
  version_status		TEXT,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id),
  CONSTRAINT FK_CONTAINER_CREATOR_ID FOREIGN KEY (created_by_id) REFERENCES aa.user_account(id),
  CONSTRAINT FK_CONTAINER_MODIFIER_ID FOREIGN KEY (modified_by_id) REFERENCES aa.user_account(id)
);

CREATE TABLE list.context (
  id				TEXT NOT NULL,
  created_by_id			TEXT,
  created_by_title		TEXT,
  creation_date			TIMESTAMP,
  description			TEXT,
  last_modification_date	TIMESTAMP,
  lock_date			TIMESTAMP,
  lock_owner			TEXT,
  lock_status			TEXT,
  modified_by_id		TEXT,
  modified_by_title		TEXT,
  ou				TEXT,
  public_status			TEXT,
  title				TEXT,
  type				TEXT,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id),
  CONSTRAINT FK_CONTEXT_CREATOR_ID FOREIGN KEY (created_by_id) REFERENCES aa.user_account(id),
  CONSTRAINT FK_CONTEXT_MODIFIER_ID FOREIGN KEY (modified_by_id) REFERENCES aa.user_account(id)
);

CREATE TABLE list.item (
  id				TEXT NOT NULL,
  content_model_id		TEXT,
  content_model_title		TEXT,
  context_id			TEXT,
  context_title			TEXT,
  created_by_id			TEXT,
  created_by_title		TEXT,
  creation_date			TIMESTAMP,
  description			TEXT,
  last_modification_date	TIMESTAMP,
  lock_date			TIMESTAMP,
  lock_owner			TEXT,
  lock_status			TEXT,
  modified_by_id		TEXT,
  modified_by_title		TEXT,
  pid				TEXT,
  public_status			TEXT,
  title				TEXT,
  version_number        	TEXT,
  version_status		TEXT,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id),
  CONSTRAINT FK_ITEM_CREATOR_ID FOREIGN KEY (created_by_id) REFERENCES aa.user_account(id),
  CONSTRAINT FK_ITEM_MODIFIER_ID FOREIGN KEY (modified_by_id) REFERENCES aa.user_account(id)
);

CREATE TABLE list.member (
  member			TEXT NOT NULL,
  parent			TEXT NOT NULL,
  primary key (member, parent)
);

CREATE TABLE list.ou (
  id				TEXT NOT NULL,
  created_by_id			TEXT,
  created_by_title		TEXT,
  creation_date			TIMESTAMP,
  description			TEXT,
  last_modification_date	TIMESTAMP,
  lock_date			TIMESTAMP,
  lock_owner			TEXT,
  lock_status			TEXT,
  modified_by_id		TEXT,
  modified_by_title		TEXT,
  public_status			TEXT,
  title				TEXT,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id),
  CONSTRAINT FK_OU_CREATOR_ID FOREIGN KEY (created_by_id) REFERENCES aa.user_account(id),
  CONSTRAINT FK_OU_MODIFIER_ID FOREIGN KEY (modified_by_id) REFERENCES aa.user_account(id)
);

CREATE TABLE list.filter (
  role_id			TEXT,
  type				TEXT NOT NULL,
  rule				TEXT NOT NULL,
  CONSTRAINT FK_FILTER_ROLE_ID FOREIGN KEY (role_id) REFERENCES aa.escidoc_role(id)
);
