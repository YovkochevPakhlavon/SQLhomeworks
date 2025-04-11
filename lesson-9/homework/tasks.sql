CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);

-- Find the level of depth each employee from the President. 
;WITH cte AS (
    SELECT *, 0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.ManagerID, e.JobTitle, cte.Depth + 1
    FROM Employees e
    INNER JOIN cte 
        on cte.EmployeeID = e.ManagerID
)
SELECT * 
FROM cte
ORDER BY EmployeeID;

-- ### Task 2
-- Find Factorials up to $N$.
-- Expected output for $N = 10$:
DECLARE @N int = 10;
;WITH FactorialCTE AS (
    SELECT 1 as Num, 1 AS Factorial
    UNION ALL
    SELECT Num+1, (Num+1) * Factorial FROM FactorialCTE
    WHERE Num + 1 <= @N
)
SELECT * FROM FactorialCTE
ORDER BY Num;


--### Task 3
--Find Fibonacci numbers up to $N$.
DECLARE @N int = 10;
;WITH cte (n, fib1, fib2) AS (
    SELECT 1 , 1, 1
    UNION ALL
    SELECT n+1, fib2, fib1 + fib2 FROM cte
    WHERE n + 1 <= @N
)
SELECT n, fib1 AS Fibonacci_Number
FROM cte
OPTION (MAXRECURSION 0);


