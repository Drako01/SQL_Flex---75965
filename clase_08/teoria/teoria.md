# Unidad 8: Funciones Personalizadas y Stored Procedures en SQL

## 🧠 Objetivos de la clase

- Comprender qué son y para qué sirven las funciones personalizadas.
- Conocer la sintaxis para crear funciones en SQL.
- Implementar funciones personalizadas con ejemplos reales.
- Reconocer qué es un stored procedure.
- Identificar los distintos tipos de stored procedures.
- Implementar procedimientos almacenados (stored procedures) útiles para una institución educativa.

---

## 1️⃣ ¿Qué es una función personalizada en SQL?

Una **función personalizada** (o "user-defined function", UDF) es un bloque de código reutilizable que acepta parámetros, realiza operaciones y devuelve un valor.

👉 **Sirve para:**

- Simplificar consultas complejas.
- Encapsular lógica de negocio.
- Reutilizar cálculos o transformaciones.

🧾 **Tipos de funciones en SQL:**

- **Escalares:** Devuelven un solo valor (ej. una nota promedio).
- **De tabla:** Devuelven una tabla completa.

---

## 2️⃣ Sintaxis básica para crear funciones escalares

```sql
CREATE FUNCTION nombre_funcion (@param1 tipo, @param2 tipo)
RETURNS tipo_de_dato
AS
BEGIN
    DECLARE @resultado tipo_de_dato;
    -- Lógica
    SET @resultado = ...;
    RETURN @resultado;
END;
````

---

## 📚 Ejemplo práctico: Calcular nota final de un alumno

### Supongamos una tabla de notas

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
    @p1 DECIMAL(5,2),
    @p2 DECIMAL(5,2),
    @final DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @promedio DECIMAL(5,2);
    SET @promedio = (@p1 + @p2 + @final) / 3;
    RETURN @promedio;
END;
```

### Cómo usarla

```sql
SELECT alumno_id,
       dbo.calcular_promedio(parcial1, parcial2, final) AS nota_final
FROM Notas;
```

---

## 🧠 ¿Qué hace esta consulta?

Esta consulta **obtiene el ID del alumno** y **calcula su nota final** usando una función llamada `calcular_promedio`, tomando las notas del parcial 1, parcial 2 y el final. La consulta se aplica sobre la tabla `Notas`.

---

## 🧩 Desglose paso a paso

### `SELECT`

Palabra clave que **inicia una consulta**. Sirve para **pedir datos** de una tabla.

```sql
SELECT columna1, columna2
```

> En este caso:

```sql
SELECT alumno_id,
```

Selecciona la columna `alumno_id` (el ID del alumno).

---

### `dbo.calcular_promedio(...)`

#### 🔹 ¿Qué es `calcular_promedio(...)`?

Es una **función personalizada** (creada por el usuario) que probablemente **devuelve el promedio** de tres notas (parcial1, parcial2, final).

#### 🔹 ¿Qué es `dbo`?

`dbo` es el **esquema** al que pertenece la función. En bases de datos como **SQL Server**, cada objeto (tabla, función, etc.) **pertenece a un esquema**.

- `dbo` significa **database owner** (propietario de la base de datos).
- Es el esquema **por defecto** en la mayoría de los casos.

> 📌 Entonces `dbo.calcular_promedio(...)` significa:
> “Ejecutar la función `calcular_promedio` del esquema `dbo`”.

---

### `AS nota_final`

- `AS` sirve para darle un **alias** (nombre alternativo o temporal) a una columna en el resultado.
- En este caso, el resultado de la función `calcular_promedio(...)` se mostrará como `nota_final`.

```sql
dbo.calcular_promedio(...) AS nota_final
```

> Es decir: “Mostrame el promedio, y llamalo `nota_final` en el resultado”.

---

### `FROM Notas`

Indica de **dónde** se van a obtener los datos. En este caso, de la tabla `Notas`.

> 🗂️ La tabla `Notas` tiene columnas como `alumno_id`, `parcial1`, `parcial2`, `final`.

---

## 🧮 ¿Cómo sería esa función `calcular_promedio`?

Te muestro un ejemplo real en SQL Server:

```sql
CREATE FUNCTION calcular_promedio (
  @p1 DECIMAL(5,2),
  @p2 DECIMAL(5,2),
  @final DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
AS
BEGIN
  RETURN (@p1 + @p2 + @final) / 3;
END;
```

---

## 💡 ¿Qué significa `=` en SQL?

El signo igual `=` es un **operador de comparación**.

### Se usa para

