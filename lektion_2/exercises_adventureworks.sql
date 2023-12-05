
/*---------------------------------------------------------
In this code exercises we are going to practice 
some T-SQL queries based on the AdventureWorks2022 database. 

Have fun! 
---------------------------------------------------------*/

USE AdventureWorks2022;
GO

/*---------------------------------------------------------
Explain what the code below does.
It is very useful to explore for instance what tables
you can join together when exploring a database. 
---------------------------------------------------------*/

SELECT A.name as ColumnName, 
	(SCHEMA_NAME(B.schema_id) + '.' + B.name) AS 'TableName'
FROM  sys.columns as A INNER JOIN sys.tables as B
	on A.object_id = B.object_id
WHERE A.name LIKE '%BusinessEntityID%'
ORDER BY TableName, ColumnName;

/*---------------------------------------------------------
1. Inspect the table Sales.SalesOrderHeader.
2. We are going to look at "Top Sales", select the columns
SalesOrderID, ShipDate, TotalDue. 
You want to sort the data so the higest TotalDue comes first. 
What is the higest order amount and when was it shipped?
3. Exactly the same as question 2 but only select the TOP 10 
rows. 
---------------------------------------------------------*/
-- 1 Inspection 
SELECT * FROM Sales.SalesOrderHeader;

-- 2


-- 3


/*---------------------------------------------------------
1. Inspect the two tables Person.Person and Sales.SalesPerson. 
2. We are going to look at "Seller Statistics"
containing the columns
A.BusinessEntityID, A.FirstName, A.LastName, B.CommissionPCT, 
B.SalesYTD, B.SalesLastYear from the two tables Person.Person (as A)
and Sales.SalesPerson (as B). Order the table so that those who had higest
sales last year are at the top of the table. Keep the ten persons
who sold most. 

- Look up what is meant by SalesYTD. 

Hint: You should use a join to get columns 
from two different tables. 

3. Do the same thing as in question 2, but remove the 
"TOP 10" part and instead use a "WHERE" statement to filter
out the salespeople who sold for less than 5,000,000 and
order it in ascending order by using the column SalesLastYear.
---------------------------------------------------------*/

-- 1


-- 2


-- 3


/*---------------------------------------------------------
1. Inspect the table Sales.SalesTerritory.
2. We are going to look at "Sales by group" that has two columns, 
"Group" and how much you sold in total for that group, call this
column TotalSales.
- Hint: You should use a GROUP BY statement. 
- Note, when refeering to the Group column, write [Group] 
since "Group" is a reserved word in SQL.
---------------------------------------------------------*/


/*---------------------------------------------------------
Below we create a new table "Person.MyPersonPhoneTable",
this is useful if for instance
colleagues in your organization also are interested in some 
data that you are transforming and saving in a table. 

Look at the code, do you understand what it does?
---------------------------------------------------------*/

SELECT * FROM Person.Person;
SELECT * FROM Person.PersonPhone;

SELECT A.FirstName, 
       A.LastName,
       B.PhoneNumber
INTO Person.MyPersonPhoneTable
FROM Person.Person as A
INNER JOIN Person.PersonPhone as B
    ON A.BusinessEntityID = B.BusinessEntityID;

SELECT * FROM Person.MyPersonPhoneTable;

/*---------------------------------------------------------
Below we do a similar thing as in the example above, 
but now we create a view instead. What is the difference?

Inspiration: 
https://stackoverflow.com/questions/6015175/difference-between-view-and-table-in-sql 
In short, views are often created so many people can access
it without going into the "core data" that fewer people work 
with. 
---------------------------------------------------------*/

CREATE VIEW Person.VMyPersonPhoneTable
AS
SELECT A.FirstName, 
       A.LastName,
       B.PhoneNumber
FROM Person.Person as A
INNER JOIN Person.PersonPhone as B
    ON A.BusinessEntityID = B.BusinessEntityID;

SELECT * FROM Person.VMyPersonPhoneTable;

/*---------------------------------------------------------
Explain what the two code snippets below does. 
---------------------------------------------------------*/

/* Code snippet 1 */
SELECT * FROM HumanResources.Employee; 
SELECT * FROM HumanResources.EmployeeDepartmentHistory; 
SELECT * FROM HumanResources.Department; 

SELECT A.BusinessEntityID, 
	A.JobTitle, 
	B.DepartmentID, 
	C.Name, 
	C.GroupName,
	B.ShiftID, 
	B.StartDate, 
	B.EndDate
FROM HumanResources.Employee as A INNER JOIN HumanResources.EmployeeDepartmentHistory as B
	ON A.BusinessEntityID = B.BusinessEntityID
LEFT JOIN HumanResources.Department as C
	on B.DepartmentID = C.DepartmentID
ORDER BY A.BusinessEntityID;


/* Code snippet 2 */
--We are using something that is called a "Common Table Expression", CTE.

-- Define the CTE expression name and column list.
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

/*---------------------------------------------------------
If you have time, do some exploration of 
the Database AdventureWorks2022 and produce some queries 
that you find are interesting. 

Obviously, you will have to do some explorations before
beeing able to produce some queries. 
---------------------------------------------------------*/





