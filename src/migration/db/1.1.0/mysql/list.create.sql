DROP INDEX property_id_path_value ON list.property;
DROP INDEX property_path_value_position ON list.property;

ALTER TABLE list.property CHANGE value value VARCHAR(300);

CREATE INDEX property_id_path_value USING btree
  ON list.property (resource_id(300), local_path(300), value);

CREATE INDEX property_path_value_position USING btree
  ON list.property (local_path(300), value, position);
