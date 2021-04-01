-- TABLES
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
  , [type]
from sys.objects
where schema_name(schema_id) = 'BDGI'
  and [type] = 'U'

--COLUMNS
select 
    schema_name(so.schema_id) as [schema_name]
  , object_name(sc.object_id) as table_name
  , sc.name                   as column_name 
from sys.columns as sc
join sys.objects as so 
  on sc.object_id = so.object_id
where so.type = 'U'
  and schema_name(so.schema_id) = 'BDGI'
  and sc.name like '%Otro%'


-- NÚMERO DE POTENCIALES POSTULANTES, SEGÚN GRUPO-DEPENDENCIA DEL ESTABLECIMIENTO DE EDUCACIÓN SECUNDARIA, QUE PARTICIPAN EN AL MENOS UNA ACTIVIDAD DEL PROGRAMA DE DIFUSIÓN.
select top 4 * from BDGI.INSTITUCION where RBD__c is not null

-- grupo de depencias de los colegios
select distinct Grupo_de_Dependencia__c from BDGI.INSTITUCION
/*
Particular Pagado                       -- Particular
Particular Subvencionado                -- Particular subvencionado
Corporación de Administración Delegada  -- Particular subvencionado
Municipal DAEM                          -- Municipal
Coorporacion Municipal                  -- Municipal
Servicio Local de Educación             -- Municipal
*/


-- POTENCIALES POSTULANTES SEGÚN CARRERA DE PREFERENCIA DECLARADA
-- best ever method
select
      RUT__c
    , FirstName
    , LastName
    , Edad__c
    , value as carrera_de_interes
from BDGI.CONTACTO
cross apply string_split(Carreras_de_Inter_s_del_Escolar__c, ';')
where Carreras_de_Inter_s_del_Escolar__c is not null

-- mayor cantidad de caracteres en este caso field separator ';'
-- select top 1000
--       RUT__c
--     , Carreras_de_Inter_s_del_Escolar__c
--     , len(Carreras_de_Inter_s_del_Escolar__c) - len(replace(Carreras_de_Inter_s_del_Escolar__c, ';', '')) as Num
-- from BDGI.CONTACTO
-- where Carreras_de_Inter_s_del_Escolar__c is not null
-- order by Num desc

select count(distinct RUT__c) from BDGI.CONTACTO
select count(*) from BDGI.CONTACTO --340470


select top 40 * from BDGI.CONTACTO where Carreras_de_Inter_s_del_Escolar__c is not null

select top 50 * from BDGI.INSTITUCION where Subrubro__c = 'Escolar' Rubro__c = 'Educación' and  Rubro_2__c = 'Educación' 

select top 20 npe01__Type_of_Account__c from BDGI.CONTACTO group by npe01__Type_of_Account__c

select top 20 * from BDGI.OTROS_ESTUDIOS where Nivel_de_estudio__c is not null

select distinct Name from BDGI.OTROS_ESTUDIOS 

select distinct Nivel_de_estudio__c from BDGI.CURRICULO 
select top 4 * from BDGI.CURRICULO where Nivel_de_estudio__c is not null


-- FROM HERE ON IT DOES COUNT
select top 4 * from BDGI.CONTACTO       -- this one
select top 4 * from BDGI.OTROS_ESTUDIOS -- this one
select top 4 * from BDGI.INSTITUCION    -- this one


-- POTENCIALES POSTULANTES SEGÚN CARRERA DE PREFERENCIA DECLARADA
select
      RUT__c
    , FirstName
    , LastName
    , Edad__c
    , [value] as carrera_de_interes
from BDGI.CONTACTO
cross apply string_split(Carreras_de_Inter_s_del_Escolar__c, ';')
where Carreras_de_Inter_s_del_Escolar__c is not null

-- Columns
select * from UTILS.ColumnList('bdgi', 'contacto')
select * from UTILS.ColumnList('bdgi', 'otros_estudios')
select * from UTILS.ColumnList('bdgi', 'institucion')


select top 4 * from BDGI.CONTACTO where Escolares__c = 'True'

select * from BDGI.OTROS_ESTUDIOS where Nombre_persona__c = '001f4000004KkjGAAS'

select top 10
    OTROS_ESTUDIOS.*
  , INSTITUCION.*
from BDGI.OTROS_ESTUDIOS
join BDGI.INSTITUCION
  on OTROS_ESTUDIOS.Rut__c = left(INSTITUCION.RUT__c, coalesce(charindex('-', INSTITUCION.RUT__c), 0) - 1)

select top 10 * from BDGI.INSTITUCION where RecordTypeId = '012f4000000OYZeAAO'