- Comparar valores (ej: `WHERE alumno_id = 1`)
- Asignar valores dentro de sentencias como `SET`, o dentro de funciones y procedimientos.

Ejemplo:

```sql
DECLARE @promedio DECIMAL(5,2);
SET @promedio = (8 + 9 + 10) / 3;
```

---

## 📌 Resumen visual

| Concepto              | Significado                                   |
| --------------------- | --------------------------------------------- |
| `SELECT`              | Pide columnas de una tabla                    |
| `dbo`                 | Esquema (propietario de objeto en SQL Server) |
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
| ¿Usa `RETURN`?                | Sí                         | Opcional (usa `OUTPUT` o `PRINT`)    |

---

## 5️⃣ Sintaxis básica de un Stored Procedure

```sql
CREATE PROCEDURE nombre_procedimiento
    @param1 tipo,
    @param2 tipo
AS
BEGIN
    -- Bloque de código SQL
END;
```

🛠️ Para ejecutarlo:

```sql
EXEC nombre_procedimiento @param1 = valor1, @param2 = valor2;
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

### Crear Stored Procedure

```sql
CREATE PROCEDURE agregar_alumno
    @nombre VARCHAR(100),
    @apellido VARCHAR(100),
    @email VARCHAR(100),
    @fecha_nac DATE
AS
BEGIN
    INSERT INTO Alumnos (nombre, apellido, email, fecha_nacimiento)
    VALUES (@nombre, @apellido, @email, @fecha_nac);
END;
```

### Ejecutar

```sql
EXEC agregar_alumno 
    @nombre = 'Laura',
    @apellido = 'Pérez',
    @email = 'laura.perez@email.com',
    @fecha_nac = '2004-03-12';
```

---

## 7️⃣ Ejemplo 2: Registrar una nota (más realista)

Supongamos que tenemos esta tabla:

```sql
CREATE TABLE Notas (
    id INT IDENTITY PRIMARY KEY,
    alumno_id INT,
    materia VARCHAR(100),
    parcial1 DECIMAL(4,2),
    parcial2 DECIMAL(4,2),
    final DECIMAL(4,2)
);
```

### Stored Procedure

```sql
CREATE PROCEDURE registrar_nota
    @alumno_id INT,
    @materia VARCHAR(100),
    @parcial1 DECIMAL(4,2),
    @parcial2 DECIMAL(4,2),
    @final DECIMAL(4,2)
AS
BEGIN
    INSERT INTO Notas (alumno_id, materia, parcial1, parcial2, final)
    VALUES (@alumno_id, @materia, @parcial1, @parcial2, @final);
END;
```

### Ejecutar

```sql
EXEC registrar_nota 
    @alumno_id = 1,
    @materia = 'Matemática',
    @parcial1 = 7.5,
    @parcial2 = 8.0,
    @final = 9.0;
```

---

## 8️⃣ Stored Procedure con lógica condicional

Supongamos que solo queremos actualizar el email **si el alumno existe**:

```sql
CREATE PROCEDURE actualizar_email
    @id INT,
    @nuevo_email VARCHAR(100)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Alumnos WHERE id = @id)
    BEGIN
        UPDATE Alumnos
        SET email = @nuevo_email
        WHERE id = @id;
    END
    ELSE
    BEGIN
        PRINT 'El alumno no existe.';
    END
END;
```

---

## 9️⃣ Stored Procedure que devuelve un resultado (SELECT)

```sql
CREATE PROCEDURE obtener_datos_alumno
    @id INT
AS
BEGIN
    SELECT * FROM Alumnos WHERE id = @id;
END;
```

### Ejecutar

```sql
EXEC obtener_datos_alumno @id = 2;
```

---

## 🔟 Stored Procedure con bucles (`WHILE`)

```sql
CREATE PROCEDURE listar_alumnos_manual
AS
BEGIN
    DECLARE @contador INT = 1;
    DECLARE @max_id INT = (SELECT MAX(id) FROM Alumnos);

    WHILE @contador <= @max_id
    BEGIN
        IF EXISTS (SELECT 1 FROM Alumnos WHERE id = @contador)
        BEGIN
            SELECT * FROM Alumnos WHERE id = @contador;
        END
        SET @contador += 1;
    END
