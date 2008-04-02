CREATE SCHEMA "om";

CREATE TABLE "om"."lockstatus"
(
  "objid" varchar NOT NULL,
  "owner" varchar NOT NULL,
  "ownertitle" varchar NOT NULL,
  "locked" bool NOT NULL,
  "timestamp" timestamp NOT NULL DEFAULT now(),
  CONSTRAINT lockstatus_pkey PRIMARY KEY (objid)
);
