USE NorthwindCO
GO
--alteraciones de la tabla accountssc
ALTER TABLE AccountSubclasification
add fe_clasif VARCHAR(20);
SELECT * FROM AccountSubclasification
UPDATE AccountSubclasification set fe_clasif='OPERATIVO' where acc_subc_id in(1,3)
UPDATE AccountSubclasification set fe_clasif='INVERSION' where acc_subc_id=2;
UPDATE AccountSubclasification set fe_clasif='FINANCIAMIENTO' where acc_subc_id in(4,5);
UPDATE AccountSubclasification set fe_clasif='N/A' where acc_subc_id>5;

/*se puede usar la misma funcion validadora para origen y aplicacion y flujo de efectivo, suponiendo
que la entrada es origen y la salida es una aplicacion*/

CREATE FUNCTION fn_checkfe_totals(@var money, @oper char)
RETURNS money
AS BEGIN
	IF(@oper='E')
	BEGIN
		IF(@var<=0)
		BEGIN
			RETURN 0
		END
		ELSE
		BEGIN
			RETURN ABS(@var)
		END
	END
	ELSE IF(@oper='S')
	BEGIN
	IF(@var<=0)
		BEGIN
			RETURN ABS(@var)
		END
		ELSE
		BEGIN
			RETURN 0
		END
	END
	RETURN -1
	END



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

CREATE PROCEDURE sp_origen_aplicacion
AS
	SELECT a.id_account, a.account_name as [Nombre Cuenta],
	a.book_value as [Año Actual],
	ra.book_value as [Año Anterior],
	(a.book_value-ra.book_value) as [Variación],
	dbo.fn_checkif_orap(a.id_account,(a.book_value-ra.book_value), 'O') as Origen, 
	dbo.fn_checkif_orap(a.id_account,(a.book_value-ra.book_value), 'A') as Aplicación 
	FROM Accounts a INNER JOIN Reg_Accounts ra on a.id_account=ra.id_account
	WHERE a.clasification_code<=5
	UNION
	SELECT 115201,'Totales', 0, 0, 0, 
	sum(dbo.fn_checkif_orap(a.id_account,(a.book_value-ra.book_value), 'O')),
	sum(dbo.fn_checkif_orap(a.id_account,(a.book_value-ra.book_value), 'A'))
	FROM Accounts a INNER JOIN Reg_Accounts ra on a.id_account=ra.id_account
	WHERE a.clasification_code<=5
	order by id_account;

select * from Accounts

CREATE PROCEDURE sp_Flujo_Efectivo
as
	SELECT 0,'Retorno de depreciacion y cuentas incobrables' as [Nombre cuenta],
	null as Entrada, null as Salida
	UNION
	SELECT 0.25,a.account_name, ABS(a.book_value), 0 from Accounts a
	WHERE a.id_account in (6,9,24)
	UNION
	SELECT 0.5,'Actividades de operación' as [Nombre cuenta],
	null as Entrada, null as Salida
	UNION
	SELECT 1.0,a.account_name as [Nombre Cuenta],
	dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'O') as Entrada,
	dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'A') as Salida
	FROM Accounts a INNER JOIN Reg_Accounts ra ON a.id_account=ra.id_account
	INNER JOIN AccountSubclasification subc ON subc.acc_subc_id=a.clasification_code
	WHERE subc.fe_clasif='OPERATIVO' and a.id_account not in(1,2,6)
	UNION
	SELECT 1.5,'Actividades de Inversión' as [Nombre cuenta],
	null as Entrada, null as Salida
	UNION
	SELECT 2,a.account_name as [Nombre Cuenta],
	dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'O') as Entrada,
	dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'A') as Salida
	FROM Accounts a INNER JOIN Reg_Accounts ra ON a.id_account=ra.id_account
	INNER JOIN AccountSubclasification subc ON subc.acc_subc_id=a.clasification_code
	WHERE subc.fe_clasif='INVERSION' and a.id_account not in(9)
	UNION
	SELECT 2.5,'Actividades de Financiamieto' as [Nombre cuenta],
	null as Entrada, null as Salida
	UNION
	SELECT 3,a.account_name as [Nombre Cuenta],
	dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'O') as Entrada,
	dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'A') as Salida
	FROM Accounts a INNER JOIN Reg_Accounts ra ON a.id_account=ra.id_account
	INNER JOIN AccountSubclasification subc ON subc.acc_subc_id=a.clasification_code
	WHERE subc.fe_clasif='FINANCIAMIENTO' and a.id_account not in(24)
	UNION
	SELECT 4,'TOTALES', (sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'O'))
	+
	(SELECT SUM(ABS(a.book_value))from Accounts a
	WHERE a.id_account in (6,9,24))) 
	as Entrada,
	sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'A')) as Salida
	FROM Accounts a INNER JOIN Reg_Accounts ra ON a.id_account=ra.id_account
	INNER JOIN AccountSubclasification subc ON subc.acc_subc_id=a.clasification_code
	WHERE subc.fe_clasif in('OPERATIVO', 'INVERSION', 'FINANCIAMIENTO') and a.id_account not in(1,2,6,9,24)
	UNION
	SELECT 5,'FLUJO TOTAL DE ACTIVIDAD',
	dbo.fn_checkfe_totals(((sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'O'))
	+
	(SELECT SUM(ABS(a.book_value))from Accounts a
	WHERE a.id_account in (6,9,24))) - 
	sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'A'))),'E'),

	dbo.fn_checkfe_totals(((sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'O'))
	+
	(SELECT SUM(ABS(a.book_value))from Accounts a
	WHERE a.id_account in (6,9,24))) - 
	sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'A'))),'S')
	FROM Accounts a INNER JOIN Reg_Accounts ra ON ra.id_account=a.id_account
	UNION
	SELECT 5.5,'Disponible del periodo actual' as [Nombre cuenta],
	null as Entrada, null as Salida
	UNION
	SELECT 6, a.account_name, a.book_value, 0 
	from Accounts a where a.id_account in (1,2)
	UNION
	SELECT 7,'Total Efectivo Final',
	dbo.fn_checkfe_totals((((sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'O'))
	+
	(SELECT SUM(ABS(a.book_value))from Accounts a
	WHERE a.id_account in (6,9,24))) - 
	sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'A')))
	+
	(SELECT sum(a.book_value) 
	from Accounts a where a.id_account in (1,2))),'E'),
	dbo.fn_checkfe_totals((((sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'O'))
	+
	(SELECT SUM(ABS(a.book_value))from Accounts a
	WHERE a.id_account in (6,9,24))) - 
	sum(dbo.fn_checkif_orap(a.id_account, (a.book_value-ra.book_value), 'A')))
	+
	(SELECT sum(a.book_value) 
	from Accounts a where a.id_account in (1,2))),'S')
	FROM Accounts a INNER JOIN Reg_Accounts ra ON ra.id_account=a.id_account;
