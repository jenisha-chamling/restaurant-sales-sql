-- Run after creating all four tables.
USE RestaurantSalesDB;
GO

-- =====================================================
-- 3. INSERT SAMPLE CUSTOMER DATA
-- =====================================================

INSERT INTO Customers (CustomerName, Phone, City)
VALUES
('Aarav Sharma', '9801000001', 'Kathmandu'),
('Sita Thapa', '9801000002', 'Lalitpur'),
('Rohan KC', '9801000003', 'Bhaktapur'),
('Nisha Rai', '9801000004', 'Kathmandu'),
('Anisha Gurung', '9801000005', 'Lalitpur'),
('Bibek Shrestha', '9801000006', 'Pokhara'),
('Pooja Lama', '9801000007', 'Kathmandu'),
('Suman Adhikari', '9801000008', 'Bhaktapur');

-- =====================================================
-- 4. INSERT SAMPLE PRODUCT DATA
-- =====================================================

INSERT INTO Products (ProductName, Category, UnitPrice)
VALUES
('Chicken Momo', 'Momo', 180.00),
('Buff Momo', 'Momo', 160.00),
('Veg Momo', 'Momo', 130.00),
('Chicken Chowmein', 'Noodles', 200.00),
('Veg Chowmein', 'Noodles', 160.00),
('Chicken Burger', 'Burger', 250.00),
('Veg Burger', 'Burger', 180.00),
('Americano', 'Beverages', 150.00),
('Cappuccino', 'Beverages', 180.00),
('Chocolate Brownie', 'Dessert', 140.00);

-- Review customer and product records.
SELECT * FROM Customers;
SELECT * FROM Products;

-- =====================================================
-- 5. INSERT SAMPLE ORDER DATA
-- =====================================================

INSERT INTO Orders (CustomerID, OrderDate, OrderStatus)
VALUES
(1, '2026-09-01', 'Completed'),
(2, '2026-09-03', 'Completed'),
(3, '2026-09-05', 'Completed'),
(1, '2026-10-02', 'Completed'),
(4, '2026-10-05', 'Completed'),
(5, '2026-10-08', 'Completed'),
(6, '2026-10-12', 'Pending'),
(7, '2026-10-15', 'Cancelled'),
(8, '2026-11-01', 'Completed'),
(2, '2026-11-03', 'Completed');

SELECT *
FROM Orders
ORDER BY OrderID;

-- =====================================================
-- 6. INSERT SAMPLE ORDER ITEM DATA
-- =====================================================

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 2, 180.00),
(1, 8, 2, 150.00),
(2, 2, 3, 160.00),
(2, 9, 1, 180.00),
(3, 4, 2, 200.00),
(3, 3, 1, 130.00),
(4, 6, 2, 250.00),
(4, 8, 1, 150.00),
(5, 1, 3, 180.00),
(5, 10, 2, 140.00),
(6, 5, 2, 160.00),
(6, 9, 2, 180.00),
(7, 4, 1, 200.00),
(8, 7, 2, 180.00),
(9, 1, 2, 180.00),
(9, 10, 1, 140.00),
(10, 6, 1, 250.00),
(10, 8, 2, 150.00);

SELECT *
FROM OrderItems
ORDER BY OrderItemID;
