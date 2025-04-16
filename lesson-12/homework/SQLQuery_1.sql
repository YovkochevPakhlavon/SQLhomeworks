-- **Task 2:**

-- Write a stored procedure that retrieves all stored procedure and function names along with 
-- their schema names and parameters (if they exist), including parameter data types and maximum lengths. 
-- The procedure should accept a database name as an optional parameter. If a database name is provided, 
-- it should return the information for that specific database; otherwise, it should retrieve 
-- the information for all databases in the SQL Server instance.

CREATE PROCEDURE sp_allprocedure
    @databasename NVARCHAR(50) = NULL
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 
    'SELECT 
        s.name [SchemaName],
        p.name [FunctionName],
        prm.name [ParameterName],
        TYPE_NAME(prm.user_type_id) AS [ParameterType],
        prm.max_length AS [MaxLength]    
     FROM ';

    IF @databasename IS NULL
    BEGIN
        SET @sql = @sql + 
        ' sys.procedures p 
        JOIN 
        sys.schemas s ON p.schema_id = s.schema_id
        LEFT JOIN 
        sys.parameters prm ON p.object_id = prm.object_id;';
    END
    ELSE
    BEGIN
        SET @sql = @sql + 
        @databasename + '.sys.procedures p 
        JOIN ' 
        + @databasename + 
        '.sys.schemas s ON p.schema_id = s.schema_id
        LEFT JOIN '
        + @databasename + 
        '.sys.parameters prm ON p.object_id = prm.object_id;';        
    END
    
    EXEC sp_executesql @sql, N'@databasename NVARCHAR(50)', @databasename;
    
END;

EXEC sp_allprocedure @databasename = 'class12'
