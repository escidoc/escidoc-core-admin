CREATE SCHEMA sm;

CREATE TABLE sm.scopes ( 
  id INTEGER unique not null primary key,
  xml_data TEXT NOT NULL
);

CREATE TABLE sm.statistic_data ( 
  id INTEGER unique not null primary key,
  xml_data TEXT NOT NULL,
  scope_id INTEGER NOT NULL,
  timemarker TIMESTAMP without time zone NOT NULL,
   CONSTRAINT FK_SCOPE_ID FOREIGN KEY (scope_id) REFERENCES sm.scopes
   ON DELETE CASCADE
);

CREATE TABLE sm.aggregation_definitions ( 
  id INTEGER unique not null primary key,
  xml_data TEXT NOT NULL,
  scope_id INTEGER NOT NULL,
   CONSTRAINT FK_SCOPE_ID FOREIGN KEY (scope_id) REFERENCES sm.scopes
   ON DELETE CASCADE
);

CREATE INDEX agg_def_scope_id_idx
ON sm.aggregation_definitions (scope_id);

CREATE TABLE sm.report_definitions ( 
  id INTEGER unique not null primary key,
  xml_data TEXT NOT NULL,
  scope_id INTEGER NOT NULL,
   CONSTRAINT FK_SCOPE_ID FOREIGN KEY (scope_id) REFERENCES sm.scopes
   ON DELETE CASCADE
);

CREATE INDEX rep_def_scope_id_idx
ON sm.report_definitions (scope_id);

CREATE INDEX timestamp_scope_id_idx
ON sm.statistic_data (date_trunc( 'day',timemarker),scope_id);

create table sm.ESCIDOC_SM_IDS (
	tablename VARCHAR(255) unique not null primary key,
	id INTEGER
);

CREATE INDEX sm_ids_table_idx
	ON sm.ESCIDOC_SM_IDS (TABLENAME);
	
INSERT INTO sm.ESCIDOC_SM_IDS (TABLENAME, ID)
	VALUES ('AGGREGATION_DEFINITIONS', 10);

