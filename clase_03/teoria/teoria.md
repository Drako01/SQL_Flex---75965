# 🛢 **Clase de SQL Nro 3** 

### **Objetivo General:**

En esta clase, veremos los conceptos clave de SQL relacionados con consultas avanzadas, manipulación de datos y funciones. Se enfocará en MySQL, aplicando ejemplos prácticos para reforzar cada tema.

---

### **🕒 Fundamentos Avanzados de Consultas SQL**

1. **Unión de Tablas**

   - 📖 **Concepto:** La unión de tablas permite combinar datos de múltiples tablas en una sola consulta.
   - 🔍 **Tipos de JOIN:**
     - `INNER JOIN`
     - `LEFT JOIN`
     - `RIGHT JOIN`
     - `FULL OUTER JOIN` _(No soportado en MySQL, se simula con UNION)_
   - ✅ **Ejemplo Práctico:**

     ```sql
     CREATE TABLE cursos (
         id_curso INT PRIMARY KEY AUTO_INCREMENT,
         nombre_curso VARCHAR(50) NOT NULL
     );

     CREATE TABLE inscripciones (
         id_alumno INT,
         id_curso INT,
         PRIMARY KEY (id_alumno, id_curso),
         FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
         FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
     );

     SELECT a.nombre, a.apellido, c.nombre_curso
     FROM alumnos a
     INNER JOIN inscripciones i ON a.id_alumno = i.id_alumno
     INNER JOIN cursos c ON i.id_curso = c.id_curso;
     ```

   - 💡 **Aplicación:** Obtener una lista de alumnos con los cursos en los que están inscritos.

2. **Tipos de Datos en SQL**

   - 📖 **Concepto:** Diferencias entre `INT`, `VARCHAR`, `TEXT`, `DATE`, `DECIMAL`, etc.
   - ✅ **Ejemplo de Creación de Tabla con Distintos Tipos de Datos:**

     ```sql
     CREATE TABLE productos (
         id_producto INT PRIMARY KEY AUTO_INCREMENT,
         nombre VARCHAR(50) NOT NULL,
         precio DECIMAL(10,2) NOT NULL,
         fecha_ingreso DATE DEFAULT CURRENT_DATE
     );

     ```

---

## **Diferencia entre `VARCHAR` y `TEXT` en MySQL**

Ambos tipos de datos se utilizan para almacenar texto en MySQL, pero tienen diferencias importantes en cuanto a **almacenamiento, rendimiento y funcionalidad**.

---

## **📌 1. `VARCHAR` (Variable Character)**

El tipo `VARCHAR(n)` almacena una cadena de longitud **variable**, donde `n` define la cantidad máxima de caracteres permitidos.

📌 **Características de `VARCHAR`:**  
✅ **Máximo de 65,535 caracteres** (depende de la configuración de la fila y el tamaño de otras columnas).  
✅ **Se almacena en la tabla misma** (en páginas de datos).  
✅ **Ocupa menos espacio si los valores son cortos**, ya que almacena solo la cantidad de caracteres ingresados más 1 o 2 bytes adicionales para registrar la longitud.  
✅ **Más rápido en búsquedas e índices** porque se puede indexar completamente.  
✅ Se usa para **cadenas pequeñas o medianas** (como nombres, emails, direcciones).

📌 **Ejemplo de `VARCHAR`:**

```sql
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),  -- Máximo 50 caracteres
    email VARCHAR(100)   -- Máximo 100 caracteres
);
```

📌 **Cómo MySQL almacena `VARCHAR(100)`:**

- Si guardamos `"Hola"`, ocupa **4 caracteres + 1 byte extra** = **5 bytes en total**.
- Si guardamos `"Hola, mundo"`, ocupa **11 caracteres + 1 byte extra** = **12 bytes en total**.

---

## **📌 2. `TEXT` (Texto Largo)**

El tipo `TEXT` está diseñado para almacenar **grandes cantidades de texto** (hasta 4GB en versiones avanzadas).

📌 **Características de `TEXT`:**  
✅ Puede almacenar **hasta 4GB de texto** dependiendo de la variante (`TINYTEXT`, `TEXT`, `MEDIUMTEXT`, `LONGTEXT`).  
✅ **No se almacena en la tabla misma**, sino en un área externa y solo se guarda un puntero.  
✅ **No puede tener valores por defecto (`DEFAULT`)**.  
✅ **Menos eficiente en consultas y filtrado**, porque no se indexa completamente.  
✅ Se usa para **grandes cantidades de texto**, como descripciones, artículos, comentarios de usuarios, etc.

📌 **Ejemplo de `TEXT`:**

```sql
CREATE TABLE articulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    contenido TEXT  -- Almacena grandes cantidades de texto
);
```

📌 **Cómo MySQL almacena `TEXT`:**

- Si guardamos `"Hola, mundo"`, ocupa **11 bytes**, pero el texto se almacena en un área separada y la tabla solo guarda un puntero.

---

## **📌 3. Diferencias Claves**

| Característica                      | `VARCHAR`                                                | `TEXT`                                                      |
| ----------------------------------- | -------------------------------------------------------- | ----------------------------------------------------------- |
| **Tamaño Máximo**                   | Hasta **65,535** caracteres (depende del tamaño de fila) | Hasta **4GB** en `LONGTEXT`                                 |
| **Almacenamiento**                  | En la tabla (más rápido)                                 | Fuera de la tabla, con puntero                              |
| **Uso de índices**                  | **Se puede indexar completamente**                       | Solo se indexan los primeros **768 bytes**                  |
| **Uso de memoria**                  | Más eficiente para datos pequeños                        | Ocupa más espacio y requiere más procesamiento              |
| **Valores por defecto (`DEFAULT`)** | ✅ Sí                                                    | ❌ No permitido                                             |
| **Mejor uso**                       | Para datos cortos y medianos (emails, nombres, títulos)  | Para grandes textos (artículos, descripciones, comentarios) |

---

## **📌 4. ¿Cuándo usar `VARCHAR` y cuándo usar `TEXT`?**

🔹 **Usa `VARCHAR` cuando...**  
✔️ Necesitas almacenar textos **relativamente cortos** (como nombres o direcciones).  
✔️ Quieres **indexar** la columna para búsquedas rápidas.  
✔️ Planeas hacer muchas **operaciones de filtrado y ordenamiento**.

