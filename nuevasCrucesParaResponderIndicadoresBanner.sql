-- TABLES
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
from sys.objects
where schema_name(schema_id) = 'NORMALIZADO_BANNER'
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
  and schema_name(so.schema_id) = 'NORMALIZADO_BANNER'
  and sc.name like '%dura%'

--
select top 4 * from NORMALIZADO_BANNER.PERSON
select top 4 * from NORMALIZADO_BANNER.STUDENT_REGISTERS_SECTION
select top 4 * from NORMALIZADO_BANNER.SECTION_REGISTRATION_TYPE

select top 40 * from NORMALIZADO_BANNER.GRADE
select top 4 * from NORMALIZADO_BANNER.STUDENT_VALIDITY_TYPE

select distinct registration_type_id from NORMALIZADO_BANNER.STUDENT_REGISTERS_SECTION
select top 4 * from NORMALIZADO_BANNER.ENROLLMENT
select top 4 * from NORMALIZADO_BANNER.ENROLLMENT_BY_TERM
select top 4 * from NORMALIZADO_BANNER.STUDENT


-- LOS INDICADORES VAN DE LA FILA 8 A LA 24 EN EL GOOGLE SHEET

-- Estudiantes según situación académica
select top 4 * from NORMALIZADO_BANNER.ENROLLMENT_BY_TERM
select distinct academic_status_id, validity from NORMALIZADO_BANNER.ENROLLMENT_BY_TERM
select top 4 * from NORMALIZADO_BANNER.TERM




select top 500
      ENROLLMENT.student_id as rut
    , STUDENT_REGISTERS_SECTION.enrollment_id
    , STUDENT_REGISTERS_SECTION.registration_type_id as id_tipo_registro
    , SECTION_REGISTRATION_TYPE.name as nombre_tipo_registro
    , ENROLLMENT_BY_TERM.term_id 
    , CASE 
        WHEN right(cast(ENROLLMENT_BY_TERM.term_id AS NVARCHAR), 2) = '20' THEN concat(left(ENROLLMENT_BY_TERM.term_id, 4), '-1') 
        WHEN right(cast(ENROLLMENT_BY_TERM.term_id AS NVARCHAR), 2) = '22' THEN concat(left(ENROLLMENT_BY_TERM.term_id, 4), '-2')
      end as periodo_academico
    , ENROLLMENT_BY_TERM.academic_status_id as situacion_academica
    , STUDENT_VALIDITY_TYPE.code as cod_estado_situacion_academica
    , STUDENT_VALIDITY_TYPE.name as nombre_estado_situacion_academica
    -- , STUDENT_REGISTERS_SECTION.*
    -- , SECTION_REGISTRATION_TYPE.*
    , SECTION.course_id as id_curso
from NORMALIZADO_BANNER.ENROLLMENT
left join NORMALIZADO_BANNER.ENROLLMENT_BY_TERM on ENROLLMENT.id = ENROLLMENT_BY_TERM.enrollment_id
left join NORMALIZADO_BANNER.STUDENT_VALIDITY_TYPE on ENROLLMENT_BY_TERM.validity = STUDENT_VALIDITY_TYPE.code
left join NORMALIZADO_BANNER.STUDENT_REGISTERS_SECTION on ENROLLMENT.id = STUDENT_REGISTERS_SECTION.enrollment_id
left join NORMALIZADO_BANNER.SECTION_REGISTRATION_TYPE on STUDENT_REGISTERS_SECTION.registration_type_id = SECTION_REGISTRATION_TYPE.code
left join NORMALIZADO_BANNER.SECTION on (STUDENT_REGISTERS_SECTION.section_id = SECTION.id and ENROLLMENT_BY_TERM.term_id = SECTION.term_id)
order by ENROLLMENT_BY_TERM.term_id desc



-- retiro de cursos
select top 50 
    STUDENT_REGISTERS_SECTION.*
    , SECTION_REGISTRATION_TYPE.*
    , SECTION.*
