;WITH zeros AS (
    SELECT 1 AS N
    UNION ALL
    SELECT N + 1 FROM zeros WHERE N < 40
), 
days_with_zeros AS (
    SELECT z.N, ISNULL(s.Num, 0) AS Num
    FROM zeros z
    LEFT JOIN Shipments s ON z.N = s.N
), 
ordered AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY Num) AS rnk
    FROM days_with_zeros
)
SELECT 
    ((SELECT Num FROM ordered WHERE rnk = 20)  + 
    (SELECT Num FROM ordered WHERE rnk = 21)) / 2.0 AS Median
OPTION (MAXRECURSION 40);




