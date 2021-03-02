/* THISSSSSSSSSSSSS */

WITH ONE AS (
SELECT
    CP.COD_PERS              AS cod_pers
    , NBP.rut                AS rut
    , NBP.check_digit        AS dv
    , NBP.first_name         AS nombre
    , NBP.paternal_last_name AS apellido_paterno
    , NBP.maternal_last_name AS apellido_materno
    , NBP.sex                AS sexo
    , CP.FECHA_NACIM         AS fecha_nacimiento
    , NBP.country_of_origin  AS pais_origen
    , CASE WHEN NBP.country_of_origin = 'Chile' THEN N'Español' ELSE HAI.NOM_IDIOM END  AS idioma
    , PSA.ADDRESS1           AS calle
    , PSA.ADDRESS2           AS num_calle
    , PSA.ADDRESS3           AS num_vivienda
    , PSA.CITY               AS ciudad
    , PSA.COUNTY             AS comuna
    , CASE WHEN PSA.COUNTRY = 'CHL' THEN 'Chile' END  AS pais_direccion
    , CAST(PSA.EFFDT AS DATE) AS fecha_registro_dir
    , PSPD.PHONE              AS telefono
    , GG.GOREMAL_EMAIL_ADDRESS AS email
    , CASE 
        WHEN NPSP.marital_status_id = 'D' AND NBP.sex = 'M' THEN 'Divorciado'
        WHEN NPSP.marital_status_id = 'D' AND NBP.sex = 'F' THEN 'Divorciada'
        WHEN NPSP.marital_status_id = 'E' AND NBP.sex = 'M' THEN 'Separado'
        WHEN NPSP.marital_status_id = 'E' AND NBP.sex = 'F' THEN 'Separada'
        WHEN NPSP.marital_status_id = 'M' AND NBP.sex = 'M' THEN 'Casado'
        WHEN NPSP.marital_status_id = 'M' AND NBP.sex = 'F' THEN 'Casada'
        WHEN NPSP.marital_status_id = 'S' AND NBP.sex = 'M' THEN 'Soltero'
        WHEN NPSP.marital_status_id = 'S' AND NBP.sex = 'F' THEN 'Soltera'
        WHEN NPSP.marital_status_id = 'C' THEN 'Pareja hecho'
        WHEN NPSP.marital_status_id = 'H' THEN 'Cabeza de familia'
        WHEN NPSP.marital_status_id = 'P' THEN 'Acuerdo de Unión Civil'
        WHEN NPSP.marital_status_id = 'T' THEN 'Pareja superviviente'
        WHEN NPSP.marital_status_id = 'U' THEN 'No consta'
      END                            AS estado_civil
    , NPSHP.name                     AS plan_salud
    , NPSA.name                      AS afp
    , CASE WHEN NBP.is_alive = 1 THEN 'S' ELSE 'N' END  AS esta_vivo
    , NPSEL.name                     AS nivel_educacional
    , HATGA.NOM_TIPO_GRADO_ACADEMICO AS tipo_grado_academico
    , HAGA.ANO_OBTENIDO              AS ano_obtencion_grado
    , HAGA.AREA_ESPECIALIZ           AS area_especializacion
    , HAII1.NOM_INSTITUCION_INVESTIG AS nombre_institucion_investigacion
    , HAGA.DOBLE_TITUL               AS doble_titulacion
    , HAII2.NOM_INSTITUCION_INVESTIG AS nombre_inst_investig_doble_titulacion
FROM NORMALIZADO_BANNER.PERSON                AS NBP
LEFT JOIN CORP.PERS                           AS CP
    ON NBP.rut = CAST(CP.RUT AS INT)
LEFT JOIN PEOPLE_SOFT.PS_PERSONAL_DATA        AS PSPD 
    ON CAST(NBP.rut AS nvarchar) = CASE WHEN CHARINDEX('-', PSPD.EMPLID) <> 0 THEN LEFT(PSPD.EMPLID, CHARINDEX('-', PSPD.EMPLID) - 1) END
LEFT JOIN PEOPLE_SOFT.PS_ADDRESSES            AS PSA 
    ON CAST(NBP.rut AS nvarchar) = CASE WHEN CHARINDEX('-', PSA.EMPLID) <> 0 THEN LEFT(PSA.EMPLID, CHARINDEX('-', PSA.EMPLID) - 1) END
    AND PSPD.EMPLID = PSA.EMPLID
    AND PSA.ADDRESS_TYPE = 'HOME'
LEFT JOIN NORMALIZADO_PEOPLE_SOFT.PERSON      AS NPSP 
    ON CAST(NBP.rut AS NVARCHAR) = NPSP.rut
LEFT JOIN NORMALIZADO_PEOPLE_SOFT.HEALTH_PLAN AS NPSHP 
    ON NPSP.health_plan_id = NPSHP.code
LEFT JOIN NORMALIZADO_PEOPLE_SOFT.AFP         AS NPSA 
    ON NPSP.afp_id = NPSA.code
LEFT JOIN HISTACADEMICO.GRADO_ACADEMICO       AS HAGA
    ON CP.COD_PERS = HAGA.COD_PERS
LEFT JOIN HISTACADEMICO.TIPO_GRADO_ACADEMICO  AS HATGA
    ON HAGA.COD_TIPO_GRADO_ACADEMICO = HATGA.COD_TIPO_GRADO_ACADEMICO
LEFT JOIN HISTACADEMICO.INSTITUCION_INVESTIG  AS HAII1
    ON HAGA.COD_INSTITUCION_INVESTIG = HAII1.COD_INSTITUCION_INVESTIG
LEFT JOIN HISTACADEMICO.INSTITUCION_INVESTIG  AS HAII2
    ON HAGA.COD_INSTITUCION_INVESTIG_DOBLE = HAII2.COD_INSTITUCION_INVESTIG
LEFT JOIN NORMALIZADO_PEOPLE_SOFT.EDUCATIONAL_LEVEL AS NPSEL
    ON NPSP.educational_level_id = NPSEL.code
LEFT JOIN HISTACADEMICO.IDIOM_ACADEMICO             AS HAIA
    ON CP.COD_PERS = HAIA.COD_PERS
LEFT JOIN HISTACADEMICO.IDIOM                       AS HAI 
    ON HAIA.COD_IDIOM = HAI.COD_IDIOM
    AND HAIA.COD_NIVEL_IDIOM = 1
LEFT JOIN GENERAL.GOREMAL                           AS GG 
    ON NBP.banner_person_id = GG.GOREMAL_PIDM
GROUP BY
    CP.COD_PERS              
    , NBP.rut                
    , NBP.check_digit        
    , NBP.first_name         
    , NBP.paternal_last_name 
    , NBP.maternal_last_name 
    , NBP.sex                
    , CP.FECHA_NACIM       
    , NBP.country_of_origin  
    , HAI.NOM_IDIOM          
    , PSA.ADDRESS1           
    , PSA.ADDRESS2           
    , PSA.ADDRESS3           
    , PSA.CITY               
    , PSA.COUNTY             
    , PSA.COUNTRY
    , PSA.EFFDT 
    , PSPD.PHONE              
    , GG.GOREMAL_EMAIL_ADDRESS
    , NPSP.marital_status_id   
    , NPSHP.name              
    , NPSA.name               
    , NBP.is_alive
    , NPSEL.name                     
    , HATGA.NOM_TIPO_GRADO_ACADEMICO 
    , HAGA.ANO_OBTENIDO              
    , HAGA.AREA_ESPECIALIZ           
    , HAII1.NOM_INSTITUCION_INVESTIG 
    , HAGA.DOBLE_TITUL               
    , HAII2.NOM_INSTITUCION_INVESTIG 

)
select top 100 * from one where len(rut) > 7

