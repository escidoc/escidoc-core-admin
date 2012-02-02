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

DROP TABLE jbpm.ESCIDOC_WM_IDS CASCADE;
