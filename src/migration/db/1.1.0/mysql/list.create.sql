DROP INDEX property_id_path_value ON list.property;
DROP INDEX property_path_value_position ON list.property;

UPDATE list.property set value = substring(value from 1 for 300);
ALTER TABLE list.property CHANGE value value VARCHAR(300);

CREATE INDEX id_local_path_position
  USING btree
  ON list.property
  (resource_id(300), local_path(300), position);

CREATE INDEX id_local_path_value
  USING btree
  ON list.property
  (resource_id(300), local_path(300), value);

CREATE INDEX local_path_value_position
  USING btree
  ON list.property
  (local_path(300), value, position);

CREATE INDEX local_path_value_id
  USING btree
  ON list.property
  (local_path(300), value, resource_id(300));
