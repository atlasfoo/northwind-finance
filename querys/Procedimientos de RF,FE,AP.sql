
select * from Reg_Accounts
Select * from Accounts
Select * from AccountSubclasification
Select * from AccountClasification
Select * from Transactions
Select a.id_account,ra.id_reg, a.account_name, ra.book_value from Reg_Accounts ra inner join Accounts a on a.id_account=ra.id_account
where a.clasification_code<=5;
exec sp_Balance_General
--regaccounts population
update Reg_Accounts set book_value=(select sum(od.Quantity*od.UnitPrice) from [Order Details] od inner join Orders o
on od.OrderID=o.OrderID where YEAR(o.OrderDate)=1997) where id_reg=25;
update Reg_Accounts set book_value=(select sum(od.Quantity*od.UnitPrice*od.Discount) from [Order Details] od inner join Orders o
on od.OrderID=o.OrderID where YEAR(o.OrderDate)=1997) where id_reg=26;
update Reg_Accounts set book_value=(select sum(od.Quantity*p.UnitCost) from [Order Details] od inner join Orders o
on od.OrderID=o.OrderID inner join Products p on p.ProductID=od.ProductID where YEAR(o.OrderDate)=1997) where id_reg=27;
update Reg_Accounts set book_value=61674.62607 where id_reg=31;
update Reg_Accounts set book_value=143907.4608 where id_reg=24;
update Reg_Accounts set book_value=50000 where id_account=4 and yr=1997;
update Reg_Accounts set book_value=61674.6261 where id_reg=17;
update Reg_Accounts set book_value=725000 where id_reg=18;
update Reg_Accounts set book_value=700000 where id_reg=20;
update Reg_Accounts set book_value=434818.2918 where id_reg=21;
--balance del año anterior cuadrado



	/*--------------CREACION DE RAZONES FINANCIERAS----------------*/

	create procedure sp_Razones_financieras_del_añoactual
	as
	declare @deprec int;
	set @deprec=-(select book_value from Accounts where account_name='Depreciacion Act. Fijos');

	Select 'Capital de trabajo' as [Razones Financieras],(select sum(book_value) from Accounts where clasification_code=1) - (select sum(book_value) 
	from Accounts where clasification_code=3)  as [CALCULO]
	union
	Select 'Razon Circulante',(select sum(book_value) from Accounts where clasification_code=1) / (select sum(book_value) 
	from Accounts where clasification_code=3) 
	union
	Select 'Razon Rapida',((select sum(book_value) from Accounts where clasification_code=1) - (select book_value from Accounts where id_account = 4))  
	/ (select sum(book_value) 
	from Accounts where clasification_code=3)
	union
	Select 'Rotacion de inventario',(select sum(book_value) from Accounts where  id_account = 27) / 
	(select book_value from Accounts where id_account = 4) 
	union
	Select 'Rotacion de inventario en meses',(12 / ((select sum(book_value) from Accounts where id_account = 27) / 
	(select book_value from Accounts where id_account = 4))) 
	union
	Select 'Rotacion de inventario en dia',(360 / ((select sum(book_value) from Accounts where id_account = 27) / 
	(select book_value from Accounts where id_account = 4))) 
	union
	Select  'Rotacion de cuentas por cobrar',(select sum(book_value) 
	from Accounts where clasification_code=6) /   
	(select book_value from Accounts where id_account = 5)
	union
	Select 'Periodo promedio de cobro',(select book_value from Accounts where id_account = 5) / (360/(select sum(book_value) 
	from Accounts where clasification_code=6))
	union
	Select 'Rotacion de activo fijo',(select sum(book_value) 
	from Accounts where clasification_code=6) /
	((select book_value from Accounts where id_account = 8)-(select book_value from Accounts where id_account = 8))--esta resta es por la depreciacion
	union
	Select 'Rotacion de activos totales',(select sum(book_value) 
	from Accounts where clasification_code=6) /(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1) 
	union
	Select 'Razon de deuda total',(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=2) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1) 
	union
	Select 'Capacidad de pago de intereses',(((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec)) / (select book_value from Accounts where id_account = 12)
	union
	Select 'Razon de pasivo a capital',(select sum(book_value) from Accounts where clasification_code=4) / 
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=3) 
	union
	Select 'Margen de utilidad bruta',((select sum(book_value) 
	from Accounts where clasification_code=6) -( select book_value from Accounts where id_account = 27)) / (select sum(book_value) 
	from Accounts where clasification_code=6) 
	union
	Select 'Margen de utilidad operativa',(select book_value from Accounts where id_account = 24) / (select sum(book_value) 
	from Accounts where clasification_code=6) 
	union
	Select 'Margen de utilidad neta',(select book_value from Accounts where id_account = 24) / (select sum(book_value) 
	from Accounts where clasification_code=6) 
	union
	Select 'Rendimiento de los activos',(select book_value from Accounts where id_account = 24) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1)
	union
	Select 'Rendimiento sobre el Capital',(select book_value from Accounts where id_account = 24) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=3)

	---Razones financieras del año anterior

	Select * from Accounts

	create procedure sp_razones_del_añoAnterior
	as
	Select 'Capital de trabajo' as [Razones Financieras],(select sum(book_value) from Reg_Accounts where id_account = 1 and id_account = 2 and id_account = 3 and id_account = 4 and id_account = 5 and id_account = 6 and id_account = 7) - 
	(select sum(book_value) 
	from Reg_Accounts where id_account =14 and id_account = 15 and id_account = 16 and id_account =18 and id_account =19) as [CALCULO]
	union
	Select 'Razon Circulante',(select sum(book_value) from Reg_Accounts where id_account = 1 and id_account = 2 and id_account = 3 and id_account = 4 and id_account = 5 and id_account = 6 and id_account = 7) / 
	(select sum(book_value) 
	from Reg_Accounts where id_account =14 and id_account = 15 and id_account = 16 and id_account =18 and id_account =19) 
	union
	Select 'Razon Rapida',((select sum(book_value) from Reg_Accounts where id_account = 1 and id_account = 2 and id_account = 3 and id_account = 4 and id_account = 5 and id_account = 6 and id_account = 7)
	 - (select book_value from Reg_Accounts where id_account = 4))  
	/ (select sum(book_value) 
	from Reg_Accounts where id_account =14 and id_account = 15 and id_account = 16 and id_account =18 and id_account =19) 
	union
	Select 'Rotacion de inventario',(select sum(book_value) from Reg_Accounts where  id_account = 27) / 
	(select book_value from Reg_Accounts where id_account = 4) 
	union
	Select 'Rotacion de inventario en meses',(12 / ((select sum(book_value) from Reg_Accounts where id_account = 27) / 
	(select book_value from Reg_Accounts where id_account = 4))) 
	union
	Select 'Rotacion de inventario en dia',(360 / ((select sum(book_value) from Accounts where id_account = 27) / 
	(select book_value from Accounts where id_account = 4))) 
	union
	Select 'Rotacion de cuentas por cobrar',(select sum(book_value) 
	from Reg_Accounts where id_account = 25 and id_account = 26) /   
	(select book_value from Reg_Accounts where id_account = 5) 
	union
	Select 'Periodo promedio de cobro',(select book_value from Reg_Accounts where id_account = 5) / (360/(select sum(book_value) 
	from Reg_Accounts where id_account = 25 and id_account = 26))
	union
	Select 'Rotacion de activo fijo',(select sum(book_value) 
	from Reg_Accounts where id_account = 25 and id_account = 26) /
	 ((select book_value from Reg_Accounts where id_account = 8)-(select book_value from Reg_Accounts where id_account = 8))--esta resta es por la depreciacion
	union
	Select 'Rotacion de activos totales',(select sum(book_value) 
	from Reg_Accounts where id_account = 25 and id_account = 26) /(select sum(book_value) from Reg_Accounts where id_account = 1 and 
	id_account =  2 and id_account =3 and id_account = 4 and id_account = 5 and id_account = 6 and id_account = 7 and id_account = 8 
	and id_account = 9 and id_account = 10 and id_account = 11 and id_account = 12 and id_account = 13 )
	union
	Select 'Razon de deuda total',(select sum(book_value) from Reg_Accounts where id_account = 14 and 
	id_account =  15 and id_account =16 and id_account = 17 and id_account = 18 and id_account = 19 and id_account = 20 and id_account = 21 )
	/ (select sum(book_value) from Reg_Accounts where id_account = 1 and 
	id_account =  2 and id_account =3 and id_account = 4 and id_account = 5 and id_account = 6 and id_account = 7 and id_account = 8 
	and id_account = 9 and id_account = 10 and id_account = 11 and id_account = 12 and id_account = 13 ) 
	union
	Select 'Capacidad de pago de intereses',(((Select sum(book_value) from Reg_Accounts where id_account = 25 and id_account=26)-
	(Select sum(book_value) from Reg_Accounts where id_account=27))-
	(Select sum(book_value) from Reg_Accounts where id_account = 28 or id_account = 29)) / (select book_value from Reg_Accounts where id_account = 12)
	union
	Select 'Razon de pasivo a capital',(Select sum(book_value) from Reg_Accounts where id_account = 20 and id_account = 21) / 
	(Select sum(book_value) from Reg_Accounts where id_account = 22 and id_account = 23 and id_account = 24) 
	union
	Select 'Margen de utilidad bruta',((select sum(book_value) 
	from Reg_Accounts where id_account = 25 and id_account= 26) -( select book_value from Reg_Accounts where id_account = 27)) / (select sum(book_value) 
	from Reg_Accounts where id_account = 25 and id_account= 26) 
	union
	Select 'Margen de utilidad operativa',(select book_value from Reg_Accounts where id_account = 24) / (select sum(book_value) 
	from Reg_Accounts where id_account = 25 and id_account= 26)
	union
	Select 'Margen de utilidad neta',(select book_value from Reg_Accounts where id_account = 24) / (select sum(book_value) 
	from Accounts where id_account = 25 and id_account= 26) 
	union
	Select 'Rendimiento de los activos',(select book_value from Reg_Accounts where id_account = 24) /  (select sum(book_value) from Reg_Accounts where id_account = 1 and 
	id_account =  2 and id_account =3 and id_account = 4 and id_account = 5 and id_account = 6 and id_account = 7 and id_account = 8 
	and id_account = 9 and id_account = 10 and id_account = 11 and id_account = 12 and id_account = 13 ) 
	union
	Select 'Rendimiento sobre el Capital',(select book_value from Reg_Accounts where id_account = 24) / (Select sum(book_value) from Reg_Accounts where id_account = 22 
	and id_account = 23 and id_account = 24)  



	/*----------------CREACION DEL ESTADO DE FLUJO DE EFECTIVO-------------------------*/
	Select * from Reg_Accounts
	Select * from Accounts