🔹 **Usa `TEXT` cuando...**  
✔️ Vas a guardar **grandes cantidades de texto** (descripciones largas, artículos, comentarios).  
✔️ No necesitas hacer **búsquedas exactas o ordenamiento frecuente** sobre la columna.

---

## **Diferencias entre los tipos de datos numéricos en MySQL**

En MySQL, los datos numéricos se dividen en **números enteros** y **números decimales (flotantes o de precisión fija)**. La elección del tipo de dato adecuado depende del **rango de valores**, **precisión** y **uso de almacenamiento**.

---

## **📌 1. Tipos de Datos Numéricos en MySQL**

| Tipo de Dato       | Bytes    | Rango de Valores (con signo)         | Rango de Valores (sin signo) | Soporta Decimales |
| ------------------ | -------- | ------------------------------------ | ---------------------------- | ----------------- |
| **TINYINT**        | 1        | -128 a 127                           | 0 a 255                      | ❌ No             |
| **SMALLINT**       | 2        | -32,768 a 32,767                     | 0 a 65,535                   | ❌ No             |
| **MEDIUMINT**      | 3        | -8,388,608 a 8,388,607               | 0 a 16,777,215               | ❌ No             |
| **INT / INTEGER**  | 4        | -2,147,483,648 a 2,147,483,647       | 0 a 4,294,967,295            | ❌ No             |
| **BIGINT**         | 8        | -9.2 cuatrillones a 9.2 cuatrillones | 0 a 18.4 cuatrillones        | ❌ No             |
| **DECIMAL (M, D)** | Variable | Definido por `M, D`                  | Definido por `M, D`          | ✅ Sí             |
| **FLOAT (M, D)**   | 4        | ≈ ±3.4E-38 a ±3.4E+38                | ≈ ±3.4E-38 a ±3.4E+38        | ✅ Sí             |
| **DOUBLE (M, D)**  | 8        | ±1.7E-308 a ±1.7E+308                | ±1.7E-308 a ±1.7E+308        | ✅ Sí             |

📌 **Nota:**

- `(M, D)`: `M` es la cantidad total de dígitos y `D` es el número de decimales.
- `UNSIGNED` significa que **solo admite valores positivos**, duplicando el rango positivo.

---

## **📌 2. Tipos de Números Enteros (`TINYINT`, `SMALLINT`, `MEDIUMINT`, `INT`, `BIGINT`)**

Los números enteros se utilizan cuando **no se requieren decimales** y se deben elegir según el rango de valores esperados.

### **Ejemplo de Uso**

```sql
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    edad TINYINT UNSIGNED,  -- Valores entre 0 y 255
    puntos SMALLINT,        -- Valores entre -32,768 y 32,767
    ingresos BIGINT         -- Valores grandes (hasta cuatrillones)
);
```

📌 **¿Cuál usar?**  
✔️ **`TINYINT`**: Edad de una persona, estados binarios (1=Activo, 0=Inactivo).  
✔️ **`SMALLINT`**: Contador de productos, stock en almacén.  
✔️ **`MEDIUMINT`**: Número de visitas a una página.  
✔️ **`INT`**: ID de usuarios, conteo de registros en bases de datos grandes.  
✔️ **`BIGINT`**: Números muy grandes (ej. transacciones bancarias).

---

## **📌 3. Tipos de Números Decimales (`DECIMAL`, `FLOAT`, `DOUBLE`)**

Se usan cuando se requiere **precisión en valores decimales**.

| Tipo de Dato       | Precisión                        | Uso                                            |
| ------------------ | -------------------------------- | ---------------------------------------------- |
| **DECIMAL (M, D)** | Alta precisión (almacena exacto) | Valores financieros, precios, tasas de interés |
| **FLOAT (M, D)**   | Menos preciso, más eficiente     | Gráficos, mediciones científicas               |
| **DOUBLE (M, D)**  | Más preciso que `FLOAT`          | Cálculos científicos, estadísticas complejas   |

### **Ejemplo de Uso**

```sql
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    precio DECIMAL(10,2),   -- Hasta 10 dígitos, 2 decimales
    descuento FLOAT(5,2),   -- Aproximado, menos preciso
    valor_preciso DOUBLE(10,6) -- Mayor precisión
);
```

📌 **¿Cuál usar?**  
✔️ **`DECIMAL`**: Precios de productos, valores monetarios.  
✔️ **`FLOAT`**: Temperaturas, estadísticas, valores científicos.  
✔️ **`DOUBLE`**: Cálculos matemáticos con alta precisión.

---

## **📌 4. Diferencias Clave: `DECIMAL` vs `FLOAT` vs `DOUBLE`**

| Característica   | `DECIMAL`           | `FLOAT`           | `DOUBLE`                       |
| ---------------- | ------------------- | ----------------- | ------------------------------ |
| **Precisión**    | **Exacta**          | Aproximada        | Aproximada (mejor que `FLOAT`) |
| **Uso de Bytes** | Variable            | 4 bytes           | 8 bytes                        |
| **Aplicación**   | Valores financieros | Datos científicos | Cálculos matemáticos complejos |

📌 **Ejemplo de Diferencia**

```sql
SELECT
    10.1 + 0.2 AS suma_decimal,
    CAST(10.1 AS FLOAT) + 0.2 AS suma_float;
```

✅ **Salida:**  
| suma_decimal | suma_float |
|--------------|------------|
| **10.30** | **10.299999** |

🚨 **Atención**: `FLOAT` y `DOUBLE` pueden generar **errores de redondeo**. Para cálculos financieros, usa `DECIMAL`.

---

## **📌 5. `SIGNED` vs `UNSIGNED` (Valores Positivos y Negativos)**

- **Por defecto, los enteros son `SIGNED`**, es decir, permiten valores negativos y positivos.
- **Si usas `UNSIGNED`**, el número solo puede ser **positivo** y el rango **se duplica en valores positivos**.

### **Ejemplo de `SIGNED` y `UNSIGNED`**

