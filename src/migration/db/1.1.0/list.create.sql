DROP INDEX list.property_id_path_value;
DROP INDEX list.property_path_value_position;

ALTER TABLE list.property ALTER COLUMN value TYPE VARCHAR(2000);

DROP INDEX list.property_id_path_value;
DROP INDEX list.property_path_value_position;

CREATE INDEX id_local_path_position
  ON list.property
  USING btree
  (resource_id, local_path, "position");

CREATE INDEX id_local_path_context_id
  ON list.property
  USING btree
  (resource_id, local_path, value)
  WHERE local_path = '/properties/context/id'::text;

CREATE INDEX id_local_path_value
  ON list.property
  USING btree
  (resource_id, local_path, value);

CREATE INDEX local_path_value_position
  ON list.property
  USING btree
  (local_path, value, "position");

CREATE INDEX local_path_value_id
  ON list.property
  USING btree
  (local_path, value, resource_id);
