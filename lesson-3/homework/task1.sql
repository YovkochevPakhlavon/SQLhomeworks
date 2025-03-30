-- Selects the **top 10% highest-paid** employees.
SELECT TOP 10 PERCENT * 
FROM Employees
ORDER BY Salary DESC;

-- Groups them by **department** and calculates the **average salary:
SELECT Department, AVG(Salary) AS Average_Salary
FROM Employees
GROUP BY Department;

--  Displays a new column `SalaryCategory`:
--   - 'High' if Salary > 80,000  
--   - 'Medium' if Salary is **between** 50,000 and 80,000  
--   - 'Low' otherwise.  

SELECT Salary,
    CASE 
        WHEN Salary > 80000 THEN 'High'
        WHEN 80000 > Salary AND Salary > 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees

-- Orders the result by `AverageSalary` **descending** and Skips the first 2 records and fetches the next 5.
SELECT Department, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;