INSERT INTO sm.scopes (id, xml_data) VALUES (1,'<?xml version="1.0" encoding="UTF-8"?>
<scope xmlns="http://www.escidoc.de/schemas/scope/0.3" objid="1">
	<name>Scope for Framework</name>
	<type>normal</type>
</scope>');

INSERT INTO sm.scopes (id, xml_data) VALUES (2,'<?xml version="1.0" encoding="UTF-8"?>
<scope xmlns="http://www.escidoc.de/schemas/scope/0.3" objid="2">
	<name>Admin Scope</name>
	<type>admin</type>
</scope>');

INSERT INTO sm.aggregation_definitions (id, xml_data, scope_id) VALUES (1, '<?xml version="1.0" encoding="UTF-8"?>
<aggregation-definition xmlns="http://www.escidoc.de/schemas/aggregationdefinition/0.3" objid="1">
	<name>Page Statistics for Framework</name> 
	<scope objid="1" />
	<aggregation-table>
		<name>_1_Request_Statistics</name>
		<field>
			<info-field feed="statistics-data">
				<name>handler</name>
				<type>text</type>
				<xpath>//parameter[@name="handler"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>request</name>
				<type>text</type>
				<xpath>//parameter[@name="request"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>interface</name>
				<type>text</type>
				<xpath>//parameter[@name="interface"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<time-reduction-field feed="statistics-data">
				<name>day</name>
				<reduce-to>day</reduce-to>
			</time-reduction-field>
		</field>
		<field>
			<time-reduction-field feed="statistics-data">
				<name>month</name>
				<reduce-to>month</reduce-to>
			</time-reduction-field>
		</field>
		<field>
			<time-reduction-field feed="statistics-data">
				<name>year</name>
				<reduce-to>year</reduce-to>
			</time-reduction-field>
		</field>
		<field>
			<count-cumulation-field>
				<name>requests</name>
			</count-cumulation-field>
		</field>
		<index>
			<name>_1_time1_idx</name>
			<field>day</field>
			<field>month</field>
			<field>year</field>
		</index>
		<index>
			<name>_1_time2_idx</name>
			<field>month</field>
			<field>year</field>
		</index>
	</aggregation-table>
	<aggregation-table>
		<name>_1_Object_Statistics</name>
		<field>
			<info-field feed="statistics-data">
				<name>handler</name>
				<type>text</type>
				<xpath>//parameter[@name="handler"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>request</name>
				<type>text</type>
				<xpath>//parameter[@name="request"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>object_id</name>
				<type>text</type>
				<xpath>//parameter[@name="object_id"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>parent_object_id</name>
				<type>text</type>
				<xpath>//parameter[@name="parent_object_id1"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>user_id</name>
				<type>text</type>
				<xpath>//parameter[@name="user_id"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<time-reduction-field feed="statistics-data">
				<name>month</name>
				<reduce-to>month</reduce-to>
			</time-reduction-field>
		</field>
		<field>
			<time-reduction-field feed="statistics-data">
				<name>year</name>
				<reduce-to>year</reduce-to>
			</time-reduction-field>
		</field>
		<field>
			<count-cumulation-field>
				<name>requests</name>
			</count-cumulation-field>
		</field>
		<index>
			<name>_1_time3_idx</name>
			<field>month</field>
			<field>year</field>
		</index>
	</aggregation-table>
	<statistic-data>
		<statistic-table>
			<xpath>//parameter[@name="successful"]/*=''1'' 
			AND //parameter[@name="internal"]/*=''0''</xpath>
		</statistic-table>
	</statistic-data>
</aggregation-definition>
', 1);

CREATE TABLE sm._1_request_statistics ( 
  handler TEXT NOT NULL,
  request TEXT NOT NULL,
  interface TEXT NOT NULL,
  day NUMERIC NOT NULL,
  month NUMERIC NOT NULL,
  year NUMERIC NOT NULL,
  requests NUMERIC NOT NULL
);

CREATE TABLE sm._1_object_statistics ( 
  handler TEXT NOT NULL,
  request TEXT NOT NULL,
  object_id TEXT NOT NULL,
  parent_object_id TEXT NOT NULL,
  user_id TEXT NOT NULL,
  month NUMERIC NOT NULL,
  year NUMERIC NOT NULL,
  requests NUMERIC NOT NULL
);

CREATE INDEX _1_time1_idx
ON sm._1_request_statistics (day, month, year);

CREATE INDEX _1_time2_idx
ON sm._1_request_statistics (month, year);

CREATE INDEX _1_time3_idx
ON sm._1_object_statistics (month, year);

INSERT INTO sm.aggregation_definitions (id, xml_data, scope_id) VALUES (2, '<?xml version="1.0" encoding="UTF-8"?>
<aggregation-definition xmlns="http://www.escidoc.de/schemas/aggregationdefinition/0.3" objid="2">
	<name>Error Statistics for Framework</name>
	<scope objid="1" />
	<aggregation-table>
		<name>_2_Error_Statistics</name>
		<field>
			<info-field feed="statistics-data">
				<name>handler</name>
				<type>text</type>
				<xpath>//parameter[@name="handler"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>request</name>
				<type>text</type>
				<xpath>//parameter[@name="request"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>interface</name>
				<type>text</type>
				<xpath>//parameter[@name="interface"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<info-field feed="statistics-data">
				<name>exception_name</name>
				<type>text</type>
				<xpath>//parameter[@name="exception_name"]/stringvalue</xpath>
			</info-field>
		</field>
		<field>
			<time-reduction-field feed="statistics-data">
				<name>day</name>
				<reduce-to>day</reduce-to>
			</time-reduction-field>
		</field>
		<field>
			<time-reduction-field feed="statistics-data">
				<name>month</name>
				<reduce-to>month</reduce-to>
			</time-reduction-field>
		</field>
		<field>
			<time-reduction-field feed="statistics-data">
				<name>year</name>
				<reduce-to>year</reduce-to>
			</time-reduction-field>
		</field>
		<field>
			<count-cumulation-field>
				<name>requests</name>
			</count-cumulation-field>
		</field>
		<index>
			<name>_1_time1_idx</name>
			<field>day</field>
			<field>month</field>
			<field>year</field>
		</index>
		<index>
			<name>_1_time2_idx</name>
			<field>month</field>
			<field>year</field>
		</index>
	</aggregation-table>
	<statistic-data>
		<statistic-table>
			<xpath>//parameter[@name="successful"]/*=''0''</xpath>
		</statistic-table>
	</statistic-data>
</aggregation-definition>
', 1);

CREATE TABLE sm._2_error_statistics ( 
  handler TEXT NOT NULL,
  request TEXT NOT NULL,
  interface TEXT NOT NULL,
  exception_name TEXT NOT NULL,
  day NUMERIC NOT NULL,
  month NUMERIC NOT NULL,
  year NUMERIC NOT NULL,
  requests NUMERIC NOT NULL
);

CREATE INDEX _2_time1_idx
ON sm._2_error_statistics (day, month, year);

CREATE INDEX _2_time2_idx
ON sm._2_error_statistics (month, year);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (1, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="1">	<name>Successful Framework Requests</name>   <scope objid="1" />	<sql>		select 		handler, request, day, month, year, sum(requests) 		from _1_request_statistics		group by handler, request, day, month, year;	</sql></report-definition>', 1);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (2, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="2">	<name>Unsuccessful Framework Requests</name>  <scope objid="1" />	<sql>		select * 		from _2_error_statistics;	</sql> </report-definition>', 1);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (3, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="3">	<name>Successful Framework Requests by Month and Year</name>  <scope objid="1" />	<sql>		select *		from _1_request_statistics		where month = {month} and year = {year};	</sql> </report-definition>', 1);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (4, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="4">	<name>Item retrievals, all users</name>  <scope objid="2" />	<sql>		select object_id as itemId, sum(requests) as itemRequests		from _1_object_statistics		where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieve'' group by object_id;	</sql> </report-definition>', 2);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (5, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="5">	<name>File downloads per Item, all users</name>  <scope objid="2" />	<sql>		select parent_object_id as itemId, sum(requests)	as fileRequests	from _1_object_statistics		where parent_object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' group by parent_object_id;	</sql> </report-definition>', 2);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (6, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="6">	<name>File downloads, all users</name>  <scope objid="2" />	<sql>		select object_id as fileId, sum(requests) as fileRequests		from _1_object_statistics		where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' group by object_id;	</sql> </report-definition>', 2);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (7, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="7">	<name>Item retrievals, anonymous users</name>  <scope objid="2" />	<sql>		select object_id as itemId, sum(requests) as itemRequests		from _1_object_statistics		where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieve'' and user_id='''' group by object_id;	</sql> </report-definition>', 2);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (8, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="8">	<name>File downloads per Item, anonymous users</name>  <scope objid="2" />	<sql>		select parent_object_id as itemId, sum(requests)	as fileRequests	from _1_object_statistics		where parent_object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' and user_id='''' group by parent_object_id;	</sql> </report-definition>', 2);

INSERT INTO sm.report_definitions (id, xml_data, scope_id) VALUES (9, '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="9">	<name>File downloads, anonymous users</name>  <scope objid="2" />	<sql>		select object_id as fileId, sum(requests) as fileRequests		from _1_object_statistics		where object_id = {object_id} and handler=''ItemHandler'' and request=''retrieveContent'' and user_id='''' group by object_id;	</sql> </report-definition>', 2);


    