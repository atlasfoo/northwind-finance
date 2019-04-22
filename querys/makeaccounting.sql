USE NorthwindCO
GO

--añadir el costo de venta a los productos
ALTER TABLE Products
ADD UnitCost MONEY;
--procedimiento para llenar el costo de venta con un 25% de margen de ganancia
select * from Products
ALTER PROC FillUnitCost
AS
	DECLARE @cont int, @tam int;
	SET @cont = 1;
	SET @tam=(SELECT COUNT(*) FROM Products);
	WHILE(@cont<=@tam)
	begin
		UPDATE Products set UnitCost=(SELECT (UnitPrice*0.55) as UnitCost FROM Products WHERE ProductID=@cont)
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
INSERT INTO AccountSubclasification VALUES(5,1,'Costo de Venta');
INSERT INTO AccountSubclasification VALUES(5,2,'Gastos de Venta');
INSERT INTO AccountSubclasification VALUES(5,3,'Gastos de Administracion');
INSERT INTO AccountSubclasification VALUES(4,2,'Productos Financieros');
INSERT INTO AccountSubclasification VALUES(4,3,'Otros productos');
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
drop table Reg_Accounts
CREATE TABLE Reg_Accounts(
	id_reg INTEGER PRIMARY KEY IDENTITY(1,1),
	id_account INTEGER FOREIGN KEY REFERENCES Accounts(id_account),
	book_value MONEY,
	yr INTEGER
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
INSERT INTO Accounts VALUES('Inventario', 50, 1);
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
INSERT INTO Accounts VALUES('Costo de venta', 0, 7);
INSERT INTO Accounts VALUES('Gastos de venta', 78000, 8);
INSERT INTO Accounts VALUES('Gastos administrativos',50000,9);
INSERT INTO Accounts VALUES('Intereses por pagar',0, 12);
INSERT INTO Accounts VALUES('IR del ejercicio', 0, 13);

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
INSERT INTO F_Act VALUES(114, 'Maquina de etiquetas', 250, 0, 3);

update Accounts set book_value=10000 where account_name='Gastos administrativos';

select * from AccountClasification
select * from AccountSubclasification
Select * from Accounts
Select * from Reg_Accounts

INSERT INTO Reg_Accounts VALUES(1,1802123.5421,1997);
INSERT INTO Reg_Accounts VALUES(2,40245.6234,1997);
INSERT INTO Reg_Accounts VALUES(3,10000.00,1997);
INSERT INTO Reg_Accounts VALUES(4,0,1997);
INSERT INTO Reg_Accounts VALUES(5,500000.00,1997);
INSERT INTO Reg_Accounts VALUES(6,-5000,1997);
INSERT INTO Reg_Accounts VALUES(7,30600.00,1997);
INSERT INTO Reg_Accounts VALUES(8,1002000.00,1997);
INSERT INTO Reg_Accounts VALUES(9,-50000,1997);
INSERT INTO Reg_Accounts VALUES(10,400600,1997);
INSERT INTO Reg_Accounts VALUES(11,120000,1997);
INSERT INTO Reg_Accounts VALUES(12,20400,1997);
INSERT INTO Reg_Accounts VALUES(13,200000,1997);
INSERT INTO Reg_Accounts VALUES(14,350600,1997);
INSERT INTO Reg_Accounts VALUES(15,304234.4623,1997);
INSERT INTO Reg_Accounts VALUES(16,25500.20,1997);
INSERT INTO Reg_Accounts VALUES(17,2180.1234,1997);
INSERT INTO Reg_Accounts VALUES(18,5000000.00,1997);
INSERT INTO Reg_Accounts VALUES(19,345000,1997);
INSERT INTO Reg_Accounts VALUES(20,345500,1997);
INSERT INTO Reg_Accounts VALUES(21,341239,1997);
INSERT INTO Reg_Accounts VALUES(22,1030234.1245,1997);
INSERT INTO Reg_Accounts VALUES(23,0,1997);
INSERT INTO Reg_Accounts VALUES(24,0,1997);
INSERT INTO Reg_Accounts VALUES(25,0,1997);
INSERT INTO Reg_Accounts VALUES(26,0,1997);
INSERT INTO Reg_Accounts VALUES(27,0,1997);
INSERT INTO Reg_Accounts VALUES(28,23400,1997);
INSERT INTO Reg_Accounts VALUES(29,5000,1997);
INSERT INTO Reg_Accounts VALUES(30,0,1997);
INSERT INTO Reg_Accounts VALUES(31,4000.7868,1997);

Update Reg_Accounts set book_value =  100000 where id_account=18
/*Sorrry me confundi en el valor de los proveedores del año anterior revisar si fue cambiado :v*/



delete from F_Act;
/*TRIGGERS*/
/*actualizacion de la cuenta de activos fijos al actualizar o insertar*/
alter TRIGGER tr_upd_ActivosFijos
on F_act
after insert, update, delete
as
	declare @deprec_lin int;
	set @deprec_lin=(SELECT SUM((book_value-disc_value)/lifespan)from F_Act);
	UPDATE Accounts SET book_value=(SELECT SUM(book_value) FROM F_Act) WHERE account_name='Activos fijos';
	UPDATE Accounts SET book_value=-@deprec_lin WHERE account_name='Depreciacion Act. Fijos';
/*
CREATE TRIGGER tr_upd_transaction
ON Transact_details
AFTER INSERT
AS
	declare @transact_id int;
	select @transact_id=id_transact from inserted;

	select change_amount into #deud from Transact_details td
	inner join Accounts a on td.id_accounts=a.id_account
	inner join AccountSubclasification asb on asb.acc_subc_id=a.clasification_code
	inner join AccountClasification ac on ac.clasification_id=asb.clasification_id 
	where id_transact=1 and ac.nat='D';

	select change_amount into #acred from Transact_details td
	inner join Accounts a on td.id_accounts=a.id_account
	inner join AccountSubclasification asb on asb.acc_subc_id=a.clasification_code
	inner join AccountClasification ac on ac.clasification_id=asb.clasification_id 
	where id_transact=1 and ac.nat='A';
	
	select sum(change_amount) from #acred;

*/
--pendiente terminar transacciones


exec sp_Balance_General
exec sp_Estado_Resultados

select * from Reg_Accounts;
select * from Accounts;
--rellenar tabla reg_accounts


select * from AccountSubclasification
/*SP's*/
CREATE PROCEDURE sp_Balance_General
AS
	exec sp_Upd_Utilidad;
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
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1)
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
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=2)
	union
	--capital
	SELECT clasification_code, account_name ,
	book_value FROM Accounts
	WHERE clasification_code=5
	union
	--total c
	SELECT 5.5, 'Total Capital',
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=3)
	union
	--total p+c
	SELECT 5.75, 'Total Pasivo+Capital',
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=3 or asb.clasification_id=2);