```sql
CREATE TABLE ejemplo (
    valor_negativo SMALLINT SIGNED,  -- Rango: -32,768 a 32,767
    valor_positivo SMALLINT UNSIGNED -- Rango: 0 a 65,535
);
```

---

## **📌 6. Elección del Tipo de Dato Numérico Correcto**

| Caso de Uso                    | Tipo de Dato Recomendado |
| ------------------------------ | ------------------------ |
| Edad de una persona            | `TINYINT UNSIGNED`       |
| Cantidad de productos en stock | `SMALLINT` o `MEDIUMINT` |
| ID de usuario                  | `INT UNSIGNED`           |
| Precio de un producto          | `DECIMAL(10,2)`          |
| Descuento en porcentaje        | `FLOAT(5,2)`             |
| Transacciones bancarias        | `BIGINT UNSIGNED`        |
| Registro de temperatura        | `FLOAT`                  |
| Cálculos científicos complejos | `DOUBLE`                 |

---

## **📌 7. Conclusión**

- **Usa números enteros (`INT`, `BIGINT`, etc.)** cuando **no necesitas decimales**.
- **Usa `DECIMAL` para cálculos exactos** (ejemplo: dinero).
- **Usa `FLOAT` o `DOUBLE` si necesitas valores con decimales, pero puedes tolerar una ligera imprecisión**.
- **Siempre usa `UNSIGNED` si no necesitas valores negativos** para optimizar el almacenamiento.

---

## **Diferencia entre `DATE`, `DATETIME` y `TIMESTAMP` en MySQL**

En MySQL, estos tres tipos de datos se utilizan para almacenar información de fecha y hora, pero tienen diferencias importantes en cuanto a **rango, almacenamiento y comportamiento con zonas horarias**.

---

## **📌 1. `DATE` (Solo Fecha)**

- Almacena **solo la fecha**, sin información de hora.
- Formato: `'YYYY-MM-DD'` (Año-Mes-Día).
- Ocupa **3 bytes** en la base de datos.
- Rango de valores: **del `1000-01-01` al `9999-12-31`**.
- No depende de la zona horaria del servidor.

📌 **Ejemplo de `DATE`:**

```sql
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    fecha_nacimiento DATE
);

INSERT INTO empleados (nombre, fecha_nacimiento)
VALUES ('Carlos', '1995-06-15');

SELECT * FROM empleados;
```

✅ **Salida esperada:**  
| id | nombre | fecha_nacimiento |
|----|--------|-----------------|
| 1 | Carlos | 1995-06-15 |

✅ **Uso típico:** Fechas de nacimiento, eventos sin hora específica, fechas de vencimiento.

---

## **📌 2. `DATETIME` (Fecha y Hora Completa)**

- Almacena **fecha y hora** en formato completo.
- Formato: `'YYYY-MM-DD HH:MM:SS'` (Año-Mes-Día Hora:Minuto:Segundo).
- Ocupa **8 bytes** en la base de datos.
- Rango de valores: **del `1000-01-01 00:00:00` al `9999-12-31 23:59:59`**.
- No se ajusta automáticamente a la zona horaria del servidor.

📌 **Ejemplo de `DATETIME`:**

```sql
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente VARCHAR(50),
    fecha_pedido DATETIME
);

INSERT INTO pedidos (cliente, fecha_pedido)
VALUES ('Ana', '2025-03-22 14:30:00');

SELECT * FROM pedidos;
```

✅ **Salida esperada:**  
| id | cliente | fecha_pedido |
|----|---------|----------------------|
| 1 | Ana | 2025-03-22 14:30:00 |

✅ **Uso típico:** Registro de eventos exactos, fechas de creación/modificación de registros, programación de tareas.

---

## **📌 3. `TIMESTAMP` (Marca de Tiempo con Zona Horaria)**

- Similar a `DATETIME`, pero **se ajusta automáticamente a la zona horaria** del servidor.
- Formato: `'YYYY-MM-DD HH:MM:SS'`.
- Ocupa **4 bytes** en la base de datos (más eficiente que `DATETIME`).
- Rango de valores: **del `1970-01-01 00:00:01` al `2038-01-19 03:14:07`** (por la limitación del formato UNIX Timestamp).
- Se usa comúnmente para registrar la fecha/hora de modificaciones de registros (`CURRENT_TIMESTAMP`).

📌 **Ejemplo de `TIMESTAMP`:**

```sql
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(100),
    fecha_log TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO logs (accion) VALUES ('Usuario inició sesión');

SELECT * FROM logs;
```

✅ **Salida esperada:**  
| id | accion | fecha_log |
|----|--------------------------|---------------------|
| 1 | Usuario inició sesión | 2025-03-22 10:45:30 |

✅ **Uso típico:** Fechas de auditoría, logs de actividad, marcas de tiempo en transacciones.

---

## **📌 4. Comparación de `DATE` vs `DATETIME` vs `TIMESTAMP`**

| Característica        | `DATE`                               | `DATETIME`                                    | `TIMESTAMP`                                   |
| --------------------- | ------------------------------------ | --------------------------------------------- | --------------------------------------------- |
| **Incluye Hora**      | ❌ No                                | ✅ Sí                                         | ✅ Sí                                         |
| **Formato**           | `'YYYY-MM-DD'`                       | `'YYYY-MM-DD HH:MM:SS'`                       | `'YYYY-MM-DD HH:MM:SS'`                       |
| **Bytes que ocupa**   | 3 bytes                              | 8 bytes                                       | 4 bytes                                       |
| **Rango de valores**  | `1000-01-01` a `9999-12-31`          | `1000-01-01 00:00:00` a `9999-12-31 23:59:59` | `1970-01-01 00:00:01` a `2038-01-19 03:14:07` |
| **Zona horaria**      | ❌ No depende de zona horaria        | ❌ No depende de zona horaria                 | ✅ Se ajusta a la zona horaria del servidor   |
| **Valor por defecto** | ❌ No puede usar `CURRENT_TIMESTAMP` | ❌ No puede usar `CURRENT_TIMESTAMP`          | ✅ `CURRENT_TIMESTAMP` por defecto            |

---

## **📌 5. ¿Cuándo usar cada uno?**

✅ **Usa `DATE` cuando...**  
✔️ Solo necesitas la fecha sin la hora (fechas de nacimiento, vencimientos, eventos de un día).

