[7.1] Tienda de informática
Realice las siguientes operaciones sobre la base de datos tienda.


*para iniciar *
SET AUTOCOMMIT=0;
START TRANSACTION;
*aquí va la respuesta y comprobamos el resultado*
*deshacemos la transacción*
ROLLBACK;


Inserta un nuevo fabricante indicando su código y su nombre.
Inserta un nuevo fabricante indicando solamente su nombre.
Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: código, nombre, precio y código_fabricante.
Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: nombre, precio y código_fabricante.
Crea una nueva tabla con el nombre fabricante_productos que tenga las siguientes columnas: nombre_fabricante, nombre_producto y precio. Una vez creada la tabla inserta todos los registros de la base de datos tienda en esta tabla haciendo uso de única operación de inserción.
Crea una vista con el nombre vista_fabricante_productosque tenga las siguientes columnas: nombre_fabricante, nombre_producto y precio.
Elimina el fabricante Asus. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
Elimina el fabricante Xiaomi. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
Actualiza el código del fabricante Lenovo y asígnale el valor 20. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
Actualiza el código del fabricante Huawei y asígnale el valor 30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
Actualiza el precio de todos los productos sumándole 5 € al precio actual.
Elimina todas las impresoras que tienen un precio menor de 200 €.





3.1.1. 📝Ejercicios sobre Procedimientos❓:
Sobre la base de datos bd_teoria_productos:
Crea un procedimiento que muestre cuantos productos hay sin fabricante.
DELIMITER $$
CREATE PROCEDURE productos_sin_fabricante()
BEGIN
	SELECT *
    	FROM producto
        WHERE código_fabricante IS null;
END
$$

Modifica el procedimiento anterior y añádele un comentario que describa lo que devuelve el procedimiento.


Muestra con una orden SQL, el contenido del procedimiento.
SHOW CREATE PROCEDURE productos_sin_fabricante;
–una vez le damos a continuar vamos a opciones extra y luego textos completos para ver el contenido del procedimiento completo


Crea un procedimiento que muestre el número de productos del fabricante ‘Hijo de Ep’. Se puede indicar la cláusula COMMENT 
en la creación del procedimiento, descubre cómo hacerlo y utilizala en este ejercicio.
DELIMITER $$
CREATE PROCEDURE num_productos_El_Hijo_de_Ep()
COMMENT 'Obtiene un listado que muestre el número de productos del fabricante "Hijo de Ep"'
BEGIN
	SELECT COUNT(*) num_productos_El_Hijo_de_Ep
            FROM producto INNER JOIN fabricante
            	ON producto.código_fabricante = fabricante.código
            WHERE fabricante.nombre = 'El Hijo de Ep';
            
END $$

DELIMITER ;


Muestra con una orden SQL el nombre de todos los procedimientos de la base de datos.
👆



3.2.1. 📝Ejercicios sobre variables locales❓:
Sobre la base de datos bd_teoria_productos
Crea un procedimiento de nombre producto_getUltimo() que guarde en variables locales los datos del último producto 
ordenado alfabeticamente. Después debe mostrar en una única columna de nombre ‘datos_producto’ todos los datos del 
producto encontrado separados por guiones (utiliza la función concat_ws).

DELIMITER //
 CREATE PROCEDURE producto_getUltimo()
 BEGIN 
	 DECLARE vResultado varchar(255) DEFAULT '';
	SELECT concat_ws('-',id,nombre,tipo,precio,código_fabricante)
			INTO vResultado
    		FROM producto
    		ORDER BY nombre DESC
			LIMIT 1;
	SELECT vResultado as 'dato_producto';
END //       


Crea un procedimiento de nombre produto_getMaxPrecio() que guarde en variables locales los datos (código, nombre y precio)
 del producto con mayor precio. Después debe mostrar en una única columna de nombre ‘datos_producto’ los datos del producto
  encontrado con este formato (código) nombre : precio . Tenemos que asegurarnos que solamente se devuelve un producto en la 
  consulta, para que no se produzcan errores.
DELIMITER //
DROP PROCEDURE IF EXISTS producto_getMaxPrecio//

CREATE PROCEDURE producto_getMaxPrecio()
BEGIN
	DECLARE vid int;
    DECLARE vnombre varchar(255);
    DECLARE vprecio float;
    
	SELECT producto.id,producto.nombre,producto.precio
    		INTO vid,vnombre,vprecio
		FROM producto
		ORDER BY producto.precio DESC
		LIMIT 1;
        
    SELECT CONCAT('(',vid,')',vnombre, ': ',vprecio) AS 'datos_producto';
END //    
        




ESTRUCTURA PARA CREAR PROCEDIMIENTOS

	DELIMITER $$
	DROP PROCEDURE IF EXISTS nombre$$
	CREATE PROCEDURE nombre()
	COMMENT ‘......’
	BEGIN
	

	END $$


