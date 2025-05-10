# Unidad 8: Funciones Personalizadas y Stored Procedures en SQL

## 🧠 Objetivos de la clase

- Comprender qué son y para qué sirven las funciones personalizadas.
- Conocer la sintaxis para crear funciones en SQL.
- Implementar funciones personalizadas con ejemplos reales.
- Reconocer qué es un stored procedure.
- Identificar los distintos tipos de stored procedures.
- Implementar procedimientos almacenados (stored procedures) útiles para una institución educativa.

---

Claro, aquí tienes la adaptación del concepto y ejemplos a MySQL:

---

## 1️⃣ ¿Qué es una función personalizada en SQL?

Una **función personalizada** (o "user-defined function", UDF) en MySQL es un bloque de código que se puede **reutilizar** para realizar cálculos o transformaciones y devolver un valor.

👉 **Sirve para:**

- Simplificar consultas complejas.
- Encapsular lógica de negocio.
- Reutilizar cálculos o transformaciones.

🧾 **Tipos de funciones en SQL:**

- **Escalares:** Devuelven un solo valor (por ejemplo, una nota promedio).
- **De tabla:** Devuelven una tabla completa (aunque en MySQL las funciones personalizadas suelen ser escalares).

---

## 2️⃣ Sintaxis básica para crear funciones escalares

```sql
CREATE FUNCTION nombre_funcion (param1 tipo, param2 tipo)
RETURNS tipo_de_dato
DETERMINISTIC
BEGIN
    -- Lógica
    RETURN resultado;
END;
```

### 🧠 Explicación

- **`CREATE FUNCTION`**: Define una nueva función personalizada.
- **`param1 tipo, param2 tipo`**: Especifica los parámetros de entrada y sus tipos.
- **`RETURNS tipo_de_dato`**: Define el tipo de valor que la función devolverá.
- **`DETERMINISTIC`**: Indica que la función siempre devuelve el mismo resultado con los mismos parámetros.
- **`BEGIN ... END`**: Contiene la lógica de la función.

---

## 📚 Ejemplo práctico: Calcular nota final de un alumno

### Supongamos que tenemos una tabla de notas

```sql
CREATE TABLE Notas (
    id INT PRIMARY KEY,
    alumno_id INT,
    parcial1 DECIMAL(5,2),
    parcial2 DECIMAL(5,2),
    final DECIMAL(5,2)
);
```

### Función para calcular el promedio simple

```sql
CREATE FUNCTION calcular_promedio (
  p1 DECIMAL(5,2),
  p2 DECIMAL(5,2),
  final DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
  RETURN (p1 + p2 + final) / 3;
END;
```

### Cómo usarla

```sql
SELECT alumno_id,
       calcular_promedio(parcial1, parcial2, final) AS nota_final
FROM Notas;
```

---

## 🧠 ¿Qué hace esta consulta?

La consulta **obtiene el ID del alumno** y **calcula su nota final** usando la función `calcular_promedio`, que toma las notas de los parciales y el examen final. La consulta se aplica a la tabla `Notas`.

---

## 🧩 Desglose paso a paso

### `SELECT`

- **Palabra clave** que inicia una consulta y permite **pedir datos** de una tabla.

```sql
SELECT columna1, columna2
```

> En este caso:

```sql
SELECT alumno_id,
```

Selecciona la columna `alumno_id` (el ID del alumno).

---

### `calcular_promedio(...)`

#### 🔹 ¿Qué es `calcular_promedio(...)`?

Es una **función personalizada** creada por el usuario, que **devuelve el promedio** de las tres notas (parcial1, parcial2, final).

---

### `AS nota_final`

- **`AS`** sirve para darle un **alias** (nombre alternativo o temporal) a una columna en el resultado.
- En este caso, el resultado de la función `calcular_promedio(...)` se mostrará como `nota_final`.

```sql
calcular_promedio(...) AS nota_final
```

> Es decir: "Muéstrame el promedio, y llámalo `nota_final` en el resultado".

---

### `FROM Notas`

- **`FROM`** indica de **dónde** se van a obtener los datos. En este caso, de la tabla `Notas`.

