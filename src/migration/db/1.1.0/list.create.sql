DROP INDEX list.property_id_path_value;
DROP INDEX list.property_path_value_position;

ALTER TABLE list.property ALTER COLUMN value TYPE VARCHAR(2000);

CREATE INDEX property_id_path_value ON list.property
  USING btree (resource_id, local_path, value);

CREATE INDEX property_path_value_position ON list.property
  USING btree (local_path, value, position);
