-- ==============================================================
--                          Puzzle 3 DDL
-- ==============================================================

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

--## **Puzzle 3: The Unbreakable View**  
-- You are given a database that tracks **employee working hours**. The company needs a **monthly summary report** that calculates:  
-- - **Total hours worked per employee**  
-- - **Total hours worked per department**  
-- - **Average hours worked per department**  

-- ### **Task:**  
-- 1. Create a **view** `vw_MonthlyWorkSummary` that calculates:  
--    - `EmployeeID`, `EmployeeName`, `Department`, **TotalHoursWorked** (SUM of hours per employee).  
--    - `Department`, **TotalHoursDepartment** (SUM of all hours per department).  
--    - `Department`, **AvgHoursDepartment** (AVG hours worked per department).  

CREATE VIEW vw_MonthlyWorkSummary AS 
SELECT
    EmployeeID,
    EmployeeName,
    Department,
    YEAR(WorkDate) AS WorkYear,
    MONTH(WorkDate) AS WorkMonth,
    SUM(HoursWorked) AS TotalHoursWorked,
    SUM(SUM(HoursWorked)) OVER(PARTITION BY Department, YEAR(WorkDate), MONTH(WorkDate)) AS TotalHoursDepartment,
    AVG(SUM(HoursWorked)) OVER(PARTITION BY Department, YEAR(WorkDate), MONTH(WorkDate)) AS AvgHoursDepartment
FROM WorkLog
GROUP BY
    EmployeeID, EmployeeName, Department, YEAR(WorkDate), MONTH(WorkDate);

--2. Retrieve all records from `vw_MonthlyWorkSummary`. 
SELECT * FROM vw_MonthlyWorkSummary
ORDER BY Department, WorkYear, WorkMonth, EmployeeID;