> 🗂️ La tabla `Notas` tiene columnas como `alumno_id`, `parcial1`, `parcial2`, `final`.

---

## 🧮 ¿Cómo sería esa función `calcular_promedio`?

La función `calcular_promedio` en MySQL sería de esta forma:

```sql
CREATE FUNCTION calcular_promedio(p1 DECIMAL(5,2), p2 DECIMAL(5,2), final DECIMAL(5,2))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(5,2);
    SET promedio = (p1 + p2 + final) / 3;
    RETURN promedio;
END;
```

### Detalles

- **`DECLARE promedio DECIMAL(5,2);`**: Declara una variable `promedio` de tipo `DECIMAL(5,2)`.
- **`SET promedio = ...;`**: Asigna el valor del promedio.
- **`RETURN promedio;`**: Devuelve el valor calculado.

---

## 💡 ¿Qué significa `=` en SQL?

En SQL, el signo igual `=` es un **operador de comparación o asignación**, dependiendo del contexto.

### Se usa para

1. **Comparar valores** en condiciones (`WHERE`, `IF`, etc.):
   👉 Ejemplo:

   ```sql
   SELECT * FROM Notas WHERE alumno_id = 1;
   ```

2. **Asignar valores** a variables dentro de procedimientos o funciones, usando `SET`:

   ```sql
   SET promedio = (p1 + p2 + final) / 3;
   ```

---

Este ejemplo muestra cómo crear una función personalizada en MySQL para calcular el promedio de las notas de un alumno y usarla en una consulta. Las funciones personalizadas en SQL son una herramienta poderosa para simplificar y organizar el código.

---

### 🧪 Ejemplo en MySQL Workbench

```sql
DELIMITER //

CREATE PROCEDURE ejemplo_asignacion()
BEGIN
    DECLARE promedio DECIMAL(5,2);
    SET promedio = (8 + 9 + 10) / 3;
    SELECT promedio AS resultado;
END //

DELIMITER ;
```

Y se ejecuta con:

```sql
CALL ejemplo_asignacion();
```

---

## 📌 Resumen visual

| Concepto              | Significado                                   |
| --------------------- | --------------------------------------------- |
| `SELECT`              | Pide columnas de una tabla                    |
| `calcular_promedio()` | Función que devuelve el promedio de 3 notas   |
| `AS nota_final`       | Alias: renombra la columna en el resultado    |
| `FROM Notas`          | Indica la tabla de donde se sacan los datos   |
| `=`                   | Operador de comparación o asignación          |

---

## 💾 Stored Procedures (Procedimientos Almacenados) - Explicación Completa para Principiantes

---

## 1️⃣ ¿Qué es un Stored Procedure?

Un **Stored Procedure** (procedimiento almacenado) es un **bloque de código SQL que se guarda en la base de datos** y que puede ser ejecutado cuando lo necesitemos.

En lugar de escribir siempre la misma serie de instrucciones SQL, las podemos guardar con un nombre, y luego simplemente llamarlas cuando las necesitemos.

📦 Piensalo como una "función" que vive dentro de la base de datos.

---

## 2️⃣ ¿Para qué sirve?

🔧 Los Stored Procedures se usan para:

- Insertar datos
- Actualizar registros
- Eliminar registros
- Validar condiciones antes de hacer algo
- Automatizar tareas repetitivas (como registrar una nota o validar la asistencia)
- Encapsular lógica de negocio compleja

---

## 3️⃣ ¿Por qué usar Stored Procedures?

### ✅ Ventajas

| Ventaja                    | Explicación                                                               |
| -------------------------- | ------------------------------------------------------------------------- |
| 📦 Reutilización de código | Se escribe una sola vez y se puede usar muchas veces                      |
| 🔒 Seguridad               | Se puede dar permiso solo para ejecutar el procedimiento, no ver la tabla |
| 🚀 Rendimiento             | Se compila una vez y luego se ejecuta más rápido                          |
| 🤝 Organización            | Ayuda a mantener el código ordenado y dividido en bloques reutilizables   |
| 🧠 Lógica condicional      | Permite usar IF, WHILE, CASE, etc. dentro de él                           |

---

## 4️⃣ Diferencia entre Función y Stored Procedure

