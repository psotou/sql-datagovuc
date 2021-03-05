/* Debemos correr lo siguiente en Stage-Datagov_Prod */

-- ===========================================
-- Tablas de DASE
-- ===========================================

-- cheaqueamos útlima fecha de actualización de STG
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
          'BENEF'
        , 'CATEGORIA_BENEF'
        , 'FINANC_BENEF'
        , 'TIPO_BENEF'
    )
    AND NOMBRE_OWNER = 'DASE'
)

-- hacemos el update de la fecha de actualización para que lo pueda tomar la malla STG
UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
          'BENEF'
        , 'CATEGORIA_BENEF'
        , 'FINANC_BENEF'
        , 'TIPO_BENEF'
    )
    AND NOMBRE_OWNER = 'DASE'
)

-- chequeamos la última fecha de modificación de las tablas
SELECT [name]
    , create_date
    , modify_date
    , schema_id
    , SCHEMA_NAME(schema_id)
FROM sys.objects
WHERE SCHEMA_NAME(schema_id) = 'DASE'
AND [name] IN (
      'BENEF'
    , 'CATEGORIA_BENEF'
    , 'FINANC_BENEF'
    , 'TIPO_BENEF'
)

-- ===========================================
-- Tablas de UC_BANNER
-- ===========================================

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

-- hacemos el update de la fecha de actualización para que lo pueda tomar la malla STG
UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'CARRERA'
    , 'PARAM'
    )
    AND NOMBRE_OWNER = 'UC_BANNER'
)

-- chequeamos la última fecha de modificación de las tablas
SELECT [name]
    , create_date
    , modify_date
    , schema_id
    , SCHEMA_NAME(schema_id)
FROM sys.objects
WHERE SCHEMA_NAME(schema_id) = 'UC_BANNER'
ORDER BY modify_date DESC


------
SELECT TOP 100 * FROM [MCP].[MCP_LOG_PROCESO_BULK] ORDER BY ID_LOG_PROCESO DESC
