--Exercise 6: Write a trigger for the Product table to ensure the list price can never be raised more than 15 Percent in a single change. Modify the above trigger to execute its check code only if the ListPrice column is updated 


USE AdventureWorks2008R2
DROP TRIGGER IF EXISTS Production.myPrice
GO
CREATE TRIGGER Production.myPrice
ON Production.Product
FOR UPDATE
AS
IF EXISTS (
SELECT * FROM inserted ins
JOIN deleted de
ON ins.ProductID = de.ProductID
WHERE ins.ListPrice > (de.ListPrice * 0.15)
)
BEGIN
RAISERROR('Price increased may not be greater than 15 percent.Therefore Transaction Failed.',16,1)
ROLLBACK TRANSACTION
END
GO


ALTER TRIGGER Production.myPrice
ON Production.Product
FOR UPDATE
AS
IF UPDATE(ListPrice)
BEGIN
IF EXISTS(
SELECT *
FROM inserted ins
JOIN deleted de
ON ins.ProductID = de.ProductID
WHERE ins.ListPrice > (de.ListPrice * 0.15)
 )
BEGIN RAISERROR('Price increased may not be greater than 15 percent.Therefore Transaction Failed.',12,1)
ROLLBACK TRANSACTION
END
END


SELECT Production.Product.ProductID,
	   Production.Product.ListPrice
FROM PRODUCTION.Product;

UPDATE PRODUCTION.Product 
SET ListPrice=2
WHERE Product.ProductID=4;