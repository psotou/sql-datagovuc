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
where NodeName = 'TBL_VW_UNIDAD_ACADEMICA' --'TBL_VW_PLANTA_ACADEMICA'

-- Todos los que dicen bd
-- la función. Recibe el nombre del y el esquema

/*** PARA ACTUALIZAR UN ATRIBUTO
EXEC [catalog].[insert_attr] N'TBL_VW_PLANTA_ACADEMICA', N'Acceso', 'Usuario 1'
***/
/*** PARA CORROBORAR que atributos faltan por llenar
SELECT 
	 a.NodeID
	,a.NodeName
	,a.NodeTypeID
	,b.NodeType
	,c.attributeID
	,c.AttributeName
	,c.AttributeDescription
	,c.AttributeSource
	,d.AttributeValue
FROM catalog.Node a
LEFT JOIN catalog.NodeType b ON a.NodeTypeID = b.NodeTypeID
LEFT JOIN catalog.Attribute c ON a.NodeTypeID = c.NodeTypeID
LEFT JOIN catalog.NodeAttribute d ON a.NodeID = d.NodeID and c.AttributeID = d.AttributeID
where NodeName = 'TBL_VW_PLANTA_ACADEMICA'
***/
/*** PARA REVISAR QUE NODOS EXISTEN
SELECT * FROM catalog.Node
***/

-- Nombre --> sys.objects

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'catalog'
select * from [catalog].NodeAttribute
select * from [catalog].Attribute where NodeTypeID in (4,10)
select * from [catalog].NodeType where NodeTypeID in (4,10)
select * from [catalog].Node where NodeTypeID = 10

update [catalog].Node
set NodeDescription = 'vista para responder a la segunda mitad de indicadores de admisión'
WHERE NodeID = 175

insert into [catalog].Node(NodeTypeID)
values ('TBL_VW_FT_ADMISION_PAS', '10')
--175	TBL_VW_FT_ADMISION_PAS	10

insert into [catalog].NodeAttribute(NodeID, AttributeID)
values (175, 26)
	, (175, 27)
	, (175, 28)
	, (175, 29)
	, (175, 30)
	, (175, 31)
	, (175, 32)
	, (175, 33)
	, (175, 34)
	, (175, 35)
	, (175, 36)
	, (175, 37)
	, (175, 38)
	, (175, 39)

select * from UTILS.ColumnType('catalog', 'NodeAttribute')

SELECT 
	  cnt.NodeType
	, ca.*
from  [catalog].Attribute    as ca 
left join [catalog].NodeType as cnt
	on cnt.NodeTypeID = ca.NodeTypeID
where cnt.NodeType = 'VISTA'


/* CAMPOS AUTOMAIZABLES PARA UNA VISTA */

-- Nombre (object_id name)
-- Esquema_en_bd
-- Columnas (array con nombre de columnas)
-- Numero_de_filas
-- Actualización

----
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [catalog].[test_insert]
	(
		  @ObjectName nvarchar(100) --Nombre de tabla o vista
		, @SchemaName nvarchar(100) --Nombre de esquema del objecto
        , @NodeType nvarchar(50)    --Tipo del objeto: V para vista y U para user table
	)

as

select
      so.object_id
    , OBJECT_NAME(so.object_id) as [object_name]
    , SCHEMA_NAME(so.schema_id) as [schema_name]
    , CONCAT('[', STRING_AGG(sc.name, ','), ']')  as columns_set
    , so.modify_date
into #cat
from sys.objects as so
left join sys.columns as sc
    on so.object_id = sc.object_id
    -- and so.[type] = 'V'
where OBJECT_NAME(so.object_id) = @ObjectName
and SCHEMA_NAME(so.schema_id) = @SchemaName
GROUP by 
      so.object_id
    , so.schema_id
    , so.modify_date


declare @RowCount int;
declare @name nvarchar(100);
declare @schema nvarchar(100);
declare @columns nvarchar(100);
declare @modifyDate nvarchar(100);

set @RowCount = (select count(1) from [@SchemaName].[@ObjectName])
set @RowCount = CAST(@RowCount as nvarchar)
set @name = (select [object_name] from #cat)
set @schema = (select [schema_name] from #cat)
set @columns = (select [columns_set] from #cat)
set @modifyDate = (select [modify_date] from #cat)

EXEC [catalog].[insert_attr] @ObjectName, N'Nombre', @name;
EXEC [catalog].[insert_attr] @ObjectName, N'Esquema_en_bd', @schema;
EXEC [catalog].[insert_attr] @ObjectName, N'Columnas', @columns;
EXEC [catalog].[insert_attr] @ObjectName, N'Numero_de_filas', @RowCount;
EXEC [catalog].[insert_attr] @ObjectName, N'Actualización', @modifyDate;

GO

-----

select * from INFORMATION_SCHEMA.views