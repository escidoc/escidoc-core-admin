CREATE TABLE list.content_relation (
  id                            TEXT NOT NULL,
  rest_content                  TEXT NOT NULL,
  soap_content                  TEXT NOT NULL,
  primary key (id)
);

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
        RETURN QUERY SELECT DISTINCT CAST(var_resource_id AS TEXT) FROM list.property\
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
