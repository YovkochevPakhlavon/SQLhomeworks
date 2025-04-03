CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
);

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary INT
)

CREATE TABLE Projects
(
    ProjectID INT PRIMARY KEY IDENTITY,
    ProjectName VARCHAR(50) NOT NULL,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID)
)

INSERT INTO Departments
VALUES
    (101, 'IT'),
    (102, 'HR'),
    (103, 'Finance'),
    (104, 'Marketing');

INSERT INTO Employees(Name,DepartmentID,Salary)
VALUES
    ('Alice',101,60000),
    ('Bob',102,70000),
    ('Charlie',101,65000),
    ('David',103,72000),
    ('Eva',NULL,68000)

INSERT INTO Projects(ProjectName,EmployeeID)
VALUES
    ('Alpha',1),
    ('Beta',2),
    ('Gamma',1),
    ('Delta',4),
    ('Omega',NULL)

-- 1. **INNER JOIN**  
--    - Write a query to get a list of employees along with their department names.

SELECT e.Name , d.DepartmentName
FROM Employees as e
INNER JOIN Departments as d
    on e.DepartmentID = d.DepartmentID

--2. **LEFT JOIN**  
--   - Write a query to list all employees, including those who are not assigned to any department.

SELECT e.Name , d.DepartmentName
FROM Employees as e
LEFT JOIN Departments as d
    on e.DepartmentID = d.DepartmentID

--3. **RIGHT JOIN**  
--   - Write a query to list all departments, including those without employees. 

SELECT d.DepartmentName , e.Name 
FROM Employees as e
RIGHT JOIN Departments as d
    on e.DepartmentID = d.DepartmentID

--4. **FULL OUTER JOIN**  
--   - Write a query to retrieve all employees and all departments, even if there’s no match between them.  
SELECT d.DepartmentName , e.Name 
FROM Employees as e
FULL OUTER JOIN Departments as d
    on d.DepartmentID = e.DepartmentID

--5. **JOIN with Aggregation**  
--   - Write a query to find the total salary expense for each department.  
SELECT Distinct DepartmentName,
    SUM(Salary) OVER(partition by DepartmentName) as total_salary
FROM 
(SELECT d.DepartmentName , e.Salary
        FROM Employees as e
        RIGHT JOIN Departments as d
              on e.DepartmentID = d.DepartmentID) as t;

--6. **CROSS JOIN**  
--  - Write a query to generate all possible combinations of departments and projects.  
SELECT *
FROM Departments
CROSS JOIN Projects;

--7. **MULTIPLE JOINS**  
--  - Write a query to get a list of employees with their department names and assigned project names. Include employees even if they don’t have a project.  
SELECT 
    t.EmployeeID, t.Name, t.DepartmentName, p.ProjectName
FROM (
    SELECT e.EmployeeID,e.Name, d.DepartmentName
    FROM Employees as e
    LEFT JOIN Departments as d
        on e.DepartmentID = d.DepartmentID
) as t
LEFT JOIN Projects as p
    on t.EmployeeID = p.EmployeeID;