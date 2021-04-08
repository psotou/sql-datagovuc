
--COLUMNS
select 
    schema_name(so.schema_id) as [schema_name]
  , object_name(sc.object_id) as table_name
  , sc.name                   as column_name 
from sys.objects as so
join sys.columns as sc 
  on so.object_id = sc.object_id
where so.type = 'U'
  and schema_name(so.schema_id) = 'SATURN'
  and object_name(sc.object_id) like '%NATN%'

  -- TABLES
select 
    schema_name(schema_id) as [schema_name]
  , object_name(object_id) as table_name
  , [type]
from sys.objects
where schema_name(schema_id) = 'MDIUC'
  and [type] IN ('U', 'V')
order by table_name

--
select top 4 * from SATURN.SPRADDR
select * from SATURN.SPRADDR WHERE SPRADDR_PIDM = 385394
select count(1) from SATURN.SPRADDR  -- 753942

select count(1) from SATURN.SPRIDEN  -- 362161
select top 4 * from SATURN.SPRIDEN


select top 50
    sprspri.SPRADDR_PIDM 
  , spri.SPRIDEN_ID as rut 
  , sprspri.SPRADDR_NATN_CODE
  , stv.STVNATN_CODE
from SATURN.SPRADDR spra
left join SATURN.SPRIDEN spri on sprspri.SPRADDR_PIDM = spri.SPRIDEN_PIDM
left join SATURN.STVNATN stv on sprspri.SPRADDR_NATN_CODE = stv.STVNATN_CODE

-- Nacionalidad: the rught way
SELECT top 10
    spri.SPRIDEN_ID
  , gob.GOBINTL_NATN_CODE_LEGAL
  , stv.STVNATN_NATION
FROM SATURN.SPRIDEN spri
LEFT JOIN GENERAL.GOBINTL gob ON gob.gobintl_pidm = spri.spriden_pidm
LEFT JOIN SATURN.STVNATN stv ON gob.gobintl_natn_code_legal = stv.stvnatn_code

/* Profiling */ 

select count(1) from UC_BANNER.PERS_DIRECCION where COD_PAIS is not null
select count(1) from UC_BANNER.PERS_DIRECCION where COD_PAIS is null



select top 4 * from PEOPLE_SOFT.PS_ADDRESSES
