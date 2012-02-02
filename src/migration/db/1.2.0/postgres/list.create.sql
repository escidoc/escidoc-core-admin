CREATE TABLE list.content_relation (
  id                            TEXT NOT NULL,
  rest_content                  TEXT NOT NULL,
  soap_content                  TEXT NOT NULL,
  primary key (id)
);

DROP INDEX list.id_local_path_position;
DROP INDEX list.id_local_path_context_id;
DROP INDEX list.id_local_path_value;
DROP INDEX list.local_path_value_position;
DROP INDEX list.local_path_value_id;

CREATE INDEX id_path_contentmodelid_index
  ON list.property
  USING btree
  (resource_id, local_path, value)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/properties/content-model/id'::text;

CREATE INDEX id_path_position
  ON list.property
  USING btree
  (resource_id, local_path, "position")
TABLESPACE @escidoc.database.tablespace.list@;

CREATE INDEX local_path_public_status_value_index
  ON list.property
  USING btree
  (local_path, value)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/properties/public-status'::text;

CREATE INDEX local_path_version_status_value_index
  ON list.property
  USING btree
  (local_path, value)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/properties/version/status'::text;

CREATE INDEX path_contentmodeltitle_value_index
  ON list.property
  USING btree
  (local_path, value)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/properties/content-model/title'::text;

CREATE INDEX path_contextid_value_index
  ON list.property
  USING btree
  (local_path, value)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/properties/context/id'::text;

CREATE INDEX path_createdby_value_index
  ON list.property
  USING btree
  (local_path, value)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/properties/created-by/id'::text;

CREATE INDEX path_id_position
  ON list.property
  USING btree
  (local_path, resource_id, "position")
TABLESPACE @escidoc.database.tablespace.list@;

CREATE INDEX path_parents_value_index
  ON list.property
  USING btree
  (local_path, value, resource_id)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/parents/parent/id'::text;

CREATE INDEX path_structmap_container_index
  ON list.property
  USING btree
  (local_path, resource_id)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/struct-map/container/id'::text;

CREATE INDEX path_structmap_index
  ON list.property
  USING btree
  (local_path, resource_id)
TABLESPACE @escidoc.database.tablespace.list@
  WHERE local_path = '/struct-map/item/id'::text;

CREATE OR REPLACE FUNCTION public.create_plpgsql_language () RETURNS TEXT AS ' CREATE LANGUAGE plpgsql; SELECT ''language plpgsql created''::TEXT; ' LANGUAGE 'sql';

SELECT CASE WHEN
              (SELECT true::BOOLEAN
                 FROM pg_language
                WHERE lanname='plpgsql')
            THEN
              (SELECT 'language already installed'::TEXT)
            ELSE
              (SELECT public.create_plpgsql_language())
            END;

DROP FUNCTION public.create_plpgsql_language ();

DROP TYPE IF EXISTS resource CASCADE;

CREATE TYPE resource AS (resource_id TEXT);

CREATE OR REPLACE FUNCTION getChildContainers(param_resource_id TEXT) RETURNS SETOF resource AS '
  DECLARE\
    var_resource_id TEXT;\
  BEGIN\
    IF param_resource_id IS NOT NULL THEN\
      FOR var_resource_id IN SELECT value FROM list.property WHERE local_path=''/struct-map/container/id'' AND resource_id=param_resource_id LOOP\
        RETURN QUERY SELECT DISTINCT CAST(value AS TEXT) FROM list.property WHERE value=var_resource_id\
                     UNION ALL\
                     SELECT * FROM getChildContainers(var_resource_id);\
      END LOOP;\
    END IF;\
  END' LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION getAllChildContainers(param_expression TEXT) RETURNS SETOF resource AS '
  DECLARE\
    var_resource_id TEXT;\
  BEGIN\
    IF param_expression IS NOT NULL THEN\
      FOR var_resource_id IN EXECUTE param_expression LOOP\
        RETURN QUERY SELECT CAST(var_resource_id AS TEXT) FROM list.container\
                     UNION ALL\
                     SELECT * FROM getChildContainers(var_resource_id);\
      END LOOP;\
    END IF;\
  END' LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION getChildItems(param_resource_id TEXT) RETURNS SETOF resource AS '
  DECLARE\
    var_resource_id TEXT;\
  BEGIN\
    IF param_resource_id IS NOT NULL THEN\
      FOR var_resource_id IN SELECT value FROM list.property WHERE local_path=''/struct-map/item/id'' AND resource_id=param_resource_id LOOP\
        RETURN QUERY SELECT DISTINCT CAST(value AS TEXT) FROM list.property WHERE value=var_resource_id\
                     UNION ALL\
                     SELECT * FROM getChildItems(var_resource_id);\
      END LOOP;\
    END IF;\
  END' LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION getAllChildItems(param_expression TEXT) RETURNS SETOF resource AS '
  DECLARE\
    var_resource_id TEXT;\
  BEGIN\
    IF param_expression IS NOT NULL THEN\
      FOR var_resource_id IN EXECUTE param_expression LOOP\
        RETURN QUERY SELECT DISTINCT CAST(var_resource_id AS TEXT) FROM list.property\
                     UNION ALL\
                     SELECT * FROM getChildItems(var_resource_id);\
      END LOOP;\
    END IF;\
  END' LANGUAGE 'plpgsql';
