CREATE TABLE worker
(
    id INT PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
);

BULK INSERT worker
FROM '/var/opt/mssql/data/worker_data..csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 1
);

SELECT * FROM worker;
