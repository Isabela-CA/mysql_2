CREATE table universidad;
use universidad; 


CREATE table estudiante(
id_estudiante int primary key,
nom_estudiante varchar(100)
);

CREATE table profesor(
id_profesor int primary key, 
nom_profesor varchar(100),
departamento varchar(100)
);

CREATE table curso(
id_curso int primary key,
id_profesor int,
nom_curso varchar(100),
foreign key (id_profesor) references profesor(id_profesor)
);

CREATE table inscripcion_universidad(
id_estudiante int,
id_profesor int,
id_curso int,
foreign key (id_estudiante) references estudiante (id_estudiante),
foreign key (id_profesor) references profesor (id_profesor),
foreign key (id_curso) references curso (id_curso)
);



CREATE database hospital;
use hospital,

CREATE table paciente(
id_paciente int primary key,
nom_paciente varchar(100),
fecha_nacimiento date
);

CREATE  table medicos(
id_medicos int primary key,
nom_medico varchar(100),
especialista varchar(100)
);

CREATE table vicitas(
id_visitas int primary key,
id_paciente,
id_medicos,
fecha_visita,
foreign key (id_medicos) references medicos (id_medicos)
foreign key (id_paciente) references paciente (id_paciente)
);

CREATE table tratamiento (
id_tratamiento int primary key,
id_visita int,
descripcion_tratamiento varchar(250),
dosis varchar(50),
medicamento varchar(100),
foreign key (id_visita) references visitas (id_visita)
);


-- consultas 
-- 1

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;
CREATE TABLE fabricante (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
);
CREATE TABLE producto (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DOUBLE NOT NULL,
id_fabricante INT UNSIGNED NOT NULL,
FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);
INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');
INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.

SELECT F.nombre as 'Nombre Fabricante', P.nombre as 'Nombre Producto', P.precio 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos
-- de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.

SELECT F.nombre as 'Nombre Fabricante', P.nombre as 'Nombre Producto', P.precio 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante 
ORDER BY F.nombre;

-- 3. Devuelve una lista con el identificador del producto, nombre del producto, identificador del
-- fabricante y nombre del fabricante, de todos los productos de la base de datos.

SELECT F.id, F.nombre, P.id, P.nombre 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante;

-- 4.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.

SELECT P.nombre AS 'Nombre Producto', P.precio, F.nombre as 'Nombre Fabricante' 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
ORDER BY P.precio ASC
LIMIT 1;


-- 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.

SELECT P.nombre AS 'Nombre Producto', P.precio, F.nombre as 'Nombre Fabricante' 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
ORDER BY P.precio DESC
LIMIT 1;

-- 6. Devuelve una lista de todos los productos del fabricante Lenovo.

SELECT P.nombre as 'Nombre producto', F.nombre as 'Nombre Fabricante'
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre = 'Lenovo';

-- 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.

SELECT P.nombre as 'Nombre producto', F.nombre as 'Nombre Fabricante', P.precio 
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre = 'Crucial' and P.precio > 200;

-- 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin
-- utilizar el operador IN.

SELECT P.nombre as 'Nombre producto', F.nombre as 'Nombre Fabricante'
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre = 'Crucial' or F.nombre = 'Hewlett-Packard' or F.nombre = 'Seagate';

-- 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate.
-- Utilizando el operador IN.

SELECT P.nombre as 'Nombre producto', F.nombre as 'Nombre Fabricante'
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre
-- termine por la vocal e.


SELECT P.nombre as 'Nombre producto', P.precio , F.nombre as 'Nombre Fabricante'
FROM fabricante F
INNER JOIN producto P
ON F.id = P.id_fabricante
WHERE F.nombre LIKE '%e';

-- 11.Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
 
SELECT F.nombre AS 'Nombre Fabricante', COUNT(P.id) AS 'Cantidad de productos'
FROM fabricante F
INNER JOIN producto P ON F.id = P.id_fabricante
GROUP BY F.id, F.nombre
HAVING COUNT(P.id) >= 2;

-- 12.Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada
-- uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes
-- que no tienen productos que cumplan la condición.

