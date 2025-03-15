# Clase 02 - SQL 


# **📌 Clase #2 - Sentencias y Sublenguajes**  

## **⏳ Temas a Abordar**  
| Sección | Tema|
|---------|------|
| 1 | Introducción a SQL y Sublenguajes |
| 2 | Sentencia `SELECT` |
| 3 | Operadores en SQL |
| 4 | Sentencias complementarias (`INSERT`, `UPDATE`, `DELETE`) |
| 5 | Funciones en SQL |
| 6 | Tipos de intersección en tablas SQL (`JOIN`, `UNION`, etc.) |
| 7 | Ejercicio práctico y dudas |

---

## **📌 Contenido de la clase**  

### **1️⃣ Introducción a SQL y Sublenguajes**  
📌 SQL se divide en 4 sublenguajes:  
✅ **DDL (Data Definition Language)** → `CREATE`, `ALTER`, `DROP`  
✅ **DML (Data Manipulation Language)** → `SELECT`, `INSERT`, `UPDATE`, `DELETE`  
✅ **DCL (Data Control Language)** → `GRANT`, `REVOKE`  
✅ **TCL (Transaction Control Language)** → `COMMIT`, `ROLLBACK`  

---

### **2️⃣ Sentencia `SELECT`**  
📌 **Sintaxis básica:**  
```sql
SELECT columna1, columna2 FROM tabla WHERE condición;
```
📌 **Ejemplo:** Obtener todos los alumnos de la tabla `alumnos`:  
```sql
SELECT * FROM alumnos;
```
📌 **Cláusulas importantes:**  
✅ `WHERE` → Filtrar datos  
✅ `ORDER BY` → Ordenar resultados  
✅ `LIMIT` → Limitar cantidad de registros  

---

### **3️⃣ Operadores en SQL**  
📌 **Tipos de operadores:**  
✅ **Aritméticos** (`+`, `-`, `*`, `/`, `%`)  
✅ **Comparación** (`=`, `!=`, `>`, `<`, `>=`, `<=`)  
✅ **Lógicos** (`AND`, `OR`, `NOT`)  

📌 **Ejemplo:**  
```sql
SELECT * FROM alumnos WHERE nacionalidad = 'Argentina' AND edad >= 18;
```

---

### **4️⃣ Sentencias complementarias (`INSERT`, `UPDATE`, `DELETE`) (20 min)**  
📌 **`INSERT` - Agregar datos:**  
```sql
INSERT INTO alumnos (nombre, apellido, email) VALUES ('Juan', 'Pérez', 'juan@gmail.com');
```
📌 **`UPDATE` - Modificar datos:**  
```sql
UPDATE alumnos SET email = 'juan.perez@gmail.com' WHERE nombre = 'Juan';
```
📌 **`DELETE` - Eliminar datos:**  
```sql
DELETE FROM alumnos WHERE nombre = 'Juan';
```

---

### **5️⃣ Funciones en SQL**  
📌 **Funciones de agregación:**  
✅ `COUNT()` → Cuenta registros  
✅ `SUM()` → Suma valores  
✅ `AVG()` → Promedio  
✅ `MIN()` / `MAX()` → Valor mínimo y máximo  

📌 **Ejemplo:**  
```sql
SELECT COUNT(*) FROM alumnos WHERE nacionalidad = 'Argentina';
```

---

### **6️⃣ Tipos de intersección en tablas SQL**  
📌 **Tipos de `JOIN`:**  
✅ `INNER JOIN` → Coincidencias exactas en ambas tablas  
✅ `LEFT JOIN` → Todo de la tabla izquierda + coincidencias  
✅ `RIGHT JOIN` → Todo de la tabla derecha + coincidencias  
✅ `FULL JOIN` → Todos los registros de ambas tablas  

📌 **Ejemplo:**  
```sql
SELECT alumnos.nombre, pedidos.producto 
FROM alumnos 
INNER JOIN pedidos ON alumnos.id_alumno = pedidos.id_alumno;
```

---

### **7️⃣ Ejercicio práctico y dudas**  
📌 **Desafíos:**  
1️⃣ Seleccionar todos los alumnos mayores de 20 años.  
2️⃣ Insertar un nuevo pedido en la tabla `pedidos`.  
3️⃣ Hacer un `JOIN` entre `alumnos` y `pedidos`.  


---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  