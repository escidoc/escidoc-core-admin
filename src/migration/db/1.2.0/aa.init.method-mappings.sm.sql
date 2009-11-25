UPDATE aa.invocation_mappings SET attribute_id='urn:oasis:names:tc:xacml:1.0:resource:resource-id', mapping_type=0, value='' WHERE id='escidoc-im-preprocessing-preprocess-1';

UPDATE aa.invocation_mappings SET value='aggregation-definition' WHERE id='escidoc-im-preprocessing-preprocess-2';

INSERT INTO aa.invocation_mappings (id, attribute_id, path, position, attribute_type, mapping_type, multi_value, value, method_mapping)
  VALUES ('escidoc-im-preprocessing-preprocess-3', 'info:escidoc/names:aa:1.0:resource:object-type-new', '', 0, 
          'http://www.w3.org/2001/XMLSchema#string', 3, false, 'aggregation-definition', 'escidoc:mm-preprocessing-preprocess');
