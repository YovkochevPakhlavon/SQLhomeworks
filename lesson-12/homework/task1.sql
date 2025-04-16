-- **Task 1:**

-- Write an SQL query to retrieve the database name, schema name, table name, column name, and column data type for 
--all tables across all databases in a SQL Server instance. Ensure that system databases (`master`, `tempdb`, `model`, `msdb`) are excluded from the results.

declare @name varchar(255);
declare @i int = 1;
declare @count int;
select @count = count(name)
from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')

while @i <= @count
begin
    ;with cte as (
		select name, ROW_NUMBER() OVER(order BY name) as rn
		from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
	)
	select @name=name from cte
	where rn = @i;

    DECLARE @sql NVARCHAR(MAX);

    SET @sql = 'SELECT 
        	TABLE_CATALOG as DatabaseName,
            TABLE_SCHEMA as SchemaName,
            TABLE_NAME as TableName,
            COLUMN_NAME as ColumnName,
            DATA_TYPE as DataType
            FROM ' 
    + @name + '.INFORMATION_SCHEMA.COLUMNS';
    EXEC(@sql);

	set @i = @i + 1;

end