| Característica                | Función                    | Stored Procedure                     |
| ----------------------------- | -------------------------- | ------------------------------------ |
| ¿Devuelve valor?              | Sí, uno solo (obligatorio) | Opcional                             |
| ¿Puede tener lógica compleja? | Limitada                   | Sí (IF, WHILE, INSERT, UPDATE, etc.) |
| ¿Se puede usar en SELECT?     | Sí                         | No directamente                      |
| ¿Modifica datos?              | No (en teoría)             | Sí                                   |

---

## 5️⃣ Sintaxis básica de un Stored Procedure

```sql
DELIMITER //

CREATE PROCEDURE nombre_procedimiento(
    IN param1 tipo,
    IN param2 tipo
)
BEGIN
    -- Bloque de código SQL
END //

DELIMITER ;

```

🛠️ Para ejecutarlo:

```sql
CALL nombre_procedimiento(valor1, valor2);

```

---

## 6️⃣ Ejemplo 1: Agregar un alumno

### Crear tabla

```sql
CREATE TABLE Alumnos (
    id INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100),
    fecha_nacimiento DATE
);
```

---

## **1️⃣ Crear Stored Procedure en MySQL**

En MySQL, el **DELIMITER** se utiliza para cambiar el delimitador temporalmente (en este caso `//`) y así poder definir un procedimiento que contiene múltiples sentencias. Además, en MySQL no es necesario especificar el tipo de parámetro (`IN` es opcional, pero es recomendable usarlo por claridad).

### Procedimiento para agregar un alumno

```sql
DELIMITER //

CREATE PROCEDURE agregar_alumno (
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_fecha_nac DATE
)
BEGIN
    INSERT INTO Alumnos (nombre, apellido, email, fecha_nacimiento)
    VALUES (p_nombre, p_apellido, p_email, p_fecha_nac);
END //

DELIMITER ;
```

---

## **2️⃣ Ejecutar Stored Procedure en MySQL**

En MySQL, se usa `CALL` en lugar de `EXEC` para invocar un procedimiento almacenado. A continuación, te muestro cómo llamar al procedimiento `agregar_alumno`:

```sql
CALL agregar_alumno('Laura', 'Pérez', 'laura.perez@email.com', '2004-03-12');
```

**Notas importantes:**

- No es necesario usar el prefijo `@` para los parámetros en la llamada, ya que los parámetros son directamente pasados al procedimiento.
- El delimitador `DELIMITER` es utilizado para cambiar temporalmente el carácter delimitador en la definición del procedimiento y puede ser revertido a su valor por defecto (;) después de definir el procedimiento.

---

## **3️⃣ Ejemplo 2: Registrar una Nota en MySQL**

### Tabla `Notas`

En MySQL no se usa `IDENTITY`, sino que se usa `AUTO_INCREMENT` para generar valores de manera automática para las claves primarias. Además, en MySQL no es necesario especificar el tipo de auto incremento en el momento de la declaración de las columnas.

```sql
CREATE TABLE Notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT,
    materia VARCHAR(100),
    parcial1 DECIMAL(4,2),
    parcial2 DECIMAL(4,2),
    final DECIMAL(4,2)
);
```

### Stored Procedure para registrar una nota

En MySQL, se puede crear un procedimiento almacenado para insertar una nueva nota para un alumno en la tabla `Notas`:

```sql
DELIMITER //

CREATE PROCEDURE registrar_nota (
    IN p_alumno_id INT,
    IN p_materia VARCHAR(100),
    IN p_parcial1 DECIMAL(4,2),
    IN p_parcial2 DECIMAL(4,2),
    IN p_final DECIMAL(4,2)
)
BEGIN
    INSERT INTO Notas (alumno_id, materia, parcial1, parcial2, final)
    VALUES (p_alumno_id, p_materia, p_parcial1, p_parcial2, p_final);
END //

DELIMITER ;
```

### Ejecutar la inserción de una nota

Ahora, para registrar una nota para un alumno en la tabla `Notas`, puedes usar el siguiente comando en MySQL:

```sql
CALL registrar_nota(1, 'Matemáticas', 8.5, 7.0, 9.0);
```

En este caso:

