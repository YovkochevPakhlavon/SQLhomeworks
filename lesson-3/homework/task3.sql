--### **Task 3: Product Inventory Check**
-- Selects **distinct** product categories.
-- Finds the **most expensive** product in each category.
SELECT Category, MAX(Price) as most_expensive
FROM Products
GROUP BY Category

-- - Assigns an inventory status using `IIF`:
--   - 'Out of Stock' if `Stock = 0`.  
--   - 'Low Stock' if `Stock` is **between** 1 and 10.  
--   - 'In Stock' otherwise.  
-- - Orders the result by `Price` **descending** and skips the first 5 rows.

SELECT *,
    IIF(Stock = 0, 'Out of Stock',
        IIF(Stock > 1 AND Stock < 10, 'Low Stock','In Stock')
        )
    AS inventory_status
FROM Products
ORDER BY Price DESC
OFFSET 5 ROWS;
