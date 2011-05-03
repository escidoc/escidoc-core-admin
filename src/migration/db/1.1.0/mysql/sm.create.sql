alter table sm.aggregation_definitions drop FOREIGN KEY fk_scope_id;
alter table sm.report_definitions drop FOREIGN KEY fk_scope_id;
alter table sm.statistic_data drop FOREIGN KEY fk_scope_id;

alter table sm.scopes CHANGE id id varchar(255);
alter table sm.statistic_data CHANGE id id varchar(255);
alter table sm.statistic_data CHANGE scope_id scope_id varchar(255);
alter table sm.aggregation_definitions CHANGE id id varchar(255);
alter table sm.aggregation_definitions CHANGE scope_id scope_id varchar(255);
alter table sm.report_definitions CHANGE id id varchar(255);
alter table sm.report_definitions CHANGE scope_id scope_id varchar(255);

alter table sm.aggregation_definitions add constraint fk_scope_id
    foreign key (scope_id) references sm.scopes ON DELETE CASCADE;
alter table sm.report_definitions add constraint fk_scope_id
    foreign key (scope_id) references sm.scopes ON DELETE CASCADE;
alter table sm.statistic_data add constraint fk_scope_id
    foreign key (scope_id) references sm.scopes ON DELETE CASCADE;

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

DROP TABLE sm.ESCIDOC_SM_IDS CASCADE;