select * from UTILS.ColumnType('BDGI', 'INSTITUCION')

select top 10 replace(left(RUT__c, coalesce(charindex('-', RUT__c), '') - 1), '.', '') from BDGI.INSTITUCION

select top 10  charindex('-', coalesce(replace(RUT__c, '.', ''), '')) from BDGI.INSTITUCION

with corrected_rut as (
  select 
      replace(left(i.RUT__c, coalesce(charindex('-', i.RUT__c), '') - 1), '.', '') rut
    , i.*
  from BDGI.INSTITUCION i
) select top 10 * 
select top 10
    OTROS_ESTUDIOS.*
  , corrected_rut.*
from BDGI.OTROS_ESTUDIOS
left join corrected_rut on OTROS_ESTUDIOS.Rut__c = corrected_rut.rut
;

select distinct RecordTypeId from BDGI.INSTITUCION

-- Escolar --> 012f4000000OYZeAAO
select distinct Id from BDGI.OTROS_ESTUDIOS
select top 10 * from BDGI.CONTACTO
select top 10 * from BDGI.OTROS_ESTUDIOS


select top 20 * from BDGI.OTROS_ESTUDIOS where RecordTypeId = '012f4000000OYZeAAO'


with cte as (
  select *
  from BDGI.OTROS_ESTUDIOS where RecordTypeId = '012f4000000OYZeAAO'
)
select top 10 
    CONTACTO.RUT__c
  , CONTACTO.Email_UC__c
  , CONTACTO.Email_Personal__c
  , cte.Rut__c
from BDGI.CONTACTO
left join cte on CONTACTO.RUT__c = cte.Rut__c

select
    CONTACTO.*
  , OTROS_ESTUDIOS.*
from BDGI.CONTACTO
left join BDGI.OTROS_ESTUDIOS on CONTACTO.RUT__c = OTROS_ESTUDIOS.Rut__c
where OTROS_ESTUDIOS.RecordTypeId = '012f4000000OYZeAAO'


-- FROM HERE ON IT DOES COUNT
select top 4 * from BDGI.CONTACTO       -- this one
select top 4 * from BDGI.OTROS_ESTUDIOS -- this one
select top 4 * from BDGI.INSTITUCION    -- this one
select top 4 * from BDGI.RecordType

-- Campos a pasar a vista
--CONTACTO
/*
CreatedDate cast as date
npe01__Type_of_Account__c
RUT__c
DV__c
Email_UC__c
Email_Personal__c
Genero__c
Edad__c
Apellido_Paterno__c
Apellido_Materno__c
Estado_civil__c
Nacionalidad__c
Carreras_de_Inter_s_del_Escolar__c
Direcci_n_Particular_Comuna__c
Direcci_n_Particular_Regi_n__c
Pais__c
*/

--OTROS ESTUDIOS
/*
Anio_de_egreso__c
Rut__c
Fecha_de_captura__c
Establecimiento__c
Pais_de_Estudios__c
Anio_de_Encuesta__c

*/

--INSTITUCION
/*
Name
Razon_social__c
RBD__c
Matriculados_uc__c
Comuna__c
Grupo_de_Dependencia__c

*/

select * from BDGI.CONTACTO where RUT__c = '12939322'
--12939322  Gerardo Andrés Araya Garcia

select distinct RecordTypeId from BDGI.INSTITUCION 
--012f4000000X6VnAAK
--012f4000000X6ViAAK

/* Número de potenciales postulantes, según grupo-dependencia del establecimiento de Educación secundaria, que participan en al menos una actividad del programa de Difusión. */
--Cómo relacionar las institucoiones con los estudiantes?

select top 4 * from BDGI.CONTACTO       
select top 4 * from BDGI.OTROS_ESTUDIOS where RecordTypeId = '012f4000000OYZeAAO' and Otro_establecimiento__c is not null
select top 4 * from BDGI.INSTITUCION where Subrubro__c = 'Escolar' and RBD__c is not null 

select top 4 * from BDGI.INSTITUCION where RecordTypeId = '012f4000000X6ViAAK'

select count(*) from BDGI.INSTITUCION where RecordTypeId = '012f4000000X6ViAAK' and RBD__c is not null  --20557
select count(*) from BDGI.INSTITUCION where Subrubro__c = 'Escolar' and RBD__c is not null              --15059

select top 4 * from BDGI.OTROS_ESTUDIOS where RecordTypeId = '012f4000000OYZeAAO' and Otro_establecimiento__c is not null

select distinct Curso__c from BDGI.OTROS_ESTUDIOS

