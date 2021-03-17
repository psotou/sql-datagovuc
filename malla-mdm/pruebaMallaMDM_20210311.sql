SELECT * FROM MCP.MCP_ESPACIO_OCUPADO_BD

SELECT 
  schema_name(b.schema_id)
  ,object_name(a.object_id)
  ,c.RowCounts
FROM sys.columns a
LEFT JOIN sys.objects b 
  ON a.object_id = b.object_id
LEFT JOIN MCP.MCP_ESPACIO_OCUPADO_BD c 
  ON c.TableName = object_name(a.object_id)
WHERE b.name like  '%ACADEMIC_UNIT%'
  AND RowCounts < 100 and RowCounts <> 0
order by c.RowCounts


-- *******************************************************************************************
-- TABLAS CANDIDATAS PARA LA PRUEBA DE LA MALLA MDM
-- *******************************************************************************************
-- Prueba 1
select top 4 * from GOBDI.UNIDAD_ACADEMICA -- rank 1
select top 4 * from CORP.UNIDAD_ACADEMICA  -- rank 2

-- Prueba 2
select top 4 * from UC_BANNER.UNIDAD_ACADEM

select 
    gua.unidad as gobdi_nombre
    , cua.unidad as corp_nombre
from GOBDI.UNIDAD_ACADEMICA as gua
left join CORP.UNIDAD_ACADEMICA as cua 
    on gua.id_unidad = cua.id_unidad
where cua.unidad is null

-- cruce uc_banner - gobdi
select
      ubua.nom_unidad_academ
    , gua.COD_UNIDAD_ACADEM
    , gua.unidad
    , gua.facultad
from UC_BANNER.UNIDAD_ACADEM as ubua
join GOBDI.UNIDAD_ACADEMICA as gua 
    on ubua.cod_unidad_academ = gua.COD_UNIDAD_ACADEM


-- Vamos a comparar por nombre. Columna UNIDAD en CORP.UNIDAD_ACADEMICA y NOM_UNIDAD_ACADEM en UC_BANNER.UNIDAD_ACADEM

select top 4 * from NORMALIZADO_BANNER.ACADEMIC_UNIT
select top 4 * from UC_BANNER.UNIDAD_ACADEM

CREATE TABLE MDIUC.UNIDAD_ACADEMICA_TEST (
      unidad_academica_id INT
    , nombre_unidad_academica NVARCHAR(150)
    , facultad_id INT
    , created_at DATETIME2
)

ALTER TABLE MDIUC.UNIDAD_ACADEMICA_TEST
ALTER COLUMN facultad_id nvarchar(50);



select * from utils.ColumnType('MDIUC', 'UNIDAD_ACADEMICA_TEST')
select * from utils.ColumnType('GOBDI', 'UNIDAD_ACADEMICA')
select * from utils.ColumnType('CORP', 'UNIDAD_ACADEMICA')


--*************************************************
-- PRUEBA 1
-- Criterio de agrupación: nombre unidad académica
-- Tipo comparación: fuzzy con 50%
--*************************************************

-- ENTIDAD CREADA PARA LA PRUEBA
select * from MDIUC.UNIDAD_ACADEMICA_TEST 

-- TABLAS DE ORIGEN PARA COMPARAR 
select top 4 * from GOBDI.UNIDAD_ACADEMICA -- rank 1
select top 4 * from CORP.UNIDAD_ACADEMICA  -- rank 2

-- LLENADO DE LAS ENTIDADES
-- ENTITY
select * from MCP_MDIUC.ENTITY

INSERT INTO MCP_MDIUC.ENTITY ([name], is_valid, has_official_source)
VALUES 
      ('UNIDAD_ACADEMICA_TEST',1,0)

update MCP_MDIUC.ENTITY
set is_valid = 1 
where entity_id = 38

-- ENTITY_ATTRIBUTE
select * from MCP_MDIUC.ENTITY_ATTRIBUTE

INSERT INTO MCP_MDIUC.ENTITY_ATTRIBUTE (entity_id, attribute_name, attribute_type, is_primary_key)
VALUES
      (38,'unidad_academica_id','int',1)
    , (38,'nombre_unidad_academica','nvarchar',0)
    , (38,'facultad_id','nvarchar',0)

UPDATE MCP_MDIUC.ENTITY_ATTRIBUTE
SET is_primary_key = 0
where entity_id = 38

-- ENTITY_SYSTEM_TABLE
select * from MCP_MDIUC.ENTITY_SYSTEM_TABLE

