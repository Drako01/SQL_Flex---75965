### **Clase de SQL Nro 3**  
#### **Objetivo General:**  
En esta clase, veremos los conceptos clave de SQL relacionados con consultas avanzadas, manipulación de datos y funciones. Se enfocará en MySQL, aplicando ejemplos prácticos para reforzar cada tema.

---

### **🕒 Fundamentos Avanzados de Consultas SQL**
1. **Unión de Tablas**  
   - 📖 **Concepto:** La unión de tablas permite combinar datos de múltiples tablas en una sola consulta.  
   - 🔍 **Tipos de JOIN:**  
     - `INNER JOIN`  
     - `LEFT JOIN`  
     - `RIGHT JOIN`  
     - `FULL OUTER JOIN` *(No soportado en MySQL, se simula con UNION)*  
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

7. **Data Definition Language (DDL)**  
   - 📖 **Concepto:** Instrucciones que modifican la estructura de la base de datos (`CREATE`, `DROP`, `ALTER`, `TRUNCATE`).  
   - ✅ **Ejemplo de Aplicación:**  
     ```sql
     ALTER TABLE alumnos ADD COLUMN direccion VARCHAR(100);
     ```

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
