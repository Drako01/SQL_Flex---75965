# Curso de MySQL - Clase 04

## Introducción

En esta clase aprenderemos sobre MySQL Workbench desde una perspectiva de experiencia de usuario (UX) y diseño centrado en el usuario (UI), además de explorar conceptos fundamentales de bases de datos como tablas, claves, funciones, triggers y diagramas E-R.

---

# 1. UX en MySQL Workbench

## 1.1 Usabilidad
La usabilidad en MySQL Workbench se refiere a qué tan fácil es para los usuarios realizar tareas dentro del entorno. Esto incluye:
- **Navegación intuitiva**: La disposición de menús y herramientas permite un acceso rápido.
- **Automatización de tareas**: Posibilidad de generar modelos E-R, consultas SQL y reportes de manera sencilla.
- **Facilidad de aprendizaje**: La interfaz gráfica ayuda a reducir la curva de aprendizaje.

## 1.2 Interacción
La interacción en MySQL Workbench permite:
- **Creación visual de bases de datos** sin escribir código SQL manualmente.
- **Generación de consultas SQL** con ayuda de autocompletado y constructores visuales.
- **Depuración de consultas** con herramientas como "EXPLAIN" para analizar rendimiento. (Se Profundiza al final de la clase)

## 1.3 Factores que construyen la UX
Algunos factores clave que afectan la experiencia de usuario en MySQL Workbench incluyen:
- **Accesibilidad**: Interfaz gráfica amigable para diseñadores de bases de datos.
- **Eficiencia**: Herramientas de modelado que reducen errores y tiempo de desarrollo.
- **Seguridad**: Permite gestionar usuarios, permisos y conexiones de manera centralizada.

---

# 2. Diseño Centrado en el Usuario (UI)

El diseño UI en MySQL Workbench se enfoca en:
1. **Analizar**: Comprender los requerimientos de la base de datos antes de diseñarla.
2. **Diseñar**: Utilizar herramientas como el modelador E-R para crear estructuras eficientes.
3. **Validar**: Probar y ajustar el diseño antes de implementarlo.

Ejemplo:
```sql
-- Crear una tabla para registrar usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

# 3. Tipos de Tablas en MySQL

## 3.1 Tablas de Hecho
- Utilizadas en **almacenes de datos** para almacenar eventos o transacciones.
- Contienen datos numéricos agregables.

Ejemplo:
```sql
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_cliente INT,
    monto DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