INSERT INTO MCP_MDIUC.ENTITY_SYSTEM_TABLE(entity_id, [schema_name], table_name, primary_key)
VALUES
      (38,'GOBDI','UNIDAD_ACADEMICA','ID_UNIDAD')
    , (38,'CORP','UNIDAD_ACADEMICA','ID_UNIDAD')


-- ENTITY_ATTRIBUTE_SYSTEM_MAPPING
select * from MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING

INSERT INTO MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING (entity_attribute_id, entity_system_table_id, column_name, attribute_rank)
VALUES
      (141,64,'ID_UNIDAD',1)
    , (142,64,'UNIDAD',1)
    , (143,64,'ID_FACULTAD',1)
    , (141,65,'ID_UNIDAD',2)
    , (142,65,'UNIDAD',2)
    , (143,65,'ID_FACULTAD',2)

-- GROUPING_RULE
select * from MCP_MDIUC.GROUPING_RULE

INSERT INTO MCP_MDIUC.GROUPING_RULE
VALUES (142)

-- COMPARING_RULE
select * from MCP_MDIUC.COMPARING_RULE

INSERT INTO MCP_MDIUC.COMPARING_RULE (entity_attribute_id, rule_type, parameter, process)
VALUES
      (142,'fuzzy_allow_empty',50,'concat')

-- CHEQUEAMOS EL LOG DEL PROCESO

select top 100 * from MCP_MDIUC.LOG order by log_id desc


-- código de error: 245 - mensaje: Conversion failed when converting the nvarchar value "F_" to data type int.
-- código de error: 2627 - mensaje: Violation of PRIMARY KEY constraint "PK__UNIDAD_A__3CCE0EB661141299". Cannot insert duplicate key in object "MDIUC.UNIDAD_ACADEMICA_TEST". The duplicate key value is (35).

select * from information_schema.tables where table_schema = 'MDIUC'

select * from MCP_MDIUC.PROCESSED_UNIDAD_ACADEMICA_TEST
select * from MCP_MDIUC.PROCESSING_UNIDAD_ACADEMICA_TEST order by group_id
select * from MCP_MDIUC.UNMATCHED_UNIDAD_ACADEMICA_TEST


select * from MCP_MDIUC.ENTITY
select * from MCP_MDIUC.ENTITY_ATTRIBUTE
select * from MCP_MDIUC.ENTITY_SYSTEM_TABLE
select * from MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING
select * from MCP_MDIUC.GROUPING_RULE
select * from MCP_MDIUC.COMPARING_RULE

update MCP_MDIUC.ENTITY
set has_official_source = 0 
where entity_id in (37, 40) -- IMFD tiene las fuentes oficiales con 1

--*************************************************
-- PRUEBA 2
-- Criterio de agrupación: nombre unidad académica
-- Agrupamos por id unidad académica
-- Tipo comparación: fuzzy con 40%
--*************************************************

-- ENTIDAD CREADA PARA LA PRUEBA
select * from MDIUC.UNIDAD_ACADEMICA_TEST 

-- TABLAS DE ORIGEN PARA COMPARAR 
select top 4 * from GOBDI.UNIDAD_ACADEMICA  -- rank 1
select top 4 * from UC_BANNER.UNIDAD_ACADEM -- rank 2

-- LLENADO DE LAS ENTIDADES
-- ENTITY
update MCP_MDIUC.ENTITY
set is_valid = 0 
where entity_id = 40

-- ENTITY_ATTRIBUTE
/* poner aquí la columna que es primary key para la segunda prueba */
select * from MCP_MDIUC.ENTITY_ATTRIBUTE

UPDATE MCP_MDIUC.ENTITY_ATTRIBUTE
SET is_primary_key = 0
where entity_id = 38

UPDATE MCP_MDIUC.ENTITY_ATTRIBUTE
SET is_primary_key = 1
where entity_attribute_id = 141

-- ENTITY_SYSTEM_TABLE
select * from MCP_MDIUC.ENTITY_SYSTEM_TABLE

UPDATE MCP_MDIUC.ENTITY_SYSTEM_TABLE
SET primary_key = 'COD_UNIDAD_ACADEM'
where entity_system_table_id = 64

UPDATE MCP_MDIUC.ENTITY_SYSTEM_TABLE
SET [schema_name] = 'UC_BANNER'
  , table_name = 'UNIDAD_ACADEM'
  , primary_key = 'COD_UNIDAD_ACADEM'
where entity_system_table_id = 65


-- ENTITY_ATTRIBUTE_SYSTEM_MAPPING
select * from MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING

update MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING
-- set column_name = 'COD_UNIDAD_ACADEM'
-- where entity_attribute_system_mapping = 49
-- set column_name = 'NOM_UNIDAD_ACADEM'
-- where entity_attribute_system_mapping = 50
set column_name = 'COD_UNIDAD_ACADEM'
where entity_attribute_system_mapping = 46

