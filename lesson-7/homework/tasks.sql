CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

-- #### **1️ Retrieve All Customers With Their Orders (Include Customers Without Orders)**
-- - Use an appropriate `JOIN` to list all customers, their order IDs, and order dates.
-- - Ensure that customers with no orders still appear.

SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers as c
LEFT JOIN Orders as o
    on c.CustomerID = o.CustomerID

--#### **2️ Find Customers Who Have Never Placed an Order**
--- Return customers who have no orders.

SELECT c.CustomerName
FROM Customers as c
LEFT JOIN Orders as o
    on c.CustomerID = o.CustomerID
WHERE o.OrderID is NULL

-- #### **3️ List All Orders With Their Products**
-- - Show each order with its product names and quantity.
SELECT o.OrderID,p.ProductName, o.Quantity
FROM OrderDetails o
LEFT JOIN Products p
    on o.ProductID = p.ProductID

-- #### **4️ Find Customers With More Than One Order**
-- - List customers who have placed more than one order.

SELECT c.CustomerName, COUNT(OrderID) as number_orders
FROM Customers c
RIGHT JOIN Orders o -- We need only customers who have orders.
    on c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(OrderID) > 1

--#### **5️ Find the Most Expensive Product in Each Order**

SELECT OrderID, ProductName, Price
FROM (
    SELECT 
        p.ProductName,
        od.OrderID,
        od.Price,
        RANK() OVER (PARTITION BY od.OrderID ORDER BY od.Price DESC) AS price_rank
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
) ranked
WHERE price_rank = 1;

--#### **6️ Find the Latest Order for Each Customer**
SELECT CustomerName, OrderDate
FROM(
    SELECT c.CustomerName,o.OrderDate,
        RANK() OVER(Partition by c.CustomerName ORDER BY o.OrderDate DESC) as rnk
    FROM Customers c
    RIGHT JOIN Orders o
        on c.CustomerID = o.CustomerID) ranked
WHERE rnk = 1

--#### **7️ Find Customers Who Ordered Only 'Electronics' Products**
-- List customers who **only** purchased items from the 'Electronics' category.

SELECT c.CustomerName
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.CustomerID = c.CustomerID
) AND
NOT EXISTS (
    SELECT 1
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.CustomerID = c.CustomerID
      AND p.Category <> 'Electronics'
);

--#### **8️ Find Customers Who Ordered at Least One 'Stationery' Product**
--- List customers who have purchased at least one product from the 'Stationery' category.

SELECT DISTINCT c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Stationery';

-- #### **9️ Find Total Amount Spent by Each Customer**
-- - Show `CustomerID`, `CustomerName`, and `TotalSpent`.
SELECT c.CustomerID, c.CustomerName,
    SUM(od.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;


