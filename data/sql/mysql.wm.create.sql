#ALTER USER postgres SET search_path TO public,jbpm;

create table jbpm.ESCIDOC_WORKFLOWTEMPLATES (
    WORKFLOWTEMPLATE_NAME text, 
    XML text not null,
    PRIMARY KEY (WORKFLOWTEMPLATE_NAME(255))
);
create table jbpm.ESCIDOC_WORKFLOWDEFINITIONS (
    WORKFLOWDEFINITION_ID VARCHAR(255) unique not null 
    primary key,
    NAME text not null,
    DESCRIPTION text,
    WORKFLOWTEMPLATE_NAME text not null,
    WORKFLOWCONFIGURATION text,
    WORKFLOWTYPE_ID VARCHAR(255) not null ,
    CONTEXT_ID text
);
create table jbpm.ESCIDOC_WORKFLOWTYPES (
    WORKFLOWTYPE_ID VARCHAR(255) unique not null 
    primary key,
    NAME text not null
);
create table jbpm.ESCIDOC_STARTACTORS (
    STARTACTOR_ID VARCHAR(255) unique not null 
    primary key,
    WORKFLOWDEFINITION_ID VARCHAR(255),
    USER_ID text,
    ROLE_ID text
);

alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS 
    add constraint FK_WORKFLOWTYPE 
    foreign key (WORKFLOWTYPE_ID) 
    references jbpm.ESCIDOC_WORKFLOWTYPES (WORKFLOWTYPE_ID);
    
#alter table jbpm.ESCIDOC_WORKFLOWDEFINITIONS 
#   add constraint FK_WORKFLOWTEMPLATE 
#   foreign key (WORKFLOWTEMPLATE_NAME(255)) 
#   references jbpm.ESCIDOC_WORKFLOWTEMPLATES (WORKFLOWTEMPLATE_NAME) ;
    
alter table jbpm.ESCIDOC_STARTACTORS 
    add constraint FK_WORKFLOWDEFINITION 
    foreign key (WORKFLOWDEFINITION_ID) 
    references jbpm.ESCIDOC_WORKFLOWDEFINITIONS (WORKFLOWDEFINITION_ID);
    

