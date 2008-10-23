CREATE TABLE sm.preprocessing_logs ( 
  id VARCHAR(255) unique not null primary key,
  aggregation_definition_id VARCHAR(255) not null,
  processing_date DATE not null,
  log_entry TEXT,
  has_error BOOLEAN,
   CONSTRAINT FK_AGGREGATION_DEFINITION_ID FOREIGN KEY (aggregation_definition_id) 
   REFERENCES sm.aggregation_definitions
   ON DELETE CASCADE
);

CREATE INDEX preproc_logs_agg_def_id_idx
ON sm.preprocessing_logs (aggregation_definition_id);

CREATE INDEX preproc_logs_date_idx
ON sm.preprocessing_logs (processing_date);

CREATE INDEX preproc_logs_agg_def_date_idx
ON sm.preprocessing_logs (aggregation_definition_id, processing_date);

CREATE INDEX preproc_logs_error_agg_def_idx
ON sm.preprocessing_logs (aggregation_definition_id, has_error);

CREATE INDEX preproc_logs_error_date_idx
ON sm.preprocessing_logs (processing_date, has_error);

alter table sm.aggregation_definitions drop constraint fk_scope_id;
alter table sm.report_definitions drop constraint fk_scope_id;
alter table sm.statistic_data drop constraint fk_scope_id;

alter table sm.aggregation_definitions alter column scope_id type varchar(255);
alter table sm.report_definitions alter column scope_id type varchar(255);
alter table sm.statistic_data alter column scope_id type varchar(255);
alter table sm.scopes alter column id type varchar(255);
alter table sm.aggregation_definitions alter column id type varchar(255);
alter table sm.report_definitions alter column id type varchar(255);
alter table sm.statistic_data alter column id type varchar(255);
    
alter table sm.aggregation_definitions add constraint fk_scope_id 
    foreign key (scope_id) references sm.scopes;
alter table sm.report_definitions add constraint fk_scope_id 
    foreign key (scope_id) references sm.scopes;
alter table sm.statistic_data add constraint fk_scope_id 
    foreign key (scope_id) references sm.scopes;
    
    

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS drop constraint FK_WORKFLOWTYPE;
alter table jbpm.ESCIDOC_STARTACTORS drop constraint FK_WORKFLOWDEFINITION;

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS alter column WORKFLOWDEFINITION_ID type varchar(255);
alter table jbpm.ESCIDOC_WORKFLOWTYPES alter column WORKFLOWTYPE_ID type varchar(255);
alter table jbpm.ESCIDOC_STARTACTORS alter column STARTACTOR_ID type varchar(255);

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS alter column WORKFLOWTYPE_ID type varchar(255);
alter table jbpm.ESCIDOC_STARTACTORS alter column WORKFLOWDEFINITION_ID type varchar(255);

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS 
    add constraint FK_WORKFLOWTYPE 
    foreign key (WORKFLOWTYPE_ID) 
    references jbpm.ESCIDOC_WORKFLOWTYPES;
    
alter table jbpm.ESCIDOC_STARTACTORS 
    add constraint FK_WORKFLOWDEFINITION 
    foreign key (WORKFLOWDEFINITION_ID) 
    references jbpm.ESCIDOC_WORKFLOWDEFINITIONS;
    