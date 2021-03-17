select * from [catalog].Node where NodeTypeID = 10

/*
TBL_VW_cna_pregrado_anos        --done
TBL_VW_CONVENIO                 --done
TBL_VW_CONVENIO_HISTORICO		--done
TBL_VW_cna_pregrado				--done
TBL_VW_CARRERA					--done
TBL_VW_cna_pregrado_etapas		--done
TBL_VW_oferta_academica			--done
TBL_VW_BENEF 					--done
TBL_VW_COMPILADO_UC				--done
TBL_VW_PLANTA_ACADEMICA			--done
TBL_VW_cna_institucional_anos   --done
TBL_VW_aranceles				--done
TBL_VW_INCOMING					--done
TBL_VW_FT_ADM_VAC_VIA			--done
TBL_VW_FT_ADM_VAC_CASO			--done
TBL_VW_BIBLIOTECA				--done
TBL_VW_GENERAL					--done					
TBL_VW_ranking_qs_latam			--done
TBL_VW_ranking_the_times_latam	--done
TBL_VW_ranking_the_times_global	--done
TBL_VW_PAIS_COLABORADOR			--done
TBL_VW_PUBLICACION				--done
TBL_VW_SEXO_AUTOR				--done
TBL_VW_WOS_AREA_OCDE			--done
TBL_VW_cna_institucional		--done
TBL_VW_PERS_ADM_PROF			--done
TBL_VW_DIM_CONTACTO				--done
TBL_VW_DIM_CURRICULO			--done
TBL_VW_FT_ROL_EXALUMNO			--done
TBL_VW_FT_ADMISION_ESP_ORD		--done
TBL_VW_OUTGOING					--done
TBL_VW_CRISOL					--done
TBL_VW_SALA						--done
TBL_VW_TALLER					--done
TBL_VW_LABORATORIO				--done
TBL_VW_DIM_PERIODO				--done
TBL_VW_SEXO						--done
TBL_VW_UNIDAD_ACADEMICA			--done
TBL_VW_cna_postgrado_anos		--done
TBL_VW_ranking_qs_global		--done
TBL_VW_INCOMING_V2				--done
*/					

SELECT					
	  a.NodeID
	, a.NodeName
	, a.NodeTypeID
	, b.NodeType
	, c.attributeID
	, c.AttributeName
	, c.AttributeDescription
	, c.AttributeSource
	, d.AttributeValue
FROM [catalog].Node a
LEFT JOIN [catalog].NodeType b ON a.NodeTypeID = b.NodeTypeID
LEFT JOIN [catalog].Attribute c ON a.NodeTypeID = c.NodeTypeID
LEFT JOIN [catalog].NodeAttribute d ON a.NodeID = d.NodeID and c.AttributeID = d.AttributeID
where NodeName = 'TBL_VW_INCOMING_V2'

EXEC [catalog].[insert_attr] 'TBL_VW_INCOMING_V2', N'id', '1719677174'
EXEC [catalog].[insert_attr] 'TBL_VW_INCOMING_V2', N'Nombre', 'TBL_VW_INCOMING_V2'
EXEC [catalog].[insert_attr] 'TBL_VW_INCOMING_V2', N'Esquema_en_bd', 'RAI'
EXEC [catalog].[insert_attr] 'TBL_VW_INCOMING_V2', N'Columnas', '[COD_POSTULACION_EXTRJ,ANO_PROCESO_EXTRJ,MES_INICIO_INTERCAMBIO,CANT_MES_INTERCAMBIO,COD_PERIODO_PROCESO_EXTRJ,COD_TIPO_INTERCAMBIO,NOM_TIPO_INTERCAMBIO,COD_CURR_TIPO_INTER,VIG_TIPO_INTERCAMBIO,COD_DURACION_INTERCAMBIO,COD_INSTITUCION,NOM_INSTITUCION,COD_PAIS,PAIS_INSTITUCION,COD_ESTADO_POSTULACION_EXTRJ,NOM_ESTADO_POSTULACION_EXTRJ,SEXO,COD_PAIS_NACIONALIDAD,PAIS_NACIONALIDAD,NACIONALIDAD,NOM_CARRERA_PROCED,COD_SOLIC_INGR,COD_CASO_ADMIS,COD_CURRICULUM,COD_PERIODO,ANO_ADMIS,COD_ESTADO_POSTULACION,COD_ESTADO_POSTULACION_ANT,NRO_ALUMNO,NOM_VIA_ADMIS,NOM_CASO_ADMIS,NOM_CONVENIO_INTERCAMBIO,COD_ALUMNO,RUT,TOT_ASIGN_INSCRIP,PERIODO_ALUMNO,COD_CURRICULUM_ALUMNO,NOM_CURRICULUM,SIGLA,NOM_ASIGNATURA,NOM_UNIDAD_ACADEM,NOM_FACULTAD]'
EXEC [catalog].[insert_attr] 'TBL_VW_INCOMING_V2', N'Actualización', '2021-03-04 14:28:04.563'
EXEC [catalog].[insert_attr] 'TBL_VW_INCOMING_V2', N'Numero_de_filas', '340756'