END;
```

---

## 🧠 Tip final: Ver todos los Stored Procedures

En SQL Server:

```sql
SELECT * FROM sys.procedures;
```

---

Vamos a **desglosar completamente** cada parte del tema **Stored Procedures** de manera **clara, paso a paso y para principiantes**, explicando qué es cada cosa y **para qué sirve**, con ejemplos aplicados al contexto de una institución educativa.

---

# 📘 Stored Procedures: Explicado desde cero

---

## 🔹 ¿Qué es un Stored Procedure?

Un **Stored Procedure** (en español, *Procedimiento Almacenado*) es un **conjunto de instrucciones SQL** que se guarda en la base de datos y se puede ejecutar cuando lo necesites, con un solo comando.

🧠 **Ejemplo real**: Imaginá que cada vez que agregás un alumno nuevo a la base de datos, tenés que escribir este código:

```sql
INSERT INTO Alumnos (nombre, apellido, email, fecha_nacimiento)
VALUES ('Juan', 'Gómez', 'juan@email.com', '2003-05-12');
```

En lugar de repetir eso mil veces, podés crear un procedimiento con nombre propio, por ejemplo: `agregar_alumno`, y después lo llamás así:

```sql
EXEC agregar_alumno @nombre = 'Juan', @apellido = 'Gómez', ...
```

---

## 🔹 ¿Para qué sirve un Stored Procedure?

| ¿Qué hace?                    | ¿Para qué sirve?                                     |
| ----------------------------- | ---------------------------------------------------- |
| Agrupa instrucciones SQL      | Para evitar repetir código                           |
| Acepta parámetros             | Para que sea flexible (como una función)             |
| Guarda lógica condicional     | Para hacer cosas solo si se cumple una condición     |
| Ejecuta operaciones complejas | Como insertar, actualizar, eliminar                  |
| Mejora el rendimiento         | Porque se precompila una vez y se ejecuta más rápido |

---

## 🔹 Sintaxis básica

```sql
CREATE PROCEDURE nombre_del_procedimiento
    @parametro1 tipo_dato,
    @parametro2 tipo_dato
AS
BEGIN
    -- Aquí van las instrucciones SQL
END;
```

---

## 🔹 ¿Qué significa cada parte?

| Parte                      | ¿Qué es?         | ¿Para qué sirve?                                                                   |
| -------------------------- | ---------------- | ---------------------------------------------------------------------------------- |
| `CREATE PROCEDURE`         | Palabra clave    | Le dice a SQL que vas a crear un procedimiento                                     |
| `nombre_del_procedimiento` | Nombre elegido   | Es el nombre con el que lo vas a ejecutar                                          |
| `@parametro tipo_dato`     | Parámetros       | Son los valores que le pasás desde afuera (como el nombre del alumno, por ejemplo) |
| `AS BEGIN ... END`         | Bloque de código | Encierra todo lo que va a hacer ese procedimiento                                  |

---

## 🔹 ¿Cómo se ejecuta?

Una vez creado, se ejecuta así:

```sql
EXEC nombre_del_procedimiento @param1 = valor1, @param2 = valor2;
```

✅ **Ejemplo**:

```sql
EXEC agregar_alumno 
    @nombre = 'Laura',
    @apellido = 'Pérez',
    @email = 'laura@email.com',
    @fecha_nac = '2004-03-12';
```

---

## 🔹 Ejemplo 1: Agregar un alumno

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

### Crear el procedimiento

```sql
CREATE PROCEDURE agregar_alumno
    @nombre VARCHAR(100),
    @apellido VARCHAR(100),
    @email VARCHAR(100),
    @fecha_nac DATE
AS
BEGIN
    INSERT INTO Alumnos (nombre, apellido, email, fecha_nacimiento)
    VALUES (@nombre, @apellido, @email, @fecha_nac);
END;
```

---

## 🔹 Ejemplo 2: Registrar una nota

### Tabla

```sql
CREATE TABLE Notas (
    id INT IDENTITY PRIMARY KEY,
    alumno_id INT,
    materia VARCHAR(100),
    parcial1 DECIMAL(4,2),
    parcial2 DECIMAL(4,2),
    final DECIMAL(4,2)
);
```

### Procedimiento

```sql
CREATE PROCEDURE registrar_nota
    @alumno_id INT,
    @materia VARCHAR(100),
    @parcial1 DECIMAL(4,2),
    @parcial2 DECIMAL(4,2),
    @final DECIMAL(4,2)
AS
BEGIN
    INSERT INTO Notas (alumno_id, materia, parcial1, parcial2, final)
    VALUES (@alumno_id, @materia, @parcial1, @parcial2, @final);
