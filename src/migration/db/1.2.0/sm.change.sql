ALTER TABLE sm.report_definitions ADD COLUMN name VARCHAR (255);
UPDATE sm.report_definitions SET name = substring(xml_data, '.*?<[^>/]*?name>(.*?)</[^>]*?name>.*');
UPDATE sm.report_definitions SET name = 'noname' WHERE NAME IS NULL;
ALTER TABLE sm.report_definitions ALTER COLUMN name SET NOT NULL;

INSERT INTO sm.scopes (id, xml_data) VALUES ('escidoc:scope1','<?xml version="1.0" encoding="UTF-8"?>
<scope xmlns="http://www.escidoc.de/schemas/scope/0.3" objid="escidoc:scope1">
	<name>Scope for Framework</name>
	<type>normal</type>
</scope>');

INSERT INTO sm.scopes (id, xml_data) VALUES ('escidoc:scope2','<?xml version="1.0" encoding="UTF-8"?>
<scope xmlns="http://www.escidoc.de/schemas/scope/0.3" objid="escidoc:scope2">
	<name>Admin Scope</name>
	<type>admin</type>
</scope>');

INSERT INTO sm.aggregation_definitions (id, xml_data, scope_id) VALUES ('escidoc:aggdef1', '<?xml version="1.0" encoding="UTF-8"?>
<aggregation-definition xmlns="http://www.escidoc.de/schemas/aggregationdefinition/0.3" objid="escidoc:aggdef1">
	<name>Page Statistics for Framework</name> 
	<scope objid="escidoc:scope1" />
	<aggregation-table>
		<name>_escidocaggdef1_Request_Statistics</name>
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
			<name>_escidocaggdef1_time1_idx</name>
			<field>day</field>
			<field>month</field>
			<field>year</field>
		</index>
		<index>
			<name>_escidocaggdef1_time2_idx</name>
			<field>month</field>
			<field>year</field>
		</index>
	</aggregation-table>
	<aggregation-table>
		<name>_escidocaggdef1_Object_Statistics</name>
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
			<name>_escidocaggdef1_time3_idx</name>
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
', 'escidoc:scope1');

INSERT INTO sm.aggregation_definitions (id, xml_data, scope_id) VALUES ('escidoc:aggdef2', '<?xml version="1.0" encoding="UTF-8"?>
<aggregation-definition xmlns="http://www.escidoc.de/schemas/aggregationdefinition/0.3" objid="escidoc:aggdef2">
	<name>Error Statistics for Framework</name>
	<scope objid="escidoc:scope1" />
	<aggregation-table>
		<name>_escidocaggdef2_Error_Statistics</name>
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
			<name>_escidocaggdef2_time1_idx</name>
			<field>day</field>
			<field>month</field>
			<field>year</field>
		</index>
		<index>
			<name>_escidocaggdef2_time2_idx</name>
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
', 'escidoc:scope1');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef1', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef1">	<name>Successful Framework Requests</name>   <scope objid="escidoc:scope1" />	<sql>		select 		handler, request, day, month, year, sum(requests) 		from _escidocaggdef1_request_statistics		group by handler, request, day, month, year;	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope1', 'Successful Framework Requests');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef2', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef2">	<name>Unsuccessful Framework Requests</name>  <scope objid="escidoc:scope1" />	<sql>		select * 		from _escidocaggdef2_error_statistics;	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope1', 'Unsuccessful Framework Requests');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef3', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef3">	<name>Successful Framework Requests by Month and Year</name>  <scope objid="escidoc:scope1" />	<sql>		select *		from _escidocaggdef1_request_statistics		where month = {month} and year = {year};	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope1', 'Successful Framework Requests by Month and Year');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef4', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef4">	<name>Item retrievals, all users</name>  <scope objid="escidoc:scope2" />	<sql>		select object_id as itemid, sum(requests) as itemrequests		from _escidocaggdef1_object_statistics		where object_id = {object_id} and handler=''de.escidoc.core.om.service.ItemHandler'' and request=''retrieve'' group by object_id;	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope2', 'Item retrievals, all users');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef5', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef5">	<name>File downloads per Item, all users</name>  <scope objid="escidoc:scope2" />	<sql>		select parent_object_id as itemid, sum(requests)	as filerequests	from _escidocaggdef1_object_statistics		where parent_object_id = {object_id} and handler=''de.escidoc.core.om.service.ItemHandler'' and request=''retrieveContent'' group by parent_object_id;	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope2', 'File downloads per Item, all users');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef6', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef6">	<name>File downloads, all users</name>  <scope objid="escidoc:scope2" />	<sql>		select object_id as fileid, sum(requests) as filerequests		from _escidocaggdef1_object_statistics		where object_id = {object_id} and handler=''de.escidoc.core.om.service.ItemHandler'' and request=''retrieveContent'' group by object_id;	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope2', 'File downloads, all users');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef7', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef7">	<name>Item retrievals, anonymous users</name>  <scope objid="escidoc:scope2" />	<sql>		select object_id as itemid, sum(requests) as itemrequests		from _escidocaggdef1_object_statistics		where object_id = {object_id} and handler=''de.escidoc.core.om.service.ItemHandler'' and request=''retrieve'' and user_id='''' group by object_id;	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope2', 'Item retrievals, anonymous users');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef8', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef8">	<name>File downloads per Item, anonymous users</name>  <scope objid="escidoc:scope2" />	<sql>		select parent_object_id as itemid, sum(requests)	as filerequests	from _escidocaggdef1_object_statistics		where parent_object_id = {object_id} and handler=''de.escidoc.core.om.service.ItemHandler'' and request=''retrieveContent'' and user_id='''' group by parent_object_id;	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope2', 'File downloads per Item, anonymous users');

INSERT INTO sm.report_definitions (id, xml_data, scope_id, name) 
VALUES ('escidoc:repdef9', '<?xml version="1.0" encoding="UTF-8"?><report-definition xmlns="http://www.escidoc.de/schemas/reportdefinition/0.3" objid="escidoc:repdef9">	<name>File downloads, anonymous users</name>  <scope objid="escidoc:scope2" />	<sql>		select object_id as fileid, sum(requests) as filerequests		from _escidocaggdef1_object_statistics		where object_id = {object_id} and handler=''de.escidoc.core.om.service.ItemHandler'' and request=''retrieveContent'' and user_id='''' group by object_id;	</sql><allowed-roles><allowed-role objid="default-user" /></allowed-roles></report-definition>', 'escidoc:scope2', 'File downloads, anonymous users');

DROP INDEX sm._1_time1_idx;

DROP INDEX sm._1_time2_idx;

DROP INDEX sm._1_time3_idx;

DROP INDEX sm._2_time1_idx;

DROP INDEX sm._2_time2_idx;

ALTER TABLE sm._1_request_statistics RENAME TO _escidocaggdef1_request_statistics;

ALTER TABLE sm._1_object_statistics RENAME TO _escidocaggdef1_object_statistics;

ALTER TABLE sm._2_error_statistics RENAME TO _escidocaggdef2_error_statistics;

CREATE INDEX _escidocaggdef1_time1_idx
ON sm._escidocaggdef1_request_statistics (day, month, year);

CREATE INDEX _escidocaggdef1_time2_idx
ON sm._escidocaggdef1_request_statistics (month, year);

CREATE INDEX _escidocaggdef1_time3_idx
ON sm._escidocaggdef1_object_statistics (month, year);

CREATE INDEX _escidocaggdef2_time1_idx
ON sm._escidocaggdef2_error_statistics (day, month, year);

CREATE INDEX _escidocaggdef2_time2_idx
ON sm._escidocaggdef2_error_statistics (month, year);

DELETE FROM sm.report_definitions WHERE id IN ('1','2','3','4','5','6','7','8','9');
UPDATE sm.report_definitions SET xml_data = REPLACE(xml_data, '<scope objid="1"', '<scope objid="escidoc:scope1"') WHERE scope_id = '1';
UPDATE sm.report_definitions SET xml_data = REPLACE(xml_data, '<scope objid="2"', '<scope objid="escidoc:scope2"') WHERE scope_id = '2';
UPDATE sm.report_definitions SET scope_id = 'escidoc:scope1' WHERE scope_id = '1';
UPDATE sm.report_definitions SET scope_id = 'escidoc:scope2' WHERE scope_id = '2';

DELETE FROM sm.aggregation_definitions WHERE id IN ('1','2');
UPDATE sm.aggregation_definitions SET xml_data = REPLACE(xml_data, '<scope objid="1"', '<scope objid="escidoc:scope1"') WHERE scope_id = '1';
UPDATE sm.aggregation_definitions SET xml_data = REPLACE(xml_data, '<scope objid="2"', '<scope objid="escidoc:scope2"') WHERE scope_id = '2';
UPDATE sm.aggregation_definitions SET scope_id = 'escidoc:scope1' WHERE scope_id = '1';
UPDATE sm.aggregation_definitions SET scope_id = 'escidoc:scope2' WHERE scope_id = '2';

UPDATE sm.statistic_data SET xml_data = REPLACE(xml_data, '<scope objid="1"', '<scope objid="escidoc:scope1"') WHERE scope_id = '1';
UPDATE sm.statistic_data SET xml_data = REPLACE(xml_data, '<scope objid="2"', '<scope objid="escidoc:scope2"') WHERE scope_id = '2';
UPDATE sm.statistic_data SET scope_id = 'escidoc:scope2' WHERE scope_id = '2';
UPDATE sm.statistic_data SET scope_id = 'escidoc:scope1' WHERE scope_id = '1';

DELETE FROM sm.scopes WHERE id IN ('1','2');

