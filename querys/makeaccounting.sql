USE NorthwindCO
GO

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

CREATE TABLE AccountClasification(
	clasification_id INTEGER PRIMARY KEY IDENTITY(1,1),
	clasification_name NVARCHAR(25) NOT NULL,
	nat NCHAR NOT NULL,
);

--D: deudora, A:acreedora. Clasif para partida doble
INSERT INTO AccountClasification VALUES('ACTIVO', 'D');
INSERT INTO AccountClasification VALUES('PASIVO', 'A');
INSERT INTO AccountClasification VALUES('CAPITAL', 'A');
INSERT INTO AccountClasification VALUES('INGRESO', 'A');
INSERT INTO AccountClasification VALUES('COSTO', 'D');

CREATE TABLE AccountSubclasification(
	--este id es para referenciar en la tabla de cuentas
	acc_subc_id INTEGER PRIMARY KEY IDENTITY(1,1),
	--este par es el que construira el codigo de clasificacion de la cuenta
	clasification_id INTEGER FOREIGN KEY REFERENCES AccountClasification(clasification_id),
	subc_id INTEGER NOT NULL,
	subc_name NVARCHAR(35) NOT NULL
);

INSERT INTO AccountSubclasification VALUES(1,1,'Activo Circulante');
INSERT INTO AccountSubclasification VALUES(1,2,'Activo No Circulante');
INSERT INTO AccountSubclasification VALUES(2,1,'Pasivo a Corto Plazo');
INSERT INTO AccountSubclasification VALUES(2,2,'Pasivo a Largo Plazo');
INSERT INTO AccountSubclasification VALUES(3,1,'Capital Contable');
INSERT INTO AccountSubclasification VALUES(4,1,'Ventas');
INSERT INTO AccountSubclasification VALUES(4,2,'Productos Financieros');
INSERT INTO AccountSubclasification VALUES(4,3,'Otros productos');
INSERT INTO AccountSubclasification VALUES(5,1,'Costo de Venta');
INSERT INTO AccountSubclasification VALUES(5,2,'Gastos de Venta');
INSERT INTO AccountSubclasification VALUES(5,3,'Gastos de Administracion');
INSERT INTO AccountSubclasification VALUES(5,4,'Gastos financieros');
INSERT INTO AccountSubclasification VALUES(5,5,'Impuestos');



CREATE TABLE Accounts(
	--id propio
	id_account INTEGER PRIMARY KEY IDENTITY(1,1),
	--nombre de la cuenta
	account_name NVARCHAR(30) NOT NULL,
	--valor en libro
	book_value MONEY,
	--referencia a su codigo de subclasificacion
	clasification_code INTEGER FOREIGN KEY REFERENCES AccountSubclasification(acc_subc_id),
);

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
	--codigo de activo contable
	ac_cod INTEGER PRIMARY KEY,
	--nombre o descripcion
	descr NVARCHAR(60),
	--valor en libro
	book_value MONEY,
	--valor de descarte
	disc_value MONEY,
	--vida util
	lifespan INTEGER
);

CREATE TABLE Purchases(
	id_purc INTEGER PRIMARY KEY IDENTITY(1,1),
	product_id INTEGER FOREIGN KEY REFERENCES Products(ProductID),
	UnitQty INT,
	UnitCost MONEY,
	purchase_date DATE
);



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
select * from AccountSubclasification;
/*Insercion de datos*/
--balance general
INSERT INTO Accounts VALUES('Banco', 900000,1);
INSERT INTO Accounts VALUES('Caja', 150000, 1);
INSERT INTO Accounts VALUES('Fondo de Oportunidades', 15000,1);
INSERT INTO Accounts VALUES('Inventario', 0, 1);
INSERT INTO Accounts VALUES('Clientes', 850000,1);
INSERT INTO Accounts VALUES('Est. de cuentas incobrables', -10000,1);
INSERT INTO Accounts VALUES('Documentos por cobrar',45000,1);
INSERT INTO Accounts VALUES('Activos Fijos', 0,2);
INSERT INTO Accounts VALUES('Depreciacion Act. Fijos', 0,2);
INSERT INTO Accounts VALUES('Terreno',650000,2);
INSERT INTO Accounts VALUES('Marcas registradas',225000,2);
INSERT INTO Accounts VALUES('Patentes', 52000,2);
INSERT INTO Accounts VALUES('Gastos de instalacion', 400000,2);
INSERT INTO Accounts VALUES('Acreedores',675000,3);
INSERT INTO Accounts VALUES('Prestamos a corto plazo', 700000,3);
INSERT INTO Accounts VALUES('IVA por pagar',56000,3);
INSERT INTO Accounts VALUES('IR por pagar', 0,3);
INSERT INTO Accounts VALUES('Proveedores', 1000000,3);
INSERT INTO Accounts VALUES('Hipotecas a corto plazo', 475000,3);
INSERT INTO Accounts VALUES('Prestamos a largo plazo', 700000,4);
INSERT INTO Accounts VALUES('Hipotecas a largo plazo',700000,4);
INSERT INTO Accounts VALUES('Capital Social',2500000,5);
INSERT INTO Accounts VALUES('Utilidades Acumuladas', 400000,5);
INSERT INTO Accounts VALUES('Ut. Neta despues de IR', 0,5);

