ALTER USER escidoc SET search_path TO public,jbpm;

create table jbpm.ESCIDOC_WORKFLOWTEMPLATES (
	WORKFLOWTEMPLATE_NAME text unique not null primary key, 
	XML text not null
);
create table jbpm.ESCIDOC_WORKFLOWDEFINITIONS (
	WORKFLOWDEFINITION_ID integer unique not null 
	primary key,
	NAME text not null,
	DESCRIPTION text,
	WORKFLOWTEMPLATE_NAME text not null,
	WORKFLOWCONFIGURATION text,
	WORKFLOWTYPE_ID integer not null ,
	CONTEXT_ID text
);
create table jbpm.ESCIDOC_WORKFLOWTYPES (
	WORKFLOWTYPE_ID integer unique not null 
	primary key,
	NAME text not null
);
create table jbpm.ESCIDOC_STARTACTORS (
	STARTACTOR_ID integer unique not null 
	primary key,
	WORKFLOWDEFINITION_ID integer,
	USER_ID text,
	ROLE_ID text
);

create table jbpm.ESCIDOC_WM_IDS (
	TABLENAME varchar(255) unique not null primary key,
	ID integer
);

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS 
	add constraint FK_WORKFLOWTYPE 
	foreign key (WORKFLOWTYPE_ID) 
	references jbpm.ESCIDOC_WORKFLOWTYPES;
	
alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS 
	add constraint FK_WORKFLOWTEMPLATE 
	foreign key (WORKFLOWTEMPLATE_NAME) 
	references jbpm.ESCIDOC_WORKFLOWTEMPLATES;
	
alter table jbpm.ESCIDOC_STARTACTORS 
	add constraint FK_WORKFLOWDEFINITION 
	foreign key (WORKFLOWDEFINITION_ID) 
	references jbpm.ESCIDOC_WORKFLOWDEFINITIONS;
	
CREATE INDEX wm_ids_table_idx
	ON jbpm.ESCIDOC_WM_IDS (TABLENAME);
	
INSERT INTO jbpm.ESCIDOC_WM_IDS (TABLENAME, ID)
	VALUES ('ESCIDOC_WORKFLOWTEMPLATES', 1);


