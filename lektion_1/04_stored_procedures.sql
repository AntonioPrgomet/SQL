
-- Stored Procedures

USE AdventureWorks2022;
GO

----------------------------------------------
-- Executing a stored procedure
----------------------------------------------

SELECT *
FROM HumanResources.Employee; 

-- usp stands for "user stored procedure"
EXEC uspGetEmployeeManagers 13;

----------------------------------------------
-- Creating a stored procedure
----------------------------------------------

-- Inspecting our data first
SELECT *
FROM Person.Person;

SELECT *
FROM Person.PersonPhone;

SELECT *
FROM Person.PhoneNumberType;

SELECT A.BusinessEntityID,
	A.FirstName,
	A.LastName, 
	B.PhoneNumber, 
	C.Name as PhoneType
FROM Person.Person AS A
INNER JOIN Person.PersonPhone AS B
	ON A.BusinessEntityID = B.BusinessEntityID
INNER JOIN Person.PhoneNumberType as C
	ON B.PhoneNumberTypeID = C.PhoneNumberTypeID;

-- Creating the stored procedure
CREATE PROCEDURE Person.uspContactPhone  
	@BusinessEntityID INT
AS
SELECT A.BusinessEntityID,
	A.FirstName,
	A.LastName, 
	B.PhoneNumber, 
	C.Name as PhoneType
FROM Person.Person AS A
INNER JOIN Person.PersonPhone AS B
	ON A.BusinessEntityID = B.BusinessEntityID
INNER JOIN Person.PhoneNumberType as C
	ON B.PhoneNumberTypeID = C.PhoneNumberTypeID
WHERE A.BusinessEntityID = @BusinessEntityID;

EXEC Person.uspContactPhone 1;
EXEC Person.uspContactPhone 16;