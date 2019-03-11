--restaurar bd luego de hacer git pull para obtener los ultimos cambios
restore filelistonly from disk='ruta';
restore database NorthwindCO from disk='ruta'
with move 'archivo mdf' to 'ruta_mdf',
move 'archivo ldf' to 'ruta ldf',
replace;

--por favor añadir nombre y descripcion al hacer respaldo luego de modificar la bd
backup database NorthwindCO
to disk='D:\Repos\Visual Studio Source\northwind-finance\restore_me.bak'
with name='Inicial',
description='Respaldo incial limpio';