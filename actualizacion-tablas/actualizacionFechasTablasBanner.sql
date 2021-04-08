WITH all_dependencies_sp AS (  --358 referencias--
SELECT
	--- ENTIDAD REFERENCIADORA
	OBJECT_SCHEMA_NAME ( referencing_id ) AS referencing_schema_name,  
    OBJECT_NAME(referencing_id) AS referencing_entity_name,
	o.type AS referencing_type,
    o.type_desc AS referencing_desciption,   
    COALESCE(COL_NAME(referencing_id, referencing_minor_id), '(n/a)') AS referencing_minor_id,   
    referencing_class_desc,
	---ENTIDAD REFERENCIADA 
	referenced_class_desc,  
    referenced_server_name, referenced_database_name, referenced_schema_name,  
    referenced_entity_name,
	o2.type AS referenced_type,
    o2.type_desc AS referenced_desciption, 
    COALESCE(COL_NAME(referenced_id, referenced_minor_id), '(n/a)') AS referenced_column_name,  
    is_caller_dependent, is_ambiguous  
FROM sys.sql_expression_dependencies AS sed  
INNER JOIN sys.objects AS o ON sed.referencing_id = o.object_id
LEFT JOIN sys.objects AS o2 ON sed.referenced_id = o2.object_id
WHERE OBJECT_SCHEMA_NAME ( referencing_id ) = 'NORMALIZADO_BANNER' and o.type IN ('P','X','RF','PC') --and OBJECT_NAME(referencing_id) = 'UPDATE_ACADEMIC_PROGRAM' --and OBJECT_NAME(referenced_id) = '__academic_situation'
)
SELECT UPPER(referenced_schema_name) AS ESQUEMA, UPPER(referenced_entity_name) AS TABLAS
FROM all_dependencies_sp where referenced_schema_name NOT IN ('NORMALIZADO_BANNER','MCP') group by referenced_schema_name, referenced_entity_name order by referenced_schema_name
--SELECT DISTINCT referenced_schema_name,referenced_entity_name FROM all_dependencies_sp where referenced_schema_name IN ('NORMALIZADO_BANNER')


-----
-- FECHAS DE ACTUALIZACIÓN PARA BANNER

UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA = 'INSCRIP_ALTER'
    AND NOMBRE_OWNER = 'ALT_ACADEM'
)

UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA = 'R_SORLFOS_ALUMNO'
    AND NOMBRE_OWNER = 'BANNER_UC'
)

UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
          'GOBINTL'
        , 'GORSDAV'
        , 'GTVDICD'
        , 'GTVINSM'
        , 'GTVSDAX'
    )
    AND NOMBRE_OWNER = 'GENERAL'
)

UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
          'SCBCRSE'
        , 'SCRSYLN'
        , 'SFRSTCR'
        , 'SGBSTDN'
        , 'SGBUSER'
        , 'SGRSATT'
        , 'SGRSPRT'
        , 'SHRDGMR'
        , 'SHRTCKG'
        , 'SHRTCKN'
        , 'SHRTRCE'
        , 'SHRTRCR'
        , 'SHRTRIT'
        , 'SIBINST'
        , 'SIRASGN'
        , 'SIRDPCL'
        , 'SLBRDEF'
        , 'SLRBCAT'
        , 'SMBAGEN'
        , 'SMBARUL'
        , 'SMBPGEN'
        , 'SMRARUL'
        , 'SMRPAAP'
        , 'SMRPRLE'
        , 'SOBSBGI'
        , 'SORBCHR'
        , 'SORHSCH'
        , 'SORLCUR'
        , 'SORLFOS'
        , 'SPBPERS'
        , 'SPRHOLD'
        , 'SPRIDEN'
        , 'SSBSECT'
        , 'SSRMEET'
        , 'SSRSCCD'
        , 'SSRXLST'
        , 'STVADMT'
        , 'STVBCHR'
        , 'STVBLDG'
        , 'STVCAMP'
        , 'STVCNTY'
        , 'STVCOLL'
        , 'STVCSTS'
        , 'STVDEGC'
        , 'STVDLEV'
        , 'STVFCST'
        , 'STVGMOD'
        , 'STVHLDD'
        , 'STVMAJR'
        , 'STVNATN'
        , 'STVRATE'
        , 'STVSBGI'
        , 'STVSCCD'
        , 'STVSCHD'
        , 'STVSTAT'
        , 'STVSTST'
        , 'STVSUDB'
        , 'STVSUDC'
        , 'STVSUDD'
        , 'STVSUDE'
        , 'STVTERM'
    )
    AND NOMBRE_OWNER = 'SATURN'
)



--
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA = 'INSCRIP_ALTER' 
    AND NOMBRE_OWNER = 'ALT_ACADEM'
)


SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA = 'R_SORLFOS_ALUMNO' 
    AND NOMBRE_OWNER = 'BANNER_UC'
)

SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
          'GOBINTL'
        , 'GORSDAV'
        , 'GTVDICD'
        , 'GTVINSM'
        , 'GTVSDAX'
    ) 
    AND NOMBRE_OWNER = 'GENERAL'
)

SELECT * 
FROM MCP.MCP_FECHA_PROCESO --WHERE FCH_PROX_ACTUALIZACION_ADL = '2021-03-18'
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
        'SCBCRSE'
        , 'SCRSYLN'
        , 'SFRSTCR'
        , 'SGBSTDN'
        , 'SGBUSER'
        , 'SGRSATT'
        , 'SGRSPRT'
        , 'SHRDGMR'
        , 'SHRTCKG'
        , 'SHRTCKN'
        , 'SHRTRCE'
        , 'SHRTRCR'
        , 'SHRTRIT'
        , 'SIBINST'
        , 'SIRASGN'
        , 'SIRDPCL'
        , 'SLBRDEF'
        , 'SLRBCAT'
        , 'SMBAGEN'
        , 'SMBARUL'
        , 'SMBPGEN'
        , 'SMRARUL'
        , 'SMRPAAP'
        , 'SMRPRLE'
        , 'SOBSBGI'
        , 'SORBCHR'
        , 'SORHSCH'
        , 'SORLCUR'
        , 'SORLFOS'
        , 'SPBPERS'
        , 'SPRHOLD'
        , 'SPRIDEN'
        , 'SSBSECT'
        , 'SSRMEET'
        , 'SSRSCCD'
        , 'SSRXLST'
        , 'STVADMT'
        , 'STVBCHR'
        , 'STVBLDG'
        , 'STVCAMP'
        , 'STVCNTY'
        , 'STVCOLL'
        , 'STVCSTS'
        , 'STVDEGC'
        , 'STVDLEV'
        , 'STVFCST'
        , 'STVGMOD'
        , 'STVHLDD'
        , 'STVMAJR'
        , 'STVNATN'
        , 'STVRATE'
        , 'STVSBGI'
        , 'STVSCCD'
        , 'STVSCHD'
        , 'STVSTAT'
        , 'STVSTST'
        , 'STVSUDB'
        , 'STVSUDC'
        , 'STVSUDD'
        , 'STVSUDE'
        , 'STVTERM'
    ) 
    AND NOMBRE_OWNER = 'SATURN'
)




SELECT * 
FROM [MCP].[MCP_LOG_PROCESO_BULK] 
WHERE CAST(FCH_FIN AS DATE) = '2021-03-18'
ORDER BY ID_LOG_PROCESO DESC

select * from Utils


select 
    schema_name(schema_id)
    , [name] as tablename
    , create_date
    , modify_date
from sys.objects where schema_name(schema_id) = 'GENERAL' order by modify_date DESC
