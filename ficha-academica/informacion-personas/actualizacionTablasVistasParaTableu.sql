select * from information_schema.views where table_name like '%BENEF%'
select * from information_schema.tables where table_schema = 'MCP'

SELECT * 
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE 
WHERE VIEW_NAME = 'TBL_VW_BENEF'

SELECT * 
FROM SBX.CARGA_TABLA_STG_A_SBX

/*
DASE	AGRUPACION_BENEFICIO
DASE	BENEF
DASE	CATEGORIA_BENEF
DASE	FINANC_BENEF
DASE	MOVTO_ENCRYPT
DASE	TIPO_BENEF
GOBDI	UNIDAD_ACADEMICA --tabla referencial
UC_BANNER	CARRERA
UC_BANNER	PARAM
*/

select top 10 * from DASE.AGRUPACION_BENEFICIO
select top 10 * from GOBDI.UNIDAD_ACADEMICA
select top 10 * from DASE.MOVTO_ENCRYPT

-- cheaqueamos el flag esquema DASE
SELECT * 
FROM SBX.CARGA_TABLA_STG_A_SBX
WHERE NOMBRE_TABLA IN (
      'BENEF'
    , 'CATEGORIA_BENEF'
    , 'FINANC_BENEF'
    , 'TIPO_BENEF'
) AND NOMBRE_OWNER = 'DASE'

-- Cambiamos el flag pertinente esquema DASE
INSERT INTO SBX.CARGA_TABLA_STG_A_SBX (NOMBRE_OWNER, NOMBRE_TABLA, FLG_SBX)
VALUES ('DASE', 'BENEF', 1)
     , ('DASE', 'CATEGORIA_BENEF', 1)
     , ('DASE', 'FINANC_BENEF', 1)
     , ('DASE', 'TIPO_BENEF', 1)

UPDATE SBX.CARGA_TABLA_STG_A_SBX 
SET FLG_SBX = 1
WHERE NOMBRE_OWNER = 'ADMISION'
AND NOMBRE_TABLA = 'PERS_ADMIS'

-- cheaqueamos el flag esquema UC_BANNER
SELECT * 
FROM SBX.CARGA_TABLA_STG_A_SBX
WHERE NOMBRE_TABLA IN (
      'CARRERA'
    , 'PARAM'
) AND NOMBRE_OWNER = 'UC_BANNER'

-- Cambiamos el flag pertinente esquema UC_BANNER
INSERT INTO SBX.CARGA_TABLA_STG_A_SBX (NOMBRE_OWNER, NOMBRE_TABLA, FLG_SBX)
VALUES ('UC_BANNER', 'CARRERA', 1)
     , ('UC_BANNER', 'PARAM', 1)



WITH TABS AS ( 
SELECT 
       ISVTU.VIEW_SCHEMA   AS NombreEsquema
     , ISVTU.VIEW_NAME     AS NombreVista
     , ISVTU.TABLE_SCHEMA  AS EsquemaTablaQueUsaLaVista
     , ISVTU.TABLE_NAME    AS TablaQueUsaLaVista
     , SO.modify_date      AS FechaModTabla
     , SO.create_date      AS FechaCreacionTabla
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS ISVTU
LEFT JOIN sys.objects                    AS SO
     ON ISVTU.TABLE_SCHEMA = SCHEMA_NAME(SO.schema_id)
WHERE ISVTU.VIEW_NAME = 'TBL_VW_INCOMING'
)
SELECT EsquemaTablaQueUsaLaVista, TablaQueUsaLaVista, max(FechaModTabla) from TABS group by EsquemaTablaQueUsaLaVista, TablaQueUsaLaVista
