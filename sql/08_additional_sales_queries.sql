-- Run after database creation and sample-data insertion.
USE RestaurantSalesDB;
GO

-- =====================================================
-- 22. MONTHLY SALES ANALYSIS
-- =====================================================

-- Calculate completed sales revenue and order counts
-- for each month.

SELECT
    YEAR(o.OrderDate) AS SalesYear,
    MONTH(o.OrderDate) AS SalesMonth,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS MonthlyRevenue
FROM Orders AS o
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)
ORDER BY
    SalesYear,
    SalesMonth;

-- =====================================================
-- 23. CUSTOMERS WITHOUT COMPLETED ORDERS
-- =====================================================

-- Identify customers who have no completed orders.

SELECT
    c.CustomerID,
    c.CustomerName,
    c.City
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
    AND o.OrderStatus = 'Completed'
WHERE o.OrderID IS NULL
ORDER BY c.CustomerID;

-- =====================================================
-- 24. PRODUCTS WITHOUT COMPLETED SALES
-- =====================================================

-- Identify products that have not generated revenue
-- from any completed order.

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    p.UnitPrice
FROM Products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM OrderItems AS oi
    INNER JOIN Orders AS o
        ON oi.OrderID = o.OrderID
    WHERE
        oi.ProductID = p.ProductID
        AND o.OrderStatus = 'Completed'
)
ORDER BY p.ProductID;