-- vista institución
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW BDGI.COLEGIOS AS 
SELECT
   [Name]     AS nombre_colegio
  , Comuna__c AS comuna
  , Regi_n__c AS region
  , Pais__c   AS pais
  , RBD__c    AS rbd 
  , Grupo_de_Dependencia__c   AS grupo_dependencia
  , CASE 
      WHEN Grupo_de_Dependencia__c LIKE '%Particular Pagado%' THEN 'Particular'
      WHEN Grupo_de_Dependencia__c LIKE '%Particular Subvencionado%' THEN 'Particular subvencionado'
      WHEN Grupo_de_Dependencia__c LIKE '%Corporación de Administración Delegada%' THEN 'Particular subvencionado'
      WHEN Grupo_de_Dependencia__c LIKE '%Municipal DAEM%' THEN 'Municipal'
      WHEN Grupo_de_Dependencia__c LIKE '%Coorporacion Municipal%' THEN 'Municipal'
      WHEN Grupo_de_Dependencia__c LIKE '%Servicio Local de Educación%' THEN 'Municipal'
    END AS grupo_dependencia_corregido
  , IVE__c                    AS ive 
  , Indicador_de_Ruralidad__c AS indicador_ruralidad
  , Valor_Matricula__c        AS valor_matricula 
  , Valor_Mensual__c          AS valor_mensual
FROM BDGI.INSTITUCION
WHERE Subrubro__c = 'Escolar'
  AND RBD__c IS NOT NULL 
GO
;

/* GENERACIÓN VISTA DIFUSION */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW BDGI.DIFUSION AS

WITH institucion AS (
SELECT
    Id        AS id_colegio
  , [Name]    AS nombre_colegio
  , Comuna__c AS comuna_colegio
  , Regi_n__c AS region_colegio
  , Pais__c   AS pais_colegio
  , RBD__c    AS rbd 
  -- , Grupo_de_Dependencia__c   AS grupo_dependencia
  , CASE 
      WHEN Grupo_de_Dependencia__c LIKE '%Particular Pagado%' THEN 'Particular'
      WHEN Grupo_de_Dependencia__c LIKE '%Particular Subvencionado%' THEN 'Particular subvencionado'
      WHEN Grupo_de_Dependencia__c LIKE '%Corporación de Administración Delegada%' THEN 'Particular subvencionado'
      WHEN Grupo_de_Dependencia__c LIKE '%Municipal DAEM%' THEN 'Municipal'
      WHEN Grupo_de_Dependencia__c LIKE '%Coorporacion Municipal%' THEN 'Municipal'
      WHEN Grupo_de_Dependencia__c LIKE '%Servicio Local de Educación%' THEN 'Municipal'
    END AS grupo_dependencia
  , IVE__c                    AS ive 
  , Indicador_de_Ruralidad__c AS indicador_ruralidad
  , Valor_Matricula__c        AS valor_matricula 
  , Valor_Mensual__c          AS valor_mensual
FROM BDGI.INSTITUCION
WHERE Subrubro__c = 'Escolar'
  AND RBD__c IS NOT NULL 
)
, contacto_otros_estudios AS (
SELECT
    CONTACTO.RUT__c AS rut
  , CONTACTO.DV__c  AS dv
  , CONTACTO.Email_UC__c AS email_uc
  , CONTACTO.Email_Personal__c AS email_personal
  , CONTACTO.Genero__c AS genero
  , CONTACTO.Edad__c   AS edad
  , CONTACTO.FirstName AS nombres
  , CONTACTO.Apellido_Paterno__c AS apellido_paterno
  , CONTACTO.Apellido_Materno__c AS apellido_materno
  , CONTACTO.Estado_civil__c     AS estado_civil
  , CONTACTO.Nacionalidad__c     AS nacionalidad
  -- , CONTACTO.Carreras_de_Inter_s_del_Escolar__c AS carreras_de_interes
  , [value] AS carrera_de_interes
  , CONTACTO.Direcci_n_Particular_Comuna__c     AS comuna
  , CONTACTO.Direcci_n_Particular_Regi_n__c     AS region
  , CONTACTO.Pais__c AS pais
  , OTROS_ESTUDIOS.Anio_de_egreso__c AS ano_egreso_colegio
  -- , OTROS_ESTUDIOS.Curso__c AS curso
  , CASE OTROS_ESTUDIOS.Curso__c
      WHEN N'IVº' THEN 'IV°'  
      WHEN N'8, I°' THEN 'I°' 
      ELSE OTROS_ESTUDIOS.Curso__c
    END AS curso
  , OTROS_ESTUDIOS.Establecimiento__c  AS establecimiento
  , OTROS_ESTUDIOS.Pais_de_Estudios__c AS pais_estudio
  , OTROS_ESTUDIOS.Anio_de_Encuesta__c AS ano_encuesta
  , OTROS_ESTUDIOS.Fecha_de_captura__c AS fecha_captura_dato
FROM BDGI.CONTACTO
LEFT JOIN BDGI.OTROS_ESTUDIOS ON CONTACTO.RUT__c = OTROS_ESTUDIOS.Rut__c
CROSS APPLY STRING_SPLIT(Carreras_de_Inter_s_del_Escolar__c, ';')
WHERE OTROS_ESTUDIOS.RecordTypeId = '012f4000000OYZeAAO'
)
SELECT
    coe.*
  , institucion.*