✅ **Usa `DATETIME` cuando...**  
✔️ Necesitas la fecha y la hora exacta, sin preocuparte por la zona horaria (horarios de reserva, citas médicas).

✅ **Usa `TIMESTAMP` cuando...**  
✔️ Necesitas registrar eventos con zona horaria ajustable (logs de actividad, fechas de modificación de registros).

---

🚀 **Conclusión:**

- **`DATE`**: Solo almacena fecha, ideal para datos sin hora.
- **`DATETIME`**: Fecha y hora fija, sin ajuste de zona horaria.
- **`TIMESTAMP`**: Similar a `DATETIME`, pero más eficiente y ajustable a la zona horaria del servidor.

📌 **Ejemplo práctico:**  
Si tienes una tabla de productos en un e-commerce:

```sql
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),  -- Corto y fácil de buscar
    descripcion TEXT       -- Puede ser un párrafo largo
);
```

🔹 Aquí `nombre` es un **`VARCHAR(100)`** porque lo usarás para búsquedas.  
🔹 `descripcion` es un **`TEXT`** porque puede ser un texto largo y no necesitas filtrar por él.

---

🚀 **Conclusión:**

- **Usa `VARCHAR` para datos pequeños y medianos que necesitas buscar rápidamente.**
- **Usa `TEXT` para almacenar textos largos que no vas a indexar mucho.**

3. **Uso de LIKE y comodines**

   - 📖 **Concepto:** LIKE se usa para búsquedas flexibles en `VARCHAR` o `TEXT`.
   - 🔍 **Comodines:**
     - `%` (cualquier cantidad de caracteres)
     - `_` (un solo carácter)
     - `[ ]` (rango de caracteres en SQL Server)
   - ✅ **Ejemplo de Aplicación:**
     ```sql
     SELECT * FROM alumnos WHERE nombre LIKE 'A%'; -- Nombres que empiezan con "A"
     SELECT * FROM alumnos WHERE email LIKE '%@gmail.com'; -- Emails de Gmail
     ```

4. **Expresiones Regulares**

   - 📖 **Concepto:** En MySQL, `REGEXP` permite patrones más complejos.
   - ✅ **Ejemplo de Aplicación:**
     ```sql
     SELECT * FROM alumnos WHERE email REGEXP '^[a-z]+@[a-z]+\\.(com|net)$';
     ```

## **Expresiones Regulares (REGEX) en MySQL**

Las **Expresiones Regulares (REGEX)** permiten realizar búsquedas avanzadas y validaciones de texto dentro de bases de datos. En MySQL, se usan con `REGEXP` y `RLIKE` para hacer comparaciones más avanzadas que las que permite `LIKE`.

---

## **📌 1. Uso de REGEXP en MySQL**

El operador `REGEXP` (o `RLIKE`, que es su sinónimo) se usa para hacer comparaciones con patrones de texto.

### **Ejemplo básico**

```sql
SELECT * FROM alumnos WHERE nombre REGEXP 'Alejandro|Juan';
```

🔹 **Busca alumnos cuyos nombres sean "Alejandro" o "Juan".**

### **Comparación con LIKE**

| **Método** | **Descripción**                                     | **Ejemplo**          | **Resultado**                |
| ---------- | --------------------------------------------------- | -------------------- | ---------------------------- |
| `LIKE`     | Busca coincidencias exactas con comodines `%` y `_` | `nombre LIKE 'A%'`   | Nombres que empiezan con "A" |
| `REGEXP`   | Permite patrones avanzados                          | `nombre REGEXP '^A'` | Nombres que empiezan con "A" |

---

## **📌 2. Caracteres Especiales en REGEXP**

| **Símbolo** | **Descripción**              | **Ejemplo**                                        |
| ----------- | ---------------------------- | -------------------------------------------------- | ------ | --------------------------------------- |
| `.`         | Cualquier carácter           | `'A.e'` (Coincide con "Ale", "Axe", etc.)          |
| `^`         | Inicio de la cadena          | `'^A'` (Empieza con "A")                           |
| `$`         | Fin de la cadena             | `'o$'` (Termina en "o")                            |
| `           | `                            | Alternativa (OR)                                   | `'Juan | Pedro'` (Coincide con "Juan" o "Pedro") |
| `[]`        | Grupo de caracteres          | `'[JPM]uan'` (Coincide con "Juan", "Puan", "Muan") |
| `[a-z]`     | Rango de letras minúsculas   | `'[a-d]'` (Coincide con "a", "b", "c" o "d")       |
| `[0-9]`     | Rango de números             | `'[0-9]'` (Coincide con cualquier número)          |
| `[^ ]`      | Negación (NO este carácter)  | `'[^A]lejandro'` (No empieza con "A")              |
| `{n}`       | Repeticiones exactas         | `'[0-9]{3}'` (Exactamente 3 dígitos)               |
| `{n,}`      | Al menos `n` repeticiones    | `'[0-9]{2,}'` (Al menos 2 dígitos)                 |
| `{n,m}`     | Entre `n` y `m` repeticiones | `'[a-z]{2,5}'` (Entre 2 y 5 letras)                |

---

## **📌 3. Ejemplos de Uso en MySQL**

### **1️⃣ Buscar nombres que comiencen con "J"**

```sql
SELECT * FROM alumnos WHERE nombre REGEXP '^J';
```

🔹 **Encuentra nombres como "Juan", "Julian", etc.**

### **2️⃣ Buscar nombres que terminen en "o"**

```sql
SELECT * FROM alumnos WHERE nombre REGEXP 'o$';
```

🔹 **Encuentra "Alejandro", "Marcelo", etc.**

### **3️⃣ Buscar nombres que contengan "an" en cualquier parte**

```sql
SELECT * FROM alumnos WHERE nombre REGEXP 'an';
```

🔹 **Encuentra "Juan", "Alejandra", etc.**

### **4️⃣ Buscar nombres que sean "Juan" o "Pedro"**

```sql
SELECT * FROM alumnos WHERE nombre REGEXP 'Juan|Pedro';
```

🔹 **Filtra registros con cualquiera de estos dos nombres.**

### **5️⃣ Buscar nombres con solo letras mayúsculas**