SELECT F.nombre AS 'Nombre Fabricante', COUNT(P.id) AS 'Cantidad de productos ≥ 220 €'
FROM fabricante F
INNER JOIN producto P ON F.id = P.id_fabricante
WHERE P.precio >= 220
GROUP BY F.id, F.nombre;

-- 13.Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada
-- uno con un precio superior o igual a 220 €. El listado debe mostrar el nombre de todos los
-- fabricantes, es decir, si hay algún fabricante que no tiene productos con un precio superior o igual
-- a 220€ deberá aparecer en el listado con un valor igual a 0 en el número de productos.

SELECT F.nombre AS 'Nombre Fabricante', COUNT(CASE WHEN P.precio >= 220 THEN 1 END) AS 'Cantidad de productos ≥ 220 €'
FROM fabricante F
LEFT JOIN producto P ON F.id = P.id_fabricante
GROUP BY F.id, F.nombre;

-- 14.Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus
-- productos es superior a 1000 €.

SELECT F.nombre AS 'Nombre Fabricante', SUM(P.precio) AS 'Suma total de precios'
FROM fabricante F
INNER JOIN producto P ON F.id = P.id_fabricante
GROUP BY F.id, F.nombre
HAVING SUM(P.precio) > 1000;

-- 15.Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. El resultado
-- debe tener tres columnas: nombre del producto, precio y nombre del fabricante. El resultado tiene
-- que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.

SELECT P.nombre AS 'Nombre del producto', P.precio AS 'Precio', F.nombre AS 'Fabricante'
FROM producto P
INNER JOIN fabricante F ON P.id_fabricante = F.id
INNER JOIN (
    SELECT 
        id_fabricante,
        MAX(precio) AS max_precio
    FROM producto
    GROUP BY id_fabricante
) AS Sub ON P.id_fabricante = Sub.id_fabricante AND P.precio = Sub.max_precio
ORDER BY F.nombre ASC;

-- 16.Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER
-- BY ni LIMIT. 

SELECT P.nombre AS 'Nombre del producto', P.precio AS 'Precio'
FROM producto P
WHERE NOT EXISTS (
    SELECT 1 
    FROM producto P2 
    WHERE P2.precio > P.precio
);

-- 17.Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.

SELECT P.nombre AS 'Nombre del producto', P.precio AS 'Precio'
FROM producto P
WHERE NOT EXISTS (
    SELECT 1 
    FROM producto P2 
    WHERE P2.precio < P.precio
);

-- 18.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).

SELECT nombre
FROM fabricante
WHERE id = ANY (
    SELECT id_fabricante
    FROM producto
);

-- 19.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).

SELECT nombre
FROM fabricante
WHERE id <> ALL (
    SELECT id_fabricante
    FROM producto
);

-- 20. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).

SELECT nombre
FROM fabricante
WHERE id IN (
    SELECT id_fabricante
    FROM producto
);





--- segundo ejercicio

DROP DATABASE IF EXISTS ventas;
CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;
CREATE TABLE cliente (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
ciudad VARCHAR(100),
categoría INT UNSIGNED
);
CREATE TABLE comercial (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido1 VARCHAR(100) NOT NULL,
apellido2 VARCHAR(100),
comisión FLOAT
);
CREATE TABLE pedido (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
total DOUBLE NOT NULL,
fecha DATE,
id_cliente INT UNSIGNED NOT NULL,
id_comercial INT UNSIGNED NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES cliente(id),
FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);
INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);
INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

-- 1. Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.

SELECT * 
FROM cliente c
WHERE c.id NOT IN (SELECT id_cliente FROM pedido);


-- 2. Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.

SELECT * 
FROM comercial co 
WHERE co.id NOT IN (SELECT id_comercial FROM pedido);

-- 3. Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que
-- no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el
-- nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.

SELECT 'Cliente' AS tipo, nombre, apellido1, apellido2 
FROM cliente 
WHERE id NOT IN (SELECT id_cliente FROM pedido)
UNION
SELECT 'Comercial' AS tipo, nombre, apellido1, apellido2 
FROM comercial 
WHERE id NOT IN (SELECT id_comercial FROM pedido)
ORDER BY apellido1, apellido2, nombre;


-- 4. ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique
-- su respuesta.

SELECT p.id_cliente, c.nombre, c.apellido1, c.apellido2, p.fecha, MAX(p.total) AS max_total
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id
GROUP BY p.id_cliente, p.fecha;

