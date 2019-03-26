--restaurar bd luego de hacer git pull para obtener los cambios mas recientes
restore headeronly from disk='ruta';
restore filelistonly from disk='ruta';
restore database NorthwindCO from disk='ruta'
with move 'archivo mdf' to 'ruta_mdf',
move 'archivo ldf' to 'ruta ldf',
replace;

--por favor añadir nombre y descripcion al hacer respaldo luego de modificar la bd
backup database NorthwindCO
to disk='ruta'
with name='nombre',
description='descripcion';

--añadir otro tipo de transacciones a este log, fecha|github_username|descripcion
/*LOG*/
/*26-03-19 | thefoo547 |  He tenido que deshacer los cambios correspondientes al ultimo cambio al modelo en el backup
pertenecientes al numero de archivo  , ya que he tenido que rediseñar la clasificacion del catalogo de cuentas
utilizando herencia relacional*/