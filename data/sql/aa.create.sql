CREATE SCHEMA "aa";

CREATE TABLE "aa"."user_account" ( 
  "id" VARCHAR(255) NOT NULL,
  "active" BOOLEAN,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255),
  "loginname" VARCHAR(255) NOT NULL UNIQUE,
  "password" VARCHAR(255),
  "person_ref" VARCHAR(255),
  "creator_id" VARCHAR(255),
  "creation_date" TIMESTAMP,
  "modified_by_id" VARCHAR(255),
  "last_modification_date" TIMESTAMP,
   primary key (id),
   CONSTRAINT "FK_CREATOR" FOREIGN KEY ("creator_id") REFERENCES "aa"."user_account",
   CONSTRAINT "FK_MODIFIED_BY" FOREIGN KEY ("modified_by_id") REFERENCES "aa"."user_account"
);

CREATE TABLE "aa"."user_account_ous" (
  "index" INTEGER NOT NULL,
  "user_account_id" VARCHAR(255) NOT NULL,
  "ou_id" VARCHAR(255) NOT NULL,
   primary key (index, user_account_id),
   CONSTRAINT "FK_UA_ID" FOREIGN KEY ("user_account_id") REFERENCES "aa"."user_account"
);
   
  

CREATE TABLE "aa"."escidoc_role" (
  "id" VARCHAR(255) NOT NULL,
  "role_name" VARCHAR(255) NOT NULL UNIQUE,
  "description" TEXT,
  "creator_id" VARCHAR(255),
  "creation_date" TIMESTAMP,
  "modified_by_id" VARCHAR(255),
  "last_modification_date" TIMESTAMP,
  primary key (id),
  CONSTRAINT "FK_ROLE_CREATED_BY" FOREIGN KEY ("creator_id") REFERENCES "aa"."user_account",
  CONSTRAINT "FK_ROLE_MODIFIED_BY" FOREIGN KEY ("modified_by_id") REFERENCES "aa"."user_account"
);

CREATE TABLE "aa"."scope_def" (
  "id" VARCHAR(255) NOT NULL,
  "role_id" VARCHAR(255),
  "object_type" VARCHAR(255) NOT NULL,
  "attribute_id" VARCHAR(255),
  primary key (id),
  CONSTRAINT "FK_SCOPE_DEF" FOREIGN KEY ("role_id") REFERENCES "aa"."escidoc_role"
);

CREATE TABLE "aa"."escidoc_policies" (
  "id" VARCHAR(255) NOT NULL, 
  "role_id" VARCHAR(255),
  "xml" TEXT, 
  CONSTRAINT "PK_ESCIDOC_POLICIES" PRIMARY KEY("id"),
  CONSTRAINT "FK_ESCIDOC_POLICIES_ROLE" FOREIGN KEY ("role_id") REFERENCES "aa"."escidoc_role"
) WITH OIDS;

CREATE TABLE "aa"."actions" (
  "id" VARCHAR(255) NOT NULL, 
  "name" VARCHAR(255) NOT NULL,
  CONSTRAINT "actions_pkey" PRIMARY KEY("id")
) WITH OIDS;

CREATE TABLE "aa"."method_mappings" (
  "id" VARCHAR(255) NOT NULL,
  "class_name" VARCHAR(255) NOT NULL,
  "method_name" VARCHAR(255) NOT NULL,
  "action_name" VARCHAR(255) NOT NULL,
  "before" BOOLEAN NOT NULL,
  "single_resource" BOOLEAN NOT NULL,
  "resource_not_found_exception" TEXT,
  CONSTRAINT "method_mappings_pkey" PRIMARY KEY("id")
) WITH OIDS;

CREATE TABLE "aa"."invocation_mappings" (
  "id" VARCHAR(255) NOT NULL,
  "attribute_id" TEXT NOT NULL, 
  "path" VARCHAR(100) NOT NULL,
  "position" NUMERIC(2,0) NOT NULL,
  "attribute_type" VARCHAR(255) NOT NULL,
  "mapping_type" NUMERIC(2,0) NOT NULL,
  "multi_value" boolean NOT NULL,
  "value" VARCHAR(100) NULL,
  "method_mapping" VARCHAR(255) NULL, 
  CONSTRAINT "invocation_mappings_pkey" PRIMARY KEY("id"),
  CONSTRAINT "invocation_mappings_fkey" FOREIGN KEY ("method_mapping") REFERENCES "aa"."method_mappings"
  ) WITH OIDS;


CREATE TABLE "aa"."role_grant" (
  "id" VARCHAR(255) NOT NULL,
  "user_id" VARCHAR(255) NOT NULL,
  "role_id" VARCHAR(255) NOT NULL,
  "object_id" VARCHAR(255), 
  "object_title" VARCHAR(255),
  "object_href" VARCHAR(255),
  "grant_remark" VARCHAR(255) NULL,
  "creator_id" VARCHAR(255),
  "creation_date" TIMESTAMP,
  "revoker_id" VARCHAR(255),
  "revocation_date" TIMESTAMP,
  "revocation_remark" VARCHAR(255),
  "granted_from" TIMESTAMP,
  "granted_to" TIMESTAMP,
  primary key (id),
  CONSTRAINT "FK_GRANT" FOREIGN KEY ("user_id") REFERENCES "aa"."user_account",
  CONSTRAINT "FK_GRANTOR_GRANT" FOREIGN KEY ("creator_id") REFERENCES "aa"."user_account",
  CONSTRAINT "FK_REVOKER_GRANT" FOREIGN KEY ("revoker_id") REFERENCES "aa"."user_account",
  CONSTRAINT "FK_ROLE_GRANT" FOREIGN KEY ("role_id") REFERENCES "aa"."escidoc_role"
);

CREATE TABLE "aa"."user_login_data" (
  "id" VARCHAR(255) NOT NULL,
  "user_id"  VARCHAR(255) NOT NULL,
  "handle" VARCHAR(255) NOT NULL,
  "expiryts" int8 NOT NULL,
  primary key (id),
  CONSTRAINT "FK_USER_LOGIN_DATA" FOREIGN KEY ("user_id") REFERENCES "aa"."user_account"
);

CREATE TABLE "aa"."unsecured_action_list" (
  "id" VARCHAR(255) NOT NULL,
  "context_id" VARCHAR(255) NOT NULL,
  "action_ids" TEXT NOT NULL,
  primary key (id)
);



