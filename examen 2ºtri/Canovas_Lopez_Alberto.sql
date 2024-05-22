--Canovas Lopez Alberto

-- BBDD formula 2

--EJERCICIO 1
--Crear una nueva tabla llamada resultados_carrera con las siguientes características:
--id que será un entero que se almacenara automáticamente incrementando una unidad para cada nueva fila o registro.
--carrera_id que será el id de la carrera cuyos resultados se quieren almacenar.
--piloto_id que será el id del piloto del que se va a especificar la posición que ha ocupado en el siguiente campo.
--posicion entero que almacena la posicion de piloto_id en carrera_id.
--El campo id será la clave primaria de la tabla y tanto piloto_id como carrera_id serán claves ajenas a las tablas a las que apuntan.

CREATE TABLE resultados_carrera(
    id int AUTO_INCREMENT PRIMARY KEY,
    carrera_id int,
    piloto_id int,
    posicion int,
    FOREIGN KEY (piloto_id) REFERENCES pilotos(id),
    FOREIGN KEY (carrera_id) REFERENCES carreras(id)
    )


----------------------------------------------------------
--BBDD formula 2
--EJERCICIO 2
--Construye una consulta que genere tres campos llamados carrera_id, piloto_id y posicion (será una constante) , 
--para todas las carreras disputadas (es decir, con pilotos clasificados) en las que la posición del piloto en dicha carrera es el entero asociado al tercer_clasificado y su piloto_id está recogido en ese mismo campo.
--Una vez construida y probada la consulta, 
--utilizala para crear una sentencia INSERT INTO que añada todas esas filas sobre la tabla resultados_carrera que creaste anteriormente.


------------------------------------------------------
--BBDD formula 2
--EJERCICIO 3
--Elimina de la tabla carreras la clave ajena correspondiente al campo primer_clasificado

SHOW CREATE TABLE carreras
ALTER TABLE carreras 
DROP FOREIGN KEY carreras_ibfk_2;
-------------------------------------------------------------
--BBDD formula2
--EJERCICIO 4
--Elimina el campo primer_clasificado de la tabla carreras.

ALTER TABLE carreras
DROP COLUMN primer_clasificado
-------------------------------------------------------------------
--BBDD formula 2
--EJERCICIO 5
--Añade una restricción de valor por defecto sobre el campo nombre de la tabla carreras que introduzca el valor por defecto 'GP SIN NOMBRE' 
--y haga obligatoria la existencia de un valor para ese campo.

ALTER TABLE carreras
MODIFY nombre varchar(255) NOT NULL

ALTER TABLE carreras
ALTER nombre SET DEFAULT 'GP SIN NOMBRE' 


--------------------------------------------------------------------
--BBDD formula 1
--EJERCICIO 6
--¿Cuales son las carreras cuyo nombre de Gran Premio ('GP de ...') empieza por 'Au' ?

SELECT nombre
FROM carreras
WHERE nombre LIKE 'Gp de Au%'

nombre	
GP de Australia	
GP de Austria	
----------------------------------------------------------------------
--BBDD formula 1
--EJERCICIO 7
--País, nombre del equipo y nombre del piloto de aquellos pilotos que están corriendo en un equipo de su mismo pais. 
--Utiliza los alias que consideres para que los nombres de los atributos sean descriptivos.

SELECT p.pais,e.nombre AS 'Nombre Equipo', p.nombre AS 'Nombre Piloto'
FROM pilotos p INNER JOIN equipos e
ON p.equipo_id = e.id
WHERE p.pais = e.pais

pais	      Nombre Equipo	    Nombre Piloto	
Reino Unido  McLaren F1 Team	Lando Norris	
Francia	     Alpine F1 Team	    Pierre Gasly	
------------------------------------------------------------------------------
--BBDD formula 1
--EJERCICIO 8
--Se pide mostrar el nombre de todos los circuitos de España, junto al de todos los equipos de España y todos los pilotos de España.

SELECT c.nombre FROM circuitos c
WHERE  c.pais= 'España'
UNION 
SELECT p.nombre FROM pilotos p
WHERE p.pais= 'España'
UNION
SELECT e.nombre FROM equipos e
WHERE e.pais = 'España'

nombre	
Circuit de Barcelona-Catalunya	
Fernando Alonso	
Carlos Sainz	


--------------------------------------------------------------------------------
--BBDD formula1
--EJERCICIO 9
--Muestra todos los datos de aquellos circuitos que no tengan una carrera asignada

SELECT ci.*
FROM circuitos ci LEFT JOIN carreras ca
ON ci.id = ca.circuito_id
WHERE ca.circuito_id is null


id	nombre	ubicacion	pais	
15	Yas Marina Circuit	Abu Dhabi	Emiratos Árabes Unidos	
16	Autódromo de Sochi	Sochi	Rusia	

-------------------------------------------------------------------------------------
--BBDD formula 1
--EJERCICIO 10
--¿Cual es el nombre de la última carrera ganada por Fernando Alonso? Debes llamar a la columna 'ultima victoria de Fernando Alonso'. 
--Si tuvieras que ejecutar esta consulta en SQL Server, 
--¿le tendrías que hacer algún cambio? (indica la sintaxis para SQL Server, si has respondido sí a la pregunta anterior).

gp de austria 

SELECT c.nombre AS 'Última victoria de Fernando Alonso'
FROM carreras c 
WHERE c.primer_clasificado = 3 
ORDER by c.fecha DESC
LIMIT 1


Última victoria de Fernando Alonso
GP de Austria	

--EN SQL SERVER SERÍA DIFERENTE EN VEZ DE LIMIIT 1 HABRÍA QUE PONER TOP 1
