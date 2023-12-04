
USE ExampleDatabase;
GO

----------------------------------------------
-- Doing some basic queries with our tables
----------------------------------------------

-- Viewing our tables
SELECT *
FROM Customer;

SELECT *
FROM CustomerMarketing;

SELECT *
FROM CustomerOrder;

SELECT *
FROM Product;

-- Selecting specific columns
SELECT SSNO, 
	Quantity,
	TotalAmount
FROM CustomerOrder;

-- Filtering the data with "WHERE" clause
SELECT SSNO, 
	Quantity,
	TotalAmount
FROM CustomerOrder
WHERE Quantity > 2;

-- Ordering the data
SELECT SSNO, 
	Quantity,
	TotalAmount
FROM CustomerOrder
WHERE Quantity > 2
ORDER BY TotalAmount DESC;

-- LEFT JOIN to se which customers that can be contacted for marketing
-- No information about the customer "20080107-3341" in the CustomerMarketing table
SELECT A.SSNO, 
	A.Quantity,
	A.TotalAmount, 
	B.LegalToContact
FROM CustomerOrder as A
LEFT JOIN CustomerMarketing as B
	ON A.SSNO = B.SSNO
WHERE Quantity > 2
ORDER BY TotalAmount DESC;

-- INNER JOIN to se which customers that can be contacted for marketing
-- Only customers in both tables are displayed
SELECT A.SSNO, 
	A.Quantity,
	A.TotalAmount, 
	B.LegalToContact
FROM CustomerOrder as A
INNER JOIN CustomerMarketing as B
	ON A.SSNO = B.SSNO
WHERE Quantity > 2
ORDER BY TotalAmount DESC;

-- We can join multiple tables
SELECT A.SSNO, 
	B.FirstName,
	A.Quantity,
	A.TotalAmount, 
	C.LegalToContact
FROM CustomerOrder as A
LEFT JOIN Customer as B
	ON A.SSNO = B.SSNO
LEFT JOIN CustomerMarketing as C
	ON A.SSNO = C.SSNO
WHERE Quantity > 2
ORDER BY TotalAmount DESC;