```sql
SELECT * FROM alumnos WHERE nombre REGEXP '^[A-Z]+$';
```

🔹 **Útil si queremos encontrar datos ingresados incorrectamente.**

### **6️⃣ Buscar números de teléfono con exactamente 10 dígitos**

```sql
SELECT * FROM alumnos WHERE telefono REGEXP '^[0-9]{10}$';
```

🔹 **Filtra teléfonos incorrectos o incompletos.**

---

## **📌 4. Casos Prácticos de REGEXP**

### ✅ **Validación de correos electrónicos**

```sql
SELECT * FROM alumnos WHERE email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$';
```

🔹 **Encuentra solo correos electrónicos válidos.**

### ✅ **Filtrar números de DNI argentinos (entre 7 y 8 dígitos)**

```sql
SELECT * FROM alumnos WHERE dni REGEXP '^[0-9]{7,8}$';
```

🔹 **Útil para verificar DNIs correctamente ingresados.**

### ✅ **Buscar alumnos con apellidos compuestos (con espacio o guion)**

```sql
SELECT * FROM alumnos WHERE apellido REGEXP '[- ]';
```

🔹 **Encuentra "De la Fuente", "García-Márquez", etc.**

---

## **📌 5. Diferencias entre LIKE y REGEXP**

| Característica                   | `LIKE`                     | `REGEXP`                                      |
| -------------------------------- | -------------------------- | --------------------------------------------- | ------ |
| Uso de comodines                 | `%` y `_`                  | `.` `^` `$` `[]` `                            | ` `{}` |
| Búsqueda flexible                | Solo posiciones fijas      | Soporta patrones avanzados                    |
| Sensible a mayúsculas/minúsculas | ✅ (depende del collation) | ✅ (sensible, pero configurable con `BINARY`) |
| Soporta rangos y repeticiones    | ❌ No                      | ✅ Sí                                         |

🔹 **¿Cuándo usar `LIKE`?**  
✔️ Cuando necesitas búsquedas simples (ej. nombres que contienen "Juan").

🔹 **¿Cuándo usar `REGEXP`?**  
✔️ Cuando necesitas validar formatos o hacer búsquedas más avanzadas.

---

### ❌ **Error en la sintaxis de `LIKE` en MySQL**  
Las consultas que escribiste usan **rangos de caracteres `[A-B]` y negaciones `[^DV]`**, pero **esto no es compatible con `LIKE` en MySQL**.  

✅ **En MySQL, debes usar `REGEXP` en lugar de `LIKE`** para estos casos.  

---

## **📌 Conversión de tus consultas a MySQL (`REGEXP`)**  

### **1️⃣ Buscar alumnos cuyos nombres comiencen con "A" o "B"**  
**SQL Incorrecto (No funciona en MySQL con `LIKE`):**  
```sql
SELECT * FROM alumnos WHERE nombre LIKE '[A-B]%';
```
✅ **Corrección con `REGEXP`:**  
```sql
SELECT * FROM alumnos WHERE nombre REGEXP '^[A-B]';
```
🔹 **Explicación:**  
- `^` → Indica que la coincidencia debe estar al **inicio** del nombre.  
- `[A-B]` → Acepta nombres que **empiecen con "A" o "B"**.  

---

### **2️⃣ Buscar alumnos cuyos nombres comiencen con "A" o "M" y contengan "del" en cualquier parte**  
**SQL Incorrecto (No funciona en MySQL con `LIKE`):**  
```sql
SELECT * FROM alumnos WHERE first_name LIKE '[AM]%del%';
```
✅ **Corrección con `REGEXP`:**  
```sql
SELECT * FROM alumnos WHERE nombre REGEXP '^[AM].*del.*';
```
🔹 **Explicación:**  
- `^[AM]` → **Empieza con "A" o "M"**.  
- `.*del.*` → Contiene **"del" en cualquier parte** del nombre.  

---

### **3️⃣ Buscar alumnos cuyos nombres NO empiecen con "D" o "V"**  
**SQL Incorrecto (No funciona en MySQL con `LIKE`):**  
```sql
SELECT * FROM alumnos WHERE name LIKE '[^DV]%';
```
✅ **Corrección con `REGEXP`:**  
```sql
SELECT * FROM alumnos WHERE nombre REGEXP '^[^DV]';
```
🔹 **Explicación:**  
- `^` **dentro de los corchetes (`[^DV]`)** → Niega los caracteres dentro, es decir, **excluye los nombres que comiencen con "D" o "V"**.  

---

## **📌 Resumen de la conversión de `LIKE` a `REGEXP` en MySQL**  
| **Consulta original (`LIKE` en SQL Server)** | **Conversión correcta (`REGEXP` en MySQL)** |
|---------------------------------|---------------------------------|
| `LIKE '[A-B]%'` | `REGEXP '^[A-B]'` |
| `LIKE '[AM]%del%'` | `REGEXP '^[AM].*del.*'` |
| `LIKE '[^DV]%'` | `REGEXP '^[^DV]'` |

✅ **Usa `LIKE` para búsquedas simples con `%`.**  
✅ **Usa `REGEXP` para búsquedas avanzadas con rangos `[ ]`, negaciones `[^ ]` y patrones más complejos.**  



## **📌 6. Conclusión**

✅ **`REGEXP` es una herramienta poderosa** que permite hacer búsquedas avanzadas, validaciones y limpieza de datos en MySQL.  
✅ **Es más flexible que `LIKE`**, pero puede ser más costoso en términos de rendimiento en grandes volúmenes de datos.  
✅ **Usar `REGEXP` es clave para validar formatos**, como correos electrónicos, números de teléfono o códigos específicos.

5. **Subconsultas en SQL**
   - 📖 **Concepto:** Consultas dentro de consultas.
   - 🔍 **Tipos de Subconsultas:**
     - **Escalar** (devuelve un solo valor)
     - **Multifila** (`IN`, `EXISTS`)
   - ✅ **Ejemplo de Aplicación:**
     ```sql
     SELECT nombre, apellido
     FROM alumnos
     WHERE id_alumno IN (SELECT id_alumno FROM inscripciones);
     ```

---

### **🕒 Funciones y Sentencias Avanzadas**

