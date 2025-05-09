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

Perfecto, estás buscando una explicación **paso a paso, clara y detallada**, ideal para alumnos que están empezando desde cero. Vamos a desglosar todo lo que aparece en este fragmento SQL y los conceptos que lo rodean.

---

## 🔍 Consulta SQL

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

* `dbo` significa **database owner** (propietario de la base de datos).
* Es el esquema **por defecto** en la mayoría de los casos.

> 📌 Entonces `dbo.calcular_promedio(...)` significa:
> “Ejecutar la función `calcular_promedio` del esquema `dbo`”.

---

### `AS nota_final`

* `AS` sirve para darle un **alias** (nombre alternativo o temporal) a una columna en el resultado.
* En este caso, el resultado de la función `calcular_promedio(...)` se mostrará como `nota_final`.

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

### Se usa para:

* Comparar valores (ej: `WHERE alumno_id = 1`)
* Asignar valores dentro de sentencias como `SET`, o dentro de funciones y procedimientos.

Ejemplo:

```sql
DECLARE @promedio DECIMAL(5,2);
SET @promedio = (8 + 9 + 10) / 3;
```

---

## 📌 Resumen visual:

| Concepto              | Significado                                   |
| --------------------- | --------------------------------------------- |
| `SELECT`              | Pide columnas de una tabla                    |
| `dbo`                 | Esquema (propietario de objeto en SQL Server) |
| `calcular_promedio()` | Función que devuelve el promedio de 3 notas   |
| `AS nota_final`       | Alias: renombra la columna en el resultado    |
| `FROM Notas`          | Indica la tabla de donde se sacan los datos   |
| `=`                   | Operador de comparación o asignación          |



---

## 3️⃣ ¿Qué es un Stored Procedure (Procedimiento Almacenado)?

Un **Stored Procedure** es un conjunto de instrucciones SQL guardadas en la base de datos, que se pueden ejecutar con un solo llamado.

👉 **Ventajas:**

- Evita repetir código.
- Mejora la organización.
- Puede incluir lógica condicional.
- Mejora el rendimiento (pre-compilado).

---

## 4️⃣ Sintaxis para crear un Stored Procedure

```sql
CREATE PROCEDURE nombre_procedimiento
    @param1 tipo,
    @param2 tipo
AS
BEGIN
    -- Bloque de instrucciones SQL
END;
```

🔁 Para ejecutarlo:

```sql
EXEC nombre_procedimiento @param1 = valor1, @param2 = valor2;
```

---

## 👨‍🏫 Ejemplo práctico: Agregar un alumno a la base de datos

```sql
CREATE TABLE Alumnos (
    id INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100),
    fecha_nacimiento DATE
);
```

### Procedimiento para insertar un alumno

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

### Ejecución

```sql
EXEC agregar_alumno 
    @nombre = 'Laura',
    @apellido = 'Pérez',
    @email = 'laura.perez@email.com',
    @fecha_nac = '2004-03-12';
```

---

## 5️⃣ Stored Procedure con lógica condicional

### Supongamos que queremos actualizar el email de un alumno solo si existe

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

## 🏁 Conclusión

Las funciones y procedimientos almacenados te permiten automatizar, simplificar y organizar mejor el código SQL. Son herramientas fundamentales para cualquier desarrollador o analista de bases de datos.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
