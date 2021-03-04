select * from [catalog].Node

/* ACTUALIZACIÓN TABLAS CONSUMIDAS POR VISTA TBL_VW_BENEF */

-- Fechas de actualización para las tablas del esquema DASE
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
        -- 'AGRUPACION_BENEFICIO' -- no está, why?
        'BENEF'
        , 'CATEGORIA_BENEF'
        , 'FINANC_BENEF'
        -- , 'MOVTO_ENCRYPT' -- no
        , 'TIPO_BENEF'
    ) AND NOMBRE_OWNER = 'DASE'
)

-- Fechas de actualización para las tablas del esquema GOBDI (no está, why?)
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA = 'UNIDAD_ACADEMICA'
    AND NOMBRE_OWNER = 'GOBDI'
)


-- Fechas de actualización para las tablas del esquema UC_BANNER
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
        'CARRERA'
        , 'PARAM'
    )
    AND NOMBRE_OWNER = 'UC_BANNER'
)

SELECT * from UTILS.ColumnType('MCP', 'MCP_FECHA_PROCESO')
SELECT CAST(GETDATE() AS DATE ); -- today

/* ACTUALIZACIÓN DE LAS FECHAS DE ACTUALIZACIÓN*/

-- Fechas de actualización para las tablas del esquema DASE
UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'  
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
          'BENEF'
        , 'CATEGORIA_BENEF'
        , 'FINANC_BENEF'
        , 'TIPO_BENEF'
    ) AND NOMBRE_OWNER = 'DASE'
)

-- Fechas de actualización para las tablas del esquema UC_BANNER
UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'  
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
        'CARRERA'
        , 'PARAM'
    ) AND NOMBRE_OWNER = 'UC_BANNER'
)