FROM contacto_otros_estudios coe
LEFT JOIN institucion ON coe.establecimiento = institucion.id_colegio
GO
;

select * from BDGI.DIFUSION 

/* RESPUESTA A INDICADORES DE DIFUSIÓN*/

--Número de potenciales postulantes, según grupo-dependencia del establecimiento de Educación secundaria, que participan en al menos una actividad del programa de Difusión.
SELECT
    grupo_dependencia
  , COUNT(rut) AS num_potenciales_postul
FROM BDGI.DIFUSION
WHERE grupo_dependencia IS NOT NULL
GROUP BY grupo_dependencia

-- Número de Potenciales postulantes alcanzados por cada actividad del programa de Difusión.
-- aclarar esto y cómpo difiere de lo de abajo.

-- Número de potenciales postulantes interesados en la UC, que participan en  actividades del Programa de Difusión.
SELECT 
  COUNT(rut) AS num_potenciales_postul
FROM BDGI.DIFUSION

-- Número de colegios que participan en el programa de difusión.
SELECT
  COUNT(DISTINCT id_colegio) AS num_colegios
FROM BDGI.DIFUSION

-- Número de potenciales postulantes según carrera de preferencia declarada.
SELECT
    carrera_de_interes
  , COUNT(DISTINCT rut) num_potenciales_postul
FROM BDGI.DIFUSION
GROUP BY carrera_de_interes
ORDER BY num_potenciales_postul DESC

-- Número de estudiantes embajadores UC.
-- Not clear. Preguntar si existe alguna marca para ver esto

-- Número de actividades del Programa de Difusión por tipo de organizador.
-- Not clear. Preguntar si existe alguna marca para ver esto

-- Número de potenciales postulantes que son alcanzados, según curso.
SELECT 
    curso 
  , COUNT(DISTINCT rut) num_potenciales_postul
FROM BDGI.DIFUSION
WHERE curso IN ('7°', '8°', 'I°', 'II°', 'III°', 'IV°')
GROUP BY curso

-- Número de orientadores y directores de los establecimientos educacionales, que pertenecen a la Red de Apoyo de la Comunidad Educativa.
-- preguntar cuál es la marca para encontrar los directores
SELECT 
  COUNT(DISTINCT rut) num_orientadores
FROM BDGI.DIFUSION
WHERE curso = 'Profesor-Orientador'

-- Número de potenciales postulantes en programa de Preparación y Exploración Vocacional.
-- preguntar sobre alguna marca que indique el preuniversitario uc gratuito u otra marca.


/* RESPUESTAS A INDICADORES USANDO TAMBIÉN LAS NUEVAS TABLAS CARGADAS */

-- buscar tablas
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
  , [type]
from sys.objects
where schema_name(schema_id) = 'BDGI'
  and [type] IN ('U', 'V')
order by table_name

/* DIFUSION */
-- Falta el objeto relación cuenta contacto

select top 4 * from BDGI.COLEGIOS -- aquí vienes ls grupos de dependencia agrupados y corregidos. Curzar con RBD (son 15.059)
select top 4 * from BDGI.ROL_TRABAJO --del campo Nombre_del_cargo__c se puede obtener directores, orientadores, etc
select top 4 * from BDGI.HISTORIAL_DE_EVENTO -- se debe filtrar el campo Organizador_del_evento__c = Organizador_del_evento__c
select * from BDGI.RecordType

select distinct Organizador_del_evento__c from BDGI.HISTORIAL_DE_EVENTO
select * from BDGI.ROL_TRABAJO where Nombre_del_cargo__c like '%Director%'

select * from BDGI.ROL_TRABAJO where RecordTypeId = '012f4000000X6h1AAC'

select top 4 * from BDGI.Cuentas
select top 4 * from BDGI.CONTACTO

select count(rbd) from BDGI.COLEGIOS

-- progamar correo con lo dado de los directores