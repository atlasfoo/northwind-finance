alter procedure sp_showOrders
as
	SELECT O.OrderID, C.CompanyName as [Nombre de la Compañía], O.OrderDate as [Fecha de la Orden]
	FROM Orders O INNER JOIN Customers C ON C.CustomerID=O.CustomerID
	WHERE YEAR(O.OrderDate)=1998;

alter PROCEDURE sp_showProducts
as
	SELECT ProductID, ProductName as [Nombre del producto], UnitsInStock as [Inventario disponible], UnitPrice as [Precio Unitario] FROM Products WHERE UnitsInStock>0;