CREATE OR ALTER PROCEDURE [MDIUC].[INSERT_MDM_TABLES] 
    @Entity NVARCHAR(50)            -- Nombre entidad creada para almacenar el golden record
    @OriginSchemaOne NVARCHAR(80)   -- Nombre del esquema de la tabla de origen 1
    @OriginTableOne NVARCHAR(100)   -- Nombre de la tabla de origen 1
    @OriginTableOnePK NVARCHAR(100) -- Nombre de la columna que es PK en la tabla de origen 1
    @OriginSchemaTwo NVARCHAR(80)   -- Nombre del esquema de la tabla de origen 2
    @OriginTableTwo NVARCHAR(100)   -- Nombre de la tabla de origen 2
    @OriginTableTwoPK NVARCHAR(100) -- Nombre de la columna que es PK en la tabla de origen 2
AS
    DECLARE @EntityId INT;
    DECLARE @EntitySystemTableId INT;

    SET @EntityId = (SELECT entity_id FROM MCP_MDIUC.ENTITY WHERE [name] = @Entity)
    SET @EntitySystemTableId = (SELECT entity_system_table_id FROM MCP_MDIUC.ENTITY_SYSTEM_TABLE WHERE entity_id = @EntityId)



    -- ENTITY
    -- we set is_valid to 1 whenever we insert a new entity
    INSERT INTO MCP_MDIUC.ENTITY ([name], is_valid, has_official_source)
    VALUES (@Entity, 1, 0)

    -- ENTITY_ATTRIBUTE
    INSERT INTO MCP_MDIUC.ENTITY_ATTRIBUTE (
          entity_id
        , attribute_name
        , attribute_type
        )
    SELECT
          @EntityId
        , column_name
        , raw_type
    FROM UTILS.ColumnType('MDIUC', @Entity)

    -- ENTITY_SYSTEM_TABLE
    INSERT INTO MCP_MDIUC.ENTITY_SYSTEM_TABLE(entity_id, [schema_name], table_name, primary_key)
    VALUES
          (@EntityId, @OriginSchemaOne, @OriginTableOne, @OriginTableOnePK)
        , (@EntityId, @OriginSchemaTwo, @OriginTableTwo, @OriginTableTwoPK)

GO

select top 4 * from NORMALIZADO_BANNER.ACADEMIC_UNIT
select * from GOBDI.UNIDAD_ACADEMICA where COD_UNIDAD_ACADEM = 18
select * from UC_BANNER.UNIDAD_ACADEM where COD_UNIDAD_ACADEM = 17
select * from UC_BANNER.UNIDAD_ACADEM order by COD_UNIDAD_ACADEM


select * from MCP_MDIUC.ENTITY
select * from MCP_MDIUC.ENTITY_ATTRIBUTE
select * from MCP_MDIUC.ENTITY_SYSTEM_TABLE
select * from MCP_MDIUC.ENTITY_ATTRIBUTE_SYSTEM_MAPPING
select * from MCP_MDIUC.GROUPING_RULE
select * from MCP_MDIUC.COMPARING_RULE

