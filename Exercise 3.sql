--Exercise 3: Show the most recent five orders that were purchased from account numbers that have spent more than $70,000 with AdventureWorks.

USE [AdventureWorks2008R2]

SELECT TOP 5 SalesOrderID AS 'Order ID',
	   AccountNumber AS 'Account Number',
	   SUM(TotalDue) AS 'Total Amount Spend',
	   OrderDate AS 'Order Date'
FROM Sales.SalesOrderHeader
GROUP BY AccountNumber,
		 OrderDate,
		 SalesOrderID
HAVING SUM(TotalDue) > 70000
ORDER BY OrderDate DESC;