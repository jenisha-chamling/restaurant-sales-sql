-- Run after database creation and sample-data insertion.
USE RestaurantSalesDB;
GO

-- =====================================================
-- 30. CUSTOMER ORDER STORED PROCEDURE
-- =====================================================

-- Retrieve completed orders for a specified customer.

GO

CREATE OR ALTER PROCEDURE GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        o.OrderID,
        c.CustomerName,
        o.OrderDate,
        o.OrderStatus,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderTotal
    FROM Customers AS c
    INNER JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    INNER JOIN OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE
        c.CustomerID = @CustomerID
        AND o.OrderStatus = 'Completed'
    GROUP BY
        o.OrderID,
        c.CustomerName,
        o.OrderDate,
        o.OrderStatus
    ORDER BY o.OrderDate;
END;
GO

-- Execute the stored procedure for customer 1.
EXEC GetCustomerOrders @CustomerID = 1;
GO

-- =====================================================
-- 31. CUSTOMER SALES USING OUTPUT PARAMETER
-- =====================================================

-- Calculate completed sales for a customer
-- and return the result through an output parameter.

CREATE OR ALTER PROCEDURE GetCustomerTotalSales
    @CustomerID INT,
    @TotalSales DECIMAL(12,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        @TotalSales = COALESCE(
            SUM(oi.Quantity * oi.UnitPrice), 0
        )
    FROM Orders AS o
    INNER JOIN OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE
        o.CustomerID = @CustomerID
        AND o.OrderStatus = 'Completed';
END;
GO

-- Execute the procedure and retrieve the output value.
DECLARE @Sales DECIMAL(12,2);

EXEC GetCustomerTotalSales
    @CustomerID = 1,
    @TotalSales = @Sales OUTPUT;

SELECT @Sales AS CustomerTotalSales;
GO

-- =====================================================
-- 32. SQL SERVER ERROR HANDLING
-- =====================================================

-- Demonstrate error handling using TRY...CATCH
-- with an invalid table reference executed dynamically.

BEGIN TRY

    EXEC sp_executesql
        N'SELECT * FROM NonExistingTable;';

END TRY

BEGIN CATCH

    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;

END CATCH;
GO
