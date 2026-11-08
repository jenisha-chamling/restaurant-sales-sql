-- Run after database creation and sample-data insertion.
USE RestaurantSalesDB;
GO

-- =====================================================
-- 18. CUSTOMER SALES RANKING
-- =====================================================

-- Rank customers based on completed sales revenue.

SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,
    RANK() OVER (
        ORDER BY SUM(oi.Quantity * oi.UnitPrice) DESC
    ) AS SalesRank
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY SalesRank;

-- =====================================================
-- 19. COMPARING WINDOW RANKING FUNCTIONS
-- =====================================================

-- Compare ROW_NUMBER, RANK, and DENSE_RANK
-- when ranking customers by completed sales.

SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales,

    ROW_NUMBER() OVER (
    ORDER BY
        SUM(oi.Quantity * oi.UnitPrice) DESC,
        c.CustomerID
    ) AS RowNumber,

    RANK() OVER (
        ORDER BY SUM(oi.Quantity * oi.UnitPrice) DESC
    ) AS SalesRank,

    DENSE_RANK() OVER (
        ORDER BY SUM(oi.Quantity * oi.UnitPrice) DESC
    ) AS DenseRank

FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY TotalSales DESC;

-- =====================================================
-- 20. PRODUCT RANKING WITHIN EACH CATEGORY
-- =====================================================

-- Rank products by completed sales revenue within
-- their respective product categories.

SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue,
    RANK() OVER (
        PARTITION BY p.Category
        ORDER BY SUM(oi.Quantity * oi.UnitPrice) DESC
    ) AS CategoryRank
FROM Products AS p
INNER JOIN OrderItems AS oi
    ON p.ProductID = oi.ProductID
INNER JOIN Orders AS o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY
    p.Category,
    CategoryRank;

-- =====================================================
-- 21. RUNNING TOTAL OF COMPLETED SALES
-- =====================================================

-- Calculate cumulative completed sales revenue over time.

WITH DailySales AS (
    SELECT
        CAST(o.OrderDate AS DATE) AS OrderDate,
        SUM(oi.Quantity * oi.UnitPrice) AS DailyRevenue
    FROM Orders AS o
    INNER JOIN OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus = 'Completed'
    GROUP BY CAST(o.OrderDate AS DATE)
)
SELECT
    OrderDate,
    DailyRevenue,
    SUM(DailyRevenue) OVER (
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM DailySales
ORDER BY OrderDate;
