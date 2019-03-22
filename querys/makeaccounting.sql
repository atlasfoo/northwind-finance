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

/*La tabla reg accounts registra el valor en libro de las cuentas en un
determinado año, con el fin de obtener el estado financiero respectivo de ese año.
Por convencion, las fechas de ese año son el ultimo dia*/

CREATE TABLE Reg_Accounts(
	id_reg INTEGER PRIMARY KEY IDENTITY(1,1),
	id_account INTEGER FOREIGN KEY REFERENCES Accounts(id_account),
	book_value MONEY,
	yr DATE
);

CREATE TABLE F_Act (
	ac_cod INTEGER PRIMARY KEY,
	descr NVARCHAR(60),
	dept NVARCHAR(5),
	book_value MONEY
);

ALTER TABLE F_Act
ADD CONSTRAINT [CK_f_act_dept] check (dept in('SALES', 'ADMIN'));

CREATE TABLE Purchases(
	id_purc INTEGER PRIMARY KEY IDENTITY(1,1),
	product_id INTEGER FOREIGN KEY REFERENCES Products(ProductID),
	UnitQty INT,
	UnitCost MONEY,
	purchase_date DATE
);


/*To test*/


CREATE TABLE Transactions (
	id_transact INTEGER PRIMARY KEY IDENTITY(1,1),
	descr NVARCHAR(70),
	transact_date DATE,
	total_amount MONEY
);

CREATE TABLE Transact_details(
	id_transact_details INTEGER PRIMARY KEY IDENTITY(1,1),
	id_accounts INTEGER FOREIGN KEY REFERENCES Accounts(id_account) NOT NULL,
	id_transact INTEGER FOREIGN KEY REFERENCES Transactions(id_transact) NOT NULL,
	change_amount MONEY NOT NULL
);

/*TRIGGERS*/

/*Actualizacion de inventario por c promedio simple*/
ALTER TRIGGER UpdAVGUnitCost
ON Purchases
AFTER INSERT
AS
	DECLARE @UCost int, @PrID int, @Uqty int;
	SELECT @UCost=UnitCost, @PrID=product_id, @Uqty=UnitQty  from inserted; 
	UPDATE Products SET UnitCost=((UnitCost+@UCost)/2), UnitsInStock=UnitsInStock+@Uqty 
	WHERE ProductID=@PrID;
	
/*Asientos de Diario*/