- `1` es el `alumno_id`.
- `'Matemáticas'` es el nombre de la materia.
- `8.5`, `7.0` y `9.0` son las calificaciones de los parciales y final.

---

### Resumen de cambios importantes

- En MySQL, el delimitador `DELIMITER` se utiliza para cambiar el separador temporalmente mientras se crea un procedimiento.
- La palabra clave `AUTO_INCREMENT` reemplaza a `IDENTITY` en la declaración de columnas con claves primarias auto incrementales.
- Para ejecutar un procedimiento en MySQL, se usa `CALL` en lugar de `EXEC`.

Ahora puedes crear y ejecutar procedimientos almacenados con estas instrucciones adaptadas a MySQL.

### Stored Procedure

```sql
DELIMITER //

CREATE PROCEDURE registrar_nota(
    IN alumno_id INT,
    IN materia VARCHAR(100),
    IN parcial1 DECIMAL(4,2),
    IN parcial2 DECIMAL(4,2),
    IN final DECIMAL(4,2)
)
BEGIN
    INSERT INTO Notas (alumno_id, materia, parcial1, parcial2, final)
    VALUES (alumno_id, materia, parcial1, parcial2, final);
END //

DELIMITER ;

```

### Ejecutar

```sql
CALL registrar_nota(1, 'Matemática', 7.5, 8.0, 9.0);

```

---

## 8️⃣ Stored Procedure con lógica condicional

Supongamos que solo queremos actualizar el email **si el alumno existe**:

```sql
DELIMITER //

CREATE PROCEDURE actualizar_email (
    IN p_id INT,
    IN p_nuevo_email VARCHAR(100)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Alumnos WHERE id = p_id) THEN
        UPDATE Alumnos
        SET email = p_nuevo_email
        WHERE id = p_id;
    ELSE
        SELECT 'El alumno no existe.' AS mensaje;
    END IF;
END //

DELIMITER ;

```

---

## 9️⃣ Stored Procedure que devuelve un resultado (SELECT)

```sql
DELIMITER //

CREATE PROCEDURE obtener_datos_alumno(IN id INT)
BEGIN
    SELECT * FROM Alumnos WHERE id = id;
END //

DELIMITER ;

```

### Ejecutar

```sql
CALL obtener_datos_alumno(2);

```

---

## 🔟 Stored Procedure con bucles (`WHILE`)

```sql
DELIMITER //

CREATE PROCEDURE listar_alumnos_manual()
BEGIN
    DECLARE contador INT DEFAULT 1;
    DECLARE max_id INT;

    -- Obtener el ID máximo
    SELECT MAX(id) INTO max_id FROM Alumnos;

    -- Bucle WHILE para recorrer los alumnos
    WHILE contador <= max_id DO
        -- Verificar si el alumno existe
        IF EXISTS (SELECT 1 FROM Alumnos WHERE id = contador) THEN
            SELECT * FROM Alumnos WHERE id = contador;
        END IF;

        -- Incrementar el contador
        SET contador = contador + 1;
    END WHILE;
END //

DELIMITER ;

```

### Ejecución del Procedimiento

```sql
CALL listar_alumnos_manual();
```

---

Vamos a **desglosar completamente** cada parte del tema **Stored Procedures** de manera **clara, paso a paso y para principiantes**, explicando qué es cada cosa y **para qué sirve**, con ejemplos aplicados al contexto de una institución educativa.

---

# 📘 **Stored Procedures: Explicado desde cero**

---

## 🔹 **¿Qué es un Stored Procedure?**

Un **Stored Procedure** (en español, *Procedimiento Almacenado*) es un **conjunto de instrucciones SQL** que se guarda en la base de datos y se puede ejecutar cuando lo necesites, con un solo comando.

🧠 **Ejemplo real**: Imaginá que cada vez que agregás un alumno nuevo a la base de datos, tenés que escribir este código:

```sql
INSERT INTO Alumnos (nombre, apellido, email, fecha_nacimiento)
VALUES ('Juan', 'Gómez', 'juan@email.com', '2003-05-12');
```

En lugar de repetir eso mil veces, podés crear un procedimiento con nombre propio, por ejemplo: `agregar_alumno`, y después lo llamás así:

