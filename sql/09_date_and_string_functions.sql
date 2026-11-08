-- Run after database creation and sample-data insertion.
USE RestaurantSalesDB;
GO

-- =====================================================
-- 25. ORDER DATE ANALYSIS
-- =====================================================

-- Calculate the number of days elapsed since each order.

SELECT
    OrderID,
    CAST(OrderDate AS DATE) AS OrderDate,
    GETDATE() AS CurrentDateTime,
    DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysSinceOrder
FROM Orders
ORDER BY OrderDate;

-- =====================================================
-- 26. ORDER FOLLOW-UP DATE CALCULATION
-- =====================================================

-- Calculate a follow-up date seven days after each order
-- and a date one month after the original order date.

SELECT
    OrderID,
    CAST(OrderDate AS DATE) AS OrderDate,
    DATEADD(DAY, 7, OrderDate) AS FollowUpDate,
    DATEADD(MONTH, 1, OrderDate) AS OneMonthLater
FROM Orders
ORDER BY OrderDate;

-- =====================================================
-- 27. ORDER AGE CLASSIFICATION
-- =====================================================

-- Categorize orders based on the number of days
-- elapsed since their placement.

SELECT
    OrderID,
    CAST(OrderDate AS DATE) AS OrderDate,
    OrderStatus,
    DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysSinceOrder,
    CASE
        WHEN DATEDIFF(DAY, OrderDate, GETDATE()) <= 7
            THEN 'Recent Order'
        WHEN DATEDIFF(DAY, OrderDate, GETDATE()) <= 30
            THEN 'Within 30 Days'
        ELSE 'Older Order'
    END AS OrderAgeCategory
FROM Orders
ORDER BY OrderDate;

-- =====================================================
-- 28. CUSTOMER INFORMATION FORMATTING
-- =====================================================

-- Demonstrate string functions for customer names
-- and phone number formatting.

SELECT
    CustomerID,
    CustomerName,
    UPPER(CustomerName) AS UppercaseName,
    LEN(CustomerName) AS NameLength,
    LEFT(CustomerName, 3) AS NamePrefix,
    RIGHT(Phone, 4) AS PhoneLastFourDigits
FROM Customers
ORDER BY CustomerID;
