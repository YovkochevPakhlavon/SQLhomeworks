CREATE TABLE student
(
    id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(100) NOT NULL,
    classes INT NOT NULL,
    tuition_per_class DECIMAL(10,2) NOT NULL,
    total_tuition AS (classes * tuition_per_class) PERSISTED --stores the computed value physically. 
);

--Inserting 3 sample rows.
INSERT INTO student (name, classes, tuition_per_class) VALUES
('Alice', 5, 200.00),
('Bob', 3, 150.50),
('Charlie', 4, 180.75);

--Retrieving all data
SELECT * FROM student;