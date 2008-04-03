CREATE SCHEMA "sm";

CREATE SEQUENCE "sm"."aggregation_definitions_id_seq" START 10;

CREATE TABLE "sm"."scopes" ( 
  "id" integer unique not null primary key,
  "xml" TEXT NOT NULL
);

CREATE TABLE "sm"."statistic_data" ( 
  "id" integer unique not null primary key,
  "xml" TEXT NOT NULL,
  "scope_id" INTEGER NOT NULL,
  "timestamp" timestamp without time zone NOT NULL,
   CONSTRAINT "FK_SCOPE_ID" FOREIGN KEY ("scope_id") REFERENCES "sm"."scopes"
   ON DELETE CASCADE
);

CREATE TABLE "sm"."aggregation_definitions" ( 
  "id" integer unique not null primary key,
  "xml" TEXT NOT NULL,
  "scope_id" INTEGER NOT NULL,
   CONSTRAINT "FK_SCOPE_ID" FOREIGN KEY ("scope_id") REFERENCES "sm"."scopes"
   ON DELETE CASCADE
);

CREATE INDEX agg_def_scope_id_idx
ON "sm"."aggregation_definitions" (scope_id);

CREATE TABLE "sm"."report_definitions" ( 
  "id" integer unique not null primary key,
  "xml" TEXT NOT NULL,
  "scope_id" INTEGER NOT NULL,
   CONSTRAINT "FK_SCOPE_ID" FOREIGN KEY ("scope_id") REFERENCES "sm"."scopes"
   ON DELETE CASCADE
);

CREATE INDEX rep_def_scope_id_idx
ON "sm"."report_definitions" (scope_id);

CREATE INDEX timestamp_scope_id_idx
ON "sm"."statistic_data" (date_trunc( 'day',timestamp),scope_id);


    