SELECT count(distinct rut) FROM ONE -- 321611 cod_pers
SELECT count(1) FROM ONE --361774
where idioma IS NOT NULL AND idioma <> N'Español'

SELECT * 
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE 
WHERE view_schema = 'MDIUC'
and VIEW_NAME like '%ACADEMICO_SIPA%'


SELECT top 10 * from MDIUC.ACADEMICO_SIPA 
SELECT count(distinct cod_pers) from MDIUC.ACADEMICO_SIPA -- 3575

select top 10 * from PLA.PLANTA_ACADEMICA
select count(1) from PLA.PLANTA_ACADEMICA                   -- 32843
select count(distinct RUT_DV) from PLA.PLANTA_ACADEMICA     -- 6892



/* -------------------------------------------------------------------------- */

select * from information_schema.tables where table_schema like '%people%'
select * from information_schema.columns where column_name like '%cod_idiom%'


select * from HISTACADEMICO.IDIOM
select top 10 * from HISTACADEMICO.IDIOM_ACADEMICO
select top 10 * from HISTACADEMICO.NIVEL_IDIOM

SELECT * FROM UTILS.ColumnType('HISTACADEMICO', 'IDIOM_ACADEMICO')

select top 10 * from HISTACADEMICO.INSTITUCION_INVESTIG