6. **Combinación de Subconsultas y Funciones**

   - 📖 **Concepto:** Se pueden usar funciones dentro de subconsultas para cálculos dinámicos.
   - ✅ **Ejemplo de Aplicación:**
     ```sql
     SELECT nombre, apellido, edad
     FROM alumnos
     WHERE edad = (SELECT MAX(edad) FROM alumnos);
     ```

# **📌 Combinación de Subconsultas y Funciones en MySQL**

En MySQL, podemos **combinar subconsultas con funciones** para obtener información más compleja y útil. Esto nos permite realizar cálculos, filtrar datos dinámicamente y mejorar la eficiencia de nuestras consultas.

---

## **🧐 1. ¿Qué es una subconsulta?**

Una **subconsulta** es una consulta dentro de otra consulta. Puede usarse en **cláusulas `SELECT`, `WHERE`, `HAVING` o `FROM`** para devolver datos que serán utilizados por la consulta principal.

**Ejemplo básico:**

```sql
SELECT nombre, edad
FROM alumnos
WHERE edad = (SELECT MAX(edad) FROM alumnos);
```

🔹 **Encuentra el alumno con la mayor edad.**

---

## **🔹 2. Tipos de Subconsultas**

Las subconsultas pueden ser:

1. **Escalares** → Devuelven un solo valor.
2. **De una sola columna** → Devuelven varios valores en una columna.
3. **De varias columnas** → Devuelven varias filas y columnas.
4. **Correlacionadas** → Se ejecutan por cada fila de la consulta principal.

Ejemplo de subconsulta **escalar** con funciones:

```sql
SELECT nombre, edad
FROM alumnos
WHERE edad > (SELECT AVG(edad) FROM alumnos);
```

🔹 **Lista los alumnos cuya edad es mayor al promedio.**

---

## **🎯 3. Funciones Combinadas con Subconsultas**

### **🔹 Funciones de Agregación + Subconsultas**

Las funciones de agregación (`SUM()`, `AVG()`, `COUNT()`, `MIN()`, `MAX()`) son ideales para calcular valores a partir de subconsultas.

#### 📌 **Ejemplo 1: Obtener el alumno más joven por nacionalidad**

```sql
SELECT nombre, nacionalidad, edad
FROM alumnos
WHERE (nacionalidad, edad) IN (
    SELECT nacionalidad, MIN(edad)
    FROM alumnos
    GROUP BY nacionalidad
);
```

🔹 **Encuentra el alumno más joven de cada país.**

---

### **🔹 Funciones de Texto + Subconsultas**

Podemos transformar datos con funciones de cadena (`CONCAT()`, `UPPER()`, `LOWER()`, `SUBSTRING()`).

#### 📌 **Ejemplo 2: Obtener emails en mayúsculas de alumnos mayores al promedio de edad**

```sql
SELECT UPPER(email) AS email_mayuscula
FROM alumnos
WHERE edad > (SELECT AVG(edad) FROM alumnos);
```

🔹 **Convierte en mayúsculas los emails de los alumnos con edad mayor al promedio.**

---

### **🔹 Funciones de Fecha + Subconsultas**

Las funciones de fecha (`NOW()`, `DATEDIFF()`, `YEAR()`, `MONTH()`) permiten calcular tiempos.

#### 📌 **Ejemplo 3: Alumnos que se inscribieron hace más de 1 año**

```sql
SELECT nombre, fecha_inscripcion
FROM alumnos
WHERE DATEDIFF(NOW(), fecha_inscripcion) > 365;
```

🔹 **Muestra los alumnos que se inscribieron hace más de un año.**

---

## **📌 4. Subconsultas en la Cláusula `FROM`**

Podemos usar una subconsulta como una **tabla temporal** dentro del `FROM`.

#### 📌 **Ejemplo 4: Promedio de edad por nacionalidad**

```sql
SELECT nacionalidad, promedio_edad
FROM (
    SELECT nacionalidad, AVG(edad) AS promedio_edad
    FROM alumnos
    GROUP BY nacionalidad
) AS subconsulta
ORDER BY promedio_edad DESC;
```

🔹 **Calcula el promedio de edad por nacionalidad y los ordena de mayor a menor.**

---

## **📌 5. Subconsultas Correlacionadas**

Las **subconsultas correlacionadas** dependen de la consulta principal y se ejecutan para cada fila.

#### 📌 **Ejemplo 5: Obtener alumnos cuya edad sea mayor que la edad promedio de su nacionalidad**

```sql
SELECT nombre, nacionalidad, edad
FROM alumnos A
WHERE edad > (SELECT AVG(edad) FROM alumnos WHERE nacionalidad = A.nacionalidad);
```

🔹 **Compara la edad de cada alumno con el promedio de su propio país.**

---

## **📌 6. Combinación de Subconsultas con Operadores (`IN`, `NOT IN`, `EXISTS`)**

### **🔹 `IN` con Subconsultas**

```sql
SELECT nombre, email
FROM alumnos
WHERE nacionalidad IN (SELECT nacionalidad FROM alumnos WHERE edad > 30);
```

🔹 **Lista los alumnos de países donde hay personas mayores de 30 años.**

### **🔹 `EXISTS` con Subconsultas**

```sql
SELECT nombre
FROM alumnos A
WHERE EXISTS (
    SELECT 1 FROM alumnos B WHERE B.nacionalidad = A.nacionalidad AND B.edad > 30
);
```

🔹 **Muestra los alumnos que pertenecen a una nacionalidad donde hay mayores de 30 años.**

---

## **📌 7. Conclusión**

✅ **Las subconsultas permiten construir consultas más complejas y dinámicas.**  
✅ **Combinarlas con funciones agrega más poder y flexibilidad a los análisis de datos.**  
✅ **Son útiles para cálculos, validaciones y transformaciones de datos.**

7. **Data Definition Language (DDL)**

   - 📖 **Concepto:** Instrucciones que modifican la estructura de la base de datos (`CREATE`, `DROP`, `ALTER`, `TRUNCATE`).
   - ✅ **Ejemplo de Aplicación:**
     ```sql
     ALTER TABLE alumnos ADD COLUMN direccion VARCHAR(100);
     ```

