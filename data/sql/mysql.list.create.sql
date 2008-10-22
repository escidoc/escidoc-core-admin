CREATE SCHEMA IF NOT EXISTS list;

CREATE TABLE IF NOT EXISTS list.container (
  id				TEXT NOT NULL,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id(30))
);

CREATE TABLE IF NOT EXISTS list.context (
  id				TEXT NOT NULL,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id(30))
);

CREATE TABLE IF NOT EXISTS list.item (
  id				TEXT NOT NULL,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id(30))
);

CREATE TABLE IF NOT EXISTS list.ou (
  id				TEXT NOT NULL,
  rest_content			TEXT NOT NULL,
  soap_content			TEXT NOT NULL,
  primary key (id(30))
);

CREATE TABLE IF NOT EXISTS list.filter (
  role_id			TEXT,
  type				TEXT NOT NULL,
  rule				TEXT NOT NULL,
  CONSTRAINT FK_FILTER_ROLE_ID FOREIGN KEY (role_id(30)) REFERENCES aa.escidoc_role(id)
);

CREATE TABLE IF NOT EXISTS list.property (
  resource_id                   TEXT NOT NULL,
  local_path                    TEXT NOT NULL,
  value                         TEXT NOT NULL,
  position			INTEGER NOT NULL
);

CREATE INDEX property_id_path_value USING btree
  ON list.property (resource_id(30), local_path(30), value(30));

CREATE INDEX property_path_value_position USING btree
  ON list.property (local_path(30), value(30), position);
