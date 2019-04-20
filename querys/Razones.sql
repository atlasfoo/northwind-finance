	
	Create procedure  SP_capital_trabajo
	as
	Select (select sum(book_value) from Accounts where clasification_code=1) - (select sum(book_value) 
	from Accounts where clasification_code=3) 
	
	Create procedure SP_razon_circulante
	as
	Select (select sum(book_value) from Accounts where clasification_code=1) / (select sum(book_value) 
	from Accounts where clasification_code=3) 
	
	Create procedure  SP_razon_rapida
	as
	Select ((select sum(book_value) from Accounts where clasification_code=1) - (select book_value from Accounts where id_account = 4))  
	/ (select sum(book_value) 
	from Accounts where clasification_code=3)
	
	exec SP_rotacion_de_inventario
	Create procedure  SP_rotacion_de_inventario
	as
	Select (select sum(book_value) from Accounts where  id_account = 27) / 
	(select book_value from Accounts where id_account = 4) 
	
	Create procedure  SP_rotacion_inventario_meses
	as
	Select (12 / ((select sum(book_value) from Accounts where id_account = 27) / 
	(select book_value from Accounts where id_account = 4))) 
	
	Create procedure  SP_rotacion_inventario_dia
	as
	Select (360 / ((select sum(book_value) from Accounts where id_account = 27) / 
	(select book_value from Accounts where id_account = 4))) 
	
	Create procedure  SP_rotacion_cuentas_por_cobrar
	as
	Select (select sum(book_value) 
	from Accounts where clasification_code=6) /   
	(select book_value from Accounts where id_account = 5)
	
	Create procedure  SP_periodo_promedio_cobro
	as
	Select (select book_value from Accounts where id_account = 5) / (360/(select sum(book_value) 
	from Accounts where clasification_code=6))
	
	Create procedure  SP_rotacion_activo_fijo
	as
	Select (select sum(book_value) 
	from Accounts where clasification_code=6) /
	((select book_value from Accounts where id_account = 8)-(select book_value from Accounts where id_account = 8))--esta resta es por la depreciacion
	
	Create procedure  SP_rotacion_activos_totales
	as
	Select (select sum(book_value) 
	from Accounts where clasification_code=6) /(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1) 
	
	Create procedure  SP_deuda_total
	as
	Select (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=2) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1) 
	
	Create procedure  SP_capacidad_pago_interes
	as
	declare @deprec int;
	set @deprec=-(select book_value from Accounts where account_name='Depreciacion Act. Fijos')
	Select (((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=6)-(SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=7))-((SELECT sum(book_value)
	FROM Accounts a WHERE a.clasification_code=8 or
	a.clasification_code=9 or a.clasification_code=11)+@deprec)) / (select book_value from Accounts where id_account = 12)
	
	Create procedure  SP_razon_pasivo_capit
	as
	Select (select sum(book_value) from Accounts where clasification_code=4) / 
	(select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=3) 
	
	Create procedure  SP_margen_utilidad_bruta
	as
	Select ((select sum(book_value) 
	from Accounts where clasification_code=6) -( select book_value from Accounts where id_account = 27)) / (select sum(book_value) 
	from Accounts where clasification_code=6) 


	Create procedure  SP_margen_utilidad_neta
	as
	Select (select book_value from Accounts where id_account = 24) / (select sum(book_value) 
	from Accounts where clasification_code=6) 

	Create procedure  SP_rendimiento_activo
	as
	Select (select book_value from Accounts where id_account = 24) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=1)
	

	Create procedure  SP_rendimiento_sobre_capital
	as
	Select (select book_value from Accounts where id_account = 24) / (select sum(book_value) from Accounts a inner join AccountSubclasification asb on 
	a.clasification_code=asb.acc_subc_id where asb.clasification_id=3) 