```

## 3.2 Tablas Transaccionales
- Utilizadas en **sistemas operacionales** para almacenar información de transacciones en tiempo real.

Ejemplo:
```sql
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL
);
```

## 3.3 Tablas Dimensionales
- Utilizadas en **modelos de data warehouse** para describir entidades en un contexto de análisis.

Ejemplo:
```sql
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(255),
    categoria VARCHAR(100)
);
```

---

# 4. Claves en MySQL

## 4.1 Clave Primaria
Identifica de manera única cada fila en una tabla.
```sql
CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100)
);
```

## 4.2 Clave Foránea
Mantiene relaciones entre tablas.
```sql
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
```

## 4.3 Índices
Mejoran el rendimiento de las consultas.
```sql
CREATE INDEX idx_nombre ON empleados(nombre);
```

## 4.4 Claves Candidatas
Son atributos únicos que podrían ser clave primaria.
```sql
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);
```

## 4.5 Claves Concatenadas
Se forman combinando múltiples columnas.
```sql
CREATE TABLE detalle_pedido (
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_pedido, id_producto)
);
```

---

# 5. Objetos de una Base de Datos

## 5.1 Vistas en MySQL


Las **Vistas** en MySQL son consultas almacenadas que actúan como tablas virtuales. Permiten acceder y manipular datos de manera más organizada sin necesidad de escribir consultas complejas repetidamente.

---

## 🟢 **¿Qué es una Vista?**  
Una vista es una **consulta predefinida** que se almacena en la base de datos y puede usarse como si fuera una tabla normal. No almacena los datos directamente, sino que muestra los resultados de la consulta cada vez que se accede a ella.  

✅ **Ventajas de las Vistas:**  
✔ **Simplicidad**: Ocultan la complejidad de consultas SQL complejas.  
✔ **Seguridad**: Permiten restringir el acceso a ciertos datos sensibles.  
✔ **Reutilización**: Se pueden usar en múltiples consultas sin repetir el código.  
✔ **Mantenimiento**: Si cambian las tablas subyacentes, la vista sigue funcionando sin necesidad de modificar el código de consulta en cada aplicación.

---

# 1️⃣ **Creación de Vistas en MySQL**  

## 🟢 **Ejemplo 1: Creación de una Vista Básica**  
Imagina que tenemos una tabla `ventas` y queremos crear una vista que solo muestre las ventas de los últimos 30 días.  

```sql
CREATE VIEW vista_ventas_recientes AS
SELECT id_venta, id_cliente, monto, fecha
FROM ventas
WHERE fecha >= CURDATE() - INTERVAL 30 DAY;
```

### ✅ **Uso de la Vista**
```sql
SELECT * FROM vista_ventas_recientes;
```
Esto devuelve solo las ventas de los últimos 30 días sin necesidad de escribir la condición cada vez.

---

# 2️⃣ **Tipos de Vistas en MySQL**  

## 🟢 **Vista de una Sola Tabla**  
Las vistas pueden crearse a partir de una sola tabla para mostrar solo ciertos campos o filtrar datos.  

```sql
CREATE VIEW vista_clientes_activos AS
SELECT id_cliente, nombre, email
FROM clientes
WHERE estado = 'activo';
```
### ✅ **Consulta la Vista**  
```sql
SELECT * FROM vista_clientes_activos;
```

---

## 🟢 **Vista con Múltiples Tablas (JOINs)**  
Las vistas pueden combinar datos de múltiples tablas usando `JOIN`.  

```sql
CREATE VIEW vista_pedidos_detalle AS
SELECT p.id_pedido, p.fecha, c.nombre AS cliente, pr.nombre AS producto, dp.cantidad
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
JOIN productos pr ON dp.id_producto = pr.id_producto;
```
### ✅ **Consulta la Vista**
```sql
SELECT * FROM vista_pedidos_detalle;
```
Esta vista muestra los detalles de los pedidos con el nombre del cliente y los productos adquiridos.

---

# 3️⃣ **Actualización y Eliminación de Vistas**

## 🟢 **Modificar una Vista**  
Si necesitas cambiar la estructura de una vista, puedes usar `CREATE OR REPLACE` o `ALTER VIEW`.  

```sql
CREATE OR REPLACE VIEW vista_clientes_activos AS
SELECT id_cliente, nombre, telefono
FROM clientes
WHERE estado = 'activo';
```

---

## 🟢 **Eliminar una Vista**  
Si ya no necesitas una vista, puedes eliminarla con:  

```sql
DROP VIEW vista_clientes_activos;
```

---

# 4️⃣ **Vistas con Parámetros (Usando Variables)**  
Las vistas en MySQL **no aceptan parámetros directamente**, pero puedes simular esta funcionalidad usando **variables de sesión**.  

```sql
SET @categoria = 'Electrónica';

