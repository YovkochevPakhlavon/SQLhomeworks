-- ==============================================================
--                          Puzzle 2 DDL
-- ==============================================================

CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);


--## **Puzzle 2: The Missing Orders**  
--An e-commerce company tracks orders in two separate systems, but some orders are **missing** in one of them. You need to find the missing records. 
--### **Task:**  
--1. Declare a **table variable** `@MissingOrders` with the same structure as `Orders_DB1`. 
DECLARE  @MissingOrders TABLE (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

--2. Insert **all orders that exist in `Orders_DB1` but not in `Orders_DB2`** into `@MissingOrders`.  
INSERT INTO @MissingOrders
SELECT o1.OrderID,o1.CustomerName,o1.Product,o1.Quantity
FROM Orders_DB1 o1
LEFT JOIN Orders_DB2 o2
    on o1.OrderID = o2. OrderID
WHERE o2.OrderID is NULL;

--3. Retrieve the missing orders.
SELECT * FROM @MissingOrders;