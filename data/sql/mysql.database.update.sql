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
    