3.3.1.1. 📝Ejercicios sobre parámetros de entrada❓:
Sobre la base de datos bd_teoria_productos
Crea un procedimiento de nombre producto_posicion() que guarde en variables locales los datos del producto
que ocupa la posición indicada, una vez ordenados alfabeticamente. Después debe mostrar en una única columna 
de nombre ‘datos_producto’ todos los datos del producto encontrado separados por guiones (utiliza la función concat_ws) 
o el mensaje 'no existe' cuando no exista ningún producto que ocupe esa posición.
DELIMITER $$
DROP PROCEDURE IF EXISTS producto_posicion $$
CREATE PROCEDURE producto_posicion(ppos int)
    COMMENT 'muestra los datos del ultimo producto ordenado alfabeticamente por nombre'
BEGIN
   
    DECLARE vresultado varchar(255);
    DECLARE vdesplazamiento int;


    IF ifnull(ppos, 0) = 0 THEN
        SET vdesplazamiento = 0;
    ELSE
        SET vdesplazamiento = ppos -1;
    END IF;


    SELECT concat_ws('-',id, nombre, tipo, precio, código_fabricante)
        INTO vresultado
    FROM producto
    ORDER BY nombre
    LIMIT vdesplazamiento,1;


-- solucion 1
--    SELECT if(vresultado is null, 'no existe', vresultado)  as 'datos_producto';


-- solucion 2
    IF vresultado is not null THEN
        SELECT vresultado  as 'datos_producto';
    ELSE
        SELECT 'no existe' as 'datos_producto';
    END IF;


/*
call producto_posicion(null);
call producto_posicion(3);
call producto_posicion(100);
*/
END$$



Crea un procedimiento de nombre produto_getMaxPrecioFabricante() que reciba un parametro denominado pfabricante 
que recibirá el codigo del fabricante del que deseamos calcular el producto más caro. Debe guardar en variables 
locales los datos (código, nombre y precio) del producto con mayor precio de ese fabricante. Después debe mostrar 
en una única columna de nombre ‘datos_producto’ los datos del producto encontrado con este formato (código) nombre : precio . 
Tenemos que asegurarnos que solamente se devuelve un producto en la consulta, para que no se produzcan errores.
DELIMITER //
DROP PROCEDURE IF EXISTS producto_getCodigo//

CREATE PROCEDURE producto_getCodigo(
	pCadena varchar(50), 
    OUT pCodigo int
)
	COMMENT 'Dado una parte del nombre de un producto devuelve en forma de parámetro de salida el código del primero que cumple la condición de los ordenados alfabéticamente'
BEGIN    
	SET pCodigo=0;
    
	SELECT id
    	INTO pcodigo
		FROM producto
		WHERE nombre like concat(pCadena, '%')
        ORDER BY nombre
        LIMIT 1;
/*
call producto_getCodigo('DISCO',@id);
SELECT @id;
SELECT * from producto where id =@id;

call producto_getCodigo('ordenad',@id);
SELECT @id;
SELECT * from producto where id =@id;
*/
END //    





Crea un procedimiento de nombre producto_add() que añada un nuevo producto dado su nombre, tipo, precio y código_fabricante. 
Deberás enviar los datos del producto utilizando parámetros. Después debe mostrar en una única columna de nombre ‘datos_producto’ todos 
los datos del producto insertado separados por guiones.

//ESTRUCTURA//

DELIMITER $$
DROP PROCEDURE IF EXISTS nombre$$
CREATE PROCEDURE nombre()

COMMENT ''
BEGIN

END$$

//


📝 Nota: Cuando el tipo sea null o '' (cadena vacia), antes de insertar el producto, se buscará el tipo del último producto insertado del mismo fabricante, que será el que asignaremos a este nuevo producto. Caso de no existir productos de ese fabricante, el tipo será 'desconocido'.
👆

3.3.3.1. 📝Ejercicios sobre parámetros de entrada/salida❓:

    Crea un procedimiento de nombre producto_addPrecio al que se le envíe como parámetros el código del producto y una cantidad
    que representa el dinero que se le va a aumentar el precio a dicho producto. Si se desea decrementar se indicará una cantidad negativa.
    El procedimiento debe devolver en el mismo parámetro el nuevo precio del producto. Debes realizar la implementación del procedimiento 
    y un bloque de codigo con una llamada de ejemplo.

	DELIMITER $$
	DROP PROCEDURE IF EXISTS producto_addPrecio$$
	CREATE PROCEDURE producto_addPrecio(
        IN pid int, -- codigo del producto a modificar el precio
        INOUT pprecio decimal(16,2) -- 16 dígitos y 2 decimales
        )

	BEGIN
        DECLARE vprecio decimal(16,2);

        SELECT precio 
            INTO vprecio
            FROM producto
            WHERE id = pid;

        SET vprecio = vprecio + pprecio;

        UPDATE producto
            SET precio = vprecio
            WHERE id = pid;

        SET pprecio = vprecio;