```sql
CALL agregar_alumno('Juan', 'Gómez', 'juan@email.com', '2003-05-12');
```

---

## 🔹 **¿Para qué sirve un Stored Procedure?**

| ¿Qué hace?                    | ¿Para qué sirve?                                     |
| ----------------------------- | ---------------------------------------------------- |
| Agrupa instrucciones SQL      | Para evitar repetir código                           |
| Acepta parámetros             | Para que sea flexible (como una función)             |
| Guarda lógica condicional     | Para hacer cosas solo si se cumple una condición     |
| Ejecuta operaciones complejas | Como insertar, actualizar, eliminar                  |
| Mejora el rendimiento         | Porque se precompila una vez y se ejecuta más rápido |

---

## 🔹 **Sintaxis básica en MySQL**

```sql
DELIMITER //

CREATE PROCEDURE nombre_del_procedimiento(
    IN parametro1 tipo_dato,
    IN parametro2 tipo_dato
)
BEGIN
    -- Aquí van las instrucciones SQL
END //

DELIMITER ;
```

---

## 🔹 **¿Qué significa cada parte?**

| Parte                      | ¿Qué es?         | ¿Para qué sirve?                                                                   |
| -------------------------- | ---------------- | ---------------------------------------------------------------------------------- |
| `CREATE PROCEDURE`         | Palabra clave    | Le dice a MySQL que vas a crear un procedimiento                                   |
| `nombre_del_procedimiento` | Nombre elegido   | Es el nombre con el que lo vas a ejecutar                                          |
| `IN parametro tipo_dato`   | Parámetros       | Son los valores que le pasás desde afuera (como el nombre del alumno, por ejemplo) |
| `BEGIN ... END`            | Bloque de código | Encierra todo lo que va a hacer ese procedimiento                                  |

---

## 🔹 **¿Cómo se ejecuta?**

Una vez creado, se ejecuta así:

```sql
CALL nombre_del_procedimiento(valor1, valor2);
```

✅ **Ejemplo**:

```sql
CALL agregar_alumno('Laura', 'Pérez', 'laura@email.com', '2004-03-12');
```

---

### Explicación adicional de MySQL

1. **Parámetros**: En MySQL, los parámetros se definen con `IN` para entrada, `OUT` para salida, y `INOUT` para ambos. En el ejemplo anterior, todos son de entrada (`IN`).

2. **Delimitador**: En MySQL, se usa el `DELIMITER` para cambiar temporalmente el delimitador de sentencias para poder definir procedimientos con el símbolo `;` dentro del bloque del procedimiento.

3. **Ejecución**: A diferencia de SQL Server que usa `EXEC`, en MySQL se utiliza el comando `CALL` para ejecutar un procedimiento almacenado.

---

## 🔹 **Ejemplo 1: Agregar un alumno**

### Crear tabla

```sql
CREATE TABLE Alumnos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100),
    fecha_nacimiento DATE
);
```

### Crear el procedimiento

```sql
DELIMITER //

CREATE PROCEDURE agregar_alumno(
    IN nombre VARCHAR(100),
    IN apellido VARCHAR(100),
    IN email VARCHAR(100),
    IN fecha_nac DATE
)
BEGIN
    INSERT INTO Alumnos (nombre, apellido, email, fecha_nacimiento)
    VALUES (nombre, apellido, email, fecha_nac);
END //

DELIMITER ;
```

---

## 🔹 **Ejemplo 2: Registrar una nota**

### Tabla

```sql
CREATE TABLE Notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT,
    materia VARCHAR(100),
    parcial1 DECIMAL(4,2),
    parcial2 DECIMAL(4,2),
    final DECIMAL(4,2)
);
```

### Procedimiento

```sql
DELIMITER //

CREATE PROCEDURE registrar_nota(
    IN alumno_id INT,
    IN materia VARCHAR(100),
    IN parcial1 DECIMAL(4,2),
    IN parcial2 DECIMAL(4,2),
    IN final DECIMAL(4,2)
)
BEGIN
    INSERT INTO Notas (alumno_id, materia, parcial1, parcial2, final)
    VALUES (alumno_id, materia, parcial1, parcial2, final);
END //

DELIMITER ;
```