from NORMALIZADO_BANNER.STUDENT_REGISTERS_SECTION
left join NORMALIZADO_BANNER.SECTION_REGISTRATION_TYPE on STUDENT_REGISTERS_SECTION.registration_type_id = SECTION_REGISTRATION_TYPE.code
left join NORMALIZADO_BANNER.SECTION on STUDENT_REGISTERS_SECTION.section_id = SECTION.id

select distinct name from NORMALIZADO_BANNER.SECTION_REGISTRATION_TYPE
select top 4 * from NORMALIZADO_BANNER.COURSE
select top 4 * from NORMALIZADO_BANNER.SECTION


select top 500
      STUDENT_REGISTERS_SECTION.*
    , GRADE.*
    , PERSON.*
from NORMALIZADO_BANNER.STUDENT_REGISTERS_SECTION
left join NORMALIZADO_BANNER.GRADE on STUDENT_REGISTERS_SECTION.grade_id = GRADE.id
left join NORMALIZADO_BANNER.PERSON on STUDENT_REGISTERS_SECTION.id = PERSON.banner_person_id


select top 10 * from SC.STUDENT_360_PAS

SELECT
    academic_status_validity_name
  , periodo_academico
  , count(*) AS num_estudiantes
FROM SC.STUDENT_360_PAS
GROUP BY 
    academic_status_validity_name
  , periodo_academico
ORDER BY periodo_academico DESC

select distinct registration_type_name, registration_type_id from SC.STUDENT_360_PAS

SELECT top 10
    registration_type_name
  , periodo_academico
  , count(*) AS num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE registration_type_id IN ('DX', 'DD', 'DW', 'DS')
GROUP BY 
    registration_type_name
  , periodo_academico
ORDER BY periodo_academico DESC

--desgregado  cursos retirados por alumnoy por periodo
SELECT top 10
    rut
  , periodo_academico
  , registration_type_name
  , count(course_id) AS num_cursos_retirados
FROM SC.STUDENT_360_PAS
WHERE course_id IS NOT NULL
  AND registration_type_id IN ('DX', 'DD', 'DW', 'DS')
GROUP BY 
    rut
  , periodo_academico
  , registration_type_name
ORDER BY periodo_academico DESC

-- n
SELECT top 10
    periodo_academico
  , registration_type_name
  , count(course_id) AS num_cursos_retirados
FROM SC.STUDENT_360_PAS
WHERE course_id IS NOT NULL
  AND registration_type_id IN ('DX', 'DD', 'DW', 'DS')
GROUP BY 
    periodo_academico
  , registration_type_name
ORDER BY periodo_academico DESC

select top 10 * from SC.STUDENT_360_PAS where academic_level_name is not null

select distinct academic_level_id, academic_level_name  from SC.STUDENT_360_PAS

--academic_status_valdity_name --> vigencia ==> academic_status_valdity = AS

SELECT top 10
    admission_term
  , academic_level_name
  , count(*) AS num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE academic_level_id IS NOT NULL
  AND academic_status_validity = 'AS'
GROUP BY 
    admission_term
  , academic_level_name
ORDER BY periodo_academico DESC

SELECT top 10
    CASE 
      WHEN right(cast(admission_term AS NVARCHAR), 2) = '20' THEN concat(left(admission_term, 4), '-1') 
      WHEN right(cast(admission_term AS NVARCHAR), 2) = '22' THEN concat(left(admission_term, 4), '-2')
    END AS periodo_academico
  , academic_level_name
  , count(*) AS num_estudiantes_vigentes
FROM SC.STUDENT_360_PAS
WHERE academic_level_id IS NOT NULL
  AND academic_status_validity = 'AS'
GROUP BY 
    admission_term
  , academic_level_name
ORDER BY periodo_academico DESC

SELECT top 10
    cohorte
  , academic_level_name
  , count(*) AS num_estudiantes_vigentes
FROM SC.STUDENT_360_PAS
WHERE academic_level_id IS NOT NULL
  AND academic_status_validity = 'AS'