/*
Create procedure sp_fne
as
	Select 1,'Banco' as Cuentas,(select a.book_value from Accounts a
	inner join Reg_Accounts r
	on r.id_account = a.id_account where a.id_account = 1 and clasification_code = 1) as [Año Actual],(Select book_value from Reg_Accounts where id_account = 1) as [Año Anterior],((select a.book_value from Accounts a
	inner join Reg_Accounts r
	on r.id_account = a.id_account where a.id_account = 1 and clasification_code = 1)-(Select book_value from Reg_Accounts where id_account = 1)) as [Variacion]
	union
	Select 2,'Caja',(Select book_value from Accounts where id_account = 2),(Select book_value from Reg_Accounts where id_account = 2),((Select book_value from Accounts where id_account = 2)-(Select book_value from Reg_Accounts where id_account = 2))
	union
	Select 3,'Clientes',(Select book_value from Accounts where id_account = 5),(Select book_value from Reg_Accounts where id_account = 5),((Select book_value from Accounts where id_account = 5)-(Select book_value from Reg_Accounts where id_account = 5))
	union
	Select 4,'Documento por cobrar',(Select book_value from Accounts where id_account = 7),(Select book_value from Reg_Accounts where id_account = 7),((Select book_value from Accounts where id_account = 7)-(Select book_value from Reg_Accounts where id_account = 7))
	union
	Select 5,'Est.de Cuentas incobrales',(Select book_value from Accounts where id_account = 6),(Select book_value from Reg_Accounts where id_account = 6),((Select book_value from Accounts where id_account = 6)-(Select book_value from Reg_Accounts where id_account = 6))
	union
	Select 6,'Fondo de oportunidad',(Select book_value from Accounts where id_account = 3),(Select book_value from Reg_Accounts where id_account = 3),((Select book_value from Accounts where id_account = 3)-(Select book_value from Reg_Accounts where id_account = 3))
	union
	Select 7,'Inventario',(Select book_value from Accounts where id_account = 4),(Select book_value from Reg_Accounts where id_account = 4),((Select book_value from Accounts where id_account = 4)-(Select book_value from Reg_Accounts where id_account = 4))
	union
	Select 8,'Activos fijos',(Select book_value from Accounts where id_account = 8),(Select book_value from Reg_Accounts where id_account = 8),((Select book_value from Accounts where id_account = 8)-(Select book_value from Reg_Accounts where id_account = 8))
	union
	Select 9,'Depreciacion act.fijo',(Select book_value from Accounts where id_account = 9),(Select book_value from Reg_Accounts where id_account = 9),((Select book_value from Accounts where id_account = 9)-(Select book_value from Reg_Accounts where id_account = 9))
	union
	Select 10,'Gastos de instalacion',(Select book_value from Accounts where id_account = 13),(Select book_value from Reg_Accounts where id_account = 13),((Select book_value from Accounts where id_account = 13)-(Select book_value from Reg_Accounts where id_account = 13))
	union
	Select 11,'Marcas Registrada',(Select book_value from Accounts where id_account = 11),(Select book_value from Reg_Accounts where id_account = 11),((Select book_value from Accounts where id_account = 11)-(Select book_value from Reg_Accounts where id_account = 11))
	union
	Select 12,'Patentes',(Select book_value from Accounts where id_account = 12),(Select book_value from Reg_Accounts where id_account = 12),((Select book_value from Accounts where id_account = 12)-(Select book_value from Reg_Accounts where id_account = 12))
	union
	Select 13,'Terreno',(Select book_value from Accounts where id_account = 10),(Select book_value from Reg_Accounts where id_account = 10),((Select book_value from Accounts where id_account = 10)-(Select book_value from Reg_Accounts where id_account = 10))
	union
	Select 14,'Acreedores',(Select book_value from Accounts where id_account = 14),(Select book_value from Reg_Accounts where id_account = 14),((Select book_value from Accounts where id_account = 14)-(Select book_value from Reg_Accounts where id_account = 14))
	union
	Select 15,'Hipotecas a C/P',(Select book_value from Accounts where id_account = 19),(Select book_value from Reg_Accounts where id_account = 19),((Select book_value from Accounts where id_account = 19)-(Select book_value from Reg_Accounts where id_account = 19))
	union
	Select 16,'IR por pagar',(Select book_value from Accounts where id_account = 17),(Select book_value from Reg_Accounts where id_account = 17),((Select book_value from Accounts where id_account = 17)-(Select book_value from Reg_Accounts where id_account = 17))
	union
	Select 17,'IVA por pagar',(Select book_value from Accounts where id_account = 16),(Select book_value from Reg_Accounts where id_account = 16),((Select book_value from Accounts where id_account = 16)-(Select book_value from Reg_Accounts where id_account = 16))
	union
	Select 18,'Prestamo a C/P',(Select book_value from Accounts where id_account = 15),(Select book_value from Reg_Accounts where id_account = 15),((Select book_value from Accounts where id_account = 15)-(Select book_value from Reg_Accounts where id_account = 15))
	union
	Select 19,'Proveedores',(Select book_value from Accounts where id_account = 18),(Select book_value from Reg_Accounts where id_account = 18),((Select book_value from Accounts where id_account = 18)-(Select book_value from Reg_Accounts where id_account = 18))
	union
	Select 20,'Hipotecas a L/P',(Select book_value from Accounts where id_account = 21),(Select book_value from Reg_Accounts where id_account = 21),((Select book_value from Accounts where id_account = 21)-(Select book_value from Reg_Accounts where id_account = 21))
	union
	Select 21,'Prestamos a L/P',(Select book_value from Accounts where id_account = 20),(Select book_value from Reg_Accounts where id_account = 20),((Select book_value from Accounts where id_account = 20)-(Select book_value from Reg_Accounts where id_account = 20))
	union
	Select 22,'Capital Social',(Select book_value from Accounts where id_account = 22),(Select book_value from Reg_Accounts where id_account = 22),((Select book_value from Accounts where id_account = 22)-(Select book_value from Reg_Accounts where id_account = 22))
	union
	Select 23,'Ut.Neta de IR',(Select book_value from Accounts where id_account = 24),(Select book_value from Reg_Accounts where id_account = 24),((Select book_value from Accounts where id_account = 24)-(Select book_value from Reg_Accounts where id_account = 24))
	union
	Select 24,'Utilidades Acumuladas',(Select book_value from Accounts where id_account = 23),(Select book_value from Reg_Accounts where id_account = 23),((Select book_value from Accounts where id_account = 23)-(Select book_value from Reg_Accounts where id_account = 23))
	
	Select * from Accounts
	Select * from AccountSubclasification
	Select * from AccountClasification
*/	
	
