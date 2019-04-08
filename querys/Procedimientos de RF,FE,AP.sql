
Select * from Accounts
Select * from AccountSubclasification
Select * from AccountClasification


	/*--------------CREACION DE RAZONES FINANCIERAS----------------*/

	create procedure SP_razon_Capital_trabajo
	as
	Select (select sum(book_value) from Accounts where clasification_code=1) + (select sum(book_value) 
	from Accounts where clasification_code=3) as [Capital de trabajo]

	Create procedure SP_razon_circulante
	as
	Select (select sum(book_value) from Accounts where clasification_code=1) / (select sum(book_value) 
	from Accounts where clasification_code=3) as [Razon Circulante]

	Create procedure SP_razon_rapida
	as
	Select ((select sum(book_value) from Accounts where clasification_code=1) - (select book_value from Accounts where id_account = 4))  
	/ (select sum(book_value) 
	from Accounts where clasification_code=3) as [Razon Rapida]

	Create procedure SP_rotacion_inventario
	as
	Select (select sum(book_value) from Accounts where  id_account = 27) / 
	(select book_value from Accounts where id_account = 4) as [Rotacion de inventario]
	
	Create procedure SP_rotacion_inventario_mes
	as
	Select (12 / ((select sum(book_value) from Accounts where id_account = 27) / 
	(select book_value from Accounts where id_account = 4))) as [Rotacion de inventario en meses]

	Create procedure SP_rotacion_inventario_dias
	as
	Select (360 / ((select sum(book_value) from Accounts whereid_account = 27) / 
	(select book_value from Accounts where id_account = 4))) as [Rotacion de inventario en dia]

	Create procedure SP_rotacion_de_cuentas_por_cobrar
	as
	Select  (select sum(book_value) 
	from Accounts where clasification_code=6) /   
	(select book_value from Accounts where id_account = 5) AS [Rotacion de cuentas por cobrar]

	Create procedure SP_promedio_de_cobro
	as
	Select (select book_value from Accounts where id_account = 5) / (360/(select sum(book_value) 
	from Accounts where clasification_code=6))
	as [Periodo promedio de cobro]
	
	Create procedure SP_rotacion_activo_fijo
	as
	Select (select sum(book_value) 
	from Accounts where clasification_code=6) /
	 ((select book_value from Accounts where id_account = 8)-(select book_value from Accounts where id_account = 8))--esta resta es por la depreciacion
	 as [Rotacion de activo fijo]

	Create procedure SP_rotacion_activo_totales
	as
	Select (select sum(book_value) 
	from Accounts where clasification_code=6) /(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1) AS [Rotacion de activos totales]
	 
	Create procedure SP_razon_deuda_total
	as
	Select (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=2) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1) as [Razon de deuda total]

	Create procedure SP_capacidad_pago_interes
	as
	declare @deprec int;
	set @deprec=-(select book_value from Accounts where account_name='Depreciacion Act. Fijos');
	Select (((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec)) / (select book_value from Accounts where id_account = 12)
	as [Capacidad de pago de intereses]

	Create procedure SP_razon_pasivo_capital
	as
	Select (select sum(book_value) from Accounts where clasification_code=4) / 
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=3) 
	as [Razon de pasivo a capital]

	Create procedure SP_Margen_utilidad_bruta
	as
	Select ((select sum(book_value) 
	from Accounts where clasification_code=6) -( select book_value from Accounts where id_account = 27)) / (select sum(book_value) 
	from Accounts where clasification_code=6) as [Margen de utilidad bruta]

	Create procedure SP_margen_utilidad_operativa
	as
	Select (select book_value from Accounts where id_account = 24) / (select sum(book_value) 
	from Accounts where clasification_code=6) as [Margen de utilidad operativa]

	Create procedure SP_margen_utilidad_neta
	as
	Select (select book_value from Accounts where id_account = 24) / (select sum(book_value) 
	from Accounts where clasification_code=6) as [Margen de utilidad neta]

	Create procedure SP_rendimiento_de_los_activos
	as
	Select (select book_value from Accounts where id_account = 24) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1) as [Rendimiento de los activos]

	Create procedure SP_rendimiento_sobre_capital
	as
	Select (select book_value from Accounts where id_account = 24) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=3)



	/*----------------CREACION DEL ESTADO DE FLUJO DE EFECTIVO-------------------------*/

	Select * from Accounts

	Create table #Flujo_neto_efectivo