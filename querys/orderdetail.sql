create procedure sp_showOrders
as
	SELECT O.OrderID, C.CompanyName, O.OrderDate
	FROM Orders O INNER JOIN Customers C ON C.CustomerID=O.CustomerID
	WHERE YEAR(O.OrderDate)=1998;

CREATE PROCEDURE sp_showProducts
as
	SELECT ProductID, ProductName, UnitsInStock, UnitPrice FROM Products WHERE UnitsInStock>0;