CREATE FUNCTION fn_checkif_orap(@id_acc int, @var money, @ck char)
RETURNS MONEY
AS BEGIN
	declare @nat char;
	--obteniendo la naturaleza de la cuenta
	SELECT @nat=ac.nat FROM Accounts a INNER JOIN
	AccountSubclasification asb ON asb.acc_subc_id=a.clasification_code
	INNER JOIN AccountClasification ac ON asb.clasification_id=ac.clasification_id
	WHERE a.id_account=@id_acc;
	--caso cuenta deudora
	if(@nat='D')
	BEGIN
		--deudora origen
		if(@ck='O')
		BEGIN
			--si la variacion es neg, entonces si es un origen
			if(@var<=0)
			BEGIN
				RETURN ABS(@var);
			END
			--si no, no lo es, return 0
			ELSE
			BEGIN
				RETURN 0;
			END
		END
		--caso deudor aplicacion 
		if(@ck='A')
		BEGIN
			--si la variacion es neg, entonces no es una aplicacion
			if(@var<=0)
			BEGIN
				RETURN 0;
			END
			--si no, no lo es, return 0
			ELSE
			BEGIN
				RETURN ABS(@var);
			END
		END
	END
	--cuenta acreedora
	if(@nat='A')
	BEGIN
		--acreedora origen
		if(@ck='O')
		BEGIN
			--si la variacion es neg, entonces no es un origen
			if(@var<=0)
			BEGIN
				RETURN 0;
			END
			--si es positiva, si es origen
			ELSE
			BEGIN
				RETURN ABS(@var);
			END
		END
		--caso acreedor aplicacion
		ELSE if(@ck='A')
		BEGIN
			--si la variacion es neg, entonces es una aplicacion
			if(@var<=0)
			BEGIN
				RETURN ABS(@var);
			END
			--si no, es aplicacion, return 0
			ELSE
			BEGIN
				RETURN 0;
			END
		END
	END
	--en caso de error
	RETURN -1
	END

	/*----------------------------------------------------------APALANCAMIENTO--------------------------------------------------------------*/
	exec sp_Apalancamiento 1200
	exec sp_Estado_Resultados
	select book_value from Reg_Accounts where id_account=25
	--Depreciacion del año actual

