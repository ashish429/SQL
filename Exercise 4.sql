--Exercise 4: Create a function that takes as inputs a SalesOrderID, a Currency Code, and a date, and returns a table of all the SalesOrderDetail rows for that Sales Order including Quantity, ProductID, UnitPrice, and the unit price converted to the target currency based on the end of day rate for the date provided. Exchange rates can be found in the Sales.CurrencyRate table.

DROP Function IF EXISTS Sales.myFunction
GO
CREATE FUNCTION Sales.myFunction(@SalesOrderId int,@CurrencyCode varchar(3),@Date datetime)
RETURNS TABLE
AS
RETURN 
	SELECT so.ProductID AS 'Product ID',
		   so.OrderQty AS ' Order Quantity',
		   so.UnitPrice As 'Unit Price',
		   so.UnitPrice*sc.EndOfDayRate AS 'Target Price'
	FROM Sales.SalesOrderDetail AS so,
		 Sales.CurrencyRate AS sc
	WHERE sc.ToCurrencyCode = @CurrencyCode AND
		  sc.ModifiedDate = @Date AND 
		  so.SalesOrderID = @SalesOrderID

GO

Select * from Sales.myFunction(43659,'MXN','2005-09-05');