-- 5 Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de
-- los clientes. Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes
-- cantidades el mismo día. Se pide que se calcule cuál es el pedido de máximo valor para cada uno
-- de los días en los que un cliente ha realizado un pedido. Muestra el identificador del cliente,
-- nombre, apellidos, la fecha y el valor de la cantidad.

SELECT p.id_cliente, c.nombre, c.apellido1, c.apellido2, p.fecha, MAX(p.total) AS max_total
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id
GROUP BY p.id_cliente, p.fecha;


-- 6. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de
-- los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la
-- cantidad de 2000 €.

SELECT p.id_cliente, c.nombre, c.apellido1, c.apellido2, p.fecha, MAX(p.total) AS max_total
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id
GROUP BY p.id_cliente, p.fecha
HAVING max_total > 2000;


-- 7. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la
-- fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.

SELECT p.id_comercial, co.nombre, co.apellido1, co.apellido2, MAX(p.total) AS max_total
FROM pedido p
JOIN comercial co ON p.id_comercial = co.id
WHERE p.fecha = '2016-08-17'
GROUP BY p.id_comercial;

-- 8. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de
-- pedidos que ha realizado cada uno de clientes. Tenga en cuenta que pueden existir clientes que
-- no han realizado ningún pedido. Estos clientes también deben aparecer en el listado indicando
-- que el número de pedidos realizados es 0.

SELECT c.id, c.nombre, c.apellido1, c.apellido2, COUNT(p.id) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
GROUP BY c.id;

-- 9. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de
-- pedidos que ha realizado cada uno de clientes durante el año 2017.

SELECT c.id, c.nombre, c.apellido1, c.apellido2, COUNT(p.id) AS total_pedidos_2017
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente AND YEAR(p.fecha) = 2017
GROUP BY c.id;

-- 10.Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el valor de
-- la máxima cantidad del pedido realizado por cada uno de los clientes. El resultado debe mostrar
-- aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus
-- pedidos realizados es 0. Puede hacer uso de la función IFNULL.

SELECT c.id, c.nombre, c.apellido1,
       IFNULL(MAX(p.total), 0) AS max_pedido
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
GROUP BY c.id;

-- 11.Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.

SELECT YEAR(fecha) AS año, MAX(total) AS max_total
FROM pedido
GROUP BY YEAR(fecha);

-- 12.Devuelve el número total de pedidos que se han realizado cada año.

SELECT YEAR(fecha) AS año, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY YEAR(fecha);

-- 13.Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER
-- JOIN)

SELECT *
FROM cliente
WHERE id = (
    SELECT id_cliente
    FROM pedido
    WHERE YEAR(fecha) = 2019
    ORDER BY total DESC
    LIMIT 1
);

-- 14.Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz
-- Santana.

SELECT fecha, total
FROM pedido
WHERE id_cliente = (
    SELECT id FROM cliente 
    WHERE nombre = 'Pepe' AND apellido1 = 'Ruiz' AND apellido2 = 'Santana'
)
ORDER BY total ASC
LIMIT 1;

-- 15.Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han
-- realizado un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos
-- realizados durante ese mismo año.

SELECT c.*, p.*
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
WHERE YEAR(p.fecha) = 2017
  AND p.total >= (
    SELECT AVG(total)
    FROM pedido
    WHERE YEAR(fecha) = 2017
);


-- 16.Devuelve el pedido más caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.

SELECT *
FROM pedido p1
WHERE NOT EXISTS (
    SELECT * FROM pedido p2
    WHERE p2.total > p1.total
);


-- 17.Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).

SELECT *
FROM cliente
WHERE id <> ALL (SELECT id_cliente FROM pedido);


-- 18.Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).

SELECT *
FROM comercial
WHERE id <> ALL (SELECT id_comercial FROM pedido);


-- 19.Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).

SELECT *
FROM cliente
WHERE id NOT IN (SELECT id_cliente FROM pedido);


-- 20.Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT
-- IN).

SELECT *
FROM comercial
WHERE id NOT IN (SELECT id_comercial FROM pedido);


-- 21.Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT
-- EXISTS).

SELECT *
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedido p
    WHERE p.id_cliente = c.id
);






