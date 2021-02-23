SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [ADMISION].[TBL_VW_FT_ADMISION_PAS]
   AS
    SELECT
          AAAH.RUT                          AS RUT
        , AP.APELLIDO_PATERNO
        , AP.APELLIDO_MATERNO
        , AP.NOM                            AS NOMBRES
        , AP.SEXO
        , AAAH.COD_COLEGIO
        , ACA.NOM_COLEGIO                   AS COLEGIO
        , AIVE.INDICE                       AS IVE_COLEGIO
        , AAAH.ANO_EGRESO_COLEGIO
        , AAAH.ANO_ADMIS                    AS ANO_ADMISION
        , APEH.CLAVE_NACIONAL
        , AHC.NOM_CARRERA                   AS CARRERA
        , APEH.PREF                         AS PREFERENCIA
        , APEH.COD_SIT_POSTULACION          AS COD_SIT_POSTUL
        , ASPH.NOM_SIT_POSTULACION          AS NOM_SIT_POSTUL
        , APEH.COD_SIT_POSTULACION_ANT      AS COD_SIT_POSTUL_ANT
        , ASPH2.NOM_SIT_POSTULACION         AS NOM_SIT_POSTUL_ANT
        , APEH.COD_SIT_POSTULACION_INICIAL  AS COD_SIT_POSTUL_INICIAL
        , ASPH3.NOM_SIT_POSTULACION         AS NOM_SIT_POSTUL_INICIAL
        , AP.COD_ETNIA
        , AE.NOM_ETNIA                      AS ETNIA
        , APA.NOM_PAIS                      AS PAIS
    FROM ADMISION.ANTECED_ADMIS_HIST                                AS AAAH
    LEFT JOIN ADMISION.POSTUL                                       AS AP 
        ON AAAH.RUT = AP.RUT                
            AND AAAH.ANO_ADMIS = AP.ANO_ADMIS               
            AND AAAH.COD_COLEGIO = AP.COD_COLEGIO               
    LEFT JOIN ADMISION.COLEGIO_ADMISION                             AS ACA 
        ON AAAH.COD_COLEGIO = ACA.COD_COLEGIO               
            AND AAAH.ANO_COLEGIO = ACA.ANO_COLEGIO              
    LEFT JOIN ADMISION.INDICE_VULNER_ESCOLAR                        AS AIVE 
        ON ACA.ROL_BASE_DATO = AIVE.ROL_BASE_DATO               
            AND AAAH.ANO_ADMIS = AIVE.ANO_ADMIS             
    LEFT JOIN ADMISION.ETNIA                                        AS AE 
        ON AP.COD_ETNIA = AE.COD_ETNIA              
    LEFT JOIN ADMISION.PERSONA_ADMISION                             AS APA 
        ON AAAH.RUT = APA.RUT               
            AND AAAH.ANO_ADMIS = APA.ANO_ADMIS              
    LEFT JOIN ADMISION.POSTULACION_EFECT_HIST                       AS APEH 
        ON AAAH.RUT = APEH.RUT              
            AND AAAH.ANO_ADMIS = APEH.ANO_ADMIS             
    LEFT JOIN ADMISION.HIST_CARRERA                                 AS AHC
        ON APEH.CLAVE_NACIONAL = AHC.CLAVE_NACIONAL             
            AND APEH.ANO_ADMIS = AHC.ANO_ADMIS              
    LEFT JOIN ADMISION.SIT_POSTULACION_HIST                         AS ASPH
        ON APEH.COD_SIT_POSTULACION = ASPH.COD_SIT_POSTULACION
    LEFT JOIN ADMISION.SIT_POSTULACION_HIST                         AS ASPH2
        ON APEH.COD_SIT_POSTULACION_ANT = ASPH2.COD_SIT_POSTULACION
    LEFT JOIN ADMISION.SIT_POSTULACION_HIST                         AS ASPH3
        ON APEH.COD_SIT_POSTULACION_INICIAL = ASPH3.COD_SIT_POSTULACION
    GROUP BY
          AAAH.RUT
        , AP.APELLIDO_PATERNO
        , AP.APELLIDO_MATERNO
        , AP.NOM
        , AP.SEXO
        , AAAH.COD_COLEGIO
        , ACA.NOM_COLEGIO
        , AIVE.INDICE
        , AAAH.ANO_EGRESO_COLEGIO
        , AAAH.ANO_ADMIS
        , APEH.CLAVE_NACIONAL
        , AHC.NOM_CARRERA
        , APEH.PREF
        , APEH.COD_SIT_POSTULACION
        , ASPH.NOM_SIT_POSTULACION
        , APEH.COD_SIT_POSTULACION_ANT
        , ASPH2.NOM_SIT_POSTULACION
        , APEH.COD_SIT_POSTULACION_INICIAL
        , ASPH3.NOM_SIT_POSTULACION
        , AP.COD_ETNIA
        , AE.NOM_ETNIA
        , APA.NOM_PAIS

GO