### ¿Qué significa cada parte?

| Parte                     | ¿Qué hace?                     |
| ------------------------- | ------------------------------ |
| `IN alumno_id INT`        | Recibe el ID del alumno        |
| `IN materia VARCHAR(100)` | Recibe el nombre de la materia |
| `DECIMAL(4,2)`            | Guarda decimales como 8.75     |

---

## 🔹 **Ejemplo 3: Actualizar un dato solo si existe**

```sql
DELIMITER //

CREATE PROCEDURE actualizar_email (
    IN p_id INT,
    IN p_nuevo_email VARCHAR(100)
)
BEGIN
    IF EXISTS (SELECT 1 FROM Alumnos WHERE id = p_id) THEN
        UPDATE Alumnos
        SET email = p_nuevo_email
        WHERE id = p_id;
    ELSE
        SELECT 'El alumno no existe.' AS mensaje;
    END IF;
END //

DELIMITER ;
```

✅ **¿Qué pasa acá?**

- `IF EXISTS (...)` → Verifica si existe el alumno.
- `UPDATE` → Solo se ejecuta si el alumno está en la tabla.

---

## 🔹 **Ejemplo 4: Consultar y mostrar datos**

```sql
DELIMITER //

CREATE PROCEDURE ver_notas(
    IN alumno_id INT
)
BEGIN
    SELECT * FROM Notas WHERE alumno_id = alumno_id;
END //

DELIMITER ;
```

---


## 🔹 **Bonus: ¿Qué significa cada símbolo?**

| Símbolo / palabra | ¿Qué significa?       | ¿Para qué sirve?                                                                                                                                                                                                                               |
| ----------------- | --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `IN`              | Parámetro             | Define que el parámetro se pasa como **entrada** al procedimiento o función. Este es el valor que el usuario debe proporcionar al ejecutar el procedimiento.                                                                                   |
| `@`               | Parámetro             | **Indicador de parámetro** en MySQL cuando se usa en la invocación del procedimiento. No se usa al declarar un parámetro dentro del procedimiento, pero sí al invocar variables o almacenar valores. Por ejemplo, `SET @mi_variable = valor;`. |
| `=`               | Igualdad / Asignación | **Asignación** de valores a variables (dentro de procedimientos) o para **comparación** en condiciones. Por ejemplo, `SET @mi_variable = valor;` o `IF variable = valor THEN ...`.                                                             |
| `BEGIN ... END`   | Bloque                | **Agrupa las instrucciones** dentro del procedimiento, función o trigger. Permite agrupar múltiples sentencias SQL para ejecutar como un bloque único.                                                                                         |
| `IF`              | Condición             | Utilizado para **ejecutar una acción condicional** dentro del procedimiento, función o trigger. Por ejemplo, `IF condición THEN ... END IF;`.                                                                                                  |
| `DELIMITER`       | Delimitador           | **Cambia temporalmente el delimitador** de comandos, permitiendo usar el `;` dentro de procedimientos, funciones o triggers sin que se termine la declaración del bloque. Por ejemplo: `DELIMITER //`.                                         |
| `CALL`            | Ejecutar              | **Ejecuta un procedimiento almacenado**. Se usa para invocar procedimientos almacenados en MySQL. Por ejemplo: `CALL procedimiento(param1, param2);`.                                                                                          |

---

### Detalles adicionales:

* **`IN`**: En MySQL, los parámetros pueden ser `IN`, `OUT`, o `INOUT`, dependiendo de si el parámetro es solo de entrada, solo de salida o de ambos. El uso más común es `IN`, ya que la mayoría de los procedimientos utilizan parámetros que solo reciben valores de entrada.

* **`@`**: Se usa cuando **se quiere referenciar una variable** o cuando se trabaja con variables de sesión, como `@mi_variable`. En la declaración de un parámetro de procedimiento no es necesario el uso de `@`, pero cuando se hace una asignación dentro del procedimiento, o en la ejecución del procedimiento con variables, sí se usa.

* **`DELIMITER`**: Cambia el carácter delimitador para poder definir procedimientos o funciones que contienen múltiples sentencias, sin que el sistema lo interprete como el final de la instrucción. Se suele cambiar temporalmente a algo como `//` y luego volver a `;` al finalizar.

