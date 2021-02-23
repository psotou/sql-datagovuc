SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW ADMISION.[TBL_VW_FT_ADMISION_ESP_ORD_PAS]
AS
SELECT 
      ASIH.COD_SOLIC_INGR               AS COD_SOLIC_INGR
    , ASIH.RUT                          AS RUT
    , APAH.SEXO                         AS SEXO
    , NULL                              AS CLAVE_NACIONAL
    , ASIH.COD_CURRICULUM               AS COD_CURRICULUM
    , ASIH.ANO_ADMIS                    AS ANO_ADMIS
    -- , ASIH.COD_PERIODO                  AS COD_PERIODO_B is this really helpful?
    , CASE 
        WHEN ASIH.COD_PERIODO = 21 THEN ASIH.ANO_ADMIS*100+1
        ELSE ASIH.ANO_ADMIS*100+2 
      END                               AS COD_PERIODO
    , NULL                              AS PREF
    , ASIH.PUESTO                       AS PUESTO
    , ASIH.PRIORID                      AS PRIORIDAD
    , ASIH.PTJE_PACE                    AS PTJE_PACE
    , ASIH.PTJE_POND_SELEC              AS PTJE_POND_SELEC
    , CAST(ASIH.PTJE_SELEC AS FLOAT)    AS PTJE_SELEC
    , NULL                              AS COD_SIT_POSTULACION
    , NULL                              AS NOM_SITUACION_POSTULACION
    , NULL                              AS COD_SITUACION_POSTULACION_INICIAL
    , NULL                              AS NOM_SITUACION_POSTULACION_INICIAL
    , ASIH.COD_ESTADO_POSTULACION       AS COD_EST_POSTULACION
    , AVAH.COD_VIA_ADMIS                AS COD_VIA_ADMIS
    , AVAH.NOM_VIA_ADMIS                AS NOM_VIA_ADMIS
    , ACAH.COD_CASO_ADMIS               AS COD_CASO_ADMIS
    , ACAH.NOM_CASO_ADMIS               AS NOM_CASO_ADMIS
    , PTJE.NEM                          AS NEM
    , PTJE.RKG                          AS RKG
    , PTJE.CIE                          AS CIE
    , PTJE.HYC                          AS HYC
    , PTJE.LYC                          AS LYC
    , PTJE.MAT                          AS MAT
    , PTJE.PSU                          AS PSU
    , PTJE.PCMLT                        AS PCMLT
    , AAAH.PROM_NOTA_ENSEN_MEDIA        AS PROM_NOTA_ENSEN_MEDIA
    , AAAH.PROM_PAA                     AS PROM_PAA
    , AAAH.COD_COLEGIO                  AS COD_COLEGIO
    , AAAH.ANO_EGRESO_COLEGIO           AS ANO_EGRESO_COLEGIO
    , AAAH.ANO_COLEGIO                  AS ANO_COLEGIO
    , AAAH.BECA_EXCELENCIA_ACADEM       AS BEA
    , AAAH.PACE                         AS PACE
FROM ADMISION.SOLIC_INGR_HIST       AS ASIH   -- MY LEFT TABLE
LEFT JOIN ADMISION.PERS_ADMIS_HIST  AS APAH
    ON (ASIH.RUT = APAH.RUT)
LEFT JOIN ADMISION.VIA_ADMIS_HIST   AS AVAH
    ON (ASIH.COD_VIA_ADMIS = AVAH.COD_VIA_ADMIS)
LEFT JOIN ADMISION.CASO_ADMIS_HIST  AS ACAH 
    ON (ASIH.COD_CASO_ADMIS = ACAH.COD_CASO_ADMIS)
LEFT JOIN (
        SELECT 
              RUT
            , ANO_ADMIS
            , MAX(CIE)      AS CIE
            , MAX(HYC)      AS HYC
            , MAX(LYC)      AS LYC
            , MAX(MAT)      AS MAT
            , MAX(NEM)      AS NEM
            , MAX(PSU)      AS PSU
            , MAX(PCMLT)    AS PCMLT
            , MAX(RKG)      AS RKG
        FROM ADMISION.PTJE_ADMISION
        WHERE ANO_ADMIS > 2007
        GROUP BY RUT, ANO_ADMIS 
) AS PTJE
    ON (ASIH.RUT = PTJE.RUT
        AND ASIH.ANO_ADMIS = PTJE.ANO_ADMIS)
LEFT JOIN (
        SELECT 
              RUT
            , ANO_ADMIS
            , PROM_NOTA_ENSEN_MEDIA
            , PROM_PAA
            , COD_COLEGIO
            , ANO_EGRESO_COLEGIO
            , ANO_COLEGIO
            , BECA_EXCELENCIA_ACADEM
            , PACE
        FROM ADMISION.ANTECED_ADMIS_HIST
) AS AAAH
    ON (ASIH.RUT = AAAH.RUT
        AND ASIH.ANO_ADMIS = AAAH.ANO_ADMIS)
WHERE ASIH.ANO_ADMIS > 2007

UNION ALL

