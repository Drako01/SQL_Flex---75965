# 📚 Teoría -Clase 02: Sentencias y Sublenguajes en SQL

## **📌 1️⃣ ¿Qué es SQL y sus Sublenguajes?**  
SQL (Structured Query Language) es el lenguaje utilizado para manejar bases de datos relacionales.  
Se divide en **cuatro sublenguajes principales**:  

✅ **DDL (Data Definition Language)** → Definir estructuras de datos (`CREATE`, `ALTER`, `DROP`).  
✅ **DML (Data Manipulation Language)** → Manipular datos (`SELECT`, `INSERT`, `UPDATE`, `DELETE`).  
✅ **DCL (Data Control Language)** → Controlar permisos (`GRANT`, `REVOKE`).  
✅ **TCL (Transaction Control Language)** → Manejar transacciones (`COMMIT`, `ROLLBACK`).  

---

## **📌 2️⃣ Sentencia `SELECT`: Cómo consultar datos**  
La sentencia `SELECT` permite recuperar información de una base de datos.  

📌 **Ejemplo básico:**  
```sql
SELECT * FROM alumnos;
```
📌 **Cláusulas más usadas:**  
✅ `WHERE` → Filtrar registros  
✅ `ORDER BY` → Ordenar resultados  
✅ `LIMIT` → Limitar cantidad de registros  

📌 **Ejemplo filtrando datos:**  
```sql
SELECT nombre, apellido FROM alumnos WHERE nacionalidad = 'Argentina';
```

---

## **📌 3️⃣ Operadores en SQL**  
SQL tiene **tres tipos principales de operadores**:  

### **🔹 Aritméticos** (`+`, `-`, `*`, `/`, `%`)  
📌 **Ejemplo:**  
```sql
SELECT precio * 1.21 AS precio_con_IVA FROM productos;
```

### **🔹 Comparación** (`=`, `!=`, `>`, `<`, `>=`, `<=`)  
📌 **Ejemplo:**  
```sql
SELECT * FROM alumnos WHERE edad >= 18;
```

### **🔹 Lógicos** (`AND`, `OR`, `NOT`)  
📌 **Ejemplo:**  
```sql
SELECT * FROM alumnos WHERE nacionalidad = 'Argentina' AND edad > 18;
```

---

## **📌 4️⃣ Sentencias Complementarias (`INSERT`, `UPDATE`, `DELETE`)**  

### **🔹 `INSERT` → Agregar datos**  
📌 **Ejemplo:**  
```sql
INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad)
VALUES ('Carlos', 'López', 'carlos.lopez@gmail.com', 37845612, '1122334455', 'Chile');
```

### **🔹 `UPDATE` → Modificar datos**  
📌 **Ejemplo:**  
```sql
UPDATE alumnos SET email = 'nuevoemail@gmail.com' WHERE nombre = 'Carlos';
```

### **🔹 `DELETE` → Eliminar datos**  
📌 **Ejemplo:**  
```sql
DELETE FROM alumnos WHERE nombre = 'Carlos';
```

---

## **📌 5️⃣ Funciones en SQL**  
Las funciones permiten realizar cálculos en los datos.  

### **🔹 Funciones de Agregación**  
✅ `COUNT()` → Contar registros  
✅ `SUM()` → Sumar valores  
✅ `AVG()` → Promedio  
✅ `MIN()` / `MAX()` → Valor mínimo y máximo  

📌 **Ejemplo:**  
```sql
SELECT COUNT(*) FROM alumnos WHERE nacionalidad = 'Argentina';
```

---

## **📌 6️⃣ Tipos de Intersección en Tablas SQL**  
Para trabajar con varias tablas, usamos `JOIN`, `UNION` y otras herramientas.  

### **🔹 Tipos de `JOIN`**  
✅ **`INNER JOIN`** → Coincidencias exactas en ambas tablas  
✅ **`LEFT JOIN`** → Todo de la tabla izquierda + coincidencias  
✅ **`RIGHT JOIN`** → Todo de la tabla derecha + coincidencias  
✅ **`FULL JOIN`** → Todos los registros de ambas tablas  

📌 **Ejemplo con `INNER JOIN`:**  
```sql
SELECT alumnos.nombre, pedidos.producto 
FROM alumnos 
INNER JOIN pedidos ON alumnos.id_alumno = pedidos.id_alumno;
```

### **🔹 `UNION` y `INTERSECT`**  
✅ **`UNION`** → Une los resultados de dos consultas eliminando duplicados.  
✅ **`UNION ALL`** → Une los resultados sin eliminar duplicados.  
✅ **`INTERSECT`** → Muestra solo los datos que están en ambas consultas.  

📌 **Ejemplo de `UNION`:**  
```sql
SELECT nombre FROM alumnos
UNION
SELECT nombre FROM profesores;
```

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
