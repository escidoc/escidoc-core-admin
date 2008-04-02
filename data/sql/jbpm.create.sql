CREATE SCHEMA jbpm;

ALTER USER postgres SET search_path TO public,jbpm;

CREATE SEQUENCE "jbpm"."workflow_templates_id_seq";

create table jbpm.JBPM_ACTION (ID_ int8 not null, class char(1) not null, NAME_ varchar(255), ISPROPAGATIONALLOWED_ bool, ACTIONEXPRESSION_ varchar(255), ISASYNC_ bool, REFERENCEDACTION_ int8, ACTIONDELEGATION_ int8, EVENT_ int8, PROCESSDEFINITION_ int8, TIMERNAME_ varchar(255), DUEDATE_ varchar(255), REPEAT_ varchar(255), TRANSITIONNAME_ varchar(255), TIMERACTION_ int8, EXPRESSION_ varchar(4000), EVENTINDEX_ int4, EXCEPTIONHANDLER_ int8, EXCEPTIONHANDLERINDEX_ int4, primary key (ID_));;
create table jbpm.JBPM_BYTEARRAY (ID_ int8 not null, NAME_ varchar(255), FILEDEFINITION_ int8, primary key (ID_));
create table jbpm.JBPM_BYTEBLOCK (PROCESSFILE_ int8 not null, BYTES_ bytea, INDEX_ int4 not null, primary key (PROCESSFILE_, INDEX_));
create table jbpm.JBPM_COMMENT (ID_ int8 not null, VERSION_ int4 not null, ACTORID_ varchar(255), TIME_ timestamp, MESSAGE_ varchar(4000), TOKEN_ int8, TASKINSTANCE_ int8, TOKENINDEX_ int4, TASKINSTANCEINDEX_ int4, primary key (ID_));
create table jbpm.JBPM_DECISIONCONDITIONS (DECISION_ int8 not null, TRANSITIONNAME_ varchar(255), EXPRESSION_ varchar(255), INDEX_ int4 not null, primary key (DECISION_, INDEX_));
create table jbpm.JBPM_DELEGATION (ID_ int8 not null, CLASSNAME_ varchar(4000), CONFIGURATION_ varchar(4000), CONFIGTYPE_ varchar(255), PROCESSDEFINITION_ int8, primary key (ID_));
create table jbpm.JBPM_EVENT (ID_ int8 not null, EVENTTYPE_ varchar(255), TYPE_ char(1), GRAPHELEMENT_ int8, PROCESSDEFINITION_ int8, NODE_ int8, TRANSITION_ int8, TASK_ int8, primary key (ID_));
create table jbpm.JBPM_EXCEPTIONHANDLER (ID_ int8 not null, EXCEPTIONCLASSNAME_ varchar(4000), TYPE_ char(1), GRAPHELEMENT_ int8, PROCESSDEFINITION_ int8, GRAPHELEMENTINDEX_ int4, NODE_ int8, TRANSITION_ int8, TASK_ int8, primary key (ID_));
create table jbpm.JBPM_ID_GROUP (ID_ int8 not null, CLASS_ char(1) not null, NAME_ varchar(255), TYPE_ varchar(255), PARENT_ int8, primary key (ID_));
create table jbpm.JBPM_ID_MEMBERSHIP (ID_ int8 not null, CLASS_ char(1) not null, NAME_ varchar(255), ROLE_ varchar(255), USER_ int8, GROUP_ int8, primary key (ID_));
create table jbpm.JBPM_ID_PERMISSIONS (ENTITY_ int8 not null, CLASS_ varchar(255), NAME_ varchar(255), ACTION_ varchar(255));
create table jbpm.JBPM_ID_USER (ID_ int8 not null, CLASS_ char(1) not null, NAME_ varchar(255), EMAIL_ varchar(255), PASSWORD_ varchar(255), primary key (ID_));
create table jbpm.JBPM_JOB (ID_ int8 not null, CLASS_ char(1) not null, VERSION_ int4 not null, DUEDATE_ timestamp, PROCESSINSTANCE_ int8, TOKEN_ int8, TASKINSTANCE_ int8, ISSUSPENDED_ bool, ISEXCLUSIVE_ bool, LOCKOWNER_ varchar(255), LOCKTIME_ timestamp, EXCEPTION_ varchar(4000), RETRIES_ int4, NAME_ varchar(255), REPEAT_ varchar(255), TRANSITIONNAME_ varchar(255), ACTION_ int8, GRAPHELEMENTTYPE_ varchar(255), GRAPHELEMENT_ int8, NODE_ int8, primary key (ID_));
create table jbpm.JBPM_LOG (ID_ int8 not null, CLASS_ char(1) not null, INDEX_ int4, DATE_ timestamp, TOKEN_ int8, PARENT_ int8, MESSAGE_ varchar(4000), EXCEPTION_ varchar(4000), ACTION_ int8, NODE_ int8, ENTER_ timestamp, LEAVE_ timestamp, DURATION_ int8, NEWLONGVALUE_ int8, TRANSITION_ int8, CHILD_ int8, SOURCENODE_ int8, DESTINATIONNODE_ int8, VARIABLEINSTANCE_ int8, OLDBYTEARRAY_ int8, NEWBYTEARRAY_ int8, OLDDATEVALUE_ timestamp, NEWDATEVALUE_ timestamp, OLDDOUBLEVALUE_ float8, NEWDOUBLEVALUE_ float8, OLDLONGIDCLASS_ varchar(255), OLDLONGIDVALUE_ int8, NEWLONGIDCLASS_ varchar(255), NEWLONGIDVALUE_ int8, OLDSTRINGIDCLASS_ varchar(255), OLDSTRINGIDVALUE_ varchar(255), NEWSTRINGIDCLASS_ varchar(255), NEWSTRINGIDVALUE_ varchar(255), OLDLONGVALUE_ int8, OLDSTRINGVALUE_ varchar(4000), NEWSTRINGVALUE_ varchar(4000), TASKINSTANCE_ int8, TASKACTORID_ varchar(255), TASKOLDACTORID_ varchar(255), SWIMLANEINSTANCE_ int8, primary key (ID_));
create table jbpm.JBPM_MODULEDEFINITION (ID_ int8 not null, CLASS_ char(1) not null, NAME_ varchar(4000), PROCESSDEFINITION_ int8, STARTTASK_ int8, primary key (ID_));
create table jbpm.JBPM_MODULEINSTANCE (ID_ int8 not null, CLASS_ char(1) not null, VERSION_ int4 not null, PROCESSINSTANCE_ int8, TASKMGMTDEFINITION_ int8, NAME_ varchar(255), primary key (ID_));
create table jbpm.JBPM_NODE (ID_ int8 not null, CLASS_ char(1) not null, NAME_ varchar(255), DESCRIPTION_ varchar(4000), PROCESSDEFINITION_ int8, ISASYNC_ bool, ISASYNCEXCL_ bool, ACTION_ int8, SUPERSTATE_ int8, SUBPROCNAME_ varchar(255), SUBPROCESSDEFINITION_ int8, DECISIONEXPRESSION_ varchar(255), DECISIONDELEGATION int8, SCRIPT_ int8, SIGNAL_ int4, CREATETASKS_ bool, ENDTASKS_ bool, NODECOLLECTIONINDEX_ int4, primary key (ID_));
create table jbpm.JBPM_POOLEDACTOR (ID_ int8 not null, VERSION_ int4 not null, ACTORID_ varchar(255), SWIMLANEINSTANCE_ int8, primary key (ID_));
create table jbpm.JBPM_PROCESSDEFINITION (ID_ int8 not null, CLASS_ char(1) not null, NAME_ varchar(255), DESCRIPTION_ varchar(4000), VERSION_ int4, ISTERMINATIONIMPLICIT_ bool, STARTSTATE_ int8, primary key (ID_));
create table jbpm.JBPM_PROCESSINSTANCE (ID_ int8 not null, VERSION_ int4 not null, KEY_ varchar(255), START_ timestamp, END_ timestamp, ISSUSPENDED_ bool, PROCESSDEFINITION_ int8, ROOTTOKEN_ int8, SUPERPROCESSTOKEN_ int8, primary key (ID_));
create table jbpm.JBPM_RUNTIMEACTION (ID_ int8 not null, VERSION_ int4 not null, EVENTTYPE_ varchar(255), TYPE_ char(1), GRAPHELEMENT_ int8, PROCESSINSTANCE_ int8, ACTION_ int8, PROCESSINSTANCEINDEX_ int4, primary key (ID_));
create table jbpm.JBPM_SWIMLANE (ID_ int8 not null, NAME_ varchar(255), ACTORIDEXPRESSION_ varchar(255), POOLEDACTORSEXPRESSION_ varchar(255), ASSIGNMENTDELEGATION_ int8, TASKMGMTDEFINITION_ int8, primary key (ID_));
create table jbpm.JBPM_SWIMLANEINSTANCE (ID_ int8 not null, VERSION_ int4 not null, NAME_ varchar(255), ACTORID_ varchar(255), SWIMLANE_ int8, TASKMGMTINSTANCE_ int8, primary key (ID_));
create table jbpm.JBPM_TASK (ID_ int8 not null, NAME_ varchar(255), DESCRIPTION_ varchar(4000), PROCESSDEFINITION_ int8, ISBLOCKING_ bool, ISSIGNALLING_ bool, CONDITION_ varchar(255), DUEDATE_ varchar(255), PRIORITY_ int4, ACTORIDEXPRESSION_ varchar(255), POOLEDACTORSEXPRESSION_ varchar(255), TASKMGMTDEFINITION_ int8, TASKNODE_ int8, STARTSTATE_ int8, ASSIGNMENTDELEGATION_ int8, SWIMLANE_ int8, TASKCONTROLLER_ int8, primary key (ID_));
create table jbpm.JBPM_TASKACTORPOOL (TASKINSTANCE_ int8 not null, POOLEDACTOR_ int8 not null, primary key (TASKINSTANCE_, POOLEDACTOR_));
create table jbpm.JBPM_TASKCONTROLLER (ID_ int8 not null, TASKCONTROLLERDELEGATION_ int8, primary key (ID_));
create table jbpm.JBPM_TASKINSTANCE (ID_ int8 not null, CLASS_ char(1) not null, VERSION_ int4 not null, NAME_ varchar(255), DESCRIPTION_ varchar(4000), ACTORID_ varchar(255), CREATE_ timestamp, START_ timestamp, END_ timestamp, DUEDATE_ timestamp, PRIORITY_ int4, ISCANCELLED_ bool, ISSUSPENDED_ bool, ISOPEN_ bool, ISSIGNALLING_ bool, ISBLOCKING_ bool, TASK_ int8, TOKEN_ int8, PROCINST_ int8, SWIMLANINSTANCE_ int8, TASKMGMTINSTANCE_ int8, primary key (ID_));
create table jbpm.JBPM_TOKEN (ID_ int8 not null, VERSION_ int4 not null, NAME_ varchar(255), START_ timestamp, END_ timestamp, NODEENTER_ timestamp, NEXTLOGINDEX_ int4, ISABLETOREACTIVATEPARENT_ bool, ISTERMINATIONIMPLICIT_ bool, ISSUSPENDED_ bool, LOCK_ varchar(255), NODE_ int8, PROCESSINSTANCE_ int8, PARENT_ int8, SUBPROCESSINSTANCE_ int8, primary key (ID_));
create table jbpm.JBPM_TOKENVARIABLEMAP (ID_ int8 not null, VERSION_ int4 not null, TOKEN_ int8, CONTEXTINSTANCE_ int8, primary key (ID_));
create table jbpm.JBPM_TRANSITION (ID_ int8 not null, NAME_ varchar(255), DESCRIPTION_ varchar(4000), PROCESSDEFINITION_ int8, FROM_ int8, TO_ int8, CONDITION_ varchar(255), FROMINDEX_ int4, primary key (ID_));
create table jbpm.JBPM_VARIABLEACCESS (ID_ int8 not null, VARIABLENAME_ varchar(255), ACCESS_ varchar(255), MAPPEDNAME_ varchar(255), PROCESSSTATE_ int8, TASKCONTROLLER_ int8, INDEX_ int4, SCRIPT_ int8, primary key (ID_));
create table jbpm.JBPM_VARIABLEINSTANCE (ID_ int8 not null, CLASS_ char(1) not null, VERSION_ int4 not null, NAME_ varchar(255), CONVERTER_ char(1), TOKEN_ int8, TOKENVARIABLEMAP_ int8, PROCESSINSTANCE_ int8, BYTEARRAYVALUE_ int8, DATEVALUE_ timestamp, DOUBLEVALUE_ float8, LONGIDCLASS_ varchar(255), LONGVALUE_ int8, STRINGIDCLASS_ varchar(255), STRINGVALUE_ varchar(255), TASKINSTANCE_ int8, primary key (ID_));
create index IDX_ACTION_EVENT on jbpm.JBPM_ACTION (EVENT_);
create index IDX_ACTION_ACTNDL on jbpm.JBPM_ACTION (ACTIONDELEGATION_);
create index IDX_ACTION_PROCDF on jbpm.JBPM_ACTION (PROCESSDEFINITION_);
alter table jbpm.JBPM_ACTION add constraint FK_ACTION_EVENT foreign key (EVENT_) references jbpm.JBPM_EVENT;
alter table jbpm.JBPM_ACTION add constraint FK_ACTION_EXPTHDL foreign key (EXCEPTIONHANDLER_) references jbpm.JBPM_EXCEPTIONHANDLER;
alter table jbpm.JBPM_ACTION add constraint FK_ACTION_PROCDEF foreign key (PROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
alter table jbpm.JBPM_ACTION add constraint FK_CRTETIMERACT_TA foreign key (TIMERACTION_) references jbpm.JBPM_ACTION;
alter table jbpm.JBPM_ACTION add constraint FK_ACTION_ACTNDEL foreign key (ACTIONDELEGATION_) references jbpm.JBPM_DELEGATION;
alter table jbpm.JBPM_ACTION add constraint FK_ACTION_REFACT foreign key (REFERENCEDACTION_) references jbpm.JBPM_ACTION;
alter table jbpm.JBPM_BYTEARRAY add constraint FK_BYTEARR_FILDEF foreign key (FILEDEFINITION_) references jbpm.JBPM_MODULEDEFINITION;
alter table jbpm.JBPM_BYTEBLOCK add constraint FK_BYTEBLOCK_FILE foreign key (PROCESSFILE_) references jbpm.JBPM_BYTEARRAY;
create index IDX_COMMENT_TOKEN on jbpm.JBPM_COMMENT (TOKEN_);
create index IDX_COMMENT_TSK on jbpm.JBPM_COMMENT (TASKINSTANCE_);
alter table jbpm.JBPM_COMMENT add constraint FK_COMMENT_TOKEN foreign key (TOKEN_) references jbpm.JBPM_TOKEN;
alter table jbpm.JBPM_COMMENT add constraint FK_COMMENT_TSK foreign key (TASKINSTANCE_) references jbpm.JBPM_TASKINSTANCE;
alter table jbpm.JBPM_DECISIONCONDITIONS add constraint FK_DECCOND_DEC foreign key (DECISION_) references jbpm.JBPM_NODE;
create index IDX_DELEG_PRCD on jbpm.JBPM_DELEGATION (PROCESSDEFINITION_);
alter table jbpm.JBPM_DELEGATION add constraint FK_DELEGATION_PRCD foreign key (PROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
alter table jbpm.JBPM_EVENT add constraint FK_EVENT_PROCDEF foreign key (PROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
alter table jbpm.JBPM_EVENT add constraint FK_EVENT_NODE foreign key (NODE_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_EVENT add constraint FK_EVENT_TRANS foreign key (TRANSITION_) references jbpm.JBPM_TRANSITION;
alter table jbpm.JBPM_EVENT add constraint FK_EVENT_TASK foreign key (TASK_) references jbpm.JBPM_TASK;
alter table jbpm.JBPM_ID_GROUP add constraint FK_ID_GRP_PARENT foreign key (PARENT_) references jbpm.JBPM_ID_GROUP;
alter table jbpm.JBPM_ID_MEMBERSHIP add constraint FK_ID_MEMSHIP_GRP foreign key (GROUP_) references jbpm.JBPM_ID_GROUP;
alter table jbpm.JBPM_ID_MEMBERSHIP add constraint FK_ID_MEMSHIP_USR foreign key (USER_) references jbpm.JBPM_ID_USER;
create index IDX_JOB_TSKINST on jbpm.JBPM_JOB (TASKINSTANCE_);
create index IDX_JOB_PRINST on jbpm.JBPM_JOB (PROCESSINSTANCE_);
create index IDX_JOB_TOKEN on jbpm.JBPM_JOB (TOKEN_);
alter table jbpm.JBPM_JOB add constraint FK_JOB_TOKEN foreign key (TOKEN_) references jbpm.JBPM_TOKEN;
alter table jbpm.JBPM_JOB add constraint FK_JOB_NODE foreign key (NODE_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_JOB add constraint FK_JOB_PRINST foreign key (PROCESSINSTANCE_) references jbpm.JBPM_PROCESSINSTANCE;
alter table jbpm.JBPM_JOB add constraint FK_JOB_ACTION foreign key (ACTION_) references jbpm.JBPM_ACTION;
alter table jbpm.JBPM_JOB add constraint FK_JOB_TSKINST foreign key (TASKINSTANCE_) references jbpm.JBPM_TASKINSTANCE;
alter table jbpm.JBPM_LOG add constraint FK_LOG_SOURCENODE foreign key (SOURCENODE_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_LOG add constraint FK_LOG_TOKEN foreign key (TOKEN_) references jbpm.JBPM_TOKEN;
alter table jbpm.JBPM_LOG add constraint FK_LOG_OLDBYTES foreign key (OLDBYTEARRAY_) references jbpm.JBPM_BYTEARRAY;
alter table jbpm.JBPM_LOG add constraint FK_LOG_NEWBYTES foreign key (NEWBYTEARRAY_) references jbpm.JBPM_BYTEARRAY;
alter table jbpm.JBPM_LOG add constraint FK_LOG_CHILDTOKEN foreign key (CHILD_) references jbpm.JBPM_TOKEN;
alter table jbpm.JBPM_LOG add constraint FK_LOG_DESTNODE foreign key (DESTINATIONNODE_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_LOG add constraint FK_LOG_TASKINST foreign key (TASKINSTANCE_) references jbpm.JBPM_TASKINSTANCE;
alter table jbpm.JBPM_LOG add constraint FK_LOG_SWIMINST foreign key (SWIMLANEINSTANCE_) references jbpm.JBPM_SWIMLANEINSTANCE;
alter table jbpm.JBPM_LOG add constraint FK_LOG_PARENT foreign key (PARENT_) references jbpm.JBPM_LOG;
alter table jbpm.JBPM_LOG add constraint FK_LOG_NODE foreign key (NODE_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_LOG add constraint FK_LOG_ACTION foreign key (ACTION_) references jbpm.JBPM_ACTION;
alter table jbpm.JBPM_LOG add constraint FK_LOG_VARINST foreign key (VARIABLEINSTANCE_) references jbpm.JBPM_VARIABLEINSTANCE;
alter table jbpm.JBPM_LOG add constraint FK_LOG_TRANSITION foreign key (TRANSITION_) references jbpm.JBPM_TRANSITION;
create index IDX_MODDEF_PROCDF on jbpm.JBPM_MODULEDEFINITION (PROCESSDEFINITION_);
alter table jbpm.JBPM_MODULEDEFINITION add constraint FK_TSKDEF_START foreign key (STARTTASK_) references jbpm.JBPM_TASK;
alter table jbpm.JBPM_MODULEDEFINITION add constraint FK_MODDEF_PROCDEF foreign key (PROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
create index IDX_MODINST_PRINST on jbpm.JBPM_MODULEINSTANCE (PROCESSINSTANCE_);
alter table jbpm.JBPM_MODULEINSTANCE add constraint FK_TASKMGTINST_TMD foreign key (TASKMGMTDEFINITION_) references jbpm.JBPM_MODULEDEFINITION;
alter table jbpm.JBPM_MODULEINSTANCE add constraint FK_MODINST_PRCINST foreign key (PROCESSINSTANCE_) references jbpm.JBPM_PROCESSINSTANCE;
create index IDX_PSTATE_SBPRCDEF on jbpm.JBPM_NODE (SUBPROCESSDEFINITION_);
create index IDX_NODE_SUPRSTATE on jbpm.JBPM_NODE (SUPERSTATE_);
create index IDX_NODE_PROCDEF on jbpm.JBPM_NODE (PROCESSDEFINITION_);
create index IDX_NODE_ACTION on jbpm.JBPM_NODE (ACTION_);
alter table jbpm.JBPM_NODE add constraint FK_PROCST_SBPRCDEF foreign key (SUBPROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
alter table jbpm.JBPM_NODE add constraint FK_NODE_PROCDEF foreign key (PROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
alter table jbpm.JBPM_NODE add constraint FK_NODE_SCRIPT foreign key (SCRIPT_) references jbpm.JBPM_ACTION;
alter table jbpm.JBPM_NODE add constraint FK_NODE_ACTION foreign key (ACTION_) references jbpm.JBPM_ACTION;
alter table jbpm.JBPM_NODE add constraint FK_DECISION_DELEG foreign key (DECISIONDELEGATION) references jbpm.JBPM_DELEGATION;
alter table jbpm.JBPM_NODE add constraint FK_NODE_SUPERSTATE foreign key (SUPERSTATE_) references jbpm.JBPM_NODE;
create index IDX_PLDACTR_ACTID on jbpm.JBPM_POOLEDACTOR (ACTORID_);
create index IDX_TSKINST_SWLANE on jbpm.JBPM_POOLEDACTOR (SWIMLANEINSTANCE_);
alter table jbpm.JBPM_POOLEDACTOR add constraint FK_POOLEDACTOR_SLI foreign key (SWIMLANEINSTANCE_) references jbpm.JBPM_SWIMLANEINSTANCE;
create index IDX_PROCDEF_STRTST on jbpm.JBPM_PROCESSDEFINITION (STARTSTATE_);
alter table jbpm.JBPM_PROCESSDEFINITION add constraint FK_PROCDEF_STRTSTA foreign key (STARTSTATE_) references jbpm.JBPM_NODE;
create index IDX_PROCIN_ROOTTK on jbpm.JBPM_PROCESSINSTANCE (ROOTTOKEN_);
create index IDX_PROCIN_SPROCTK on jbpm.JBPM_PROCESSINSTANCE (SUPERPROCESSTOKEN_);
create index IDX_PROCIN_KEY on jbpm.JBPM_PROCESSINSTANCE (KEY_);
create index IDX_PROCIN_PROCDEF on jbpm.JBPM_PROCESSINSTANCE (PROCESSDEFINITION_);
alter table jbpm.JBPM_PROCESSINSTANCE add constraint FK_PROCIN_PROCDEF foreign key (PROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
alter table jbpm.JBPM_PROCESSINSTANCE add constraint FK_PROCIN_ROOTTKN foreign key (ROOTTOKEN_) references jbpm.JBPM_TOKEN;
alter table jbpm.JBPM_PROCESSINSTANCE add constraint FK_PROCIN_SPROCTKN foreign key (SUPERPROCESSTOKEN_) references jbpm.JBPM_TOKEN;
create index IDX_RTACTN_PRCINST on jbpm.JBPM_RUNTIMEACTION (PROCESSINSTANCE_);
create index IDX_RTACTN_ACTION on jbpm.JBPM_RUNTIMEACTION (ACTION_);
alter table jbpm.JBPM_RUNTIMEACTION add constraint FK_RTACTN_PROCINST foreign key (PROCESSINSTANCE_) references jbpm.JBPM_PROCESSINSTANCE;
alter table jbpm.JBPM_RUNTIMEACTION add constraint FK_RTACTN_ACTION foreign key (ACTION_) references jbpm.JBPM_ACTION;
alter table jbpm.JBPM_SWIMLANE add constraint FK_SWL_ASSDEL foreign key (ASSIGNMENTDELEGATION_) references jbpm.JBPM_DELEGATION;
alter table jbpm.JBPM_SWIMLANE add constraint FK_SWL_TSKMGMTDEF foreign key (TASKMGMTDEFINITION_) references jbpm.JBPM_MODULEDEFINITION;
create index IDX_SWIMLINST_SL on jbpm.JBPM_SWIMLANEINSTANCE (SWIMLANE_);
alter table jbpm.JBPM_SWIMLANEINSTANCE add constraint FK_SWIMLANEINST_TM foreign key (TASKMGMTINSTANCE_) references jbpm.JBPM_MODULEINSTANCE;
alter table jbpm.JBPM_SWIMLANEINSTANCE add constraint FK_SWIMLANEINST_SL foreign key (SWIMLANE_) references jbpm.JBPM_SWIMLANE;
create index IDX_TASK_TSKNODE on jbpm.JBPM_TASK (TASKNODE_);
create index IDX_TASK_PROCDEF on jbpm.JBPM_TASK (PROCESSDEFINITION_);
create index IDX_TASK_TASKMGTDF on jbpm.JBPM_TASK (TASKMGMTDEFINITION_);
alter table jbpm.JBPM_TASK add constraint FK_TSK_TSKCTRL foreign key (TASKCONTROLLER_) references jbpm.JBPM_TASKCONTROLLER;
alter table jbpm.JBPM_TASK add constraint FK_TASK_ASSDEL foreign key (ASSIGNMENTDELEGATION_) references jbpm.JBPM_DELEGATION;
alter table jbpm.JBPM_TASK add constraint FK_TASK_TASKNODE foreign key (TASKNODE_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_TASK add constraint FK_TASK_PROCDEF foreign key (PROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
alter table jbpm.JBPM_TASK add constraint FK_TASK_STARTST foreign key (STARTSTATE_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_TASK add constraint FK_TASK_TASKMGTDEF foreign key (TASKMGMTDEFINITION_) references jbpm.JBPM_MODULEDEFINITION;
alter table jbpm.JBPM_TASK add constraint FK_TASK_SWIMLANE foreign key (SWIMLANE_) references jbpm.JBPM_SWIMLANE;
alter table jbpm.JBPM_TASKACTORPOOL add constraint FK_TSKACTPOL_PLACT foreign key (POOLEDACTOR_) references jbpm.JBPM_POOLEDACTOR;
alter table jbpm.JBPM_TASKACTORPOOL add constraint FK_TASKACTPL_TSKI foreign key (TASKINSTANCE_) references jbpm.JBPM_TASKINSTANCE;
alter table jbpm.JBPM_TASKCONTROLLER add constraint FK_TSKCTRL_DELEG foreign key (TASKCONTROLLERDELEGATION_) references jbpm.JBPM_DELEGATION;
create index IDX_TASKINST_TOKN on jbpm.JBPM_TASKINSTANCE (TOKEN_);
create index IDX_TASKINST_TSK on jbpm.JBPM_TASKINSTANCE (TASK_, PROCINST_);
create index IDX_TSKINST_TMINST on jbpm.JBPM_TASKINSTANCE (TASKMGMTINSTANCE_);
create index IDX_TSKINST_SLINST on jbpm.JBPM_TASKINSTANCE (SWIMLANINSTANCE_);
create index IDX_TASK_ACTORID on jbpm.JBPM_TASKINSTANCE (ACTORID_);
alter table jbpm.JBPM_TASKINSTANCE add constraint FK_TSKINS_PRCINS foreign key (PROCINST_) references jbpm.JBPM_PROCESSINSTANCE;
alter table jbpm.JBPM_TASKINSTANCE add constraint FK_TASKINST_TMINST foreign key (TASKMGMTINSTANCE_) references jbpm.JBPM_MODULEINSTANCE;
alter table jbpm.JBPM_TASKINSTANCE add constraint FK_TASKINST_TOKEN foreign key (TOKEN_) references jbpm.JBPM_TOKEN;
alter table jbpm.JBPM_TASKINSTANCE add constraint FK_TASKINST_SLINST foreign key (SWIMLANINSTANCE_) references jbpm.JBPM_SWIMLANEINSTANCE;
alter table jbpm.JBPM_TASKINSTANCE add constraint FK_TASKINST_TASK foreign key (TASK_) references jbpm.JBPM_TASK;
create index IDX_TOKEN_PROCIN on jbpm.JBPM_TOKEN (PROCESSINSTANCE_);
create index IDX_TOKEN_SUBPI on jbpm.JBPM_TOKEN (SUBPROCESSINSTANCE_);
create index IDX_TOKEN_NODE on jbpm.JBPM_TOKEN (NODE_);
create index IDX_TOKEN_PARENT on jbpm.JBPM_TOKEN (PARENT_);
alter table jbpm.JBPM_TOKEN add constraint FK_TOKEN_PARENT foreign key (PARENT_) references jbpm.JBPM_TOKEN;
alter table jbpm.JBPM_TOKEN add constraint FK_TOKEN_NODE foreign key (NODE_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_TOKEN add constraint FK_TOKEN_PROCINST foreign key (PROCESSINSTANCE_) references jbpm.JBPM_PROCESSINSTANCE;
alter table jbpm.JBPM_TOKEN add constraint FK_TOKEN_SUBPI foreign key (SUBPROCESSINSTANCE_) references jbpm.JBPM_PROCESSINSTANCE;
create index IDX_TKVARMAP_CTXT on jbpm.JBPM_TOKENVARIABLEMAP (CONTEXTINSTANCE_);
create index IDX_TKVVARMP_TOKEN on jbpm.JBPM_TOKENVARIABLEMAP (TOKEN_);
alter table jbpm.JBPM_TOKENVARIABLEMAP add constraint FK_TKVARMAP_CTXT foreign key (CONTEXTINSTANCE_) references jbpm.JBPM_MODULEINSTANCE;
alter table jbpm.JBPM_TOKENVARIABLEMAP add constraint FK_TKVARMAP_TOKEN foreign key (TOKEN_) references jbpm.JBPM_TOKEN;
create index IDX_TRANSIT_TO on jbpm.JBPM_TRANSITION (TO_);
create index IDX_TRANSIT_FROM on jbpm.JBPM_TRANSITION (FROM_);
create index IDX_TRANS_PROCDEF on jbpm.JBPM_TRANSITION (PROCESSDEFINITION_);
alter table jbpm.JBPM_TRANSITION add constraint FK_TRANSITION_TO foreign key (TO_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_TRANSITION add constraint FK_TRANS_PROCDEF foreign key (PROCESSDEFINITION_) references jbpm.JBPM_PROCESSDEFINITION;
alter table jbpm.JBPM_TRANSITION add constraint FK_TRANSITION_FROM foreign key (FROM_) references jbpm.JBPM_NODE;
alter table jbpm.JBPM_VARIABLEACCESS add constraint FK_VARACC_TSKCTRL foreign key (TASKCONTROLLER_) references jbpm.JBPM_TASKCONTROLLER;
alter table jbpm.JBPM_VARIABLEACCESS add constraint FK_VARACC_SCRIPT foreign key (SCRIPT_) references jbpm.JBPM_ACTION;
alter table jbpm.JBPM_VARIABLEACCESS add constraint FK_VARACC_PROCST foreign key (PROCESSSTATE_) references jbpm.JBPM_NODE;
create index IDX_VARINST_TKVARMP on jbpm.JBPM_VARIABLEINSTANCE (TOKENVARIABLEMAP_);
create index IDX_VARINST_PRCINS on jbpm.JBPM_VARIABLEINSTANCE (PROCESSINSTANCE_);
create index IDX_VARINST_TK on jbpm.JBPM_VARIABLEINSTANCE (TOKEN_);
alter table jbpm.JBPM_VARIABLEINSTANCE add constraint FK_VARINST_TK foreign key (TOKEN_) references jbpm.JBPM_TOKEN;
alter table jbpm.JBPM_VARIABLEINSTANCE add constraint FK_VARINST_TKVARMP foreign key (TOKENVARIABLEMAP_) references jbpm.JBPM_TOKENVARIABLEMAP;
alter table jbpm.JBPM_VARIABLEINSTANCE add constraint FK_VARINST_PRCINST foreign key (PROCESSINSTANCE_) references jbpm.JBPM_PROCESSINSTANCE;
alter table jbpm.JBPM_VARIABLEINSTANCE add constraint FK_VAR_TSKINST foreign key (TASKINSTANCE_) references jbpm.JBPM_TASKINSTANCE;
alter table jbpm.JBPM_VARIABLEINSTANCE add constraint FK_BYTEINST_ARRAY foreign key (BYTEARRAYVALUE_) references jbpm.JBPM_BYTEARRAY;
create sequence jbpm.hibernate_sequence;

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