## **📌 Data Definition Language (DDL) en MySQL**

El **Data Definition Language (DDL)** es una parte fundamental de SQL que se utiliza para **definir y gestionar la estructura de las bases de datos**. Con DDL, podemos crear, modificar y eliminar bases de datos, tablas, índices y otros objetos.

---

## **📌 1. ¿Qué es DDL?**

DDL (Lenguaje de Definición de Datos) **define la estructura** de la base de datos, pero no manipula los datos directamente.

**📌 Principales comandos DDL:**  
| Comando | Descripción |
|---------|------------|
| `CREATE` | Crea bases de datos, tablas, índices, vistas, etc. |
| `ALTER` | Modifica la estructura de una tabla existente. |
| `DROP` | Elimina bases de datos, tablas o índices. |
| `TRUNCATE` | Elimina todos los datos de una tabla, pero mantiene su estructura. |
| `RENAME` | Cambia el nombre de una tabla. |

---

## **📌 2. Comando `CREATE`**

Se usa para **crear** bases de datos, tablas, índices y otros objetos.

### **📌 Crear una Base de Datos**

```sql
CREATE DATABASE IF NOT EXISTS escuela;
```

🔹 **Crea una base de datos llamada `escuela` si no existe.**

### **📌 Crear una Tabla**

```sql
CREATE TABLE alumnos (
    id_alumno INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    edad INT CHECK (edad >= 0),
    fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

🔹 **Crea la tabla `alumnos` con diversas restricciones como `PRIMARY KEY`, `UNIQUE` y `CHECK`.**

---

## **📌 3. Comando `ALTER`**

Se usa para **modificar** la estructura de una tabla existente.

### **📌 Agregar una columna**

```sql
ALTER TABLE alumnos ADD COLUMN telefono VARCHAR(20);
```

🔹 **Añade la columna `telefono` a la tabla `alumnos`.**

### **📌 Modificar una columna**

```sql
ALTER TABLE alumnos MODIFY COLUMN telefono VARCHAR(15) NOT NULL;
```

🔹 **Modifica el tipo de dato y agrega `NOT NULL`.**

### **📌 Renombrar una columna**

```sql
ALTER TABLE alumnos CHANGE COLUMN telefono celular VARCHAR(15);
```

🔹 **Cambia el nombre de `telefono` a `celular`.**

### **📌 Eliminar una columna**

```sql
ALTER TABLE alumnos DROP COLUMN edad;
```

🔹 **Elimina la columna `edad`.**

---

## **📌 4. Comando `DROP`**

Se usa para **eliminar** bases de datos, tablas o columnas.

### **📌 Eliminar una Tabla**

```sql
DROP TABLE IF EXISTS alumnos;
```

🔹 **Elimina la tabla `alumnos` si existe.**

### **📌 Eliminar una Base de Datos**

```sql
DROP DATABASE IF EXISTS escuela;
```

🔹 **Elimina la base de datos `escuela`.**

---

## **📌 5. Comando `TRUNCATE`**

Elimina **todos los datos** de una tabla pero mantiene su estructura.

```sql
TRUNCATE TABLE alumnos;
```

🔹 **Vacía la tabla `alumnos`, pero no la elimina.**

⚠️ **Diferencias entre `DELETE` y `TRUNCATE`:**  
| `DELETE` | `TRUNCATE` |
|----------|-----------|
| Puede eliminar filas específicas con `WHERE`. | Elimina todos los registros de la tabla. |
| Más lento porque registra cada eliminación. | Más rápido porque no registra cada eliminación. |
| Puede activar triggers. | No activa triggers. |

---

## **📌 6. Comando `RENAME`**

Cambia el nombre de una tabla.

```sql
RENAME TABLE alumnos TO estudiantes;
```

🔹 **Renombra `alumnos` a `estudiantes`.**

---

## **📌 7. Resumen**

✅ **DDL define la estructura** de la base de datos.  
✅ **No manipula datos, solo objetos** (tablas, índices, etc.).  
✅ **Comandos principales:** `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`.  
✅ **`TRUNCATE` es más rápido que `DELETE` para eliminar todos los registros.**

8. **Sentencias de Manipulación de Objetos**

   - 📖 **Concepto:** Comandos para modificar objetos de la base de datos.
   - ✅ **Ejemplo de Aplicación:**
     ```sql
     DROP TABLE inscripciones;
     TRUNCATE TABLE alumnos;
     ```

9. **Funciones Escalares en MySQL**

   - 📖 **Concepto:** Funciones que operan sobre valores individuales.
   - 🔍 **Ejemplos:**
     - **Funciones de cadena:** `CONCAT()`, `UCASE()`, `LCASE()`, `REVERSE()`
     - **Funciones numéricas:** `ROUND()`, `CEIL()`, `FLOOR()`, `ABS()`
     - **Funciones de fecha:** `NOW()`, `CURDATE()`, `YEAR()`, `MONTH()`
   - ✅ **Ejemplo de Aplicación:**
     ```sql
     SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM alumnos;
     SELECT UCASE(nombre) FROM alumnos;
     ```

## **📌 Funciones Escalares en MySQL**

Las **funciones escalares** en MySQL son funciones que **operan sobre una única fila** y devuelven un **único valor** como resultado. Estas funciones se utilizan comúnmente para manipular y transformar datos en las consultas SQL.

---

## **📌 1. ¿Qué son las funciones escalares?**

Son funciones que reciben un valor, lo procesan y devuelven otro valor. **No afectan a varias filas, sino a valores individuales.**

**Tipos principales de funciones escalares en MySQL:**

1. **Funciones de cadena** (para manipulación de textos).
2. **Funciones numéricas** (para cálculos matemáticos).
3. **Funciones de fecha y hora** (para manipular fechas y horas).
4. **Funciones de conversión** (para cambiar tipos de datos).

---

## **📌 2. Funciones de Cadena (Strings)**

Estas funciones permiten manipular valores de tipo `VARCHAR` o `TEXT`.

### 🔹 **`UPPER()` y `LOWER()` – Convertir a mayúsculas y minúsculas**

```sql
SELECT UPPER('hola mundo') AS mayusculas;  -- Resultado: HOLA MUNDO
SELECT LOWER('HOLA MUNDO') AS minusculas;  -- Resultado: hola mundo
```

### 🔹 **`CONCAT()` – Concatenar cadenas**

```sql
SELECT CONCAT('Hola', ' ', 'Mundo') AS saludo;  -- Resultado: Hola Mundo
```

### 🔹 **`SUBSTRING()` – Extraer parte de una cadena**

```sql
SELECT SUBSTRING('CoderHouse', 1, 5) AS subcadena;  -- Resultado: Coder
```

### 🔹 **`LENGTH()` – Obtener la longitud de una cadena**

```sql
SELECT LENGTH('CoderHouse') AS longitud;  -- Resultado: 10
```

### 🔹 **`TRIM()` – Eliminar espacios en blanco**

```sql
SELECT TRIM('  Hola Mundo   ') AS sin_espacios;  -- Resultado: Hola Mundo
```

### 🔹 **`REVERSE()` – Invertir una cadena**

```sql
SELECT REVERSE('CoderHouse') AS invertido;  -- Resultado: esuoHredoC
```

---

## **📌 3. Funciones Numéricas**

Se utilizan para realizar cálculos matemáticos sobre valores numéricos.

### 🔹 **Operaciones Matemáticas**

```sql
SELECT 10 + 5 AS suma, 10 - 5 AS resta, 10 * 5 AS multiplicacion, 10 / 5 AS division;
```

### 🔹 **`ROUND()` – Redondear un número**

```sql
SELECT ROUND(3.14159, 2) AS redondeado;  -- Resultado: 3.14
```

### 🔹 **`CEIL()` y `FLOOR()` – Redondear hacia arriba o abajo**

```sql
SELECT CEIL(4.2) AS techo, FLOOR(4.8) AS piso;  -- Resultado: techo = 5, piso = 4
```

### 🔹 **`MOD()` – Obtener el módulo (resto de división)**

```sql
SELECT MOD(10, 3) AS modulo;  -- Resultado: 1
```

---

## **📌 4. Funciones de Fecha y Hora**

Se utilizan para manipular valores de tipo `DATE`, `DATETIME` y `TIMESTAMP`.

### 🔹 **`NOW()` – Obtener la fecha y hora actual**

```sql
SELECT NOW() AS fecha_hora_actual;
```

### 🔹 **`CURDATE()` y `CURTIME()` – Obtener la fecha y la hora actual por separado**

```sql
SELECT CURDATE() AS fecha_actual, CURTIME() AS hora_actual;
```

### 🔹 **`YEAR()`, `MONTH()`, `DAY()` – Extraer partes de una fecha**

```sql
SELECT YEAR(NOW()) AS anio, MONTH(NOW()) AS mes, DAY(NOW()) AS dia;
```

### 🔹 **`DATE_FORMAT()` – Formatear una fecha**

```sql
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y') AS fecha_formateada;  -- Resultado: 22/03/2025
```

---

## **📌 5. Funciones de Conversión**

Permiten cambiar el tipo de datos de una columna o valor.

### 🔹 **`CAST()` – Convertir tipos de datos**

```sql
SELECT CAST(123.45 AS SIGNED) AS entero;  -- Resultado: 123
SELECT CAST('2025-03-22' AS DATE) AS fecha;
```

### 🔹 **`CONVERT()` – Otra forma de conversión**

```sql
SELECT CONVERT('123.45', SIGNED) AS entero;
```

---

## **📌 6. Uso de Funciones Escalares en una Consulta**

Imagina que tenemos la siguiente tabla `alumnos`:

| id_alumno | nombre | apellido | edad | fecha_inscripcion   |
| --------- | ------ | -------- | ---- | ------------------- |
| 1         | Juan   | Pérez    | 25   | 2024-05-01 14:30:00 |
| 2         | María  | Gómez    | 30   | 2023-08-10 10:15:00 |

Podemos usar funciones escalares en una consulta:

```sql
SELECT
    id_alumno,
    UPPER(nombre) AS nombre_mayusculas,
    CONCAT(nombre, ' ', apellido) AS nombre_completo,
    edad + 5 AS edad_futura,
    YEAR(fecha_inscripcion) AS anio_inscripcion