-- GROUPING_RULE
/* agrupamos por id de unidad académica */
select * from MCP_MDIUC.GROUPING_RULE

UPDATE MCP_MDIUC.GROUPING_RULE
set entity_attribute_id = 141
where grouping_rule_id = 6

-- COMPARING_RULE
/* comparamos los nombres de las unidades académicas */
select * from MCP_MDIUC.COMPARING_RULE

INSERT INTO MCP_MDIUC.COMPARING_RULE (entity_attribute_id, rule_type, parameter, process)
VALUES
      (142,'fuzzy_allow_empty',50,'concat')

-- CHEQUEAMOS EL LOG DEL PROCESO

select top 100 * from MCP_MDIUC.LOG order by log_id desc

-- truncate table select * from MDIUC.UNIDAD_ACADEMICA_TEST 


--*************************************************
-- PRUEBA 4
-- Criterio de agrupación: nombre paises
-- Agrupamos por dial coe y cod pais
-- Tipo comparación: fuzzy con 50%
--*************************************************

select top 10 * from MDIUC.IMFD_COUNTRY order by dial_code 
select top 10 * from UC_BANNER.PAIS order by cod_pais

select 
  mic.spanish_name
  , ubp.NOM_PAIS
from MDIUC.IMFD_COUNTRY as mic 
left join UC_BANNER.PAIS as ubp 
  on mic.dial_code = ubp.COD_PAIS

select * from MCP_MDIUC.ENTITY
select * from MCP_MDIUC.ENTITY_ATTRIBUTE
select * from MCP_MDIUC.ENTITY_SYSTEM_TABLE
select * from MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING
select * from MCP_MDIUC.GROUPING_RULE
select * from MCP_MDIUC.COMPARING_RULE

CREATE TABLE MDIUC.COUNTRY_TEST_AGRUPACION (
      cod_pais INT PRIMARY KEY CLUSTERED
    , nombre_pais NVARCHAR(150)
    , iso_code NVARCHAR(10)
)

select * from MDIUC.COUNTRY_TEST_AGRUPACION

insert into MCP_MDIUC.ENTITY (name, is_valid, has_official_source)
values ('COUNTRY_TEST_AGRUPACION', 1, 0)

insert into MCP_MDIUC.ENTITY_ATTRIBUTE (entity_id, attribute_name, attribute_type, is_primary_key)
values (41, 'cod_pais', 'nvarchar', 1)
  , (41, 'nombre_pais', 'nvarchar', 0)
  , (41, 'iso_code', 'nvarchar', 0)

INSERT INTO MCP_MDIUC.ENTITY_SYSTEM_TABLE(entity_id, [schema_name], table_name, primary_key)
VALUES
      (41,'MDIUC','IMFD_COUNTRY ','iso_code')
    , (41,'CUC_BANNER', 'PAIS','COD_PAIS')


INSERT INTO MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING (entity_attribute_id, entity_system_table_id, column_name, attribute_rank)
VALUES
      (150, 68, 'dial_code',1)
      , (151, 68, 'spanish_name',1)
      , (152, 68, 'iso_code',1)
      , (150, 69, 'COD_PAIS',2)
      , (151, 69, 'NOM_PAIS',2)

insert into MCP_MDIUC.GROUPING_RULE values (151)

-- comparamos por el mismo campo 151 que es nombre el pais
INSERT INTO MCP_MDIUC.COMPARING_RULE (entity_attribute_id, rule_type, parameter, process)
VALUES
      (151,'fuzzy_allow_empty',70,'concat')
  

select * from information_schema.tables where table_schema = 'MCP_MDIUC'


select * from MCP_MDIUC.PROCESSED_COUNTRY_TEST_AGRUPACION
select * from MCP_MDIUC.PROCESSING_COUNTRY_TEST_AGRUPACION order by group_id
select * from MCP_MDIUC.UNMATCHED_COUNTRY_TEST_AGRUPACION

select * from MCP_MDIUC.CONFLICTIVE_COUNTRY_TEST_AGRUPACION

select 38, * from UTILS.ColumnType('MDIUC', 'COUNTRY_TEST_AGRUPACION')


select * from MCP_MDIUC.PROCESSED_UNIDAD_ACADEMICA_TEST order by group_id
select * from MCP_MDIUC.PROCESSING_UNIDAD_ACADEMICA_TEST order by group_id
select * from MCP_MDIUC.UNMATCHED_UNIDAD_ACADEMICA_TEST order by group_id