alter procedure sp_Apalancamiento
@No_acciones int
as
	declare @deprec int;
	set @deprec=-(select book_value from Accounts where account_name='Depreciacion Act. Fijos');
	
	Select'APALANCAMIENTO OPERATIVO',(Select (Select (((SELECT book_value FROM Accounts a WHERE a.id_account=25))
	- (Select book_value from Reg_Accounts where id_account = 25)) / (Select book_value from Reg_Accounts where id_account = 25)) 
	/
	(Select (Select (((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec))
	-
	(Select (((Select sum(book_value) from Reg_Accounts where id_account = 25 or id_account=26)-
	(Select sum(book_value) from Reg_Accounts where id_account=27))-
	(Select sum(book_value) from Reg_Accounts where id_account = 28 or id_account = 29)))
	/
	(Select(((Select sum(book_value) from Reg_Accounts where id_account = 25 or id_account=26)-
	(Select sum(book_value) from Reg_Accounts where id_account=27))-
	(Select sum(book_value) from Reg_Accounts where id_account = 28 or id_account = 29))))))

	SELECT 'APALANCAMIENTO FINANCIERO',(((((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec))-(select sum(book_value) from Accounts 
	where clasification_code=10 or clasification_code=12))-@No_acciones) / @No_acciones

	Select 'APALANCAMIENTO TOTAL',(SELECT (((((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec))-(select sum(book_value) from Accounts 
	where clasification_code=10 or clasification_code=12))-@No_acciones) / @No_acciones)
	+
	(Select (Select (Select (((SELECT sum(book_value) FROM Accounts a WHERE a.clasification_code=6))
	- (Select book_value from Reg_Accounts where id_account = 25)) / (Select book_value from Reg_Accounts where id_account = 25)) 
	/
	(Select (Select (((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec))
	-
	(Select (((Select sum(book_value) from Reg_Accounts where id_account = 25 or id_account=26)-
	(Select sum(book_value) from Reg_Accounts where id_account=27))-
	(Select sum(book_value) from Reg_Accounts where id_account = 28 or id_account = 29)))
	/
	(Select(((Select sum(book_value) from Reg_Accounts where id_account = 25 or id_account=26)-
	(Select sum(book_value) from Reg_Accounts where id_account=27))-
	(Select sum(book_value) from Reg_Accounts where id_account = 28 or id_account = 29)))))))


