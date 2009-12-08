CREATE TABLE sm.aggregation_tables ( 
  id VARCHAR(255) unique not null primary key,
  aggregation_definition_id VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  list_index NUMERIC(2,0) NOT NULL,
   CONSTRAINT FK_AGG_DEF FOREIGN KEY (aggregation_definition_id) REFERENCES sm.aggregation_definitions
   ON DELETE CASCADE
);

CREATE TABLE sm.aggregation_table_indexes ( 
  id VARCHAR(255) unique not null primary key,
  aggregation_table_id VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  list_index NUMERIC(2,0) NOT NULL,
   CONSTRAINT FK_AGG_TABLE FOREIGN KEY (aggregation_table_id) REFERENCES sm.aggregation_tables
   ON DELETE CASCADE
);

CREATE TABLE sm.aggregation_table_index_fields ( 
  id VARCHAR(255) unique not null primary key,
  aggregation_table_index_id VARCHAR(255) NOT NULL,
  field VARCHAR(255) NOT NULL,
  list_index NUMERIC(2,0) NOT NULL,
   CONSTRAINT FK_AGG_TABLE_INDEX FOREIGN KEY (aggregation_table_index_id) REFERENCES sm.aggregation_table_indexes
   ON DELETE CASCADE
);

CREATE TABLE sm.aggregation_table_fields ( 
  id VARCHAR(255) unique not null primary key,
  aggregation_table_id VARCHAR(255) NOT NULL,
  field_type_id NUMERIC(2,0) NOT NULL,
  name VARCHAR(255) NOT NULL,
  feed VARCHAR(255),
  xpath TEXT,
  data_type VARCHAR(10),
  reduce_to VARCHAR(255),
  list_index NUMERIC(2,0) NOT NULL,
   CONSTRAINT FK_AGG_TABLE FOREIGN KEY (aggregation_table_id) REFERENCES sm.aggregation_tables
   ON DELETE CASCADE
);

CREATE TABLE sm.aggregation_statistic_data_selectors ( 
  id VARCHAR(255) unique not null primary key,
  aggregation_definition_id VARCHAR(255) NOT NULL,
  selector_type VARCHAR(50) NOT NULL,
  xpath VARCHAR(255) NOT NULL,
  list_index NUMERIC(2,0) NOT NULL,
   CONSTRAINT FK_AGG_DEF FOREIGN KEY (aggregation_definition_id) REFERENCES sm.aggregation_definitions
   ON DELETE CASCADE
);

ALTER TABLE sm.aggregation_definitions ADD COLUMN name VARCHAR (255);
ALTER TABLE sm.aggregation_definitions ADD COLUMN creator_id VARCHAR (255);
ALTER TABLE sm.aggregation_definitions ADD COLUMN creation_date timestamp without time zone;

UPDATE sm.aggregation_definitions set name = xpath_string(xml_data, '/*[local-name()="aggregation-definition"]/*[local-name()="name"]');
UPDATE sm.aggregation_definitions set creator_id = (select user_id from aa.role_grant where role_id = 'escidoc:role-system-administrator' LIMIT 1);
UPDATE sm.aggregation_definitions set creation_date = CURRENT_TIMESTAMP;

UPDATE sm.aggregation_definitions SET name = 'noname' WHERE NAME IS NULL;
ALTER TABLE sm.aggregation_definitions ALTER COLUMN name SET NOT NULL;

CREATE TABLE sm.report_definition_roles ( 
  id VARCHAR(255) unique not null primary key,
  report_definition_id VARCHAR(255) NOT NULL,
  role_id VARCHAR(255) NOT NULL,
  list_index NUMERIC(2,0) NOT NULL,
   CONSTRAINT FK_REPDEF_ID FOREIGN KEY (report_definition_id) REFERENCES sm.report_definitions
   ON DELETE CASCADE
);

ALTER TABLE sm.report_definitions ADD COLUMN sql text;
ALTER TABLE sm.report_definitions ADD COLUMN creator_id VARCHAR (255);
ALTER TABLE sm.report_definitions ADD COLUMN creation_date timestamp without time zone;
ALTER TABLE sm.report_definitions ADD COLUMN modified_by_id VARCHAR (255);
ALTER TABLE sm.report_definitions ADD COLUMN last_modification_date timestamp without time zone;

UPDATE sm.report_definitions set sql = replace(replace(replace(xpath_string(xml_data, '/*[local-name()="report-definition"]/*[local-name()="sql"]'), E'\n', ' '), E'\t', ' '), E'\r', ' ');

UPDATE sm.report_definitions set creator_id = (select user_id from aa.role_grant where role_id = 'escidoc:role-system-administrator' LIMIT 1);
UPDATE sm.report_definitions set creation_date = CURRENT_TIMESTAMP;
UPDATE sm.report_definitions set modified_by_id = (select user_id from aa.role_grant where role_id = 'escidoc:role-system-administrator' LIMIT 1);
UPDATE sm.report_definitions set last_modification_date = CURRENT_TIMESTAMP;

UPDATE sm.report_definitions SET sql = 'nosql' WHERE SQL IS NULL;
ALTER TABLE sm.report_definitions ALTER COLUMN sql SET NOT NULL;

ALTER TABLE sm.scopes ADD COLUMN name VARCHAR (255);
ALTER TABLE sm.scopes ADD COLUMN scope_type VARCHAR (20);
ALTER TABLE sm.scopes ADD COLUMN creator_id VARCHAR (255);
ALTER TABLE sm.scopes ADD COLUMN creation_date timestamp without time zone;
ALTER TABLE sm.scopes ADD COLUMN modified_by_id VARCHAR (255);
ALTER TABLE sm.scopes ADD COLUMN last_modification_date timestamp without time zone;

UPDATE sm.scopes set name = xpath_string(xml_data, '/*[local-name()="scope"]/*[local-name()="name"]');
UPDATE sm.scopes set scope_type = xpath_string(xml_data, '/*[local-name()="scope"]/*[local-name()="type"]');
UPDATE sm.scopes set creator_id = (select user_id from aa.role_grant where role_id = 'escidoc:role-system-administrator' LIMIT 1);
UPDATE sm.scopes set creation_date = CURRENT_TIMESTAMP;
UPDATE sm.scopes set modified_by_id = (select user_id from aa.role_grant where role_id = 'escidoc:role-system-administrator' LIMIT 1);
UPDATE sm.scopes set last_modification_date = CURRENT_TIMESTAMP;

UPDATE sm.scopes SET name = 'noname' WHERE NAME IS NULL;
UPDATE sm.scopes SET scope_type = 'normal' WHERE scope_type IS NULL;
ALTER TABLE sm.scopes ALTER COLUMN name SET NOT NULL;
ALTER TABLE sm.scopes ALTER COLUMN scope_type SET NOT NULL;
ALTER TABLE sm.scopes DROP COLUMN xml_data;

