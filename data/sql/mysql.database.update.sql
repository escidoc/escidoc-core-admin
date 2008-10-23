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

alter table sm.aggregation_definitions drop foreign key FK_SCOPE_ID_AD;
alter table sm.report_definitions drop foreign key FK_SCOPE_ID_RD;
alter table sm.statistic_data drop foreign key FK_SCOPE_ID_SD;

alter table sm.aggregation_definitions modify scope_id varchar(255);
alter table sm.report_definitions modify scope_id varchar(255);
alter table sm.statistic_data modify scope_id varchar(255);
alter table sm.scopes modify id varchar(255);
alter table sm.aggregation_definitions modify id varchar(255);
alter table sm.report_definitions modify id varchar(255);
alter table sm.statistic_data modify id varchar(255);
    
alter table sm.aggregation_definitions add constraint FK_SCOPE_ID_AD 
    foreign key (scope_id) references sm.scopes (id);
alter table sm.report_definitions add constraint FK_SCOPE_ID_RD 
    foreign key (scope_id) references sm.scopes (id);
alter table sm.statistic_data add constraint FK_SCOPE_ID_SD 
    foreign key (scope_id) references sm.scopes (id);
    
    

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS drop foreign key FK_WORKFLOWTYPE;
alter table jbpm.ESCIDOC_STARTACTORS drop foreign key FK_WORKFLOWDEFINITION;

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS modify WORKFLOWDEFINITION_ID varchar(255);
alter table jbpm.ESCIDOC_WORKFLOWTYPES modify WORKFLOWTYPE_ID varchar(255);
alter table jbpm.ESCIDOC_STARTACTORS modify STARTACTOR_ID varchar(255);

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS modify WORKFLOWTYPE_ID varchar(255);
alter table jbpm.ESCIDOC_STARTACTORS modify WORKFLOWDEFINITION_ID varchar(255);

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS 
    add constraint FK_WORKFLOWTYPE 
    foreign key (WORKFLOWTYPE_ID) 
    references jbpm.ESCIDOC_WORKFLOWTYPES (WORKFLOWTYPE_ID);
    
alter table jbpm.ESCIDOC_STARTACTORS 
    add constraint FK_WORKFLOWDEFINITION 
    foreign key (WORKFLOWDEFINITION_ID) 
    references jbpm.ESCIDOC_WORKFLOWDEFINITIONS (WORKFLOWDEFINITION_ID);
    