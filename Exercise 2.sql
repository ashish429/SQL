--Exercise 2: Write separate queries using a join, a subquery, a CTE, and then an EXISTS to list all AdventureWorks customers who have not placed an order.


USE AdventureWorks2008R2

--USING JOINS
SELECT CONCAT(PP.FirstName ,' ',PP.MiddleName,' ', PP.LastName) AS 'Customer Name'
FROM Person.Person PP INNER JOIN
	 Sales.Customer SC ON
	 PP.BusinessEntityID = SC.CustomerID INNER JOIN
	 Sales.SalesOrderHeader SS ON
	 SC.CustomerID = SS.CustomerID
WHERE SS.SalesOrderID IS NULL;


--USING EXITS
SELECT CONCAT(PP.FirstName ,' ',PP.MiddleName,' ', PP.LastName) AS 'Customer Name'
FROM Person.Person PP
WHERE EXISTS (SELECT SC.StoreID
FROM Sales.Customer SC
WHERE PP.BusinessEntityID = SC.CustomerID AND
NOT EXISTS(SELECT SS.CustomerID
FROM Sales.SalesOrderHeader SS
WHERE SC.CustomerID = SS.CustomerID));

--USING SUBQUERY
SELECT CONCAT(FirstName ,' ',MiddleName,' ', LastName) AS 'Customer Name'
FROM Person.Person
Where BusinessEntityID IN (SELECT CustomerID
FROM Sales.Customer
WHERE CustomerID NOT IN  (SELECT CustomerID
FROM Sales.SalesOrderHeader));

--USING CTEs

WITH UnorderProductCustomers (CustomerName)
AS (
	SELECT CONCAT(PP.FirstName ,' ',PP.MiddleName,' ', PP.LastName) AS 'CustomerName'
	FROM Person.Person PP INNER JOIN
	 Sales.Customer SC ON
	 PP.BusinessEntityID = SC.CustomerID LEFT JOIN
	 Sales.SalesOrderHeader SS ON
	 SC.CustomerID = SS.CustomerID
	WHERE SS.SalesOrderID IS NULL
	)
SELECT CustomerName
FROM UnorderProductCustomers;
