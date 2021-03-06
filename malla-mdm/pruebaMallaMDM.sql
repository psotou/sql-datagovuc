select * from information_schema.tables where table_schema like '%mdiuc%'

-- Tables prepared for testing purposes
SELECT * FROM MDIUC.PERSON_TEST
SELECT *
FROM MDIUC.PERSON_TEST_2
SELECT * FROM MDIUC.COUNTRY

select *
from MCP_MDIUC.PROCESSED_PERSON_TEST
where rut in ('14545147', '15337074')
select *
from MCP_MDIUC.PROCESSING_PERSON_TEST
where primary_key in ('14545147', '15337074')

select *
from MCP_MDIUC.CONFLICTIVE_PERSON_TEST
--primero en la tabla y luego a databricks; la corrección se carga luego desde databricks hacia RESOLUTION
select *
from MCP_MDIUC.RESOLUTION_PERSON_TEST

exec sp_help 'MCP_MDIUC.PROCESSED_PERSON_TEST'

update MCP_MDIUC.ENTITY 
set is_valid = 
    case 
        when is_valid = 1 then 0
        else 1 
    end;

-- TRUNCATE TABLE MCP_MDIUC.PROCESSED_PERSON_TEST
-- TRUNCATE TABLE MCP_MDIUC.PROCESSING_PERSON_TEST

TRUNCATE TABLE MDIUC.PERSON_TEST

EXEC UTILS.ColumnTypes N'MDIUC', N'PERSON_TEST'
-- EN EL PASO 0 LA TABLA SÍ SE CREA MANUAL

/* RESOLUCIÓN DE CONFLICTOS */

-- Si los grupos existen en CONFLICTIVE, se resuelven en RESOLUTION

-- Tables we have to manually populate
SELECT * FROM MCP_MDIUC.ENTITY
SELECT * FROM MCP_MDIUC.ENTITY_ATTRIBUTE
SELECT * FROM MCP_MDIUC.ENTITY_SYSTEM_TABLE
SELECT * FROM MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING
SELECT * FROM MCP_MDIUC.GROUPING_RULE
SELECT * FROM MCP_MDIUC.COMPARING_RULE

DELETE MCP_MDIUC.ENTITY_ATTRIBUTE WHERE entity_attribute_id in (73, 77)
UPDATE MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING SET attribute_rank = 2 WHERE entity_system_table_id = 33
UPDATE MCP_MDIUC.COMPARING_RULE SET parameter = '' where rule_type = N'exact'

-- UPDATE MCP_MDIUC.ENTITY SET is_valid = 0 WHERE entity_id = 19

-- We can safely truncate theses ones
TRUNCATE TABLE MCP_MDIUC.COMPARING_RULE
TRUNCATE TABLE MCP_MDIUC.GROUPING_RULE
TRUNCATE TABLE MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING

-- But, due to some of their columns being referenced as FK by other tables, we cannot truncate these tables. So we delete their rows
DELETE FROM MCP_MDIUC.ENTITY_SYSTEM_TABLE WHERE entity_system_table_id IN (SELECT entity_system_table_id
FROM MCP_MDIUC.ENTITY_SYSTEM_TABLE)
DELETE FROM MCP_MDIUC.ENTITY_ATTRIBUTE WHERE entity_attribute_id IN (SELECT entity_attribute_id
FROM MCP_MDIUC.ENTITY_ATTRIBUTE)
DELETE FROM MCP_MDIUC.ENTITY WHERE entity_id IN (SELECT entity_id
FROM MCP_MDIUC.ENTITY)

-- Once this is done, we procede to populate the tables
-- ENTITY
INSERT INTO MCP_MDIUC.ENTITY ([name], is_valid, has_official_source)
VALUES ('PERSON_TEST', 1, 0)
    ,  ('COUNTRY', 1, 1)

-- ENTITY_ATTRIBUTE
INSERT INTO MCP_MDIUC.ENTITY_ATTRIBUTE (entity_id, attribute_name, attribute_type, is_primary_key)
VALUES (18, N'rut', 'nvarchar', 1)
    ,  (18, N'dv', 'nvarchar', 0)
    ,  (18, N'tipo_id', 'int', 0)
    ,  (18, N'paternal_last_name', 'nvarchar', 0)
    ,  (18, N'maternal_last_name', 'nvarchar', 0)
    ,  (18, N'name', 'nvarchar', 0)
    ,  (18, N'created_at', 'datetime2', 0)
    ,  (19, 'iso_code', 'varchar', 1)
    ,  (19, 'english_name', 'varchar', 0)
    ,  (19, 'spanish_name', 'varchar', 0)
    ,  (19, 'dial_code', 'int', 0)
    ,  (19, 'is_active', 'int', 0)
    ,  (19, 'end_date', 'datetime2', 0)

declare @entityId int;
set @entityId = (select entity_id
from mcp_mdiuc.entity
where name = 'PERSON_TEST')
SELECT @entityId

select *
from UTILS.ColumnDescrition ('comuna', 'cod_comuna')
select *
from [UTILS].[ColumnType] ('mdiuc', 'person')

-- ENTITY_SYSTEM_TABLE
INSERT INTO MCP_MDIUC.ENTITY_SYSTEM_TABLE(entity_id, [schema_name], table_name, primary_key)
VALUES (18, 'NORMALIZADO_TEST', 'PERSON_BANNER', 'rut')
    ,  (18, 'NORMALIZADO_TEST', 'PERSON_PEOPLE_SOFT', 'rut')
    ,  (19, 'UC_BANNER', 'PAIS', 'COD_PAIS')
    ,  (19, 'NORMALIZADO_PEOPLE_SOFT', 'COUNTRY', 'code')

-- ENTITY_ATTRIBUTE_SYSTEM_MAPPING
INSERT INTO MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING (entity_attribute_id, entity_system_table_id, column_name, attribute_rank)
VALUES (80, 34, 'NOM_PAIS_INGLES', 1)
    ,  (80, 35, 'name', 1)

-- GROUPING_RULE
INSERT INTO MCP_MDIUC.GROUPING_RULE
VALUES
(74),
(75)

-- COMPARING_RULE
INSERT INTO MCP_MDIUC.COMPARING_RULE (entity_attribute_id, rule_type, parameter, process)
VALUES
(74, 'fuzzy', 70, 'concat'),
(75, 'fuzzy', 70, 'concat')



EXECUTE MDIUC.ColumnTypes N'MCP_MDIUC', N'GROUPING_RULE'

SELECT TOP 10 * FROM NORMALIZADO_TEST.PERSON_BANNER
SELECT TOP 10 * FROM NORMALIZADO_TEST.PERSON_PEOPLE_SOFT


SELECT * FROM MCP_MDIUC.ENTITY_ATTRIBUTE
SELECT * FROM MCP_MDIUC.ENTITY_SYSTEM_TABLE

SELECT TOP 3 * FROM UC_BANNER.PAIS
SELECT TOP 3 * FROM NORMALIZADO_PEOPLE_SOFT.COUNTRY


SELECT TOP 14
    *
FROM MCP_MDIUC.LOG
ORDER BY log_id DESC

exec sp_help 'MCP_MDIUC.PROCESSING_PERSON_TEST'