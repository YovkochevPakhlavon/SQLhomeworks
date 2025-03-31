--### Tasks
-- #### Ranking Functions
-- 1. Assign a Unique Rank to Each Employee Based on Salary
SELECT *,
    ROW_NUMBER() OVER(ORDER BY Salary) AS unrk
FROM Employees;

--2. Find Employees Who Have the Same Salary Rank
WITH new_table AS(
     SELECT *,
     DENSE_RANK() OVER(ORDER BY Salary) AS rk 
     FROM Employees)
SELECT *
FROM new_table
WHERE rk IN (
    SELECT rk FROM new_table
    GROUP BY rk
    HAVING COUNT(*) > 1
);

--3. Identify the Top 2 Highest Salaries in Each Department
SELECT *
FROM (SELECT *,
    DENSE_RANK() OVER(partition by Department ORDER BY Salary DESC) AS rnk
    FROM Employees) RankedTable
WHERE rnk = 1 or rnk=2;

--4. Find the Lowest-Paid Employee in Each Department
WITH RankedTable AS(
    SELECT *,
    DENSE_RANK() OVER(partition by Department ORDER BY Salary) AS rnk
    FROM Employees  
)
SELECT *
FROM RankedTable
WHERE rnk = 1;

--5. Calculate the Running Total of Salaries in Each Department
SELECT *, SUM(Salary) OVER(ORDER BY EmployeeID) AS total
FROM Employees;

--6. Find the Total Salary of Each Department Without GROUP BY
SELECT *,
    SUM(Salary) OVER(partition by Department) AS total
FROM Employees;

--7. Calculate the Average Salary in Each Department Without GROUP BY
SELECT *,
    AVG(Salary) OVER(partition by Department) AS average_salary
FROM Employees;

--8. Find the Difference Between an Employee’s Salary and Their Department’s Average
SELECT *,
    (Salary - average_salary) AS diff
FROM (
    SELECT *,
    AVG(Salary) OVER(partition by Department) AS average_salary
    FROM Employees
) Averaged_table

--9. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
SELECT *,
    AVG(Salary) OVER(ORDER BY EmployeeID rows between 1 preceding and 1 following) AS average_salary
FROM Employees;

--10. Find the Sum of Salaries for the Last 3 Hired Employees
SELECT *,
    SUM(Salary) OVER() AS totalofthree
FROM(
SELECT *,
    ROW_NUMBER() OVER(ORDER BY HireDate DESC) AS rnk
FROM Employees) RankedTable
WHERE rnk <= 3;

--11. Calculate the Running Average of Salaries Over All Previous Employees
SELECT *,
    AVG(Salary) OVER(ORDER BY HireDate ROWS BETWEEN unbounded preceding and CURRENT row)
FROM Employees;

--12. Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After
SELECT *,
    MAX(Salary) OVER(ORDER BY HireDate ROWS BETWEEN 2 preceding and 2 following)
FROM Employees;

--13. Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary
SELECT *,
    CAST(100 * (Salary)/ (SUM(Salary) OVER(partition by Department)) AS decimal(10,2)) AS percentage_cont
FROM Employees;