END;
```

### ¿Qué significa cada parte?

| Parte                   | ¿Qué hace?                     |
| ----------------------- | ------------------------------ |
| `@alumno_id INT`        | Recibe el ID del alumno        |
| `@materia VARCHAR(100)` | Recibe el nombre de la materia |
| `DECIMAL(4,2)`          | Guarda decimales como 8.75     |

---

## 🔹 Ejemplo 3: Actualizar un dato solo si existe

```sql
CREATE PROCEDURE actualizar_email
    @id INT,
    @nuevo_email VARCHAR(100)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Alumnos WHERE id = @id)
    BEGIN
        UPDATE Alumnos
        SET email = @nuevo_email
        WHERE id = @id;
    END
    ELSE
    BEGIN
        PRINT 'El alumno no existe.';
    END
END;
```

✅ ¿Qué pasa acá?

- `IF EXISTS (...)` → Verifica si existe el alumno
- `UPDATE` → Solo se ejecuta si el alumno está en la tabla
- `PRINT` → Muestra un mensaje si no lo encuentra

---

## 🔹 Ejemplo 4: Consultar y mostrar datos

```sql
CREATE PROCEDURE ver_notas
    @alumno_id INT
AS
BEGIN
    SELECT * FROM Notas WHERE alumno_id = @alumno_id;
