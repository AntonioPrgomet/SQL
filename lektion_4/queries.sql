
USE AdventureWorks2022;
GO

/*---------------------------------------------------------
What does the code below do? 
Use the "Case When" logic to produce another query of 
your choice. 
---------------------------------------------------------*/

SELECT * FROM Production.ProductInventory;

SELECT ProductID, 
	CASE
		WHEN Quantity <= 400 THEN 'Low'
		WHEN Quantity > 400 and Quantity <= 500 THEN 'Medium'
		ELSE 'High'
	END AS QuantityLevels, 
	Quantity
FROM Production.ProductInventory;

/*---------------------------------------------------------
Subqueries - What is happening below? 
Try to produce a subquery of your own choice. 
---------------------------------------------------------*/
https://learn.microsoft.com/en-us/sql/relational-databases/performance/subqueries?view=sql-server-ver16

-- Below we are doing a Subquery, do you understand what it does?
SELECT A.ProductID,
	A.Quantity,
	B.QuantityLevels
FROM Production.ProductInventory as A
LEFT JOIN(
SELECT ProductID, 
	CASE
		WHEN Quantity <= 400 THEN 'Low'
		WHEN Quantity > 400 and Quantity <= 500 THEN 'Medium'
		ELSE 'High'
	END AS QuantityLevels, 
	Quantity
FROM Production.ProductInventory
) AS B ON A.ProductID = B.ProductID
WHERE QuantityLevels = 'High';

/*---------------------------------------------------------
CTE - What is happening below? 
Try to produce a CTE of your own choice. 
---------------------------------------------------------*/

WITH MyCTE
AS (
SELECT ProductID, 
	CASE
		WHEN Quantity <= 400 THEN 'Low'
		WHEN Quantity > 400 and Quantity <= 500 THEN 'Medium'
		ELSE 'High'
	END AS QuantityLevels, 
	Quantity
FROM Production.ProductInventory
)
SELECT * FROM MyCTE
WHERE QuantityLevels = 'High';


/*---------------------------------------------------------
CTE and Subquery - Same result but different way
---------------------------------------------------------*/

-- Doing a CTE
https://learn.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver16

WITH NBR_CTE (BusinessEntityID, Nbr)
AS
-- Define the CTE query.
(
    SELECT BusinessEntityID, COUNT(BusinessEntityID) Nbr
    FROM HumanResources.EmployeeDepartmentHistory
    GROUP BY BusinessEntityID
)
-- Define the outer query referencing the CTE name.
SELECT A.BusinessEntityID, 
	A.JobTitle,
	C.GroupName,
	C.Name, 		
	B.ShiftID, 
	D.Nbr as NumberOfShifts,
	B.StartDate, 
	B.EndDate
FROM HumanResources.Employee as A 
INNER JOIN HumanResources.EmployeeDepartmentHistory as B
	ON A.BusinessEntityID = B.BusinessEntityID
LEFT JOIN HumanResources.Department as C
	on B.DepartmentID = C.DepartmentID
LEFT JOIN NBR_CTE as D
	ON A.BusinessEntityID = D.BusinessEntityID
ORDER BY NumberOfShifts DESC, A.BusinessEntityID;

-- Doing a subquery 
SELECT 
    A.BusinessEntityID, 
    A.JobTitle,
    C.GroupName,
	C.Name,        
    B.ShiftID, 
    D.NbrShifts,
    B.StartDate, 
    B.EndDate
FROM 
    HumanResources.Employee AS A 
INNER JOIN HumanResources.EmployeeDepartmentHistory AS B 
	ON A.BusinessEntityID = B.BusinessEntityID
LEFT JOIN HumanResources.Department AS C 
	ON B.DepartmentID = C.DepartmentID
LEFT JOIN (
    SELECT 
        BusinessEntityID,
        COUNT(BusinessEntityID) AS NbrShifts
    FROM HumanResources.EmployeeDepartmentHistory
    GROUP BY BusinessEntityID
) AS D ON A.BusinessEntityID = D.BusinessEntityID
ORDER BY 
    D.NbrShifts DESC, A.BusinessEntityID;
