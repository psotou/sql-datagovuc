-- TABLAS
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
  , [type]
from sys.objects
where schema_name(schema_id) = 'PEOPLE'
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

SELECT * FROM MCP.MCP_ESPACIO_OCUPADO_BD 
where SchemaName IN (
    SELECT NOMBRE_OWNER_HOM COLLATE Latin1_General_CS_AS
    FROM MCP.MCP_CATALOGO
    WHERE NOMBRE_OWNER IN ('calendario_obs','plataforma_cddoc','autoevaluacion')
    )	
ORDER BY SchemaName, RowCounts DESC

-- TABLAS
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
  , [type]
from sys.objects
where schema_name(schema_id) = 'CDDOC_autoev'
  and [type] IN ('U', 'V')
order by table_name

select top 4 * from CDDOC_plataf.actividad_participante
select top 4 * from CDDOC_plataf.participantes
select top 4 * from CDDOC_plataf.actividades where nombre like '%Uso efectivo%'
select * from CDDOC_plataf.actividades where nombre like '%Ex Corde Eccesiae e Identidad%'

select * from CDDOC_plataf.talleres where nombre like '%Ex Corde Eccesiae e Identidad%'

select top 4 * from CDDOC_plataf.talleres where sigla = 'M2-TE6'
select top 4 * from CDDOC_plataf.talleres_as
select top 4 * from CDDOC_plataf.talleres_online
select top 4 * from CDDOC_plataf.tallerto_tutor

select top 50
    ap.*
  , p.*
  , a.*
from CDDOC_plataf.actividad_participante ap
left join CDDOC_plataf.participantes p on ap.id_participante = p.id
left join CDDOC_plataf.actividades a on ap.id_actividad = a.id
where a.nombre like '%Integrando Canvas%'

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


SELECT * FROM MCP.MCP_ESPACIO_OCUPADO_BD 
WHERE SchemaName = 'PEOPLESOFT'


/* REVISIÓN INDICADORES CDDOC CON RAÚL COFRÉ */
-- Docentes capacitados por el CDDOC
-- validar ruts

select top 4 * from CDDOC_calend.evento_profesor
select top 4 * from CDDOC_calend.eventos

select top 4 * from CDDOC_autoev.cursos
select top 4 * from CDDOC_autoev.curso_item

select top 4 * from CDDOC_autoev.periodos_autoevaluacion

select top 4 * from CDDOC_autoev.configuraciones
select top 4 * from CDDOC_autoev.curso_item
select top 4 * from CDDOC_autoev.cursos
select top 4 * from CDDOC_autoev.dimensiones
select top 4 * from CDDOC_autoev.docentes
select top 4 * from CDDOC_autoev.items
select top 4 * from CDDOC_autoev.migrations
select top 4 * from CDDOC_autoev.periodos_autoevaluacion
select top 4 * from CDDOC_autoev.recomendaciones
select top 4 * from CDDOC_autoev.usuarios


select top 4 * from CDDOC_plataf.ayudante_talleronline
select top 4 * from CDDOC_plataf.ayudante_convalidacionto

--

select top 4 * from general.gorsdav_libe

select * from utils.ColumnType('GENERAL', 'GORSDAV')