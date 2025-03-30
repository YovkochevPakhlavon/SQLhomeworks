WITH FilteredOrders AS(
-- Selects customers who placed orders **between** '2023-01-01' and '2023-12-31'.
SELECT * 
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'),

-- Includes a new column `OrderStatus` that returns:
--   - 'Completed' for **Shipped** or **Delivered** orders.  
--   - 'Pending' for **Pending** orders.  
--   - 'Cancelled' for **Cancelled** orders. 
FilteredStatus AS (
SELECT *,
    CASE
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus
FROM FilteredOrders),

-- Groups by `OrderStatus` and finds the **total number of orders** and **total revenue**. 
RevenueByStatus AS (
    SELECT OrderStatus, COUNT(*) AS number_of_orders, SUM(TotalAmount) AS total_revenue
    FROM FilteredStatus
    GROUP BY OrderStatus
)

-- Filters only statuses where revenue is greater than 5000.  
-- Orders by `TotalRevenue` **descending**.
SELECT *
FROM RevenueByStatus
WHERE total_revenue > 5000
ORDER BY total_revenue DESC;