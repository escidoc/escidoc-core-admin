CREATE SCHEMA om;

CREATE TABLE om.lockstatus
(
  objid VARCHAR(255) NOT NULL,
  owner VARCHAR(255) NULL,
  ownertitle VARCHAR(255) NOT NULL,
  locked BOOLEAN NOT NULL,
  lock_timestamp TIMESTAMP NOT NULL DEFAULT now(),
  CONSTRAINT lockstatus_pkey PRIMARY KEY (objid)
);


-- Tabel to set the ingest lock
CREATE TABLE om.ingestlock
(
  objid VARCHAR(255) NOT NULL,
  resource_type VARCHAR(255) NOT NULL,
  owner VARCHAR(255) NOT NULL,
  processid VARCHAR(255) NOT NULL,
  ingest_timestamp TIMESTAMP NOT NULL DEFAULT now(),
  CONSTRAINT ingestlock_pkey PRIMARY KEY (objid)
);

-- Tabel to keep the configuration content
CREATE TABLE om.ingestconf
(
  processid bigserial NOT NULL,
  owner VARCHAR(255) NOT NULL,
  conf TEXT NOT NULL,
  CONSTRAINT ingestconf_pkey PRIMARY KEY (processid)
);
