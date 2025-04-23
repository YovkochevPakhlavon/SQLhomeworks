-- Query to retrieve index metadata
DECLARE @IndexMetadata TABLE (
    TableName NVARCHAR(256),
    IndexName NVARCHAR(256),
    IndexType NVARCHAR(60),
    ColumnName NVARCHAR(256),
    ColumnType NVARCHAR(60)
);

INSERT INTO @IndexMetadata
SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    c.name AS ColumnName,
    ty.name AS ColumnType
FROM 
    sys.indexes i
INNER JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
INNER JOIN 
    sys.tables t ON i.object_id = t.object_id
INNER JOIN 
    sys.types ty ON c.user_type_id = ty.user_type_id
WHERE 
    i.is_hypothetical = 0
ORDER BY 
    t.name, i.name, ic.key_ordinal;

-- Variables to hold the HTML email body
DECLARE @tableHTML NVARCHAR(MAX);

-- Build HTML table from query
SET @tableHTML = 
    N'<style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #dddddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
     </style>
     <h3>Index Metadata Report</h3>
     <table>
     <tr>
        <th>Table Name</th>
        <th>Index Name</th>
        <th>Index Type</th>
        <th>Column Name</th>
        <th>Column Type</th>
     </tr>' + 
    CAST((
        SELECT 
            td = TableName, '', 
            td = IndexName, '', 
            td = IndexType, '', 
            td = ColumnName, '', 
            td = ColumnType
        FROM @IndexMetadata
        FOR XML PATH('tr'), TYPE
    ).value('.', 'NVARCHAR(MAX)') AS NVARCHAR(MAX)) + 
    N'</table>';

-- Send the email using Database Mail
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'MacBook',
    @recipients = 'recipient@example.com',
    @subject = 'SQL Server Index Metadata Report',
    @body = @tableHTML,
    @body_format = 'HTML';