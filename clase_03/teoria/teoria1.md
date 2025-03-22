# **📘 Curso de SQL - MySQL**  

## **Índice**  
1. [Introducción](#introducción)  
2. [Unión de Tablas (JOIN)](#unión-de-tablas-join)  
3. [Tipos de Datos en SQL](#tipos-de-datos-en-sql)  
4. [Uso de LIKE y Comodines](#uso-de-like-y-comodines)  
5. [Expresiones Regulares](#expresiones-regulares)  
6. [Subconsultas en SQL](#subconsultas-en-sql)  
7. [Combinación de Subconsultas y Funciones](#combinación-de-subconsultas-y-funciones)  
8. [Data Definition Language (DDL)](#data-definition-language-ddl)  
9. [Sentencias de Manipulación de Objetos](#sentencias-de-manipulación-de-objetos)  
10. [Funciones Escalares en MySQL](#funciones-escalares-en-mysql)  
11. [Ejercicios Prácticos](#ejercicios-prácticos)  
12. [Recursos Adicionales](#recursos-adicionales)  

---

## **Introducción**  
Este material de apoyo cubre temas avanzados de SQL en MySQL. Aprenderás cómo combinar tablas, manipular datos y usar funciones avanzadas para optimizar consultas.

---

## **Unión de Tablas (JOIN)**  
Las uniones (`JOIN`) permiten combinar registros de dos o más tablas en una sola consulta.  

### **Tipos de JOIN**  
- **`INNER JOIN`** → Devuelve solo los registros que coinciden en ambas tablas.  
- **`LEFT JOIN`** → Devuelve todos los registros de la tabla izquierda y los coincidentes de la derecha.  
- **`RIGHT JOIN`** → Devuelve todos los registros de la tabla derecha y los coincidentes de la izquierda.  
- **`FULL OUTER JOIN`** → Devuelve todos los registros de ambas tablas (se puede simular con `UNION`).  

### **Ejemplo Práctico**  
```sql
SELECT a.nombre, a.apellido, c.nombre_curso 
FROM alumnos a
INNER JOIN inscripciones i ON a.id_alumno = i.id_alumno
INNER JOIN cursos c ON i.id_curso = c.id_curso;
```

---

## **Tipos de Datos en SQL**  
SQL soporta distintos tipos de datos:  
- **Numéricos:** `INT`, `DECIMAL`, `FLOAT`  
- **Texto:** `VARCHAR(n)`, `TEXT`, `CHAR(n)`  
- **Fecha/Hora:** `DATE`, `DATETIME`, `TIMESTAMP`  

### **Ejemplo de Creación de Tabla**  
```sql
CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha_ingreso DATE DEFAULT CURRENT_DATE
);
```

---

## **Uso de LIKE y Comodines**  
Se usa `LIKE` para realizar búsquedas flexibles.  

| Comodín | Descripción |
|---------|------------|
| `%`     | Cualquier cantidad de caracteres |
| `_`     | Un solo carácter |

### **Ejemplo Práctico**  
```sql
SELECT * FROM alumnos WHERE nombre LIKE 'A%'; -- Nombres que empiezan con "A"
SELECT * FROM alumnos WHERE email LIKE '%@gmail.com'; -- Emails de Gmail
```

---

## **Expresiones Regulares**  
En MySQL, `REGEXP` permite hacer búsquedas avanzadas.  

### **Ejemplo Práctico**  
```sql
SELECT * FROM alumnos WHERE email REGEXP '^[a-z]+@[a-z]+\\.(com|net)$';
```

---

## **Subconsultas en SQL**  
Las subconsultas permiten usar el resultado de una consulta dentro de otra.  

### **Tipos de Subconsultas**  
1. **Escalar** → Retorna un solo valor.  
2. **Multifila** → Retorna múltiples valores (`IN`, `EXISTS`).  

### **Ejemplo Práctico**  
```sql
SELECT nombre, apellido 
FROM alumnos 
WHERE id_alumno IN (SELECT id_alumno FROM inscripciones);
```

---

## **Combinación de Subconsultas y Funciones**  
Se pueden usar funciones dentro de subconsultas.  

### **Ejemplo Práctico**  
```sql
SELECT nombre, apellido, edad 
FROM alumnos 
WHERE edad = (SELECT MAX(edad) FROM alumnos);
```

---

## **Data Definition Language (DDL)**  
Permite modificar la estructura de la base de datos.  

| Comando  | Descripción |
|----------|------------|
| `CREATE` | Crea una tabla o base de datos |
| `DROP`   | Elimina una tabla o base de datos |
| `ALTER`  | Modifica una tabla |
| `TRUNCATE` | Borra todos los datos de una tabla |

### **Ejemplo Práctico**  
```sql
ALTER TABLE alumnos ADD COLUMN direccion VARCHAR(100);
```

---

## **Sentencias de Manipulación de Objetos**  
Son comandos usados para eliminar o modificar estructuras.  

### **Ejemplo Práctico**  
```sql
DROP TABLE inscripciones;
TRUNCATE TABLE alumnos;
```

---

## **Funciones Escalares en MySQL**  
Las funciones escalares operan sobre un solo valor.  

### **Funciones de Cadena**  
```sql
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM alumnos;
SELECT UCASE(nombre) FROM alumnos;
SELECT LCASE(apellido) FROM alumnos;
SELECT REVERSE(nombre) FROM alumnos;
```

### **Funciones Numéricas**  
```sql
SELECT ROUND(3.14159, 2); -- 3.14
SELECT CEIL(4.2); -- 5
SELECT FLOOR(4.8); -- 4
SELECT ABS(-10); -- 10
```

### **Funciones de Fecha**  
```sql
SELECT NOW(); -- Fecha y hora actual
SELECT CURDATE(); -- Solo la fecha actual
SELECT YEAR(fecha_inscripcion) FROM alumnos;
```

---

## **Ejercicios Prácticos**  
1. Encuentra el alumno más joven y el más viejo.  
```sql
SELECT MIN(edad) AS "Más Joven", MAX(edad) AS "Más Adulto" FROM alumnos;
```

2. Calcula la edad promedio de los alumnos argentinos.  
```sql
SELECT AVG(edad) FROM alumnos WHERE nacionalidad = 'Argentina';
```

3. Encuentra los alumnos cuyo apellido termina en "z".  
```sql
SELECT nombre, apellido FROM alumnos WHERE apellido LIKE '%z';
```

4. Lista los primeros 5 alumnos ordenados por apellido.  
```sql
SELECT nombre, apellido FROM alumnos ORDER BY apellido ASC LIMIT 5;
```

---

## **Recursos Adicionales**  
📚 **Documentación Oficial de MySQL:**  
- [https://dev.mysql.com/doc/](https://dev.mysql.com/doc/)  

📺 **Cursos en Línea:**  
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)  

---

## **📌 Conclusión**  
- Aprendimos a unir tablas con `JOIN`.  
- Exploramos tipos de datos y su uso en MySQL.  
- Aplicamos `LIKE`, expresiones regulares y subconsultas.  
- Manipulamos estructuras con `DDL` (`ALTER`, `DROP`, `TRUNCATE`).  
- Implementamos funciones escalares para trabajar con datos.  

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
