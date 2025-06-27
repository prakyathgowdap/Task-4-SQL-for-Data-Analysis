CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS online_retail (
  InvoiceNo VARCHAR(20),
  StockCode VARCHAR(20),
  Description TEXT,
  Quantity INT,
  InvoiceDate DATETIME,
  UnitPrice DECIMAL(10,2),
  CustomerID INT,
  Country VARCHAR(50)
);
-- Use the database
USE ecommerce_db;

-- View first few rows
SELECT * FROM online_retail LIMIT 10;

-- Total revenue by country
SELECT Country, SUM(UnitPrice * Quantity) AS TotalRevenue
FROM online_retail
GROUP BY Country
ORDER BY TotalRevenue DESC;

-- Average revenue per customer
SELECT CustomerID, AVG(UnitPrice * Quantity) AS AvgRevenue
FROM online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;

-- Top customer by spend using subquery
SELECT * FROM online_retail
WHERE CustomerID = (
  SELECT CustomerID
  FROM online_retail
  GROUP BY CustomerID
  ORDER BY SUM(UnitPrice * Quantity) DESC
  LIMIT 1
);

-- Create view for high-value customers
CREATE OR REPLACE VIEW high_value_customers AS
SELECT CustomerID, SUM(UnitPrice * Quantity) AS TotalSpent
FROM online_retail
GROUP BY CustomerID
HAVING TotalSpent > 1000;

-- Show data from the view
SELECT * FROM high_value_customers LIMIT 10;
