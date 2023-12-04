
/*
In this script we create four tables according to our database model
where we also insert some values. 

Finally we will do some basic queries. 
*/

----------------------------------------------
-- Creating a database to store our tables
----------------------------------------------
CREATE DATABASE ExampleDatabase;
GO

USE ExampleDatabase;
GO

----------------------------------------------
-- Creating Customer table
----------------------------------------------

-- The "City" column does not require a value to be inserted
CREATE TABLE Customer (
	SSNO char(13) NOT NULL, 
	FirstName varchar(30) NOT NULL, 
	LastName varchar(30) NOT NULL,
	City varchar(60) NULL,
	CONSTRAINT PK_Customer_SSNO PRIMARY KEY (SSNO)
);

INSERT INTO Customer (SSNO, FirstName, LastName, City)
	VALUES ('19560113-1313', 'Kalle', 'Karlsson', 'Stockholm'), 
		('20030603-7834', 'Julia', 'Johansson', 'Malmö'), 
		('20080107-3341', 'Sofia', 'Edvardsson', 'Göteborg');

INSERT INTO Customer (SSNO, FirstName, LastName)
VALUES ('19920415-4534', 'Kim', 'Alfström');

INSERT INTO Customer (SSNO, FirstName, City)
VALUES ('19920415-4534', 'Kim', 'Alfström');

----------------------------------------------
-- Creating CustomerMarketing table
----------------------------------------------

-- We specify a default value of 0 for the column "LegalToContact"
CREATE TABLE CustomerMarketing (
	SSNO char(13) NOT NULL, 
	LegalToContact int DEFAULT 0, 
	CONSTRAINT PK_CustomerMarketing_SSNO PRIMARY KEY (SSNO), 
	CONSTRAINT FK_CustomerMarketing_Customer_SSNO FOREIGN KEY (SSNO) REFERENCES Customer (SSNO),
	CONSTRAINT CHK_CustomerMarketing_LegalToContact CHECK (LegalToContact IN (0, 1))
);

-- Violating the check constraint (0, 1)
INSERT INTO CustomerMarketing (SSNO, LegalToContact)
	VALUES ('19560113-1313', 7);

-- This ssno is not in the customer table.
INSERT INTO CustomerMarketing (SSNO, LegalToContact)
	VALUES ('19001213-1234', 1);

INSERT INTO CustomerMarketing (SSNO, LegalToContact)
	VALUES ('19560113-1313', 1), 
		('19920415-4534', 0);

-- Using default value of 0
INSERT INTO CustomerMarketing (SSNO)
VALUES ('20030603-7834');

----------------------------------------------
-- Creating Product table
----------------------------------------------

-- Notice, below we use a unique constraint
CREATE TABLE Product (
    ProductID int NOT NULL,
    ProductName varchar(35) NOT NULL,
	CONSTRAINT PK_Product_ProductID PRIMARY KEY (ProductID), 
	CONSTRAINT AK_Product_ProductName UNIQUE (ProductName)
);

-- Violation of unique ProductName constraint
INSERT INTO Product (ProductID, ProductName)
	VALUES (1, 'ProductA'), 
		(2, 'ProductB'),
		(3, 'ProductB');

INSERT INTO Product (ProductID, ProductName)
	VALUES (1, 'ProductA'), 
		(2, 'ProductB'),
		(3, 'ProductC'), 
		(4, 'ProductD'),
		(5, 'ProductE');

----------------------------------------------
-- Creating CustomerOrder table
----------------------------------------------

-- Notice, we use the IDENTITY function to automatically increment
-- the id number used as a primary key. We also created an index. 
CREATE TABLE CustomerOrder (
	ID int IDENTITY(1,1),
    OrderID int NOT NULL,
    SSNO char(13) NOT NULL,
    ProductID int NOT NULL,
    Quantity int NOT NULL,
    TotalAmount money NOT NULL,
    [Date] Date NOT NULL ,
    CONSTRAINT PK_CustomerOrder_ID PRIMARY KEY (ID), 
	CONSTRAINT FK_CustomerOrder_Customer_SSNO FOREIGN KEY (SSNO) REFERENCES Customer (SSNO),
	CONSTRAINT FK_CustomerOrder_Product_ProductID FOREIGN KEY (ProductID) REFERENCES Product (ProductID), 
	INDEX IX_Date (Date)
);

INSERT INTO CustomerOrder (OrderID, SSNO, ProductID, Quantity, TotalAmount, Date)
VALUES
    (1, '19560113-1313', 5, 4, 7348.49, '2003-01-13'),
	(1, '19560113-1313', 3, 12, 7348.49, '2003-01-13'),
	(1, '19560113-1313', 1, 2, 7348.49, '2003-01-13'),
    (2, '20030603-7834', 4, 1, 2145.00, '2021-03-02'),
	(3, '20080107-3341', 2, 10, 14000, '2023-08-15');

----------------------------------------------
-- Updating values
----------------------------------------------

-- We can update values if for instance they change or we typed in the wrong value
UPDATE CustomerOrder
SET TotalAmount = 13998
WHERE SSNO = '20080107-3341';


-- Comment out and run the code if you want to drop the tables. 

/*
DROP TABLE CustomerMarketing;
DROP TABLE CustomerOrder;
DROP TABLE Customer;
DROP TABLE Product;
*/

-- Comment out and run the code if you want to drop the database. 
-- DROP DATABASE ExampleDatabase;