-- Run after database creation and sample-data insertion.
USE RestaurantSalesDB;
GO

-- =====================================================
-- 29. JSON DATA EXTRACTION
-- =====================================================

-- Extract order information and product details
-- from a JSON document.

DECLARE @OrderJSON NVARCHAR(MAX) = N'
{
    "orderId": 1001,
    "customerName": "Aarav Sharma",
    "orderStatus": "Completed",
    "items": [
        {
            "productName": "Chicken Momo",
            "quantity": 2,
            "unitPrice": 180.00
        },
        {
            "productName": "Americano",
            "quantity": 1,
            "unitPrice": 150.00
        }
    ]
}';

-- Extract individual scalar values.
SELECT
    JSON_VALUE(@OrderJSON, '$.orderId') AS OrderID,
    JSON_VALUE(@OrderJSON, '$.customerName') AS CustomerName,
    JSON_VALUE(@OrderJSON, '$.orderStatus') AS OrderStatus;

-- Extract the complete items array.
SELECT
    JSON_QUERY(@OrderJSON, '$.items') AS OrderItems;

-- Extract product details from the JSON items array.
SELECT
    ProductName,
    Quantity,
    UnitPrice,
    Quantity * UnitPrice AS ItemTotal
FROM OPENJSON(@OrderJSON, '$.items')
WITH (
    ProductName NVARCHAR(100) '$.productName',
    Quantity INT '$.quantity',
    UnitPrice DECIMAL(10,2) '$.unitPrice'
);
