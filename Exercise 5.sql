--Exercise 5: Write a Procedure supplying name information from the Person.Person table and accepting a filter for the first name. Alter the above Store Procedure to supply Default Values if user does not enter any value

use AdventureWorks2008R2;
DROP PROCEDURE IF EXISTS person.myProcedure;

GO
CREATE PROC person.myProcedure 
 @name varchar(50)='IN'
AS
(SELECT FirstName FROM Person.Person
WHERE PersonType=@name)
GO

ALTER PROCEDURE person.myProcedure 
  @name varchar(50)
AS
IF @name IS NULL BEGIN;
  SET @name='Ashish'
END;
SELECT FirstName
FROM Person.Person
WHERE PersonType=@name; 

Execute person.myProcedure @name='IN';
Execute person.myProcedure @name='EM';


