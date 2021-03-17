-- ADMISION

-- chequeamos existencia
SELECT * FROM MCP.MCP_CATALOGO
WHERE NOMBRE_OWNER = 'ADMISION'
AND NOMBRE_TABLA IN (
      'ANTECED_ADMIS'
    , 'CASO_ADMIS'
    , 'COLEGIO_ADMISION' -- no está en el mcp catálogo
    , 'ETNIA'
    , 'HIST_CARRERA'
    , 'INDICE_VULNER_ESCOLAR'
    , 'PERS_ADMIS'
    , 'PERSONA_ADMISION' -- no está en el mcp catálogo
    , 'POSTUL'
    , 'POSTULACION_EFECT'
    , 'PTJE_ADMISION'  -- no está en el mcp catálogo
    , 'SIT_POSTULACION'
    , 'SOLIC_INGR'
    , 'VAC_CASO_CURRICULUM'
    , 'VAC_VIA_CURRICULUM'
    , 'VIA_ADMIS'
) ORDER BY NOMBRE_TABLA ASC

-- actualizamos la fecha
UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'ANTECED_ADMIS'
    , 'CASO_ADMIS'
    , 'COLEGIO_ADMISION' -- no está en el mcp catálogo
    , 'ETNIA'
    , 'HIST_CARRERA'
    , 'INDICE_VULNER_ESCOLAR'
    , 'PERS_ADMIS'
    , 'PERSONA_ADMISION'
    , 'POSTUL'
    , 'POSTULACION_EFECT'
    , 'PTJE_ADMISION'  -- no está en el mcp catálogo
    , 'SIT_POSTULACION'
    , 'SOLIC_INGR'
    , 'VAC_CASO_CURRICULUM'
    , 'VAC_VIA_CURRICULUM'
    , 'VIA_ADMIS'
    )
    AND NOMBRE_OWNER = 'ADMISION'
)

-- verificamos fecha
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'ANTECED_ADMIS'
    , 'CASO_ADMIS'
    , 'COLEGIO_ADMISION' -- no está en el mcp catálogo
    , 'ETNIA'
    , 'HIST_CARRERA'
    , 'INDICE_VULNER_ESCOLAR'
    , 'PERS_ADMIS'
    , 'PERSONA_ADMISION'
    , 'POSTUL'
    , 'POSTULACION_EFECT'
    , 'PTJE_ADMISION'  -- no está en el mcp catálogo
    , 'SIT_POSTULACION'
    , 'SOLIC_INGR'
    , 'VAC_CASO_CURRICULUM'
    , 'VAC_VIA_CURRICULUM'
    , 'VIA_ADMIS'
    )
    AND NOMBRE_OWNER = 'ADMISION'
)

/* BDGI */

-- chequeamos existencia
SELECT * FROM MCP.MCP_CATALOGO
WHERE NOMBRE_OWNER = 'BDGI'
AND NOMBRE_TABLA IN (
          'DIM_CONTACTO'
        , 'DIM_CURRICULO'
        , 'FT_EXE_ROL_EXALUMNO'
) ORDER BY NOMBRE_TABLA ASC

-- LAS TABLAS NO ESTÁN EN EL MCP.MCP_CATALOGO

/* GOBDI */

-- chequeamos existencia
SELECT * FROM MCP.MCP_CATALOGO
WHERE NOMBRE_OWNER = 'GOBDI'
AND NOMBRE_TABLA IN (
      'DIM_PERIODO'
    , 'SEXO'
    , 'UNIDAD_ACADEMICA'
) ORDER BY NOMBRE_TABLA ASC

-- LAS TABLAS NO ESTÁN EN EL MCP.MCP_CATALOGO

/* OA */

-- chequeamos existencia
SELECT * FROM MCP.MCP_CATALOGO
WHERE NOMBRE_OWNER = 'OA'
AND NOMBRE_TABLA IN (
      'aranceles'
    , 'oferta_academica'
) ORDER BY NOMBRE_TABLA ASC

-- LAS TABLAS NO ESTÁN EN EL MCP.MCP_CATALOGO

/* PLA */

-- chequeamos existencia
SELECT * FROM MCP.MCP_CATALOGO
WHERE NOMBRE_OWNER = 'PLA'
AND NOMBRE_TABLA = 'PLANTA_ACADEMICA_NORM'
ORDER BY NOMBRE_TABLA ASC

-- LAS TABLAS NO ESTÁN EN EL MCP.MCP_CATALOGO

/* RAI */

-- chequeamos existencia
SELECT * FROM MCP.MCP_CATALOGO
WHERE NOMBRE_OWNER = 'RAI'
AND NOMBRE_TABLA IN (
      'CONVENIO'                -- no está en mcp catalogo
    , 'CONVENIO_HISTORICO'      -- no está en mcp catalogo
    , 'CONVENIO_INTERCAMBIO'
    , 'CONVENIO_INTERCAMBIO_UC'
    , 'ESTADO_POSTULACION_EXTRJ'
    , 'ESTADO_POSTULACION_UC'
    , 'INSTITUCION_POSTULACION_UC'
    , 'POSTULACION_EXTRJ'
    , 'POSTULACION_UC'
    , 'RAI_INSTITUCION'
    , 'TIPO_INTERCAMBIO'
)
ORDER BY NOMBRE_TABLA ASC


