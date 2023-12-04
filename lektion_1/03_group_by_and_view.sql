
-- Demonstrating the "GROUP BY" Clause and
-- how to create a view.

USE AdventureWorks2022;
GO

----------------------------------------------
-- Using the "Count" function
----------------------------------------------

SELECT * FROM Person.Address;

SELECT City,
	Count(AddressLine1) as NbrAddresses
FROM Person.Address
GROUP BY City
ORDER BY NbrAddresses DESC;

----------------------------------------------
-- Calculating quantity sold
----------------------------------------------

SELECT *
FROM Sales.SalesOrderDetail;

-- A simple "GROUP BY" example
SELECT ProductID, 
	SUM(OrderQTY) as TotQtySold
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY TotQtySold DESC;

-- Using "HAVING", note we cannot use "WHERE"
-- Having = "Specifies a search condition for a group or an aggregate"
SELECT ProductID, 
	SUM(OrderQty) as TotQtySold
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 5000
ORDER BY SUM(OrderQty) DESC;

-- Adding a join to get product name
SELECT A.ProductID, 
	B.Name,
	SUM(A.OrderQty) as TotQtySold
FROM Sales.SalesOrderDetail as A
INNER JOIN Production.Product as B
	ON A.ProductID = B.ProductID
GROUP BY A.ProductID, B.Name
HAVING SUM(OrderQty) > 5000
ORDER BY SUM(OrderQty) DESC;

----------------------------------------------
-- Creating a view
----------------------------------------------

CREATE VIEW Sales.VProductQtySold
AS
SELECT A.ProductID, 
	B.Name,
	SUM(A.OrderQty) as TotQtySold
FROM Sales.SalesOrderDetail as A
INNER JOIN Production.Product as B
	ON A.ProductID = B.ProductID
GROUP BY A.ProductID, B.Name;

-- Querying the view
SELECT * 
FROM Sales.VProductQtySold
ORDER BY TotQtySold DESC;