---

En MySQL, se utiliza `IN` para indicar que el parámetro es de entrada (entrada de datos), `OUT` para los parámetros de salida, y `INOUT` para los parámetros que pueden ser tanto de entrada como de salida. Además, el delimitador debe cambiarse con `DELIMITER` para poder usar `;` dentro del bloque del procedimiento almacenado.

---

## ✅ 1. Función: Calcular el porcentaje de asistencia

### 🎯 Objetivo

Dado el total de clases y la cantidad de clases a las que asistió un alumno, calcular el porcentaje de asistencia.

### 🧾 Sintaxis

```sql
CREATE FUNCTION calcular_asistencia (
    total_clases INT,
    asistencias INT
)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE porcentaje DECIMAL(5,2);

    IF total_clases = 0 THEN
        SET porcentaje = 0;
    ELSE
        SET porcentaje = (asistencias * 100.0) / total_clases;
    END IF;

    RETURN porcentaje;
END;
```

### 🧪 Ejemplo de uso

```sql
SELECT calcular_asistencia(40, 30) AS porcentaje_asistencia;
-- Resultado: 75.00
```

---

## ✅ 2. Stored Procedure: Registrar una nueva nota

### 🎯 Objetivo

Registrar una nueva nota para un alumno en la tabla `Notas`.

### 🗃️ Supongamos esta estructura para la tabla

```sql
CREATE TABLE Notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT,
    parcial1 DECIMAL(5,2),
    parcial2 DECIMAL(5,2),
    final DECIMAL(5,2)
);
```

### 🔧 Stored Procedure

```sql
DELIMITER //

CREATE PROCEDURE registrar_nota(
    IN alumno_id INT,
    IN parcial1 DECIMAL(5,2),
    IN parcial2 DECIMAL(5,2),
    IN final DECIMAL(5,2)
)
BEGIN
    INSERT INTO Notas (alumno_id, parcial1, parcial2, final)
    VALUES (alumno_id, parcial1, parcial2, final);
END //

DELIMITER ;
```

### 🧪 Ejemplo de ejecución

```sql
CALL registrar_nota(1, 7.5, 8.0, 9.0);
```

---

## 📌 Recomendaciones para recordar

- Usa **funciones** cuando necesites **calcular y devolver un valor**. Son útiles para operaciones simples y cálculos, como el porcentaje de asistencia.
- Usa **stored procedures** cuando necesites realizar **acciones complejas o múltiples pasos** (por ejemplo, insertar datos o actualizar tablas). Son ideales para operaciones que involucren lógica condicional o manipulación de múltiples tablas.
- Nombra claramente tus **funciones** y **procedimientos** para que su propósito sea evidente y fácil de entender.
- Agrega **validaciones** dentro de los **stored procedures** para evitar errores comunes (por ejemplo, verificar si el alumno existe antes de registrar la nota).

---

# 📘 Triggers, Joins y Stored Procedures — Paso a paso para principiantes

---

## 🔶 1️⃣ ¿Qué es un `JOIN`?

Un `JOIN` (*unión*) se utiliza para **combinar datos de varias tablas relacionadas**. Por ejemplo, si tenemos una tabla de **alumnos** y otra de **notas**, podemos obtener el **nombre del alumno junto con sus notas**, aunque los datos estén almacenados en tablas diferentes.

### 🎓 Ejemplo educativo

Supongamos que tenemos estas dos tablas:

```sql
-- Tabla Alumnos
CREATE TABLE Alumnos (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  apellido VARCHAR(100)
);

-- Tabla Notas
CREATE TABLE Notas (
  id INT PRIMARY KEY,
  alumno_id INT,
  materia VARCHAR(100),
  nota DECIMAL(4,2)
);
```

### 👉 `JOIN` para mostrar el nombre del alumno junto con sus notas

```sql
SELECT 
  A.nombre,
  A.apellido,
  N.materia,
  N.nota
FROM Alumnos A
JOIN Notas N ON A.id = N.alumno_id;
```

