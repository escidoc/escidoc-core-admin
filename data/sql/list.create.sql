CREATE SCHEMA list;

CREATE TABLE list.container (
  id				TEXT NOT NULL,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id)
);

CREATE TABLE list.context (
  id				TEXT NOT NULL,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id)
);

CREATE TABLE list.item (
  id				TEXT NOT NULL,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id)
);

CREATE TABLE list.ou (
  id				TEXT NOT NULL,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id)
);

CREATE TABLE list.filter (
  role_id			TEXT,
  type				TEXT NOT NULL,
  rule				TEXT NOT NULL,
  CONSTRAINT FK_FILTER_ROLE_ID FOREIGN KEY (role_id) REFERENCES aa.escidoc_role(id)
);

CREATE TABLE list.property (
  resource_id                   TEXT NOT NULL,
  local_path                    TEXT NOT NULL,
  value                         TEXT NOT NULL,
  position			INTEGER NOT NULL
);

CREATE INDEX property_id_path_value ON list.property
  USING btree (resource_id, local_path, substring(value from 1 for 2000));

CREATE INDEX property_path_value_position ON list.property
  USING btree (local_path, substring(value from 1 for 2000), position);