CREATE VIEW vista_productos_categoria AS
SELECT * FROM productos WHERE categoria = @categoria;
```

### ✅ **Consulta la Vista con un Valor Específico**
```sql
SET @categoria = 'Muebles';
SELECT * FROM vista_productos_categoria;
```

---

# 5️⃣ **Vistas con Restricciones (Vistas de Solo Lectura y Vistas Actualizables)**  

## 🟢 **Vistas Actualizables**  
Algunas vistas permiten modificar los datos subyacentes, siempre que cumplan ciertas condiciones:
- No usen `DISTINCT`, `GROUP BY`, `HAVING`, `UNION`, `JOIN` complejo, etc.
- Se basen en una sola tabla.
- No incluyan funciones agregadas (`SUM()`, `AVG()`, etc.).

```sql
CREATE VIEW vista_empleados AS
SELECT id_empleado, nombre, salario FROM empleados;
```
Podemos **actualizar** los datos usando la vista:
```sql
UPDATE vista_empleados SET salario = 5000 WHERE id_empleado = 1;
```

## 🛑 **Vistas de Solo Lectura**  
Si una vista contiene agregaciones (`SUM`, `COUNT`, etc.) o `JOINs`, no se pueden modificar los datos directamente.  
```sql
CREATE VIEW vista_total_ventas AS
SELECT id_cliente, SUM(monto) AS total_compras
FROM ventas
GROUP BY id_cliente;
```
Si intentamos hacer:  
```sql
UPDATE vista_total_ventas SET total_compras = 1000 WHERE id_cliente = 1;
```
🔴 *Error: No se puede actualizar una vista que usa agregaciones.*

---

# 🚀 **Conclusión: Cuándo Usar Vistas en MySQL**  

✅ **Usa vistas cuando:**
1. Necesites simplificar consultas complejas.  
2. Quieras restringir el acceso a ciertos datos sin modificar la tabla original.  
3. Quieras mejorar la organización y reutilización del código SQL.  
4. Necesites mostrar información combinada de varias tablas sin alterar la estructura de datos.

📌 **Ejemplo de uso real:**  
- En un sistema de ventas, puedes crear una vista `vista_mejores_clientes` que muestre solo los clientes con más compras.  
- En un hospital, una vista `vista_pacientes_activos` puede mostrar solo los pacientes que están actualmente en tratamiento.  

---

### 🎯 **Resumen**
| Característica  | Vistas en MySQL |
|---------------|----------------|
| **Definición** | Consultas almacenadas que se comportan como tablas virtuales |
| **Almacenan datos?** | ❌ No, solo la estructura de la consulta |
| **Pueden modificar datos?** | ✅ Sí (si no tienen agregaciones o JOINs complejos) |
| **Pueden filtrar datos?** | ✅ Sí |
| **Pueden combinar tablas?** | ✅ Sí, con `JOIN` |
| **Mejoran la seguridad?** | ✅ Sí, restringiendo columnas accesibles |
| **Son reutilizables?** | ✅ Sí, evitando repetir consultas complejas |



## 5.2 Stored Procedures

Los **Stored Procedures (Procedimientos Almacenados)** son bloques de código SQL que se almacenan en la base de datos y pueden ejecutarse cuando se necesiten. Son útiles para:

- Automatizar procesos repetitivos.
- Reducir la cantidad de código en las aplicaciones.
- Mejorar el rendimiento ejecutando consultas directamente en el servidor.

## 🟢 **Ejemplo 1: Procedimiento para Insertar Usuarios**
Este procedimiento recibe datos de un usuario y lo inserta en la tabla `usuarios`.
```sql
DELIMITER //
CREATE PROCEDURE insertar_usuario(
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100)
)
BEGIN
    INSERT INTO usuarios (nombre, email, fecha_registro) 
    VALUES (p_nombre, p_email, NOW());
END;
//
DELIMITER ;
```
### ✅ **Uso del Procedimiento**
```sql
CALL insertar_usuario('Juan Pérez', 'juanperez@email.com');
```

---

## 🟢 **Ejemplo 2: Procedimiento para Obtener Ventas por Cliente**
Este procedimiento obtiene el total de ventas de un cliente en un rango de fechas.
```sql
DELIMITER //
CREATE PROCEDURE obtener_total_ventas(
    IN p_id_cliente INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    OUT p_total DECIMAL(10,2)
)
BEGIN
    SELECT SUM(monto) INTO p_total
    FROM ventas
    WHERE id_cliente = p_id_cliente
    AND fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