| Parte                   | ¿Qué significa?                                |
| ----------------------- | ---------------------------------------------- |
| `SELECT`                | Lo que queremos mostrar                        |
| `FROM Alumnos A`        | Alias `A` para la tabla `Alumnos`              |
| `JOIN Notas N`          | Une con la tabla `Notas`, alias `N`            |
| `ON A.id = N.alumno_id` | Condición para unir: el ID del alumno coincide |

---

## 🔶 2️⃣ ¿Qué es un `TRIGGER`?

Un **Trigger** es como una **alarma o acción automática** que se ejecuta en respuesta a un evento en una tabla, como `INSERT`, `UPDATE` o `DELETE`. 🧠 Se ejecuta solo **sin que lo llames**, cuando ocurre algo en la base de datos.

### 🎓 Ejemplo: Registrar cambios en las notas

Supongamos que queremos guardar un registro cada vez que se actualiza la nota de un alumno.

#### 1. Creamos la tabla para registrar cambios

```sql
CREATE TABLE HistorialNotas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  alumno_id INT,
  materia VARCHAR(100),
  nota_anterior DECIMAL(4,2),
  nota_nueva DECIMAL(4,2),
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 2. Creamos el trigger

```sql
DELIMITER //

CREATE TRIGGER trg_actualizar_nota
AFTER UPDATE ON Notas
FOR EACH ROW
BEGIN
  INSERT INTO HistorialNotas (alumno_id, materia, nota_anterior, nota_nueva)
  VALUES (OLD.alumno_id, OLD.materia, OLD.nota, NEW.nota);
END //

DELIMITER ;
```

### 🧩 ¿Qué significan `OLD` y `NEW`?

| Palabra clave | ¿Qué representa?                 |
| ------------- | -------------------------------- |
| `OLD`         | Los datos **antes** del cambio   |
| `NEW`         | Los datos **después** del cambio |

Esto permite guardar el **antes y después** del cambio en la nota.

---

## 🔶 3️⃣ ¿Cómo combinar Stored Procedure + Join?

Podemos usar un `JOIN` dentro de un `Stored Procedure` para mostrar información combinada.

### 🎓 Ejemplo: Ver el detalle de un alumno con sus notas

```sql
DELIMITER //

CREATE PROCEDURE ver_detalle_alumno (
    IN p_alumno_id INT
)
BEGIN
    SELECT 
        A.nombre,
        A.apellido,
        N.materia,
        N.nota
    FROM Alumnos A
    JOIN Notas N ON A.id = N.alumno_id
    WHERE A.id = p_alumno_id;
END //

DELIMITER ;
```

Y lo ejecutas así:

```sql
CALL ver_detalle_alumno(1);
```

---

## 🔶 4️⃣ ¿Cómo combinar Stored Procedure + Trigger?

Imagina que tienes un procedimiento que **modifica una nota**. Ese cambio activará el trigger que guarda el historial automáticamente.

### 🎓 Ejemplo: Modificar una nota y activar el trigger

```sql
DELIMITER //

CREATE PROCEDURE modificar_nota (
    IN p_nota_id INT,
    IN p_nueva_nota DECIMAL(4,2)
)
BEGIN
    UPDATE Notas
    SET nota = p_nueva_nota
    WHERE id = p_nota_id;
END //

DELIMITER ;
```

### Se llama

```sql
CALL modificar_nota(3, 9.75);
```

Y gracias al trigger `trg_actualizar_nota`, el cambio se guarda automáticamente en la tabla `HistorialNotas`.

---

## 🧠 Resumen visual

| Concepto           | ¿Qué hace?          | Cuándo se usa                                  |
| ------------------ | ------------------- | ---------------------------------------------- |
| `JOIN`             | Combina tablas      | Para ver datos relacionados (alumno + notas)   |
| `Stored Procedure` | Bloque reutilizable | Para insertar, modificar, consultar con lógica |
| `Trigger`          | Acción automática   | Se ejecuta después de un cambio (sin llamar)   |

---

## 🏁 Conclusión

Las funciones, procedimientos almacenados y triggers son herramientas esenciales para automatizar, organizar y simplificar la gestión de bases de datos. Combinados correctamente, te permiten hacer más eficiente el manejo de la lógica de la base de datos, manteniendo la integridad y el control en los procesos automáticos y personalizados.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
