-- Run this script after selecting RestaurantSalesDB.
USE RestaurantSalesDB;
GO

-- =====================================================
-- 2. TABLE CREATION
-- =====================================================

-- Store customer information.
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    City NVARCHAR(60),
    CreatedAt DATETIME2 DEFAULT SYSDATETIME()
);

-- Store product and pricing information.
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    UnitPrice DECIMAL(10,2) NOT NULL,
    IsActive BIT DEFAULT 1,

    CONSTRAINT CK_Products_UnitPrice
        CHECK (UnitPrice > 0)
);

-- Store customer orders and their current status.
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME2 DEFAULT SYSDATETIME(),
    OrderStatus VARCHAR(20) DEFAULT 'Completed',

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT CK_Orders_Status
        CHECK (OrderStatus IN ('Pending', 'Completed', 'Cancelled'))
);

-- Store the individual products included in each order.
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID),

    CONSTRAINT CK_OrderItems_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT CK_OrderItems_UnitPrice
        CHECK (UnitPrice > 0)
);

-- Verify the database and its tables.
SELECT
    DB_NAME() AS CurrentDatabase,
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
