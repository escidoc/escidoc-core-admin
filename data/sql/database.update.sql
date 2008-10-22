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
    