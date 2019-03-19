--añadir el costo de venta a los productos
ALTER TABLE Products
ADD UnitCost MONEY;
--procedimiento para llenar el costo de venta con un 25% de margen de ganancia
select * from Products

CREATE PROC FillUnitCost
AS
	DECLARE @cont int, @tam int;
	SET @cont = 1;
	SET @tam=(SELECT COUNT(*) FROM Products);
	WHILE(@cont<=@tam)
	begin
		UPDATE Products set UnitCost=(SELECT (UnitPrice*0.75) as UnitCost FROM Products WHERE ProductID=@cont)
		WHERE ProductID=@cont;
		set @cont=@cont+1;
	end

EXEC FillUnitCOST

SELECT * FROM Products;
/*la tabla Accounts representa al catalogo de cuentas, se compone de los campos:
id, nombre de la cuenta, nat (representa si es deudora D o acreedora A), finance_stat 
(representa al estado financiero al que pertenece ya sea BG o ER) y book_value que
es el valor actual en libro*/

CREATE TABLE Accounts(
	id_account INTEGER PRIMARY KEY IDENTITY(1,1),
	acconunt_name NVARCHAR(30) NOT NULL,
	nat NCHAR NOT NULL,
	finance_stat NVARCHAR(2) NOT NULL,
	book_value MONEY NOT NULL
);

ALTER TABLE Accounts
ADD CONSTRAINT [CK_account_nat] check (nat in('D', 'A'));

ALTER TABLE Accounts
ADD CONSTRAINT [CK_account_finstat] check (finance_stat in('BG', 'ER'));


CREATE TABLE Reg_Accounts(
	id_reg INTEGER PRIMARY KEY IDENTITY(1,1),
	id_account INTEGER FOREIGN KEY REFERENCES Accounts(id_account),
	book_value MONEY,
	yr DATE,
);