ALTER PROCEDURE sp_Upd_Utilidad
AS
	UPDATE Accounts set book_value=(select sum(UnitCost*UnitsInStock) from Products) where account_name='Inventario';
	--actualizacion de cuentas
	--ventas
	UPDATE Accounts set book_value=(select sum(UnitPrice*Quantity) from [Order Details] od inner join Orders o
	on od.OrderID=o.OrderID where YEAR(o.OrderDate)=1998) where account_name='Ventas totales';
	--descuento sobre venta
	UPDATE Accounts set book_value=-(select sum(UnitPrice*Quantity*Discount) from [Order Details] od inner join Orders o
	on od.OrderID=o.OrderID where YEAR(o.OrderDate)=1998) where account_name='Descuento sobre ventas';	
	--costo de venta
	UPDATE Accounts SET book_value=(select sum(od.Quantity*p.UnitCost) from [Order Details] od inner join Products p on p.ProductID=od.ProductID
	inner join Orders o
	on od.OrderID=o.OrderID where YEAR(o.OrderDate)=1998)
	WHERE account_name='Costo de venta';

	--depreciacion
	declare @deprec int;
	set @deprec=-(select book_value from Accounts where account_name='Depreciacion Act. Fijos');

	--ir
	if(((((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec))-(select sum(book_value) from Accounts 
	where clasification_code=10 or clasification_code=12))>0)
	begin
		update Accounts set book_value=((((SELECT sum(book_value)
		FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
		FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
		FROM Accounts a WHERE a.clasification_code=8 or
		a.clasification_code=9 or a.clasification_code=11)+@deprec))-(select sum(book_value) from Accounts 
		where clasification_code=10 or clasification_code=12))*0.3 where account_name='IR del ejercicio';
	end
	else
	begin
		update Accounts set book_value=0 where account_name='IR del ejercicio';
	end

	update Accounts set book_value=(select book_value from Accounts where account_name='IR del ejercicio')
	where account_name='IR por pagar';
	--utilidades
	update Accounts set book_value=(((((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec))-(select sum(book_value) from Accounts 
	where clasification_code=10 or clasification_code=12))-(select book_value from 
	Accounts where account_name='IR del ejercicio')) where account_name='Ut. Neta despues de IR';
	


CREATE PROCEDURE sp_Estado_Resultados
AS

	EXEC sp_Upd_Utilidad;
	declare @deprec int;
	set @deprec=-(select book_value from Accounts where account_name='Depreciacion Act. Fijos');
	--ingresos y descuentos
	SELECT clasification_code, account_name as [Nombre Cuenta],
	book_value as [Valor en libro]
	FROM Accounts a WHERE a.clasification_code=6
	union
	SELECT 6.5,'Ventas Netas', (SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)
	union
	--costo de venta
	SELECT clasification_code, account_name as [Nombre Cuenta],
	book_value as [Valor en libro]
	FROM Accounts a WHERE a.clasification_code=7
	union
	SELECT 7.5,'Utilidad Bruta', ((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))
	union
	--gasto de venta
	SELECT clasification_code, account_name as [Nombre Cuenta],
	book_value as [Valor en libro]
	FROM Accounts a WHERE a.clasification_code=8
	union
	--depreciacion
	SELECT 8.5, 'Depreciacion Acumulada', @deprec
	union
	--gasto de admon
	SELECT clasification_code, account_name as [Nombre Cuenta],
	book_value as [Valor en libro]
	FROM Accounts a WHERE a.clasification_code=9
	union
	--otros prods
	SELECT clasification_code, account_name as [Nombre Cuenta],
	book_value as [Valor en libro]
	FROM Accounts a WHERE a.clasification_code=11
	union
	SELECT 11.5,'Total Gastos de Operación', (SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec
	union
	SELECT 11.75,'UAII', (((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec))
	union
	--productos financieros
	SELECT 11.99, account_name as [Nombre Cuenta],
	book_value as [Valor en libro]
	FROM Accounts a WHERE a.clasification_code=10
	union
	--intereses y gastos financieros
	SELECT clasification_code, account_name as [Nombre Cuenta],
	book_value as [Valor en libro]
	FROM Accounts a WHERE a.clasification_code=12
	UNION
	SELECT 12.5, 'Total financieros', (select sum(book_value) from Accounts 
	where clasification_code=10 or clasification_code=12)
	union
	SELECT 12.75, 'UAI', ((((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec))-(select sum(book_value) from Accounts 
	where clasification_code=10 or clasification_code=12))
	union
	--impuestos
	SELECT clasification_code, account_name as [Nombre Cuenta],
	book_value as [Valor en libro]
	FROM Accounts a WHERE a.clasification_code=13
	union
	--utilidad neta
	SELECT 250, account_name, book_value FROM Accounts 
	WHERE account_name='Ut. Neta despues de IR';


select * from [Order Details];
select * from Orders where year(OrderDate)=1998;
select * from Products;

exec sp_add_vta 10808, 1, 5, 0;


ALTER PROC sp_add_vta
@ord_id int, @prod_id int, @qty int, @disc float
AS
	declare @unt_pr int, @dqty int;
	select @dqty=UnitsInStock from Products where ProductID=@prod_id;
	set @unt_pr=(select UnitPrice from Products where ProductID=@prod_id);
	if(@qty>@dqty)
	begin
		SELECT 'ERROR: CANTIDAD SUPERIOR A LO DISPONIBLE';
	end
	else
	begin	
		INSERT INTO [Order Details] values(@ord_id, @prod_id, @unt_pr, @qty, @disc);
		SELECT 'VENTA AGREGADA CON EXITO';
	end
exec sp_showOrders
exec sp_showProducts



CREATE TRIGGER tr_add_vta
ON [Order Details]
AFTER INSERT
AS
	declare @amount float
	--actualizacion de banco
	select @amount=((UnitPrice*Quantity)-(UnitPrice*Quantity*Discount)) from inserted;
	UPDATE Accounts set book_value=book_value+@amount*1.15 where account_name='Banco';
	update Accounts set book_value=book_value+@amount*0.15 where account_name='IVA por pagar';
	--sacando de inventario
	declare @qty int, @prod_id int
	select @prod_id=ProductID, @qty=Quantity from inserted;
	update Products set UnitsInStock=UnitsInStock-@qty where ProductID=@prod_id;

