SELECT top 4 * FROM NORMALIZADO_BANNER.PERSON
SELECT top 4 * FROM NORMALIZADO_BANNER.STUDENT
SELECT top 4 * FROM NORMALIZADO_BANNER.STUDENT_TAGS_BY_TERM
SELECT top 4 * FROM NORMALIZADO_BANNER.TERM
SELECT top 4 * FROM NORMALIZADO_BANNER.SECTION
SELECT top 4 * FROM NORMALIZADO_BANNER.STUDENT_REGISTERS_SECTION
SELECT top 4 * FROM NORMALIZADO_BANNER.ENROLLMENT_BY_TERM
SELECT top 4 * FROM NORMALIZADO_BANNER.ENROLLMENT
SELECT top 4 * FROM NORMALIZADO_BANNER.ADMISSION_TYPE
SELECT top 4 * FROM NORMALIZADO_BANNER.ACADEMIC_PROGRAM
SELECT top 4 * FROM NORMALIZADO_BANNER.ACADEMIC_DEGREE
SELECT top 4 * FROM NORMALIZADO_BANNER.ACADEMIC_LEVEL
SELECT top 4 * FROM NORMALIZADO_BANNER.ACADEMIC_UNIT
SELECT top 4 * FROM NORMALIZADO_BANNER.FACULTY
SELECT top 4 * FROM NORMALIZADO_BANNER.STUDENT_WITH_CHILDREN
SELECT top 4 * FROM NORMALIZADO_BANNER.STUDENT_VALIDITY_TYPE
SELECT top 4 * FROM NORMALIZADO_BANNER.SECTION_REGISTRATION_TYPE
SELECT top 4 * FROM NORMALIZADO_BANNER.COURSE
SELECT top 4 * FROM NORMALIZADO_BANNER.GRADE
SELECT top 4 * FROM NORMALIZADO_BANNER.STUDENT_GRADUATES_FROM_SCHOOL

select count(1) from [SC].[STUDENT_360_PAS] --10_877_010

SELECT * FROM information_schema.tables where table_schema = 'NORMALIZADO_BANNER'


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SC].[STUDENT_360_PAS] AS 

/* COMMON TABLE EXPRESSIONS START */
-- Dada la envergadura de la sábana, llamaremos solo las columnas
-- que vamos a utilizar de cada tabla