END;
```

---

## 🔹 Bonus: ¿Qué significa cada símbolo?

| Símbolo / palabra | ¿Qué significa? | ¿Para qué sirve?                       |
| ----------------- | --------------- | -------------------------------------- |
| `@`               | Parámetro       | Para pasarle datos al procedimiento    |
| `=`               | Igualdad        | Para asignar un valor o comparar       |
| `BEGIN ... END`   | Bloque          | Agrupa las instrucciones               |
| `IF`              | Condición       | Para hacer algo si se cumple una regla |
| `EXEC`            | Ejecutar        | Llama al procedimiento                 |

---

## 🧪 Ejercicio propuesto

1. Crear una función que calcule el porcentaje de asistencia de un alumno, dado el total de clases y las asistencias.
2. Crear un procedimiento que registre una nueva nota para un alumno en una tabla llamada `Notas`.

## Respuestas

## ✅ 1. Función: Calcular el porcentaje de asistencia

### 🎯 Objetivo

Dado el total de clases y la cantidad de clases a las que asistió un alumno, calcular el porcentaje de asistencia.

### 🧾 Sintaxis

```sql
CREATE FUNCTION calcular_asistencia (
    @total_clases INT,
    @asistencias INT
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @porcentaje DECIMAL(5,2);
    
    IF @total_clases = 0
        SET @porcentaje = 0;
    ELSE
        SET @porcentaje = (@asistencias * 100.0) / @total_clases;
    
    RETURN @porcentaje;
END;
```

### 🧪 Ejemplo de uso

```sql
SELECT dbo.calcular_asistencia(40, 30) AS porcentaje_asistencia;
-- Resultado: 75.00
```

---

## ✅ 2. Stored Procedure: Registrar una nueva nota

### 🎯 Objetivo

Registrar una nota en una tabla `Notas` con campos para el alumno, los parciales y el examen final.

### 🗃️ Supongamos esta estructura para la tabla

```sql
CREATE TABLE Notas (
    id INT IDENTITY PRIMARY KEY,
    alumno_id INT,
    parcial1 DECIMAL(5,2),
    parcial2 DECIMAL(5,2),
    final DECIMAL(5,2)
);
```

### 🔧 Stored Procedure

```sql
CREATE PROCEDURE registrar_nota
    @alumno_id INT,
    @parcial1 DECIMAL(5,2),
    @parcial2 DECIMAL(5,2),
    @final DECIMAL(5,2)
AS
BEGIN
    INSERT INTO Notas (alumno_id, parcial1, parcial2, final)
    VALUES (@alumno_id, @parcial1, @parcial2, @final);
END;
```

### 🧪 Ejemplo de ejecución

```sql
EXEC registrar_nota 
    @alumno_id = 1,
    @parcial1 = 7.5,
    @parcial2 = 8.0,
    @final = 9.0;
```

---

## 📌 Recomendaciones para recordar

- Usa funciones cuando necesites **calcular y devolver un valor**.
- Usa stored procedures cuando necesites realizar **acciones complejas o múltiples pasos** (INSERT, UPDATE, lógica condicional).
- Nombra claramente tus funciones y procedimientos para que su propósito sea evidente.
- Agrega validaciones dentro de los stored procedures para evitar errores comunes (ej: insertar datos duplicados).

---

Vamos ahora con la explicación completa y clara de **Triggers**, **JOINS** y cómo se pueden combinar con **Stored Procedures**, siempre con ejemplos del ámbito educativo y explicando **qué es cada cosa** y **para qué sirve**.

---

# 📘 Triggers, Joins y Stored Procedures — Paso a paso para principiantes

---

## 🔶 1️⃣ ¿Qué es un `JOIN`?

Un `JOIN` (*unión*) sirve para **combinar datos de varias tablas relacionadas**. Por ejemplo, si tenemos una tabla de alumnos y otra de notas, podemos mostrar el **nombre del alumno junto con sus notas**, aunque estén en tablas distintas.

---

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

### 👉 JOIN para mostrar el nombre y la nota

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
| `SELECT`                | Lo que querés mostrar                          |
| `FROM Alumnos A`        | Alias `A` para la tabla `Alumnos`              |
| `JOIN Notas N`          | Une con la tabla `Notas`, alias `N`            |
| `ON A.id = N.alumno_id` | Condición para unir: el ID del alumno coincide |

---

## 🔶 2️⃣ ¿Qué es un `TRIGGER`?

Un **Trigger** es como una **alarma o acción automática** que se ejecuta en respuesta a un evento en una tabla, como `INSERT`, `UPDATE` o `DELETE`.

🧠 Se ejecuta solo, **sin que lo llames**, cuando pasa algo en la base de datos.

---

### 🎓 Ejemplo: Registrar cambios en las notas

Supongamos que queremos guardar un registro cada vez que se actualiza la nota de un alumno.

#### 1. Creamos la tabla para registrar cambios

```sql
CREATE TABLE HistorialNotas (
  id INT IDENTITY PRIMARY KEY,
  alumno_id INT,
  materia VARCHAR(100),
  nota_anterior DECIMAL(4,2),
  nota_nueva DECIMAL(4,2),
  fecha DATETIME DEFAULT GETDATE()
);
```

#### 2. Creamos el trigger

```sql
CREATE TRIGGER trg_actualizar_nota
ON Notas
AFTER UPDATE
AS
BEGIN
  INSERT INTO HistorialNotas (alumno_id, materia, nota_anterior, nota_nueva)
  SELECT 
    D.alumno_id,
    D.materia,
    D.nota,
    I.nota
  FROM deleted D
  JOIN inserted I ON D.id = I.id;
END;
```

---

### 🧩 ¿Qué significan `deleted` e `inserted`?

| Palabra clave | ¿Qué representa?                 |
| ------------- | -------------------------------- |
| `deleted`     | Los datos **antes** del cambio   |
| `inserted`    | Los datos **después** del cambio |

Esto permite guardar el **antes y después** del cambio en la nota.

---

## 🔶 3️⃣ ¿Cómo combinar Stored Procedure + Join?

Podemos usar un `JOIN` dentro de un `Stored Procedure` para mostrar información combinada.

---

### 🎓 Ejemplo: Ver el detalle de un alumno con sus notas

```sql
CREATE PROCEDURE ver_detalle_alumno
  @alumno_id INT
AS
BEGIN
  SELECT 
    A.nombre,
    A.apellido,
    N.materia,
    N.nota
  FROM Alumnos A
  JOIN Notas N ON A.id = N.alumno_id
  WHERE A.id = @alumno_id;
END;
```

Y lo ejecutás así:

```sql
EXEC ver_detalle_alumno @alumno_id = 1;
```

---

## 🔶 4️⃣ ¿Cómo combinar Stored Procedure + Trigger?

Imaginá que tenés un procedimiento que **modifica una nota**. Ese cambio activará el trigger que guarda el historial automáticamente.

```sql
CREATE PROCEDURE modificar_nota
  @nota_id INT,
  @nueva_nota DECIMAL(4,2)
AS
BEGIN
  UPDATE Notas
  SET nota = @nueva_nota
  WHERE id = @nota_id;
END;
```

Y gracias al trigger `trg_actualizar_nota`, se guarda el cambio automáticamente en `HistorialNotas`.

---

## 🧠 Resumen visual

| Concepto           | ¿Qué hace?          | Cuándo se usa                                  |
| ------------------ | ------------------- | ---------------------------------------------- |
| `JOIN`             | Combina tablas      | Para ver datos relacionados (alumno + notas)   |
| `Stored Procedure` | Bloque reutilizable | Para insertar, modificar, consultar con lógica |
| `Trigger`          | Acción automática   | Se ejecuta después de un cambio (sin llamar)   |

---

## 🏁 Conclusión

Las funciones y procedimientos almacenados te permiten automatizar, simplificar y organizar mejor el código SQL. Son herramientas fundamentales para cualquier desarrollador o analista de bases de datos.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