GROUP BY 
    cohorte
  , academic_level_name
ORDER BY periodo_academico DESC


select top 10 * from SC.STUDENT_360_PAS where academic_status_desc IN ('RENUNCIADO', 'ABANDONA', 'NOVIGCOMPERMA', 'ELIMINADO')
select distinct academic_status_id from NORMALIZADO_BANNER.ENROLLMENT_BY_TERM

select distinct registration_type_id, registration_type_name from SC.STUDENT_360_PAS
-- academic_status_desc IN ('RENUNCIADO', 'ABANDONA', 'NOVIGCOMPERMA', 'ELIMINADO')


SELECT top 10
    cohorte
  , periodo_academico
  , count(*) AS num_estudiante_desertados
FROM SC.STUDENT_360_PAS
WHERE academic_status_desc IN ('RENUNCIADO', 'ABANDONA', 'NOVIGCOMPERMA', 'ELIMINADO')
  AND periodo_academico > 201902
GROUP BY 
    cohorte
  , periodo_academico
ORDER BY periodo_academico, cohorte DESC

--

SELECT top 10
    periodo_academico
  , rut
  , academic_level_name
  , COUNT(*) OVER(PARTITION BY rut) AS num_cursos
FROM SC.STUDENT_360_PAS
WHERE academic_status_desc = 'INPROGRESS'
  AND registration_type_id IN ('RW', 'RE', 'RQ')
  AND academic_level_name IS NOT NULL
GROUP BY 
    periodo_academico
  , rut
  , academic_level_name
ORDER BY periodo_academico DESC



SELECT top 10
    periodo_academico
  , academic_program_name
  , COUNT(*) AS num_cursos
FROM SC.STUDENT_360_PAS
WHERE registration_type_id IN ('RW', 'RE', 'RQ')
GROUP BY 
    periodo_academico
  , academic_program_name
ORDER BY periodo_academico DESC


SELECT top 10
    periodo_academico
  , academic_program_name
  , SUM(credits) AS creditos_totales
FROM SC.STUDENT_360_PAS
WHERE registration_type_id IN ('RW', 'RE', 'RQ')
GROUP BY 
    periodo_academico
  , academic_program_name
ORDER BY periodo_academico DESC


select top 10 rut, enrollment_id, periodo_academico from SC.STUDENT_360_PAS GROUP BY rut, enrollment_id, periodo_academico

SELECT top 10
    periodo_academico
  , academic_level_name
  , COUNT(*) as num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE admission_type_name = 'Carrera Paralela'
  AND academic_status_validity = 'AS'
  AND academic_level_name IS NOT NULL
GROUP BY 
    periodo_academico
  , academic_level_name
ORDER BY periodo_academico DESC



SELECT top 10
    periodo_academico
  , academic_level_name
  , COUNT(*) as num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE registration_type_id IN ('RS', 'RQ', 'RE', 'RW')
  AND course_grade IS NOT NULL
  AND CAST(course_grade AS FLOAT) >= 4
GROUP BY 
    periodo_academico
  , academic_level_name
ORDER BY periodo_academico DESC


SELECT top 10
    periodo_academico
  , academic_level_name
  , COUNT(distinct enrollment_id) as num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE registration_type_id IN ('RS', 'RQ', 'RE', 'RW')
  AND course_grade IS NOT NULL
  AND CAST(course_grade AS FLOAT) >= 4
GROUP BY 
    periodo_academico
  , academic_level_name
ORDER BY periodo_academico DESC

SELECT top 10
    periodo_academico
  , academic_level_name
  , CASE WHEN CAST(course_grade AS FLOAT) >= 4 THEN COUNT(distinct enrollment_id) END AS num_estudiantes_aprobados
  , CASE WHEN CAST(course_grade AS FLOAT) < 4 THEN COUNT(distinct enrollment_id) END AS num_estudiantes_reprobados
  -- , COUNT(distinct enrollment_id) as num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE registration_type_id IN ('RS', 'RQ', 'RE', 'RW')
  AND course_grade IS NOT NULL
  AND academic_level_name IS NOT NULL
