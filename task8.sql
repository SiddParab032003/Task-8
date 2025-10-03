create database task8
use task8

CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    product VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers (customer_name, city) VALUES
('Amit', 'Pune'),
('Sita', 'Mumbai'),
('Rahul', 'Delhi'),
('Priya', 'Bangalore');

INSERT INTO Orders (customer_id, product, amount) VALUES
(1, 'Laptop', 75000),
(1, 'Mouse', 1200),
(2, 'Mobile', 25000),
(3, 'Tablet', 15000),
(4, 'Keyboard', 2000);

CREATE PROCEDURE GetCustomerOrders
    @cust_id INT
AS
BEGIN
    SELECT o.order_id, o.product, o.amount
    FROM Orders o
    WHERE o.customer_id = @cust_id;
END;

EXEC GetCustomerOrders @cust_id = 1

CREATE FUNCTION GetTotalSpent(@cust_id INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);

    SELECT @total = SUM(amount)
    FROM Orders
    WHERE customer_id = @cust_id;

    RETURN ISNULL(@total, 0);
END;

SELECT dbo.GetTotalSpent(1) AS Total_Spent

