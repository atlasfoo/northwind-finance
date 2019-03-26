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

CREATE TABLE Accounts(
	id_account INTEGER PRIMARY KEY IDENTITY(1,1),
	acconunt_name NVARCHAR(30) NOT NULL,
	nat NCHAR NOT NULL,
	finance_stat NVARCHAR(2) NOT NULL,
	book_value MONEY NOT NULL,
	clasif NVARCHAR(2),
);

ALTER TABLE Accounts
ADD CONSTRAINT [CK_account_nat] check (nat in('D', 'A'));

ALTER TABLE Accounts
ADD CONSTRAINT [CK_account_finstat] check (finance_stat in('BG', 'ER'));

/*Clasificiacion de cuentas:
AC: activo circulante, AN: activo no circulante, PC: pas. circ
PN: pas. n circulante, CP: Capital, IN: ingresos, CV: costo de venta,
GV: gastos fijos de venta, GA: gastos admin, GF: gastos financieros e intereses*/

ALTER TABLE Accounts
ADD CONSTRAINT [CK_account_clasif] check (clasif in('AC', 'AN', 'PC', 'PN', 'CP', 'IN', 'CV','GV','GA','GF', 'T');


/*La tabla reg accounts registra el valor en libro de las cuentas en un
determinado año, con el fin de obtener el estado financiero respectivo de ese año.
Por convencion, las fechas de ese año son el ultimo dia*/

CREATE TABLE Reg_Accounts(
	id_reg INTEGER PRIMARY KEY IDENTITY(1,1),
	id_account INTEGER FOREIGN KEY REFERENCES Accounts(id_account),
	book_value MONEY,
	yr DATE
);

DROP TABLE F_Act

CREATE TABLE F_Act (
	ac_cod INTEGER PRIMARY KEY,
	descr NVARCHAR(60),
	book_value MONEY,
	disc_value MONEY,
	lifespan INTEGER
);

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
DELETE FROM Accounts
/*Insercion de datos*/
--balance general
INSERT INTO Accounts VALUES('Banco','D','BG', 900000,'AC');
INSERT INTO Accounts VALUES('Caja','D','BG', 150000,'AC');
INSERT INTO Accounts VALUES('Fondo de Oportunidades','D','BG', 15000,'AC');
INSERT INTO Accounts VALUES('Inventario','D','BG', 0,'AC');
INSERT INTO Accounts VALUES('Clientes','D','BG', 850000,'AC');
INSERT INTO Accounts VALUES('Est. de cuentas incobrables','D','BG', -10000,'AC');
INSERT INTO Accounts VALUES('Documentos por cobrar','D','BG', 45000,'AC');
INSERT INTO Accounts VALUES('Total Activo Circulante','D','BG', 0,'T');
INSERT INTO Accounts VALUES('Activos Fijos','D','BG', 0,'AN');
INSERT INTO Accounts VALUES('Depreciacion Act. Fijos','D','BG', 0,'AN');
INSERT INTO Accounts VALUES('Terreno','D','BG', 650000,'AN');
INSERT INTO Accounts VALUES('Marcas registradas','D','BG', 225000,'AN');
INSERT INTO Accounts VALUES('Patentes','D','BG', 52000,'AN');
INSERT INTO Accounts VALUES('Gastos de instalacion','D','BG', 400000,'AN');
INSERT INTO Accounts VALUES('Total Activo no Circulante','D','BG', 0,'T');
INSERT INTO Accounts VALUES('Total Activos','D','BG', 0,'T');
INSERT INTO Accounts VALUES('Acreedores','A','BG', 675000,'PC');
INSERT INTO Accounts VALUES('Prestamos a corto plazo','A','BG', 700000,'PC');
INSERT INTO Accounts VALUES('IVA por pagar','A','BG', 56000,'PC');
INSERT INTO Accounts VALUES('IR por pagar','A','BG', 0,'PC');
INSERT INTO Accounts VALUES('Proveedores','A','BG', 1000000,'PC');
INSERT INTO Accounts VALUES('Hipotecas a corto plazo','A','BG', 475000,'PC');
INSERT INTO Accounts VALUES('Total Pas. Circulante','A','BG', 0,'T');
INSERT INTO Accounts VALUES('Prestamos a largo plazo','A','BG', 700000,'PN');
INSERT INTO Accounts VALUES('Hipotecas a largo plazo','A','BG', 700000,'PN');
INSERT INTO Accounts VALUES('Total Pas. no Circulante','A','BG', 0,'T');
INSERT INTO Accounts VALUES('Total Pasivos','A','BG', 0,'T');
INSERT INTO Accounts VALUES('Capital Social','A','BG', 2500000,'CP');
INSERT INTO Accounts VALUES('Utilidades Acumuladas','A','BG', 400000,'CP');
INSERT INTO Accounts VALUES('Ut. Neta despues de IR','A','BG', 0,'CP');
INSERT INTO Accounts VALUES('Total Capital','A','BG', 0,'T');
INSERT INTO Accounts VALUES('Total Pasivo+Capital','A','BG', 0,'T');

--Estado de resultados
INSERT INTO Accounts VALUES('Ventas totales', 'A', 'ER', 0, 'IN');
INSERT INTO Accounts VALUES('Descuento sobre ventas', 'A', 'ER', 0, 'IN');
INSERT INTO Accounts VALUES('Ventas netas', 'A', 'ER', 0,'T');
INSERT INTO Accounts VALUES('Costo de venta', 'D', 'ER', 0, 'CV');
INSERT INTO Accounts VALUES('Utilidad bruta', 'A', 'ER', 0, 'T');
INSERT INTO Accounts VALUES('Gastos de venta', 'D', 'ER', 78000, 'GV');
INSERT INTO Accounts VALUES('Total depreciacion', 'D', 'ER', 0, 'GV');
INSERT INTO Accounts VALUES('Gastos administrativos', 'D', 'ER', 50000, 'GA');
INSERT INTO Accounts VALUES('UAII', 'A', 'ER', 0, 'T');
INSERT INTO Accounts VALUES('Intereses por pagar', 'D', 'ER', 0, 'GF');
INSERT INTO Accounts VALUES('UAI', 'A', 'ER', 0, 'T');
INSERT INTO Accounts VALUES('IR del ejercicio', 'D', 'ER', 0, 'GV');
INSERT INTO Accounts VALUES('UDII', 'A', 'ER', 0, 'T');

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

select * from Accounts
/*TRIGGERS*/
--Actualizacion de totales
ALTER TRIGGER Upd_account_totals
ON Accounts
AFTER UPDATE
AS
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='AC') WHERE acconunt_name='Total Activo Circulante';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='AN') WHERE acconunt_name='Total Activo no Circulante';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='AN' or clasif='AC') WHERE acconunt_name='Total Activos';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='PC') WHERE acconunt_name='Total Pas. Circulante';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='PN') WHERE acconunt_name='Total Pas. no Circulante';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='PN' or clasif='PC') WHERE acconunt_name='Total Pasivos';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='CP') WHERE acconunt_name='Total Capital';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='PN' or clasif='PC' or clasif='CP') WHERE acconunt_name='Total Pasivo+Capital';

	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='IN') WHERE acconunt_name='Ventas netas';
	Declare @ut_brut money, @gastos_oper money;
	set @ut_brut=(SELECT book_value FROM Accounts WHERE acconunt_name='Ventas netas')-(SELECT book_value FROM Accounts WHERE acconunt_name='Costo de Venta');
	UPDATE Accounts SET book_value=@ut_brut WHERE acconunt_name='Utilidad bruta';
	set @gastos_oper=(SELECT book_value FROM Accounts WHERE acconunt_name='Gastos de venta')+(SELECT book_value FROM Accounts WHERE acconunt_name='Gastos administrativos')+(SELECT book_value FROM Accounts WHERE acconunt_name='Total depreciacion');
	UPDATE Accounts SET book_value=(select book_value from Accounts where acconunt_name='Utilidad bruta')-@gastos_oper WHERE acconunt_name='UAII';
	UPDATE Accounts SET book_value=((select book_value from Accounts where acconunt_name='UAII')-(select book_value from Accounts where acconunt_name='Intereses por pagar')) WHERE acconunt_name='UAI';
	if((select book_value from Accounts where acconunt_name='UAI')<0)
	begin
		update Accounts set book_value=0 where acconunt_name='IR del ejercicio';
		UPDATE Accounts SET book_value=(SELECT book_value FROM Accounts WHERE acconunt_name='IR del ejercicio') WHERE acconunt_name='IR por pagar';
		UPDATE Accounts SET book_value=(select book_value from Accounts where acconunt_name='UAI') WHERE acconunt_name='UDII';
		UPDATE Accounts SET book_value=(SELECT book_value FROM Accounts WHERE acconunt_name='UDII') WHERE acconunt_name='Ut. Neta despues de IR';
	end
	else
	begin
		UPDATE Accounts SET book_value=((SELECT book_value FROM Accounts WHERE acconunt_name='UAI')*0.3) WHERE acconunt_name='IR del ejercicio';
		UPDATE Accounts SET book_value=(SELECT book_value FROM Accounts WHERE acconunt_name='IR del ejercicio') WHERE acconunt_name='IR por pagar';	
		UPDATE Accounts SET book_value=((select book_value from Accounts where acconunt_name='UAI')-(select book_value from Accounts where acconunt_name='IR del ejercicio')) WHERE acconunt_name='UDII';
		UPDATE Accounts SET book_value=(SELECT book_value FROM Accounts WHERE acconunt_name='UDII') WHERE acconunt_name='Ut. Neta despues de IR';
	end