--Estado de resultados
INSERT INTO Accounts VALUES('Ventas totales', 0, 6);
INSERT INTO Accounts VALUES('Descuento sobre ventas', 0, 6);
INSERT INTO Accounts VALUES('Costo de venta', 0, 9);
INSERT INTO Accounts VALUES('Gastos de venta', 78000, 10);
INSERT INTO Accounts VALUES('Total depreciacion', 0, 10);
INSERT INTO Accounts VALUES('Gastos administrativos',50000,11);
INSERT INTO Accounts VALUES('Intereses por pagar',0, 12);
INSERT INTO Accounts VALUES('IR del ejercicio', 0, 13);
INSERT INTO Accounts VALUES('UDII', 0, 8);

INSERT INTO F_Act VALUES(100, 'Camion de entrega', 50000, 4000, 6);
INSERT INTO F_Act VALUES(101, 'Camion de entrega', 50000, 4000, 6);
INSERT INTO F_Act VALUES(102, 'Camion de entrega', 50000, 4000, 6);
INSERT INTO F_Act VALUES(103, 'Servidor de BD', 1500, 400, 5);
INSERT INTO F_Act VALUES(104, 'Computador', 800, 0, 5);
INSERT INTO F_Act VALUES(105, 'Bodega 1', 500000, 100000, 15);
INSERT INTO F_Act VALUES(106, 'Bodega 2', 500000, 90000, 15);
INSERT INTO F_Act VALUES(107, 'Edificio Principal', 650000, 125000, 20);
INSERT INTO F_Act VALUES(108, 'Maquina de embalaje', 275000, 0, 10);
INSERT INTO F_Act VALUES(109, 'Maquina de embalaje', 275000, 0, 10);
INSERT INTO F_Act VALUES(110, 'Moto de reparto', 2500, 0, 3);
INSERT INTO F_Act VALUES(111, 'Moto de reparto', 2500, 0, 3);
INSERT INTO F_Act VALUES(112, 'Moto de reparto', 2500, 0, 3);
INSERT INTO F_Act VALUES(113, 'Moto de reparto', 2500, 0, 3);


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
	UPDATE Accounts SET book_value=(SELECT SUM(UnitCost*UnitsInStock) FROM Products) WHERE acconunt_name='Inventario'
/*actualizacion de la cuenta de activos fijos al actualizar o insertar*/
Alter TRIGGER F_act_ins
on F_act
after insert
as
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM F_Act) WHERE acconunt_name='Activos fijos';
	UPDATE Accounts SET book_value=-(SELECT SUM((book_value-disc_value)/lifespan) FROM F_Act) WHERE acconunt_name='Depreciacion Act. Fijos';
	UPDATE Accounts SET book_value=(SELECT SUM((book_value-disc_value)/lifespan) FROM F_Act) WHERE acconunt_name='Total depreciacion';

alter TRIGGER F_act_upd
on F_act
after update
as
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM F_Act) WHERE acconunt_name='Activos fijos';
	UPDATE Accounts SET book_value=-(SELECT SUM((book_value-disc_value)/lifespan) FROM F_Act) WHERE acconunt_name='Depreciacion Act. Fijos';
	UPDATE Accounts SET book_value=(SELECT SUM((book_value-disc_value)/lifespan) FROM F_Act) WHERE acconunt_name='Total depreciacion';

/*SP's*/
CREATE PROCEDURE Balance_General
AS
	--activos circulantes
	SELECT clasification_code,  account_name as [Nombre Cuenta],
	book_value as [Valor en Libro] FROM Accounts
	WHERE clasification_code=1 
	union
	--total ac
	SELECT 1.5,'Total Activos Circulante',
	(select sum(book_value) from Accounts where clasification_code=1)
	union
	--activos no circulantes
	SELECT clasification_code, account_name ,
	book_value FROM Accounts
	WHERE clasification_code=2 
	union
	--total anc
	SELECT 2.5, 'Total Activo No Circulante',
	(select sum(book_value) from Accounts where clasification_code=2)
	union
	--total activos
	SELECT 2.75, 'Total Activo',
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.subc_id where asb.clasification_id=1)
	union
	--pasivo circulante
	SELECT clasification_code, account_name ,
	book_value FROM Accounts
	WHERE clasification_code=3
	union
	--total p.c
	SELECT 3.5,'Total Pasivos Circulante',
	(select sum(book_value) from Accounts where clasification_code=3)
	union
	--pasivo no circulante
	SELECT clasification_code, account_name ,
	book_value FROM Accounts
	WHERE clasification_code=4
	union
	--total pnc
	SELECT 4.5,'Total Pasivos No Circulante',
	(select sum(book_value) from Accounts where clasification_code=4)
	union
	--total p
	SELECT 4.75, 'Total Pasivo',
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.subc_id where asb.clasification_id=2)
	union
	--capital
	SELECT clasification_code, account_name ,
	book_value FROM Accounts
	WHERE clasification_code=5
	union
	--total c
	SELECT 5.5, 'Total Capital',
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.subc_id where asb.clasification_id=3)
	union
	--total p+c
	SELECT 5.75, 'Total Pasivo+Capital',
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.subc_id where asb.clasification_id=3 or asb.clasification_id=2);
	

--TODO:
/*actualizacion de la cuenta de ventas y costo de venta al insertar en order details*/

--PEND--

/*actualizacion de la respectiva cuenta al insertar una transaccion detail y validar partida doble*/

--PEND--

/*procedimientos almacenados para insercion de ventas y transacciones*/

/*procedimientos almacenados para razones financieras y de apalancamiento*/

/*procedimientos almacenados para flujo de efectivo*/