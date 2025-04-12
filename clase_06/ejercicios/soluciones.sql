/*
DDL (Data Definition Language) – Crear estructuras (1–20)

	Crear una tabla usuarios con id, nombre, email, fecha_nacimiento.
	Crear una tabla productos con id, nombre, precio, stock.
	Crear una tabla pedidos con id, usuario_id, fecha.
	Crear una tabla detalle_pedidos con id, pedido_id, producto_id, cantidad, precio_unitario.
	Crear una tabla categorias y relacionarla con productos.
	Agregar una columna telefono a usuarios.
	Modificar el tipo de dato de precio en productos a DECIMAL(10,2).
	Agregar una restricción UNIQUE sobre email en usuarios.
	Crear una clave foránea en pedidos hacia usuarios.
	Crear una clave foránea en detalle_pedidos hacia productos.
	Crear una clave foránea en detalle_pedidos hacia pedidos.
	Crear una tabla comentarios con relación a usuarios y productos.
	Crear una tabla intermedia usuarios_roles para una relación N:N entre usuarios y roles.
    
    -- Hasta aca --
	Eliminar la columna telefono de usuarios.
	Eliminar la tabla comentarios.
	Crear una tabla direcciones con una restricción CHECK para que el país sea “AR” o “UY”.
	Usar AUTO_INCREMENT en una tabla envios.
	Crear una vista vista_usuarios_activos.
	Crear un índice en productos(nombre).
	Crear una tabla logs con una columna timestamp por defecto.
*/

CREATE DATABASE IF NOT EXISTS sql_flex;
USE sql_flex;

-- Crear tabla usuarios
CREATE TABLE usuarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

-- Crear tabla productos
CREATE TABLE productos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- Crear tabla Pedidos
CREATE TABLE pedidos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL, 
    fecha DATE NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Crear tabla Detalle Pedido
CREATE TABLE detalle_pedido (
	id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL, 
    producto_id INT NOT NULL, 
    cantidad INT NOT NULL, 
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Crear tabla Categorias
CREATE TABLE categorias (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Relacionar productos con categorias
ALTER TABLE productos ADD COLUMN categoria_id INT;
ALTER TABLE productos ADD FOREIGN KEY (categoria_id) REFERENCES categorias(id);

-- Agregar columna telefono a usuarios
ALTER TABLE usuarios ADD COLUMN telefono VARCHAR (20) UNIQUE;

-- Agregar restriccion UNIQUE al email del usuario
ALTER TABLE usuarios ADD CONSTRAINT uc_email UNIQUE (email);

-- Crear una tabla comentarios con relación a usuarios y productos.
CREATE TABLE comentarios (
	id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL, 
    producto_id INT NOT NULL, 
    comentario TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Crear tabla usuarios_roles
CREATE TABLE roles(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE usuarios_roles(
	usuario_id INT NOT NULL,
    rol_id INT NOT NULL,
    PRIMARY KEY (usuario_id, rol_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- 2da Parte
/*
SECCIÓN 2: DML - Manipular datos (25 ejercicios)
	Insertar 3 usuarios.
	Insertar 5 productos con diferentes precios.
	Insertar parcialmente un usuario (solo nombre y email).
	Insertar parcialmente un producto (nombre y stock).
	Insertar un pedido con su detalle.
	Actualizar el precio de todos los productos aumentando un 10%.
	Cambiar el email de un usuario específico.
	Eliminar un producto por ID.
	Eliminar un usuario que tiene pedidos (¡provoca error!).
	Insertar un producto con NULL en precio (probar si está permitido).
	Insertar un detalle de pedido con cantidad 0 (con CHECK activado).
	Insertar varios usuarios con INSERT INTO ... VALUES (...), (...), (...);
	Insertar una dirección para un usuario existente.
	Actualizar todos los usuarios nacidos antes del 2000.
	Incrementar el stock de un producto en 20 unidades.
	Eliminar todos los pedidos anteriores a una fecha.
	Insertar un comentario sobre un producto.
	Insertar un log con la fecha actual por defecto.
	Eliminar un producto que tiene detalles de pedido (¡provoca error!).
	Insertar una fila con clave foránea que no existe (¡provoca error!).
	Insertar datos con funciones como NOW(), UUID().
	Copiar todos los productos caros a una tabla productos_premium.
	Insertar un producto sin nombre (¡provoca error! si es NOT NULL).
	Insertar un usuario con un email duplicado (¡provoca error!).
	Actualizar el stock de un producto basado en una subconsulta de ventas.
*/

-- Isertar 3 usuarios
INSERT INTO usuarios (nombre, email,fecha_nacimiento, telefono)
	VALUES
		("Pablo Goytia", "pablito@gmail.com", "1994-08-17", "+5491155556666"),
        ("Ignacio Chobanian", "ignacio@gmail.com", "2007-02-09", "+5491155557777"),
        ("Laura Calbette", "laura@gmail.com", "2000-05-02", "+5491155558888");

SELECT * FROM usuarios;

-- Isertar 5 Productos de diferentes precios
INSERT INTO categorias (nombre)
	VALUES
    ("Almacen"), -- 1
    ("Limpieza"), -- 2
    ("Indumentaria"), -- 3
    ("Insumos"), -- 4
    ("Bebidas"); -- 5
SELECT * FROM categorias;
INSERT INTO productos (nombre, precio, stock, categoria_id)
	VALUES
    ("Harina", 1500.50, 2000, 1),
    ("Shampoo", 4950.80, 1500, 2),
    ("Remera Blanca", 25000, 10, 3),
    ("Resma de Hojas A4", 40000.50, 200, 4),
    ("Coca Cola", 3500.50, 15000, 5);
    
SELECT * FROM productos;

INSERT INTO usuarios (nombre, email, fecha_nacimiento)
	VALUES
		("Sara Rionda", "sara@gmail.com", "2006-05-25");
        
SELECT * FROM usuarios;

-- 	Insertar un pedido con su detalle.
INSERT INTO pedidos (usuario_id, fecha)
	VALUES (1, CURDATE()); -- ID 1
-- Insertar detalle
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario)
	VALUES 
    (LAST_INSERT_ID(), 1, 5, 1500.50),
    (LAST_INSERT_ID(), 5, 2, 3500.50),
    (LAST_INSERT_ID(), 2, 1, 4950.80);
    
SELECT * FROM detalle_pedido;

-- Actualizar el precio de todos los productos aumentando un 10%.
UPDATE productos SET precio = precio * 1.10;

/*
13:21:37	UPDATE productos SET precio = precio * 1.10	Error Code: 1175. 
You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec
*/

SET SQL_SAFE_UPDATES = 0;
UPDATE productos SET precio = precio * 1.10;
SET SQL_SAFE_UPDATES = 1;

-- Crear una funcion para cargar un Pedido con detalle

DELIMITER //

CREATE PROCEDURE insertar_pedido_con_detalle(
	IN p_usuario_id INT,
    IN p_producto_id INT,
    IN p_cantidad INT,
    IN p_precio_unitario DECIMAL(10,2)
)

BEGIN 
	-- Insertar Pedido
    INSERT INTO pedidos (usuario_id, fecha)
	VALUES (p_usuario_id, CURDATE()); 
    
    -- Obtener el ID del pedido
    SET @ultimo_pedido_id = LAST_INSERT_ID();
    
    -- Insertar detalle
	INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario)
		VALUES (@ultimo_pedido_id, p_producto_id, p_cantidad, p_precio_unitario);
END //

DELIMITER ;

CALL insertar_pedido_con_detalle(2,2,3,27500.00);