alter TRIGGER Ins_account_totals
ON Accounts
AFTER INSERT
AS
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='AC') WHERE acconunt_name='Total Activo Circulante';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='AN') WHERE acconunt_name='Total Activo no Circulante';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='AN' or clasif='AC') WHERE acconunt_name='Total Activos';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='PC') WHERE acconunt_name='Total Pas. Circulante';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='PN') WHERE acconunt_name='Total Pas. no Circulante';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='PN' or clasif='PC') WHERE acconunt_name='Total Pasivos';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='CP') WHERE acconunt_name='Total Capital';
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='PN' or clasif='PC' or clasif='CP') WHERE acconunt_name='Total Pasivo+Capital';

	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM Accounts WHERE clasif='IN') WHERE acconunt_name='Ventas netas';
	Declare @ut_brut money, @gastos_oper money;
	set @ut_brut=(SELECT book_value FROM Accounts WHERE acconunt_name='Ventas netas')-(SELECT book_value FROM Accounts WHERE acconunt_name='Costo de Venta');
	UPDATE Accounts SET book_value=@ut_brut WHERE acconunt_name='Utilidad bruta';
	set @gastos_oper=(SELECT book_value FROM Accounts WHERE acconunt_name='Gastos de venta')+(SELECT book_value FROM Accounts WHERE acconunt_name='Gastos administrativos')+(SELECT book_value FROM Accounts WHERE acconunt_name='Total depreciacion');
	UPDATE Accounts SET book_value=(select book_value from Accounts where acconunt_name='Utilidad bruta')-@gastos_oper WHERE acconunt_name='UAII';
	UPDATE Accounts SET book_value=((select book_value from Accounts where acconunt_name='UAII')-(select book_value from Accounts where acconunt_name='Intereses por pagar')) WHERE acconunt_name='UAI';
	if((select book_value from Accounts where acconunt_name='UAI')<0)
	begin
		update Accounts set book_value=0 where acconunt_name='IR del ejercicio';
		UPDATE Accounts SET book_value=(SELECT book_value FROM Accounts WHERE acconunt_name='IR del ejercicio') WHERE acconunt_name='IR por pagar';
		UPDATE Accounts SET book_value=(select book_value from Accounts where acconunt_name='UAI') WHERE acconunt_name='UDII';
		UPDATE Accounts SET book_value=(SELECT book_value FROM Accounts WHERE acconunt_name='UDII') WHERE acconunt_name='Ut. Neta despues de IR';
	end
	else
	begin
		UPDATE Accounts SET book_value=((SELECT book_value FROM Accounts WHERE acconunt_name='UAI')*0.3) WHERE acconunt_name='IR del ejercicio';
		UPDATE Accounts SET book_value=(SELECT book_value FROM Accounts WHERE acconunt_name='IR del ejercicio') WHERE acconunt_name='IR por pagar';	
		UPDATE Accounts SET book_value=((select book_value from Accounts where acconunt_name='UAI')-(select book_value from Accounts where acconunt_name='IR del ejercicio')) WHERE acconunt_name='UDII';
		UPDATE Accounts SET book_value=(SELECT book_value FROM Accounts WHERE acconunt_name='UDII') WHERE acconunt_name='Ut. Neta despues de IR';
	end

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

--TODO:
/*actualizacion de la cuenta de ventas y costo de venta al insertar en order details*/

--PEND--


/*actualizacion de la respectiva cuenta al insertar una transaccion detail y validar partida doble*/

--PEND--

/*procedimientos almacenados para insercion de ventas y transacciones*/

/*procedimientos almacenados para razones financieras y de apalancamiento*/

/*procedimientos almacenados para flujo de efectivo*/