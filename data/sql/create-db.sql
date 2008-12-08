CREATE ROLE "escidoc" LOGIN PASSWORD 'escidoc' VALID UNTIL 'infinity';
CREATE DATABASE "escidoc-core" WITH ENCODING='UTF8' OWNER="escidoc";

CREATE ROLE "fedoraAdmin" LOGIN PASSWORD 'fedoraAdmin' VALID UNTIL 'infinity';
CREATE DATABASE "fedora31" WITH ENCODING='UTF8' OWNER='fedoraAdmin';
CREATE DATABASE "riTriples" WITH ENCODING='SQL_ASCII' OWNER='fedoraAdmin';
