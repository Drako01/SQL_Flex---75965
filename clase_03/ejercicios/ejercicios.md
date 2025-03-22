
# **📘 Ejercicios de SQL - MySQL**  

## **Índice de Ejercicios**  
1. [Unión de Tablas (JOIN)](#ejercicios-de-unión-de-tablas-join)  
2. [Tipos de Datos en SQL](#ejercicios-de-tipos-de-datos)  
3. [Uso de LIKE y Comodines](#ejercicios-de-like-y-comodines)  
4. [Expresiones Regulares](#ejercicios-de-expresiones-regulares)  
5. [Subconsultas en SQL](#ejercicios-de-subconsultas-en-sql)  
6. [Combinación de Subconsultas y Funciones](#ejercicios-de-combinación-de-subconsultas-y-funciones)  
7. [Data Definition Language (DDL)](#ejercicios-de-data-definition-language-ddl)  
8. [Sentencias de Manipulación de Objetos](#ejercicios-de-manipulación-de-objetos)  
9. [Funciones Escalares](#ejercicios-de-funciones-escalares)  

---

## **Ejercicios de Unión de Tablas (JOIN)**  

1. **Obtener los nombres y apellidos de los alumnos junto con el nombre del curso en el que están inscritos.**  
   ```sql
   SELECT a.nombre, a.apellido, c.nombre_curso
   FROM alumnos a
   INNER JOIN inscripciones i ON a.id_alumno = i.id_alumno
   INNER JOIN cursos c ON i.id_curso = c.id_curso;
   ```
2. **Listar los alumnos que no están inscritos en ningún curso.**  
   ```sql
   SELECT a.nombre, a.apellido
   FROM alumnos a
   LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
   WHERE i.id_inscripcion IS NULL;
   ```
3. **Obtener el número total de alumnos por curso.**  
   ```sql
   SELECT c.nombre_curso, COUNT(i.id_alumno) AS cantidad_alumnos
   FROM cursos c
   LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
   GROUP BY c.nombre_curso;
   ```

---

## **Ejercicios de Tipos de Datos**  

1. **Agregar un nuevo campo `promedio_final` de tipo `DECIMAL(5,2)` a la tabla `alumnos`.**  
   ```sql
   ALTER TABLE alumnos ADD COLUMN promedio_final DECIMAL(5,2);
   ```
2. **Modificar el campo `telefono` para que acepte solo números enteros de hasta 15 dígitos.**  
   ```sql
   ALTER TABLE alumnos MODIFY COLUMN telefono BIGINT(15);
   ```
3. **Insertar un nuevo alumno y verificar que los tipos de datos se respeten.**  
   ```sql
   INSERT INTO alumnos (nombre, apellido, email, dni, telefono, edad)
   VALUES ('Lucas', 'González', 'lucas@mail.com', 22334455, 1133344556, 22);
   ```

---

## **Ejercicios de LIKE y Comodines**  

1. **Encontrar todos los alumnos cuyo nombre comienza con "M".**  
   ```sql
   SELECT * FROM alumnos WHERE nombre LIKE 'M%';
   ```
2. **Obtener los alumnos cuyo email contiene "gmail".**  
   ```sql
   SELECT * FROM alumnos WHERE email LIKE '%gmail%';
   ```
3. **Buscar los alumnos cuyo apellido termine con "z".**  
   ```sql
   SELECT * FROM alumnos WHERE apellido LIKE '%z';
   ```
4. **Listar los alumnos cuyo teléfono empieza con "11".**  
   ```sql
   SELECT * FROM alumnos WHERE telefono LIKE '11%';
   ```

---

## **Ejercicios de Expresiones Regulares**  

1. **Obtener los alumnos con un email válido que termine en `.com` o `.net`.**  
   ```sql
   SELECT * FROM alumnos WHERE email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.(com|net)$';
   ```
2. **Buscar los alumnos cuyos nombres tengan solo letras mayúsculas.**  
   ```sql
   SELECT * FROM alumnos WHERE nombre REGEXP '^[A-Z]+$';
   ```
3. **Filtrar alumnos con un DNI de exactamente 8 dígitos.**  
   ```sql
   SELECT * FROM alumnos WHERE dni REGEXP '^[0-9]{8}$';
   ```

---

## **Ejercicios de Subconsultas en SQL**  

1. **Obtener el alumno más joven.**  
   ```sql
   SELECT * FROM alumnos WHERE edad = (SELECT MIN(edad) FROM alumnos);
   ```
2. **Encontrar los alumnos mayores de edad inscritos en algún curso.**  
   ```sql
   SELECT * FROM alumnos WHERE edad >= 18 AND id_alumno IN (SELECT id_alumno FROM inscripciones);
   ```
3. **Contar cuántos alumnos tienen más de 25 años.**  
   ```sql
   SELECT COUNT(*) FROM alumnos WHERE edad > 25;
   ```

---

## **Ejercicios de Combinación de Subconsultas y Funciones**  

1. **Obtener la edad promedio de los alumnos inscritos en cursos.**  
   ```sql
   SELECT AVG(edad) FROM alumnos WHERE id_alumno IN (SELECT id_alumno FROM inscripciones);
   ```
2. **Determinar cuántos alumnos argentinos hay en la base de datos.**  
   ```sql
   SELECT COUNT(*) FROM alumnos WHERE nacionalidad = 'Argentina';
   ```
3. **Encontrar la edad mínima y máxima por nacionalidad.**  
   ```sql
   SELECT nacionalidad, MIN(edad) AS menor_edad, MAX(edad) AS mayor_edad
   FROM alumnos GROUP BY nacionalidad;
   ```

---

## **Ejercicios de Data Definition Language (DDL)**  

1. **Crear una tabla `profesores` con las siguientes columnas:**  
   - `id_profesor` (INT, clave primaria, autoincremental)  
   - `nombre` (VARCHAR(50))  
   - `apellido` (VARCHAR(50))  
   - `email` (VARCHAR(100), único)  
   ```sql
   CREATE TABLE profesores (
       id_profesor INT PRIMARY KEY AUTO_INCREMENT,
       nombre VARCHAR(50) NOT NULL,
       apellido VARCHAR(50) NOT NULL,
       email VARCHAR(100) UNIQUE NOT NULL
   );
   ```
2. **Eliminar la tabla `profesores` si existe.**  
   ```sql
   DROP TABLE IF EXISTS profesores;
   ```

---

## **Ejercicios de Manipulación de Objetos**  

1. **Vaciar completamente la tabla `alumnos` sin eliminar su estructura.**  
   ```sql
   TRUNCATE TABLE alumnos;
   ```
2. **Eliminar todos los alumnos menores de 18 años.**  
   ```sql
   DELETE FROM alumnos WHERE edad < 18;
   ```

---

## **Ejercicios de Funciones Escalares**  

1. **Concatenar nombre y apellido en una sola columna llamada `nombre_completo`.**  
   ```sql
   SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo FROM alumnos;
   ```
2. **Convertir todos los nombres a mayúsculas.**  
   ```sql
   SELECT UCASE(nombre) FROM alumnos;
   ```
3. **Obtener la fecha actual.**  
   ```sql
   SELECT NOW();
   ```
4. **Obtener la suma total de edades de los alumnos.**  
   ```sql
   SELECT SUM(edad) FROM alumnos;
   ```
5. **Redondear el promedio de edades a 2 decimales.**  
   ```sql
   SELECT ROUND(AVG(edad), 2) FROM alumnos;
   ```

---

🚀 **¡A practicar y mejorar tus habilidades en SQL!**  

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  