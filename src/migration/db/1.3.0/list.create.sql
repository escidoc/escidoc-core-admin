DROP TABLE IF EXISTS list.property CASCADE;

DROP TABLE IF EXISTS list.container        CASCADE;
DROP TABLE IF EXISTS list.content_relation CASCADE;
DROP TABLE IF EXISTS list.context          CASCADE;
DROP TABLE IF EXISTS list.item             CASCADE;
DROP TABLE IF EXISTS list.ou               CASCADE;

DROP TABLE IF EXISTS list.filter CASCADE;

CREATE TABLE list.filter (
  role_id                       TEXT,
  type                          TEXT NOT NULL,
  scope_rule                    TEXT NOT NULL,
  policy_rule                   TEXT NOT NULL,
  CONSTRAINT FK_FILTER_ROLE_ID FOREIGN KEY (role_id) REFERENCES aa.escidoc_role(id)
);

DROP TYPE IF EXISTS resource CASCADE;