/*

SET @@AUTOCOMMIT=0;
START TRANSACTION;
SET @id = 1;
SET @incremento = 10;

SELECT @id, @incremento, producto.* FROM producto WHERE id = @id;

call producto_addPrecio(@id, @incremento);

SELECT @id, @incremento, producto.* FROM producto WHERE id = @id;
ROLLBACK;

*/
	END $$



    Una vez realizado el ejercicio anterior, crea un nuevo procedimiento producto_addPrecioByNombre que haga lo mismo, pero al cual se le 
    envía el nombre del producto en lugar del código. Deberás guardar en una variable local el codigo del producto para después modificar 
    su precio invocando al procedimiento anterior. Debe devolver o retornar el mismo dato que en el ejercicio anterior.

    Crea un procedimiento de nombre producto_getDescripcion al que se le pase como parámetro el código de un producto id y devuelve en el 
    mismo parámetro el nombre del fabricante, seguido de : y el nombre completo de dicho producto.




En este procedimiento se pide que el mismo parámetro sirva para enviar el código del producto (que es integer en la base de datos) y 
que devuelva el nombre del fabricante ('DESCONOCIDO' si es nulo), seguido de : y el nombre completo del producto (que será varchardel tamaño de la 
columna Producto.nombre sumado el tamaño de la columna nombre en la tabla producto con el tamaño la suma de fabricante.nombre más tres unidades.

📝 Nota: Por fuerza el tipo de dato debe de ser varchar y del tamaño indicado anteriormente.


DELIMITER $$
DROP PROCEDURE IF EXISTS producto_getDescripcion $$

CREATE PROCEDURE producto_getDescripcion(
    INOUT pdato varchar(255)
)

BEGIN
    DECLARE vdato varchar(153);

        SELECT concat(ifnull(f.nombre,'DESCONOCIDO'), ' : ', p.nombre) -- si el valor de f.nombre es nulo devuelve 'DESCONOCIDO' sino devuelve el f.nombre
            INTO vdato -- con el into guardamos el concat en una variable 
            FROM producto p LEFT JOIN fabricante f
                ON p.código_fabricante = f.código
            WHERE p.id = pdato;

        SET pdato = ifnull(vdato,''); -- aquí decimos que si es null devolvemos un campo vacío, sino devolvemos vdato

/*
SET @descripcion='5';
call producto_getDescripcion (@descripcion);
SELECT @descripcion;

SET @descripcion='6'; -- producto null 
call producto_getDescripcion (@descripcion);
SELECT @descripcion;

SET @descripcion='500'; -- producto inexistente
call producto_getDescripcion (@descripcion);
SELECT @descripcion;


*/
END $$


3.5.0.1. 📝Ejercicios sobre cursores❓:
Crea un procedimiento de nombre cuentaFabricantes que cuente el numero de fabricantes que hay en la tabla fabricante realizando dicho calculo con un cursor 
que recorra la tabla.

Crea un procedimiento llamado precios_iniciales para asignar los precios iniciales a los productos de la tabla producto, que recibirá un parametro 
pincremento_precio que será de tipo decimal(16,2). Debe asignar los precios iniciales a productos ordenados por su nombre empezando por 1€ y a continuación 
el precio de los productos será la (posición que ocupa - 1) * pincremento_precio. 

Antes de finalizar el procedimiento se mostraran todos los datos de los productos del producto del último fabricante no nulo (no de todos).



DELIMITER $$
DROP PROCEDURE IF EXISTS cuentaFrabricantes $$
CREATE PROCEDURE cuentaFabricantes()
BEGIN
    DECLARE vfin boolean DEFAULT FALSE; 
    DECLARE vcodigo int;
    DECLARE vcuenta int;

    DECLARE cur CURSOR FOR
        SELECT código FROM fabricante;
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
        BEGIN -- para poner más de una línea se pone entre begin y end
            SET vfin = TRUE; -- este es el manejador de errores
        END;

    OPEN cur;
    
    SET vcuenta = 0;
    FETCH cur INTO vcodigo; -- declaramos solo una variable porque solo tenemos en select un dato (código)
    WHILE vfin = FALSE
    DO
        SET vcuenta = vcuenta +1
        FETCH cur INTO vcodigo;
    END WHILE;

    CLOSE cur;

    SELECT vcuenta AS 'Número de fabricantes'


END $$







DELIMITER $$
DROP PROCEDURE IF EXISTS cuentaFrabricantes $$
CREATE PROCEDURE cuentaFabricantes(
    OUT presultado INT
)
BEGIN
    DECLARE vfin boolean DEFAULT FALSE; 
    DECLARE vcodigo int;
    DECLARE vcuenta int;

    DECLARE cur CURSOR FOR
        SELECT código FROM fabricante;
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
        BEGIN -- para poner más de una línea se pone entre begin y end
            SET vfin = TRUE; -- este es el manejador de errores
        END;

    OPEN cur;
    
    SET vcuenta = 0;
    FETCH cur INTO vcodigo; -- declaramos solo una variable porque solo tenemos en select un dato (código)
    WHILE vfin = FALSE
    DO
        SET vcuenta = vcuenta +1
        FETCH cur INTO vcodigo;
    END WHILE;

    CLOSE cur;

    SELECT vcuenta AS 'Número de fabricantes'


END $$