WITH section_term AS (
    SELECT
          nbsrs.enrollment_id
        , nbsrs.section_id
        , nbsrs.registration_type_id
        , nbsrs.grade_id
        , nbse.term_id
        , nbse.course_id
    FROM NORMALIZADO_BANNER.STUDENT_REGISTERS_SECTION AS nbsrs
    LEFT JOIN NORMALIZADO_BANNER.SECTION              AS nbse
        ON nbsrs.section_id = nbse.id
)
, admision_prog AS (
    SELECT
          nben.id
        , nben.student_id
        , nben.academic_program_id
        , nben.admission_term_id
        , nben.transfer_from
        , nbat.name AS admission_type_name
    FROM NORMALIZADO_BANNER.ENROLLMENT          AS nben
    LEFT JOIN NORMALIZADO_BANNER.ADMISSION_TYPE AS nbat
        ON nben.admission_type_id = nbat.code
)
, section_enroll AS (
    SELECT
          enrollment_id
        , term_id
    FROM section_term
    UNION
    SELECT
          enrollment_id
        , term_id
    FROM NORMALIZADO.ENROLLMENT_BY_TERM
)
, adm_prog_term AS (
    SELECT
          nbebt.term_id
        , nbebt.enrollment_id
        , nbebt.academic_status_id
        , nbebt.validity
    FROM NORMALIZADO_BANNER.ENROLLMENT_BY_TERM AS nbebt
    LEFT JOIN NORMALIZADO_BANNER.ENROLLMENT    AS nben 
        ON nbebt.enrollment_id = nben.id
)
, cursos AS (
    SELECT 
          nbc.id
        , nbc.subject
        , nbc.course_number
        , nbc.name 
        , nbc.credits
        , academic_levelvl.name AS academic_level_name
    FROM NORMALIZADO_BANNER.COURSE AS nbc
    LEFT JOIN NORMALIZADO_BANNER.ACADEMIC_LEVEL AS academic_levelvl
        ON nbc.academic_level_id = academic_levelvl.code
)
, student AS (
    SELECT rut FROM NORMALIZADO_BANNER.STUDENT
)
, person AS (
    SELECT * FROM NORMALIZADO_BANNER.PERSON
)
, term AS (
    SELECT * FROM NORMALIZADO_BANNER.TERM
)
, academic_prog AS (
    SELECT * FROM NORMALIZADO_BANNER.ACADEMIC_PROGRAM
)
, academic_deg AS (
    SELECT * FROM NORMALIZADO_BANNER.ACADEMIC_DEGREE
)
, academic_level AS (
    SELECT * FROM NORMALIZADO_BANNER.ACADEMIC_LEVEL
)
, academic_unit AS (
    SELECT * FROM NORMALIZADO_BANNER.ACADEMIC_UNIT
)
, faculty AS (
    SELECT * FROM NORMALIZADO_BANNER.FACULTY
)
, student_tag AS (
    SELECT * FROM NORMALIZADO_BANNER.STUDENT_TAGS_BY_TERM
)
, students_child AS (
    SELECT * FROM NORMALIZADO_BANNER.STUDENT_WITH_CHILDREN
)
, student_valid AS (
    SELECT TOP 2 * FROM NORMALIZADO_BANNER.STUDENT_VALIDITY_TYPE
)
, section_reg AS (
    SELECT * FROM NORMALIZADO_BANNER.SECTION_REGISTRATION_TYPE
)
, grade AS (
    SELECT * FROM NORMALIZADO_BANNER.GRADE
)
, sabana_final AS (

SELECT
      person.rut
    , person.check_digit
    , person.first_name
    , person.paternal_last_name
    , person.maternal_last_name
    , person.sex
    , person.birthdate
    , person.dead_at
    , person.banner_person_id
    , person.nationality
    , person.is_alive
    , student_tag.tag_id              AS special_tag_student
    , CASE WHEN term.id > students_child.term_id THEN 1 ELSE 0 END AS student_with_children
    , admision_prog.academic_program_id
    , admision_prog.admission_term_id  AS admission_term
    , admision_prog.admission_type_name
    , admision_prog.id                 AS enrollment_id
    , admision_prog.transfer_from
    , academic_prog.name               AS academic_program_name
    , academic_prog.academic_degree_id AS academic_degree_id   
    , academic_deg.name                AS academic_degree_name
    , academic_deg.academic_level_id   AS academic_level_id
    , academic_level.name              AS academic_level_name
    , academic_unit.id                 AS academic_unit_id
    , academic_unit.name               AS academic_unit_name
    , faculty.id                       AS faculty_id
    , faculty.name                     AS faculty_name
    , CASE WHEN adm_prog_term.academic_status_id IS NULL THEN 'INPROGRESS' ELSE adm_prog_term.academic_status_id END AS academic_status_desc
    , CASE WHEN adm_prog_term.validity IS NULL THEN 'AS' ELSE adm_prog_term.validity END   AS academic_status_validity
    , CASE WHEN student_valid.name IS NULL THEN 'Vigente' ELSE student_valid.name END      AS academic_status_validity_name
    , term.id                 AS term_id_real
    , term.semester
    , term.year
    , term.start_date
    , term.end_date
    , section_term.section_id
    , section_term.term_id    AS section_term_id
    , section_reg.code        AS registration_type_id
    , section_reg.name        AS registration_type_name
    , section_term.course_id
    , NULLIF(CONCAT(cursos.subject, cursos.course_number),'') AS sigla
    , cursos.name                    AS course_name
    , cursos.academic_level_name     AS academic_level_name_course
    , REPLACE(grade.value, ',', '.') AS course_grade
    , cursos.credits
FROM student  --a
LEFT JOIN person         ON student.rut = person.rut --b
LEFT JOIN admision_prog  ON student.rut = admision_prog.student_id --c
LEFT JOIN section_enroll ON admision_prog.id = section_enroll.enrollment_id --tabla4 --> d
LEFT JOIN section_term   ON (admision_prog.id = section_term.enrollment_id AND section_enroll.term_id = section_term.term_id) --e 
LEFT JOIN term           ON section_enroll.term_id = term.id --f
LEFT JOIN academic_prog  ON admision_prog.academic_program_id = academic_prog.code --h
LEFT JOIN academic_deg   ON academic_prog.academic_degree_id = academic_deg.id --l
LEFT JOIN academic_level ON academic_deg.academic_level_id = academic_level.code --m 
LEFT JOIN academic_unit  ON academic_prog.academic_unit_id = academic_unit.id  --n 
LEFT JOIN faculty        ON academic_unit.faculty_id = faculty.id --p
LEFT JOIN student_tag    ON (student.rut = student_tag.student_id AND term.id = student_tag.term_id) --t
LEFT JOIN students_child ON student.rut = students_child.student_id --t2
LEFT JOIN adm_prog_term  ON (admision_prog.id = adm_prog_term.enrollment_id AND term.id = adm_prog_term.term_id) --r
LEFT JOIN student_valid  ON adm_prog_term.validity = student_valid.code --q
LEFT JOIN section_reg    ON section_term.registration_type_id = section_reg.code   --k 
LEFT JOIN cursos         ON section_term.course_id = cursos.id  --g
LEFT JOIN grade          ON section_term.grade_id = grade.id --j

)
SELECT * FROM sabana_final
GO