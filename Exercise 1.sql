--Exercise 1: The exercise requires SQL Server AdventureWorks OLTP database which can be found at Codeplex. Download and attach a copy of the database to your server instance. Take some time to appreciate the entire schema of the database, and functions and stored procedures (refer AdventureWorks 2008 OLTP Schema.pdf). Using the AdventureWorks database, perform the following queries


USE AdventureWorks2008R2
--1: Display the number of records in the [SalesPerson] table

SELECT COUNT(*) as TotalRecords FROM Sales.SalesPerson;

--2: Select both the FirstName and LastName of records from the Person table where the FirstName begins with the letter ‘B’

select FirstName,LastName from Person.Person where FirstName like 'B%';

--3: Select a list of FirstName and LastName for employees where Title is one of Design Engineer, Tool Designer or Marketing Assistant.

Select FirstName,LastName,JobTitle
From Person.Person
INNER JOIN HumanResources.Employee
ON Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID
AND JobTitle IN( 'Design Engineer' , 'Tool Designer ' , 'Marketing Assistant');

--4: Display the Name and Color of the Product with the maximum weight.

SELECT Name , Color, Weight from Production.Product 
WHERE 
Weight=(SELECT MAX(Weight) FROM Production.Product );

--5:Display Description and MaxQty fields from the SpecialOffer table. Some of the MaxQty values are NULL, in this case display the value 0.00 instead.

SELECT Description , ISNULL(MaxQty,0.00) FROM Sales.SpecialOffer; 

--6:Display the overall Average of the [CurrencyRate].[AverageRate] values for the exchange rate ‘USD’ to ‘GBP’ for the year 2005 i.e. FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’. Note: The field [CurrencyRate].[AverageRate] is defined as 'Average exchange rate for the day.'

SELECT AVG(AverageRate) AS 'Average exchange rate for the day'
FROM [Sales].[CurrencyRate] 
WHERE FromCurrencyCode='USD' AND ToCurrencyCode='GBP';

--7: Display the FirstName and LastName of records from the Person table where FirstName contains the letters ‘ss’. Display an additional column with sequential numbers for each row returned beginning at integer 1.

SELECT ROW_NUMBER() OVER(ORDER BY FirstName) AS 
Sequence,FirstName, LastName 
FROM
Person.Person 
WHERE 
FirstName LIKE '%ss%';

--8:Sales people receive various commission rates that belong to 1 of 4 bands.

SELECT BusinessEntityID AS 'SalesPersonID',CommissionPct ,
	   CASE
			WHEN CommissionPct = 0.00 THEN 'BAND 0'
			WHEN CommissionPct > 0.00 AND CommissionPct <= 0.01 THEN 'BAND 1'
			WHEN CommissionPct > 0.01 AND CommissionPct <= 0.015 THEN 'BAND 2'
			WHEN CommissionPct > 0.015 THEN 'BAND 3'
	   END AS 'Commission Band'
FROM Sales.SalesPerson
ORDER BY [Commission Band];

--9:Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez.

SELECT Person.Person.BusinessEntityID, Person.Person.FirstName, Person.Person.MiddleName, 
Person.Person.LastName, HumanResources.EmployeePayHistory.Rate,                      
HumanResources.Employee.OrganizationLevel, HumanResources.Employee.JobTitle 
FROM HumanResources.Employee 
INNER JOIN
HumanResources.EmployeePayHistory 
ON 
HumanResources.Employee.BusinessEntityID = HumanResources.EmployeePayHistory.BusinessEntityID 
INNER JOIN
Person.Person 
ON 
HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID 
WHERE Person.person.BusinessEntityID<49                      
ORDER BY Person.person.BusinessEntityID DESC;

--10:Display the ProductId of the product with the largest stock level.

Select max(dbo.ufnGetStock(ProductID)) from Production.Product;