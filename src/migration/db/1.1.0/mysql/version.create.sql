CREATE SCHEMA common;

CREATE TABLE common.version (
  major_number INTEGER NOT NULL,
  minor_number INTEGER NOT NULL,
  revision_number INTEGER NOT NULL,
  date TIMESTAMP NOT NULL
);

INSERT INTO common.version VALUES (1, 1, 0, CURRENT_TIMESTAMP);