-- actualizamos la fecha
UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'CONVENIO'                -- no está en mcp catalogo
    , 'CONVENIO_HISTORICO'      -- no está en mcp catalogo
    , 'CONVENIO_INTERCAMBIO'
    , 'CONVENIO_INTERCAMBIO_UC'
    , 'ESTADO_POSTULACION_EXTRJ'
    , 'ESTADO_POSTULACION_UC'
    , 'INSTITUCION_POSTULACION_UC'
    , 'POSTULACION_EXTRJ'
    , 'POSTULACION_UC'
    , 'RAI_INSTITUCION'
    , 'TIPO_INTERCAMBIO'
    )
    AND NOMBRE_OWNER = 'RAI'
)


-- verificamos fecha
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'CONVENIO'                -- no está en mcp catalogo
    , 'CONVENIO_HISTORICO'      -- no está en mcp catalogo
    , 'CONVENIO_INTERCAMBIO'
    , 'CONVENIO_INTERCAMBIO_UC'
    , 'ESTADO_POSTULACION_EXTRJ'
    , 'ESTADO_POSTULACION_UC'
    , 'INSTITUCION_POSTULACION_UC'
    , 'POSTULACION_EXTRJ'
    , 'POSTULACION_UC'
    , 'RAI_INSTITUCION'
    , 'TIPO_INTERCAMBIO'
    )
    AND NOMBRE_OWNER = 'RAI'
)

/* UC_BANNER */

-- chequeamos existencia
SELECT * FROM MCP.MCP_CATALOGO
WHERE NOMBRE_OWNER = 'UC_BANNER'
AND NOMBRE_TABLA IN (
      'ALUMNO'
    , 'ASIGN'
    , 'CARRERA'
    , 'CURRICULUM'
    , 'FACULTAD'
    , 'HIST_ALUMNO_CURSO_VIG'
    , 'PAIS'
    , 'PARAM'
    , 'PERS'
    , 'UNIDAD_ACADEM'
)
ORDER BY NOMBRE_TABLA ASC


-- actualizamos la fecha
UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'ALUMNO'
    , 'ASIGN'
    , 'CARRERA'
    , 'CURRICULUM'
    , 'FACULTAD'
    , 'HIST_ALUMNO_CURSO_VIG'
    , 'PAIS'
    , 'PARAM'
    , 'PERS'
    , 'UNIDAD_ACADEM'
    )
    AND NOMBRE_OWNER = 'UC_BANNER'
)


-- verificamos fecha
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'ALUMNO'
    , 'ASIGN'
    , 'CARRERA'
    , 'CURRICULUM'
    , 'FACULTAD'
    , 'HIST_ALUMNO_CURSO_VIG'
    , 'PAIS'
    , 'PARAM'
    , 'PERS'
    , 'UNIDAD_ACADEM'
    )
    AND NOMBRE_OWNER = 'UC_BANNER'
)

/* DASE */

-- chequeamos existencia
SELECT * FROM MCP.MCP_CATALOGO
WHERE NOMBRE_OWNER = 'DASE'
AND NOMBRE_TABLA IN (
      'TIPO_BENEF'
    , 'BENEF'
    , 'FINANC_BENEF'
    , 'CATEGORIA_BENEF'
)
ORDER BY NOMBRE_TABLA ASC


-- actualizamos la fecha
UPDATE MCP.MCP_FECHA_PROCESO 
SET   FCH_ULT_ACTUALIZACION_ADL = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_ADL = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga
    , FCH_ULT_ACTUALIZACION_STG = '1900-01-01'
    , FCH_PROX_ACTUALIZACION_STG = (SELECT CAST(GETDATE() AS DATE)) -- Fecha del día en que hacemos la carga    
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'TIPO_BENEF'
    , 'BENEF'
    , 'FINANC_BENEF'
    , 'CATEGORIA_BENEF'
    )
    AND NOMBRE_OWNER = 'DASE'
)


-- verificamos fecha
SELECT * 
FROM MCP.MCP_FECHA_PROCESO 
WHERE ID_CATALOGO IN (
    SELECT ID_CATALOGO 
    FROM MCP.MCP_CATALOGO 
    WHERE NOMBRE_TABLA IN (
      'TIPO_BENEF'
    , 'BENEF'
    , 'FINANC_BENEF'
    , 'CATEGORIA_BENEF'
    )
    AND NOMBRE_OWNER = 'DASE'
)


SELECT TOP 50 * 
FROM [MCP].[MCP_LOG_PROCESO_BULK]
ORDER BY ID_LOG_PROCESO DESC


select *
from sys.objects where type = 'V' 
