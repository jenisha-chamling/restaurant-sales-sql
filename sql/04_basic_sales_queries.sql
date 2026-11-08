-- Run after database creation and sample-data insertion.
USE RestaurantSalesDB;
GO

-- =====================================================
-- 7. BASIC ITEM-LEVEL SALES ANALYSIS
-- =====================================================

-- Calculate the total sales value of each order item.

SELECT
    OrderID,
    ProductID,
    Quantity,
    UnitPrice,
    Quantity * UnitPrice AS ItemTotal
FROM OrderItems;

-- =====================================================
-- 8. ORDER-LEVEL SALES ANALYSIS
-- =====================================================

-- Calculate the total value of each order
-- using its individual order items.

SELECT
    OrderID,
    SUM(Quantity * UnitPrice) AS OrderTotal
FROM OrderItems
GROUP BY OrderID
ORDER BY OrderID;

-- =====================================================
-- 9. TOTAL COMPLETED SALES ANALYSIS
-- =====================================================

-- Calculate revenue generated from completed orders.
-- Pending and cancelled orders are excluded.

SELECT
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Orders AS o
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed';