FROM alumnos;
```

🔹 **Salida esperada:**  
| id_alumno | nombre_mayusculas | nombre_completo | edad_futura | anio_inscripcion |
|-----------|------------------|----------------|------------|-----------------|
| 1 | JUAN | Juan Pérez | 30 | 2024 |
| 2 | MARÍA | María Gómez | 35 | 2023 |

---

## **📌 7. Resumen**

✅ **Las funciones escalares trabajan con valores individuales.**  
✅ **Se pueden utilizar en `SELECT`, `WHERE`, `ORDER BY` y más.**  
✅ **Tipos de funciones:**

- **De cadena:** `UPPER()`, `CONCAT()`, `LENGTH()`, `TRIM()`.
- **Numéricas:** `ROUND()`, `MOD()`, `CEIL()`, `FLOOR()`.
- **De fecha:** `NOW()`, `YEAR()`, `DATE_FORMAT()`.
- **De conversión:** `CAST()`, `CONVERT()`.

10. **Ejercicios Prácticos y Cierre**

- 📌 **Ejercicios de Aplicación:**
  - Encontrar el alumno más joven y el más viejo.
  - Obtener la edad promedio de los alumnos de nacionalidad argentina.
  - Listar los alumnos cuyo apellido termine en "z".
- ✅ **Ejemplo de Resolución:**
  ```sql
  SELECT nombre, apellido FROM alumnos WHERE apellido LIKE '%z';
  SELECT AVG(edad) FROM alumnos WHERE nacionalidad = 'Argentina';
  ```

---

## **📢 Conclusión de la Clase**

- 🎯 **Resumen:**

  - UNION y tipos de JOIN
  - Uso avanzado de LIKE y expresiones regulares
  - Subconsultas y combinación con funciones
  - Manipulación de estructuras con DDL
  - Funciones escalares en MySQL

- 📌 **Tarea Opcional:**
  - Crear una nueva tabla `profesores` y relacionarla con `cursos`.
  - Implementar una consulta que liste alumnos con sus cursos y profesores.

---

## 🧑‍🏫 Profesor

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)
