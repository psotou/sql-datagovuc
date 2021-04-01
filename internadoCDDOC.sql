-- TABLAS
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
  , [type]
from sys.objects
where schema_name(schema_id) = 'NORMALIZADO_PEOPLE_SOFT'
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
  and schema_name(so.schema_id) = 'SPI'


select top 100 * from mcp.mcp_catalogo

SELECT TOP 50 * 
FROM [MCP].[MCP_LOG_PROCESO_BULK] 
ORDER BY ID_LOG_PROCESO DESC

select top 10 * from CDDOC_calend.users


select top 4 * from CDDOC_calend.campus
select top 4 * from CDDOC_calend.configuraciones
select top 4 * from CDDOC_calend.cursos
select top 4 * from CDDOC_calend.evento_profesor
select top 4 * from CDDOC_calend.eventos
select top 4 * from CDDOC_calend.migrations
select top 4 * from CDDOC_calend.password_resets
select top 4 * from CDDOC_calend.permission_role
select top 4 * from CDDOC_calend.permission_user
select top 4 * from CDDOC_calend.permissions
select top 4 * from CDDOC_calend.profesores
select top 4 * from CDDOC_calend.role_user
select top 4 * from CDDOC_calend.roles
select top 4 * from CDDOC_calend.tipos_evento
select top 4 * from CDDOC_calend.unidades_academicas
select top 4 * from CDDOC_calend.users

select * from mcp.mcp_espacio_ocupado_bd where SchemaName = 'CDDOC_calend' and TableName = 'campus'

EXEC sp_spaceused N'CDDOC_calend.campus';
EXEC sp_spaceused N'CDDOC_calend.users';

SELECT * FROM MCP.MCP_ESPACIO_OCUPADO_BD where SchemaName IN (SELECT NOMBRE_OWNER_HOM COLLATE Latin1_General_CS_AS
    FROM MCP.MCP_CATALOGO
    WHERE NOMBRE_OWNER IN ('calendario_obs','plataforma_cddoc','autoevaluacion'))
	order by SchemaName,RowCounts desc

select top 4 * from CDDOC_plataf.actividad_participante
select top 4 * from CDDOC_plataf.participantes
select top 4 * from CDDOC_plataf.actividades

select top 50
    ap.*
  , p.*
  , a.*
from CDDOC_plataf.actividad_participante ap
left join CDDOC_plataf.participantes p on ap.id_participante = p.id
left join CDDOC_plataf.actividades a on ap.id_actividad = a.id

select top 4 * from NORMALIZADO_PEOPLE_SOFT.DECREE
select top 4 * from NORMALIZADO_PEOPLE_SOFT.DECREE_AGREEMENT_STATUS;
select top 4 * from NORMALIZADO_PEOPLE_SOFT.DECREE_APPLICATION_STATUS;
-- select top 4 * from NORMALIZADO_PEOPLE_SOFT.DECREE_PLANT_CATEGORY;
select top 4 * from NORMALIZADO_PEOPLE_SOFT.DECREE_PRECEDENT_TYPE;
select top 4 * from NORMALIZADO_PEOPLE_SOFT.DECREE_TYPE;
select top 4 * from NORMALIZADO_PEOPLE_SOFT.EMPLOYEE_CLASS;
select top 4 * from NORMALIZADO_PEOPLE_SOFT.EMPLOYEE_STATUS;

select top 4 * from NORMALIZADO_PEOPLE_SOFT.SCHOLAR
select top 4 * from NORMALIZADO_PEOPLE_SOFT.UNION_GROUP
select top 4 * from NORMALIZADO_PEOPLE_SOFT.WORK_POSITION
select top 4 * from NORMALIZADO_PEOPLE_SOFT.WORK_POSITION_CATEGORY


/* REVISIÓN INDICADORES CDDOC CON RAÚL COFRÉ */
-- Docentes capacitados por el CDDOC

