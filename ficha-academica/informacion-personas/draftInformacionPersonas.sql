WITH
    CuboPersonas
    AS
    (
        SELECT top 30
          CP.COD_PERS           AS cod_pers
        , CP.RUT                AS rut
        , NBP.check_digit       AS dv
        , NBP.first_name        AS nombre
        , LEFT(APELLIDO_PATERNO, 1) + LOWER(SUBSTRING(APELLIDO_PATERNO, 2, LEN(APELLIDO_PATERNO)))  AS apellido_paterno 
        , LEFT(APELLIDO_MATERNO, 1) + LOWER(SUBSTRING(APELLIDO_MATERNO, 2, LEN(APELLIDO_MATERNO)))  AS apellido_materno
        , NBP.sex               AS sexo
        , CP.FECHA_NACIM        AS fecha_nacimiento
        , NBP.country_of_origin AS pais
        FROM CORP.PERS                      AS CP
            LEFT JOIN NORMALIZADO_BANNER.PERSON AS NBP
            ON CP.RUT = NBP.rut

    )

SELECT top 10
    *
from GENERAL.GOREMAL


SELECT top 10
    apellido_paterno
from CORP.PERS

select *
from information_schema.columns
where table_name = 'PERS' and table_schema = 'CORP'
select top 10
    *
from corp.pers
/*
COD_PERS
COD_INSTITUCION_SALUD
NOM_PERS
APELLIDO_MATERNO
APELLIDO_PATERNO
COD_PARAM_77_VIG
NOM_PERS_ABREV
OTRA_DIRECCION_ELECTRON
RUT
COD_PARAM_8_SEXO
COD_PARAM_23_ESTADO_CIVIL
DIG_VERIF
FECHA_NACIM
DIRECCION_INTERNET
DIRECCION_PUC
COD_PAIS_ORIGEN
COD_PAIS_NACIONALIDAD
COD_PARAM_230_TIPO_SALUD
NOM_OTRO_TIPO_SALUD
NOM_SEGURO_COMPLEMENTARIO
RUT_COTIZANTE
NOM_SOCIAL
*/

select *
from information_schema.columns
where table_name = 'PERSON' and table_schema = 'MDIUC'
select top 10
    *
from MDIUC.PERSON
/*
rut
dv
tipo_id
paternal_last_name
maternal_last_name
name
created_at
*/

select *
from information_schema.columns
where table_name = 'PERSON' and table_schema = 'NORMALIZADO_BANNER'
select top 10
    *
from NORMALIZADO_BANNER.PERSON
/*
rut
check_digit
first_name
paternal_last_name
maternal_last_name
sex
birthdate
dead_at
banner_person_id
nationality
country_of_origin
is_alive
*/

