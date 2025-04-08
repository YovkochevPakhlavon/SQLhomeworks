--1. Write an SQL statement that counts the consecutive values in the Status field.
SELECT
    MIN(StepNumber) AS MinStepNumber,
    MAX(StepNumber) AS MaxStepNumber,
    Status,
    Count(*) ConsecutiveCount
FROM
(SELECT *,
           ROW_NUMBER() OVER (ORDER BY [StepNumber]) 
           - ROW_NUMBER() OVER (PARTITION BY Status ORDER BY [StepNumber]) AS grp
FROM Groupings) t
GROUP BY Status, grp

--2. Find all the year-based intervals from 1975 up to current when the company did not hire employees

SELECT 
    t1.HireYear+1 AS StartNoHireYear,
    coalesce(t2.HireYear-1,YEAR(GETDATE())) AS FinishNoHireYear
FROM
(SELECT DISTINCT YEAR(Hire_Date) as HireYear,
    DENSE_RANK() OVER(ORDER BY YEAR(Hire_Date)) as rk
FROM EMPLOYEES_N) t1
LEFT JOIN (SELECT DISTINCT YEAR(Hire_Date) as HireYear,
    DENSE_RANK() OVER(ORDER BY YEAR(Hire_Date)) as rk
    FROM EMPLOYEES_N) t2
        on t1.rk + 1= t2.rk 
WHERE ABS(t1.HireYear - isnull(t2.HireYear,0)) != 1
