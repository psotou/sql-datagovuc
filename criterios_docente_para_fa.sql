-- TABLAS
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
  , [type]
from sys.objects
where schema_name(schema_id) = 'PEOPLE_SOFT'
-- where object_name(object_id) like '%POSTUL%'
  and [type] IN ('U', 'V')
order by table_name

--COLUMNS
select 
    schema_name(so.schema_id) as [schema_name]
  , object_name(sc.object_id) as table_name
  , sc.name                   as column_name 
from sys.columns as sc
join sys.objects as so 
  on sc.object_id = so.object_id
where so.type = 'U'
--   and schema_name(so.schema_id) = 'SPI'
    and sc.name like '%EMPL_%'


-- PEOPLE_SOFT


-- PEOPLE_SOFT.PS_PERS_NID --tiene ruts ficticios

-- Tabla de datos personales
select top 4 * from PEOPLE_SOFT.PS_PERSONAL_DATA
-- Tablas útiles para contrato
select top 4 * from PEOPLE_SOFT.PS_JOB -- horas planta, horas de contrato
select top 4 * from PEOPLE_SOFT.PS_JOB_JR
-- Tablas de decretos
select top 4 * from PEOPLE_SOFT.PS_CUS_SOL_APR_TBL order by DATE3 DESC -- Rechazos ver en campo CUS_DESC_RECHAZO
select top 4 * from PEOPLE_SOFT.PS_CUS_UNI_ACA_TBL where CUS_UNI_ACA_ID = '038'
select top 4 * from PEOPLE_SOFT.PS_CUS_ACUE_NC_TBL
-- select top 4 * from PEOPLE_SOFT.PS_CUS_UNI_NC_TBL
select top 4 * from PEOPLE_SOFT.PS_CUS_NCOMPAR_TBL where EMPLID like '%15461687-K%'

-- Tablas de traducción
select * from PEOPLE_SOFT.PSXLATITEMLANG where FIELDNAME like '%CUS_NIV_APR%' -- 0: aprobado, 1: rechazo decreto
select top 4 * from PEOPLE_SOFT.XLATTABLE_LNG where FIELDNAME like '%OPRID%'

-- Búsqueda

select * from PEOPLE_SOFT.PS_PERSONAL_DATA where EMPLID LIKE '%06441577%' 
-- tiene contrato plazo indefinido; JCE (jornada completa equivalente 44/44 todas las horas dedicadas a la academica)
-- facultad: medicina
-- unidad: academica ciencias de la salud
-- planta: adjunta
-- categoría acad: profesor asistente adjunto
-- grado: licenciado u otro título
-- tipo de contraro: indefinido

select * from PEOPLE_SOFT.PS_JOB where EMPLID like '%1921369%' -- EMPL_CLASS, STD_HOURS, HR_STATUS, EFFDT
select * from PEOPLE_SOFT.PS_JOB_JR where EMPLID like '%1921369%' -- EMPL_CLASS, STD_HOURS, HR_STATUS, EFFDT

-- Rector: 6370297-8
select * from PEOPLE_SOFT.PS_JOB where EMPLID like '%6370297-8%'

select top 10 * from PEOPLE_SOFT.PS_CUS_SOL_APR_TBL where CUS_DESC_RECHAZO is not null
select top 10 * from PEOPLE_SOFT.PS_CUS_SOL_APR_TBL where CUS_NIV_APR3 = 0