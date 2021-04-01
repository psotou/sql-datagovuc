
select count(1) from SC.STUDENT_360 --9_398_537

select * from UTILS.ViewTablesUsage() where schema_name = 'SC' and view_name = 'STUDENT_360'

/*
ACADEMIC_DEGREE
ACADEMIC_LEVEL
ACADEMIC_PROGRAM
ACADEMIC_UNIT
ADMISSION_TYPE
COURSE
ENROLLMENT
ENROLLMENT_BY_TERM
FACULTY
GRADE
PERSON
SCHOOL_FINANCING_TYPE
SECONDARY_EDUCATION_INSTITUTION
SECTION
SECTION_REGISTRATION_TYPE
STUDENT
STUDENT_GRADUATES_FROM_SCHOOL
STUDENT_REGISTERS_SECTION
STUDENT_SPECIAL_STATUS
STUDENT_TAGS
STUDENT_TAGS_BY_TERM
STUDENT_VALIDITY_TYPE
STUDENT_WITH_CHILDREN
TERM
*/

select * from UTILS.ViewTablesUsage() where schema_name like '%BANNER%'

select * from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA like '%BANNER'

select 
    schema_name(so.schema_id) as [schema_name]
  , object_name(sc.object_id) as table_name
  , sc.name                   as column_name 
from sys.columns as sc
join sys.objects as so 
  on sc.object_id = so.object_id
where so.type = 'U'
  and schema_name(so.schema_id) = 'NORMALIZADO_BANNER'