GROUP BY 
    periodo_academico
  , academic_level_name
  , course_grade 
ORDER BY periodo_academico DESC

--------------------------------------------------------
SELECT top 10
      subquery.periodo_academico
    , subquery.academic_level_name
    , subquery.estado_curso
    , COUNT(distinct enrollment_id) as num_estudiantes
FROM (
      SELECT
          periodo_academico
        , academic_level_name
        , enrollment_id
        , CASE 
            WHEN CAST(course_grade AS FLOAT) >= 4 THEN 'aprobado'
            WHEN CAST(course_grade AS FLOAT) < 4 THEN 'reprobado' 
          END AS estado_curso
      FROM SC.STUDENT_360_PAS
      WHERE registration_type_id IN ('RS', 'RQ', 'RE', 'RW')
        AND LEFT(cohorte, 4) = CAST(year AS NVARCHAR)
        AND course_grade IS NOT NULL
        AND academic_level_name IS NOT NULL
      ) AS subquery
GROUP BY 
    subquery.periodo_academico
  , subquery.academic_level_name
  , subquery.estado_curso 
ORDER BY periodo_academico DESC


SELECT TOP 10
    periodo_academico
  , academic_level_name
  , estado_curso
  , COUNT(distinct enrollment_id) as num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE registration_type_id IN ('RS', 'RQ', 'RE', 'RW') --cursos registrados only
  -- AND LEFT(cohorte, 4) = CAST(year AS NVARCHAR)
  AND course_grade IS NOT NULL
  AND academic_level_name IS NOT NULL
GROUP BY 
    periodo_academico
  , academic_level_name
  , estado_curso
ORDER BY periodo_academico DESC


SELECT top 10
    cohorte
  , periodo_academico
  , count(*) AS num_estudiante_desertados
FROM SC.STUDENT_360_PAS
WHERE academic_status_desc IN ('RENUNCIADO', 'ABANDONA', 'NOVIGCOMPERMA', 'ELIMINADO')
  AND periodo_academico > 201902 -- solo nos interesa el perido académico actual (2020)
GROUP BY 
    cohorte
  , periodo_academico
ORDER BY periodo_academico, cohorte DESC


select * from sys.objects
select top 4 rut, course_grade, estado_curso from SC.STUDENT_360_PAS


SELECT top 10
    periodo_academico
  , rut
  , academic_level_name
  , COUNT(*) OVER(PARTITION BY rut) AS num_cursos
FROM SC.STUDENT_360_PAS
WHERE academic_status_desc = 'INPROGRESS'
  AND registration_type_id IN ('RW', 'RE', 'RQ', 'RS')
  AND academic_level_name IS NOT NULL
GROUP BY 
    periodo_academico
  , rut
  , academic_level_name
ORDER BY periodo_academico DESC


select top 1000 * from NORMALIZADO_BANNER.ACADEMIC_PROGRAM

-- TABLES
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
from sys.objects
where schema_name(schema_id) = 'NORMALIZADO_BANNER'
  and [type] = 'U'

select top 10 * from NORMALIZADO_BANNER.SECONDARY_EDUCATION_INSTITUTION
select top 10 * from NORMALIZADO_BANNER.SCHOOL_FINANCING_TYPE
select top 10 * from NORMALIZADO_BANNER.STUDENT_GRADUATES_FROM_SCHOOL



SELECT top 10
    periodo_academico
  , school_financing_type_name
  , COUNT(*) AS num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE school_financing_type_name IS NOT NULL
GROUP BY 
    cohorte
  , periodo_academico
  , school_financing_type_name
ORDER BY periodo_academico DESC

SELECT top 10
    periodo_academico
  , region
  , COUNT(*) AS num_estudiantes
FROM SC.STUDENT_360_PAS
WHERE region IS NOT NULL
GROUP BY 
    periodo_academico
  , region
ORDER BY periodo_academico DESC