select top 10 * from HISTACADEMICO.USUARIO
select count(distinct DIRECCION_INTERNET) from HISTACADEMICO.USUARIO          --252

select top 10 * from HISTACADEMICO.OTRO_DATO_HA
select count(distinct DIRECCION_INTERNET_UC) from HISTACADEMICO.OTRO_DATO_HA  --1741


SELECT top 10 apellido_paterno from CORP.PERS
SELECT top 10 * from CORP.PERS where cod_pers = 66527

select * from information_schema.columns where table_name = 'PERS' and table_schema = 'CORP'
select top 10 * from corp.pers
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

select * from information_schema.columns where table_name = 'PERSON' and table_schema = 'MDIUC'
select top 10 * from MDIUC.PERSON
/*
rut
dv
tipo_id
paternal_last_name
maternal_last_name
name
created_at
*/

select top 10 * from GENERAL.GOREMAL WHERE goremal_pidm = 68485

SELECT top 100
person.first_name
, person.paternal_last_name
, goremal.goremal_email_address
from NORMALIZADO_BANNER.person 
left join GENERAL.GOREMAL
    on person.banner_person_id = goremal.goremal_pidm

select * from information_schema.columns where table_name = 'PERSON' and table_schema = 'NORMALIZADO_BANNER'
select top 10000 * from NORMALIZADO_BANNER.PERSON
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


select top 10 * from PEOPLE_SOFT.PS_ADDRESSES where emplid like '%22660448%'
where ADDRESS_TYPE <> 'HOME'
select distinct(ADDRESS_TYPE) from PEOPLE_SOFT.PS_ADDRESSES
select count(1) as NumAddr, address_type from PEOPLE_SOFT.PS_ADDRESSES GROUP by ADDRESS_TYPE
select count(distinct emplid) from PEOPLE_SOFT.PS_ADDRESSES where ADDRESS_TYPE = 'HOME'    -- 55238

select count(distinct(emplid)) from PEOPLE_SOFT.PS_ADDRESSES    -- 55357

select top 10 * from PEOPLE_SOFT.PS_PERSONAL_DATA
select count(distinct(emplid)) from PEOPLE_SOFT.PS_PERSONAL_DATA -- 57365

select top 10 * from PEOPLE_SOFT.PS_PERS_DATA_EFFDT
select count(distinct(emplid)) from PEOPLE_SOFT.PS_PERS_DATA_EFFDT -- 57365

select * from UTILS.ColumnDescription(N'PS_ADDRESSES')


/* CÓMO ABORDAR LOS CASOS DE LAS PERSONAS CON PASAPORTE */



select * from utils.ColumnType('CORP', 'PERS') -- RUT es un FLOAT
select * from utils.ColumnType('PEOPLE_SOFT', 'PS_PERSONAL_DATA') -- EMPLID es un NVARCHAR(11)
select * from utils.ColumnType('NORMALIZADO_BANNER', 'PERSON')  --rut es int
select * from utils.ColumnType('NORMALIZADO_PEOPLE_SOFT', 'PERSON') --rut es nvarchar



SELECT top 10 * FROM PEOPLE_SOFT.PS_PERSONAL_DATA WHERE CHARINDEX('-', EMPLID) = 0

SELECT top 10 * FROM NORMALIZADO_BANNER.PERSON WHERE rut = 'E15AK37199'

select top 10 * from PEOPLE_SOFT.PS_ADDRESSES where address1 like '%[depto-DEPTO]%'

select * from information_schema.columns where column_name like '%mar_status%'
SELECT DISTINCT(mar_status) FROM PEOPLE_SOFT.PS_PERSONAL_DATA

SELECT top 10 * FROM NORMALIZADO_PEOPLE_SOFT.MARITAL_STATUS
SELECT TOP 10 * FROM NORMALIZADO_PEOPLE_SOFT.PERSON
SELECT count(distinct rut) FROM NORMALIZADO_PEOPLE_SOFT.person --59681

SELECT top 10 * FROM PEOPLE_SOFT.PS_PERSONAL_DATA where dt_of_death is not null

SELECT TOP 5 * FROM NORMALIZADO_PEOPLE_SOFT.PERSON
SELECT TOP 15 * FROM NORMALIZADO_PEOPLE_SOFT.EDUCATIONAL_LEVEL

SELECT TOP 100 * FROM NORMALIZADO_PEOPLE_SOFT.health_plan
SELECT TOP 100 * FROM NORMALIZADO_PEOPLE_SOFT.AFP

select top 5 * from HISTACADEMICO.grado_academico where doble_titul <> 'N'
select top 5 * from HISTACADEMICO.tipo_grado_academico