SELECT 
      APEH.COD_POSTULACION_EFECT        AS COD_SOLIC_INGR
    , APEH.RUT                          AS RUT
    , APAH.SEXO
    , APEH.CLAVE_NACIONAL               AS CLAVE_NACIONAL
    , APEH.COD_CURRICULUM               AS COD_CURRICULUM
    , APEH.ANO_ADMIS                    AS ANO_ADMIS
    -- , ASIH.COD_PERIODO                  AS COD_PERIODO_B is this really helpful?
    , CASE 
        WHEN APEH.COD_PERIODO = 21 THEN APEH.ANO_ADMIS*100+1
        ELSE APEH.ANO_ADMIS*100+2 
      END                               AS COD_PERIODO
    , APEH.PREF                         AS PREF
    , APEH.PUESTO                       AS PUESTO
    , NULL                              AS PRIORIDAD
    , NULL                              AS PTJE_PACE
    , NULL                              AS PTJE_POND_SELEC
    , CAST(APEH.PTJE_SELEC AS FLOAT)    AS PTJE_SELEC
    , APEH.COD_SIT_POSTULACION          AS COD_SIT_POSTULACION
    , ASPH1.NOM_SIT_POSTULACION         AS NOM_SITUACION_POSTULACION
    , APEH.COD_SIT_POSTULACION_INICIAL  AS COD_SITUACION_POSTULACION_INICIAL
    , ASPH2.NOM_SIT_POSTULACION         AS NOM_SITUACION_POSTULACION_INICIAL
    , NULL                              AS COD_EST_POSTULACION
    , 600                               AS COD_VIA_ADMIS
    , CASOVIA.NOM_VIA_ADMIS             AS NOM_VIA_ADMIS
    , 601                               AS COD_CASO_ADMIS
    , CASOVIA.NOM_CASO_ADMIS            AS NOM_CASO_ADMIS
    , PTJE.NEM                          AS NEM
    , PTJE.RKG                          AS RKG
    , PTJE.CIE                          AS CIE
    , PTJE.HYC                          AS HYC
    , PTJE.LYC                          AS LYC
    , PTJE.MAT                          AS MAT
    , PTJE.PSU                          AS PSU
    , PTJE.PCMLT                        AS PCMLT
    , AAAH.PROM_NOTA_ENSEN_MEDIA        AS PROM_NOTA_ENSEN_MEDIA
    , AAAH.PROM_PAA                     AS PROM_PAA
    , AAAH.COD_COLEGIO                  AS COD_COLEGIO
    , AAAH.ANO_EGRESO_COLEGIO           AS ANO_EGRESO_COLEGIO
    , AAAH.ANO_COLEGIO                  AS ANO_COLEGIO
    , AAAH.BECA_EXCELENCIA_ACADEM       AS BEA
    , AAAH.PACE                         AS PACE
FROM ADMISION.POSTULACION_EFECT_HIST        AS APEH
LEFT JOIN ADMISION.PERS_ADMIS_HIST          AS APAH
    ON (APEH.RUT = APAH.RUT)
LEFT JOIN (
        SELECT
        AVAH.COD_VIA_ADMIS
        , AVAH.NOM_VIA_ADMIS
        , ACAH.COD_CASO_ADMIS
        , CASE 
            WHEN ACAH.NOM_CASO_ADMIS IS NULL THEN 'PSU'
            ELSE ACAH.NOM_CASO_ADMIS 
        END  AS NOM_CASO_ADMIS
        FROM ADMISION.CASO_ADMIS_HIST           AS ACAH
        FULL OUTER JOIN ADMISION.VIA_ADMIS_HIST AS AVAH
            ON (ACAH.COD_VIA_ADMIS = AVAH.COD_VIA_ADMIS)
) AS CASOVIA
    ON (600 = CASOVIA.COD_VIA_ADMIS)
LEFT JOIN ADMISION.SIT_POSTULACION_HIST     AS ASPH1
    ON (APEH.COD_SIT_POSTULACION = ASPH1.COD_SIT_POSTULACION)
LEFT JOIN ADMISION.SIT_POSTULACION_HIST     AS ASPH2
    ON (APEH.COD_SIT_POSTULACION_INICIAL = ASPH2.COD_SIT_POSTULACION)
LEFT JOIN (
        SELECT
              RUT
            , ANO_ADMIS
            , MAX(CIE)   AS CIE
            , MAX(HYC)   AS HYC
            , MAX(LYC)   AS LYC
            , MAX(MAT)   AS MAT
            , MAX(NEM)   AS NEM
            , MAX(PSU)   AS PSU
            , MAX(PCMLT) AS PCMLT
            , MAX(RKG)   AS RKG
        FROM ADMISION.PTJE_ADMISION
        WHERE ANO_ADMIS > 2007
        GROUP BY RUT, ANO_ADMIS
) AS PTJE
    ON (APEH.RUT = PTJE.RUT
        AND APEH.ANO_ADMIS = PTJE.ANO_ADMIS)
LEFT JOIN (
		SELECT 
			  RUT
			, ANO_ADMIS
			, PROM_NOTA_ENSEN_MEDIA
			, PROM_PAA
			, COD_COLEGIO
			, ANO_EGRESO_COLEGIO
			, ANO_COLEGIO
			, BECA_EXCELENCIA_ACADEM
			, PACE
		FROM ADMISION.ANTECED_ADMIS_HIST 
) AS AAAH
	ON (APEH.RUT = AAAH.RUT AND APEH.ANO_ADMIS = AAAH.ANO_ADMIS)
WHERE APEH.ANO_ADMIS > 2007

GO