END;
//
DELIMITER ;
```
### ✅ **Uso del Procedimiento**
```sql
CALL obtener_total_ventas(1, '2024-01-01', '2024-03-01', @total);
SELECT @total;
```
📌 **Conclusión:**  
✅ **Stored Procedures** → Cuando necesitas ejecutar múltiples sentencias SQL con lógica de negocio. 


## 5.3 Funciones
Las **funciones** en MySQL son similares a los procedimientos almacenados, pero con algunas diferencias clave:

✅ Siempre **devuelven un valor**.  
✅ Pueden ser usadas en consultas SQL como cualquier función nativa.  
✅ Son útiles para cálculos específicos y reutilizables.

## 🟢 **Ejemplo 1: Función para Calcular el IVA**
```sql
DELIMITER //
CREATE FUNCTION calcular_iva(precio DECIMAL(10,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN precio * 0.16;
END;
//
DELIMITER ;
```
### ✅ **Uso de la Función en una Consulta**
```sql
SELECT calcular_iva(100) AS iva;
```

---

## 🟢 **Ejemplo 2: Función para Obtener el Nombre Completo de un Usuario**
```sql
DELIMITER //
CREATE FUNCTION obtener_nombre_completo(id_usuario INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(255);
    SELECT CONCAT(nombre, ' ', apellido) INTO nombre_completo 
    FROM usuarios WHERE id = id_usuario;
    RETURN nombre_completo;
END;
//
DELIMITER ;
```
### ✅ **Uso de la Función**
```sql
SELECT obtener_nombre_completo(1) AS nombre_completo;
```
📌 **Conclusión:**  
✅ **Funciones** → Cuando necesitas un cálculo reutilizable que devuelva un valor específico.  


## 5.4 Triggers

Los **Triggers** son mecanismos que permiten ejecutar automáticamente una acción cuando ocurre un evento específico en la base de datos (INSERT, UPDATE, DELETE). Son útiles para:

✅ Mantener la integridad de los datos.  
✅ Auditar cambios en las tablas.  
✅ Automatizar acciones sin intervención manual.

---

## 🟢 **Ejemplo 1: Trigger para Registrar Cambios en una Tabla de Auditoría**
Este trigger guarda los cambios en una tabla de auditoría cuando un usuario es actualizado.
```sql
CREATE TABLE auditoria_usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    cambio VARCHAR(255),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
```sql
DELIMITER //
CREATE TRIGGER after_usuario_update
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_usuarios (id_usuario, cambio) 
    VALUES (OLD.id, CONCAT('Cambio de ', OLD.nombre, ' a ', NEW.nombre));
END;
//
DELIMITER ;
```
### ✅ **Cómo Funciona el Trigger**
Si actualizamos un usuario:
```sql
UPDATE usuarios SET nombre = 'Carlos López' WHERE id = 1;
```
Esto insertará un registro en la tabla `auditoria_usuarios` para rastrear el cambio.

---

## 🟢 **Ejemplo 2: Trigger para Prevenir la Eliminación de Registros Claves**
Este trigger previene la eliminación de usuarios con pedidos activos.
```sql
DELIMITER //
CREATE TRIGGER before_usuario_delete
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
    DECLARE pedidos_count INT;
    SELECT COUNT(*) INTO pedidos_count FROM pedidos WHERE id_cliente = OLD.id;
    
    IF pedidos_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el usuario porque tiene pedidos activos.';
    END IF;
END;
//
DELIMITER ;
```
### ✅ **Prueba del Trigger**
Si intentamos eliminar un usuario con pedidos activos:
```sql
DELETE FROM usuarios WHERE id = 1;
```
Recibiremos un error:  
❌ *No se puede eliminar el usuario porque tiene pedidos activos.*

---

## 🟢 **Ejemplo 3: Trigger para Actualizar el Stock Después de una Venta**
Este trigger reduce automáticamente el stock de un producto cuando se realiza una venta.
```sql
DELIMITER //
CREATE TRIGGER after_insert_detalle_pedido
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE productos 
    SET stock = stock - NEW.cantidad 
    WHERE id_producto = NEW.id_producto;
END;
//
DELIMITER ;
```
### ✅ **Cómo Funciona**
Si insertamos una venta:
```sql
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES (1, 10, 3);
```
El stock del producto con `id_producto = 10` disminuirá automáticamente.

---

## 🚀 **Resumen y Cuándo Usar Cada Uno**

| Característica  | Stored Procedure | Función | Trigger |
|---------------|-----------------|---------|---------|
| **Devuelve un valor** | No | Sí | No |
| **Se usa en consultas SQL** | No | Sí | No |
| **Automatiza procesos** | Sí | Sí | Sí |
| **Se ejecuta manualmente** | Sí | Sí | No (se ejecuta automáticamente) |
| **Ejemplo de uso** | Procesamiento de datos en lote | Cálculos reutilizables | Auditoría y validación de datos |

---

 
📌 **Conclusión:**  
✅ **Triggers** → Cuando quieres automatizar acciones en respuesta a cambios en la base de datos.  

---

# 6. Implementación y Uso de un Diagrama E-R

El modelo Entidad-Relación (E-R) en MySQL Workbench permite:
- Diseñar bases de datos visualmente.
- Generar automáticamente el esquema SQL.
- Identificar relaciones entre tablas.

Ejemplo:
1. Crear un **modelo nuevo** en MySQL Workbench.
2. Agregar **entidades (tablas)** y definir sus atributos.
3. Establecer **relaciones** entre entidades.
4. **Generar el código SQL** desde el modelo.

---

# 🔹 **EXPLAIN en MySQL: Análisis y Optimización de Consultas**  

El comando **`EXPLAIN`** en MySQL es una herramienta poderosa para analizar cómo el motor de la base de datos ejecuta una consulta. Se usa principalmente para:  

✅ **Optimizar consultas** y hacerlas más rápidas.  
✅ **Identificar problemas** en el uso de índices.  
✅ **Detectar JOINs ineficientes**.  
✅ **Evitar consultas que bloqueen la base de datos**.  

---

## 🟢 **Uso Básico de `EXPLAIN`**
Para analizar una consulta, simplemente anteponemos `EXPLAIN`:  

```sql
EXPLAIN SELECT * FROM empleados WHERE salario > 3000;
```

Esto devuelve información detallada sobre cómo se ejecuta la consulta.

---

## 🔹 **Columnas de `EXPLAIN` y su Significado**  

Cuando ejecutas `EXPLAIN`, MySQL devuelve varias columnas importantes. Vamos a explicarlas con un ejemplo.

### 📌 **Ejemplo: `EXPLAIN` en una Consulta**
```sql
EXPLAIN SELECT * FROM empleados WHERE departamento_id = 5;
```

| id | select_type | table     | type  | possible_keys  | key  | key_len | ref  | rows | filtered | Extra        |
|----|------------|----------|------|----------------|------|---------|------|------|----------|--------------|
| 1  | SIMPLE     | empleados | ref  | idx_depto_id   | idx_depto_id | 4 | const | 10   | 100.00   | Using index |

### 📌 **Explicación de cada columna**
| **Columna**      | **Descripción** |
|-----------------|----------------|
| `id`            | Identificador de la consulta. Si hay subconsultas, tienen diferentes `id`. |
| `select_type`   | Tipo de consulta (SIMPLE, SUBQUERY, etc.). |
| `table`         | Tabla analizada en la consulta. |
| `type`          | Tipo de acceso a la tabla (ALL, INDEX, RANGE, REF, EQ_REF, CONST, SYSTEM). |
| `possible_keys` | Índices que MySQL **podría** usar para optimizar la consulta. |
| `key`           | Índice **realmente** utilizado por MySQL. |
| `key_len`       | Tamaño del índice usado (en bytes). |
| `ref`           | Qué columna está siendo usada en la comparación. |
| `rows`          | Número de filas que MySQL estima recorrer. |
| `filtered`      | Porcentaje de filas que serán devueltas después de aplicar filtros. |
| `Extra`         | Información adicional sobre cómo se ejecuta la consulta. |

---

## 🔹 **Tipos de Acceso en `EXPLAIN` (Columna `type`)**
La columna **`type`** es clave porque indica la eficiencia del acceso a los datos. Aquí están los tipos **de peor a mejor rendimiento**:

| `type`  | **Descripción** | **Eficiencia** |
|--------|---------------|--------------|
| `ALL`  | Escaneo completo de tabla (**muy lento**). | ❌ Peor |
| `INDEX` | Escaneo de todos los índices. | ❌❌ |
| `RANGE` | Usa un rango de valores en un índice (`BETWEEN`, `>`, `<`). | ✅ Bueno |
| `REF`  | Usa un índice, pero no es único. | ✅✅ Mejor |
| `EQ_REF` | Uso de una clave primaria o índice único. | 🔥 Excelente |
| `CONST` | Se usa una constante (búsqueda por clave primaria). | 🚀 Rápido |
| `SYSTEM` | La tabla tiene solo una fila. | ⚡ Súper rápido |

**Ejemplo: Consulta sin índice (type = ALL, INEFICIENTE)**
```sql
EXPLAIN SELECT * FROM empleados WHERE salario > 3000;
```
Si `type = ALL`, significa que está **escaneando toda la tabla**, lo que es lento.

---

## 🔹 **Cómo Optimizar Consultas con `EXPLAIN`**
Si `EXPLAIN` muestra **`type = ALL`**, es una alerta roja ⚠. Hay formas de optimizar:

### 🟢 **1. Agregar Índices**
Si una consulta escanea demasiadas filas, agregar un índice puede mejorarla.

#### 🔴 **ANTES (Sin Índice)**
```sql
EXPLAIN SELECT * FROM empleados WHERE salario > 3000;
```
- **`type = ALL` (escaneo completo de tabla) → Lento**

#### ✅ **DESPUÉS (Con Índice)**
```sql
ALTER TABLE empleados ADD INDEX idx_salario (salario);
EXPLAIN SELECT * FROM empleados WHERE salario > 3000;
```
- **`type = RANGE` (usa el índice) → Más rápido 🚀**

---

### 🟢 **2. Usar Claves Primarias o Índices Únicos**
Si consultas por un campo único, asegúrate de que sea un índice único (`UNIQUE`) o clave primaria (`PRIMARY KEY`).

#### 🔴 **INEFICIENTE (Sin Índice Único)**
```sql
EXPLAIN SELECT * FROM empleados WHERE email = 'juan@email.com';
```
- `type = ALL` ❌ (no usa índice)

#### ✅ **ÓPTIMO (Con Índice Único)**
```sql
ALTER TABLE empleados ADD UNIQUE INDEX idx_email (email);
EXPLAIN SELECT * FROM empleados WHERE email = 'juan@email.com';
```
- `type = CONST` 🚀 (súper rápido)

---

### 🟢 **3. Evitar `SELECT *`, Usar Solo las Columnas Necesarias**
Si solo necesitas algunos campos, no uses `SELECT *`, sino selecciona **solo las columnas necesarias**.

#### 🔴 **INEFICIENTE**
```sql
EXPLAIN SELECT * FROM empleados WHERE departamento_id = 3;
```

#### ✅ **ÓPTIMO**
```sql
EXPLAIN SELECT nombre, salario FROM empleados WHERE departamento_id = 3;
```

---

### 🟢 **4. Usar `EXISTS` en Lugar de `IN`**
Si tienes subconsultas, usa `EXISTS` en lugar de `IN`, ya que **IN escanea toda la tabla**, mientras que **EXISTS se detiene en la primera coincidencia**.

#### 🔴 **INEFICIENTE**
```sql
EXPLAIN SELECT * FROM empleados WHERE departamento_id IN (SELECT id FROM departamentos WHERE nombre = 'Ventas');
```
- `type = ALL` ❌

#### ✅ **ÓPTIMO**
```sql
EXPLAIN SELECT * FROM empleados WHERE EXISTS (SELECT 1 FROM departamentos WHERE empleados.departamento_id = departamentos.id AND nombre = 'Ventas');
```
- `type = EQ_REF` 🚀

---

## 🔹 **`EXPLAIN ANALYZE`: Diagnóstico Detallado**
Si quieres más detalles sobre cómo se ejecuta la consulta, usa **`EXPLAIN ANALYZE`** (disponible desde MySQL 8.0).

```sql
EXPLAIN ANALYZE SELECT * FROM empleados WHERE salario > 5000;
```
Esto no solo muestra el plan de ejecución, sino que también **ejecuta la consulta y mide su rendimiento real**.

---

## 🔹 **Conclusión: ¿Cómo Mejorar el Rendimiento con `EXPLAIN`?**
✔ **Revisar la columna `type` y evitar `ALL` siempre que sea posible**.  
✔ **Agregar índices en columnas que se usen en `WHERE`, `JOIN` y `ORDER BY`**.  
✔ **Usar `EXISTS` en lugar de `IN` en subconsultas**.  
✔ **Evitar `SELECT *` y seleccionar solo las columnas necesarias**.  
✔ **Usar `EXPLAIN ANALYZE` para obtener un análisis más profundo en MySQL 8+**.  

📌 **Ejemplo Final**: Consulta optimizada con índices y `EXPLAIN`
```sql
ALTER TABLE empleados ADD INDEX idx_departamento (departamento_id);
EXPLAIN SELECT nombre, salario FROM empleados WHERE departamento_id = 3;
```
✅ **Ahora la consulta usa `INDEX` o `REF` en lugar de `ALL`, haciéndola mucho más rápida**. 🚀


---


Acá tienen varios ejemplos prácticos usando **`EXPLAIN`** en MySQL. Cada uno muestra cómo analizar y optimizar consultas.  

---

# 📌 **Ejemplo 1: `EXPLAIN` en una Consulta Simple (Sin Índices)**  
```sql
EXPLAIN SELECT * FROM empleados WHERE salario > 5000;
```
### 🔍 **Salida:**
| id | select_type | table     | type | possible_keys | key | key_len | ref  | rows  | filtered | Extra          |
|----|------------|----------|------|--------------|----|--------|------|------|---------|--------------|
| 1  | SIMPLE     | empleados | ALL  | NULL         | NULL | NULL   | NULL | 10000 | 10.00    | Using where |

### 📌 **Explicación:**  
- **`type = ALL`** ❌ → MySQL está **escaneando toda la tabla** porque no hay índices.  
- **`possible_keys = NULL`** → No hay claves disponibles para optimizar la consulta.  
- **Solución:** Agregar un índice en la columna `salario`.  

---

# 📌 **Ejemplo 2: `EXPLAIN` con un Índice**
```sql
ALTER TABLE empleados ADD INDEX idx_salario (salario);
EXPLAIN SELECT * FROM empleados WHERE salario > 5000;
```
### 🔍 **Salida Mejorada:**
| id | select_type | table     | type  | possible_keys | key       | key_len | ref  | rows  | filtered | Extra          |
|----|------------|----------|------|--------------|-----------|--------|------|------|---------|--------------|
| 1  | SIMPLE     | empleados | RANGE | idx_salario | idx_salario | 4      | NULL | 1000  | 10.00    | Using where |

### 📌 **Explicación:**  
- **`type = RANGE`** ✅ → Ahora usa el índice `idx_salario`, mucho más rápido.  
- **`possible_keys = idx_salario`** → MySQL ha encontrado un índice útil.  
- **`rows = 1000`** → Ahora solo analiza 1000 filas en lugar de 10,000.  

---

# 📌 **Ejemplo 3: `EXPLAIN` en una Consulta con `JOIN`**
```sql
EXPLAIN SELECT e.nombre, d.nombre_departamento 
FROM empleados e 
JOIN departamentos d ON e.departamento_id = d.id_departamento;
```
### 🔍 **Salida:**
| id | select_type | table       | type  | possible_keys   | key            | key_len | ref             | rows | filtered | Extra          |
|----|------------|------------|------|----------------|---------------|--------|----------------|------|---------|--------------|
| 1  | SIMPLE     | departamentos | ALL  | PRIMARY        | NULL          | NULL   | NULL           | 10   | 100.00  |              |
| 1  | SIMPLE     | empleados     | ref  | idx_depto_id   | idx_depto_id  | 4      | d.id_departamento | 1000 | 100.00  | Using index |

### 📌 **Explicación:**  
- **`empleados.type = ref`** ✅ → MySQL usa un índice para unir las tablas.  
- **`departamentos.type = ALL`** ❌ → MySQL escanea toda la tabla `departamentos`, lo que es ineficiente.  
- **Solución:** Agregar un índice en `id_departamento`.  

```sql
ALTER TABLE departamentos ADD PRIMARY KEY (id_departamento);
```
✅ Ahora `type = EQ_REF`, mejorando la consulta.

---

# 📌 **Ejemplo 4: `EXPLAIN` en una Subconsulta (`IN` vs `EXISTS`)**

### 🔴 **Ineficiente: Uso de `IN`**
```sql
EXPLAIN SELECT * FROM empleados 
WHERE departamento_id IN (SELECT id_departamento FROM departamentos WHERE nombre_departamento = 'Ventas');
```
| id | select_type | table       | type | possible_keys | key | key_len | ref | rows | filtered | Extra          |
|----|------------|------------|------|--------------|----|--------|----|------|---------|--------------|
| 1  | SIMPLE     | departamentos | ALL  | PRIMARY     | NULL | NULL   | NULL | 10   | 100.00   | Using where |
| 2  | DEPENDENT SUBQUERY | empleados | ALL  | idx_depto_id | NULL | NULL   | NULL | 10000 | 10.00 | Using where |

### 📌 **Problema:**  
- **`empleados.type = ALL`** ❌ → Escaneo completo porque `IN` no usa índice.  
- **Solución:** Reemplazar `IN` por `EXISTS`.  

### ✅ **Optimizado: Uso de `EXISTS`**
```sql
EXPLAIN SELECT * FROM empleados e
WHERE EXISTS (SELECT 1 FROM departamentos d WHERE e.departamento_id = d.id_departamento AND d.nombre_departamento = 'Ventas');
```
| id | select_type | table       | type | possible_keys | key            | key_len | ref  | rows | filtered | Extra          |
|----|------------|------------|------|--------------|---------------|--------|------|------|---------|--------------|
| 1  | SIMPLE     | departamentos | ref  | PRIMARY     | PRIMARY        | 4      | NULL | 1    | 100.00  | Using where |
| 2  | SIMPLE     | empleados     | ref  | idx_depto_id | idx_depto_id  | 4      | NULL | 1000 | 100.00  | Using index |

✅ **Ahora la consulta usa `type = REF` y `PRIMARY`, evitando escaneo completo**. 🚀  

---

# 📌 **Ejemplo 5: `EXPLAIN ANALYZE` (Disponible en MySQL 8+)**
```sql
EXPLAIN ANALYZE SELECT * FROM empleados WHERE salario > 6000;
```
### 🔍 **Salida detallada (resumida):**
```
-> Filter: (salario > 6000)  (cost=15.00 rows=500)
    -> Index range scan on empleados using idx_salario (cost=10.00 rows=500)
```
📌 **Beneficios de `EXPLAIN ANALYZE`**:
- Muestra el **costo real de la consulta**.
- Indica el **número de filas realmente leídas**.
- Permite encontrar **bottlenecks** en la ejecución.

---

## 🔥 **Conclusión: ¿Cómo Optimizar Usando `EXPLAIN`?**
✅ **Evitar `type = ALL`** (escaneo completo).  
✅ **Agregar índices en columnas usadas en `WHERE` y `JOIN`**.  
✅ **Usar `EXISTS` en lugar de `IN` en subconsultas**.  
✅ **Evitar `SELECT *`, seleccionar solo las columnas necesarias**.  
✅ **Usar `EXPLAIN ANALYZE` para diagnosticar el rendimiento en MySQL 8+**.  



---



# 7. Resumen de la Clase

## Objetos de una DB:
- Tablas, vistas, procedimientos almacenados, funciones, triggers.

## Tablas y Vistas:
- Tipos de tablas: hecho, transaccionales, dimensionales.
- Claves: primarias, foráneas, índice, candidatas, concatenadas.

## Funciones y Triggers:
- Creación y uso en MySQL.

## Implementación de un Diagrama E-R:
- Uso de MySQL Workbench para modelado de bases de datos.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  


