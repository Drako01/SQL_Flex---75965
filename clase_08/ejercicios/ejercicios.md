# Ejercicios Prácticos de SQL - Unidad Completa

Este documento contiene **50 ejercicios** prácticos para estudiantes principiantes de SQL, organizados por tema y con un enfoque educativo.

---

## 🏠 Contexto: Institución Educativa

Usaremos las siguientes tablas para contextualizar los ejercicios:

```sql
CREATE TABLE Alumnos (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  email VARCHAR(100),
  fecha_nacimiento DATE
);

CREATE TABLE Profesores (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  especialidad VARCHAR(100)
);

CREATE TABLE Cursos (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  profesor_id INT,
  FOREIGN KEY (profesor_id) REFERENCES Profesores(id)
);

CREATE TABLE Inscripciones (
  id INT PRIMARY KEY,
  alumno_id INT,
  curso_id INT,
  fecha_inscripcion DATE,
  FOREIGN KEY (alumno_id) REFERENCES Alumnos(id),
  FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

CREATE TABLE Notas (
  id INT PRIMARY KEY,
  alumno_id INT,
  curso_id INT,
  parcial1 DECIMAL(5,2),
  parcial2 DECIMAL(5,2),
  final DECIMAL(5,2),
  FOREIGN KEY (alumno_id) REFERENCES Alumnos(id),
  FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);
```

---

## ✅ DDL - Definición de Estructura (5 ejercicios)

1. Crear una tabla de asistencias con fecha, alumno y curso.
2. Agregar un campo "activo" a la tabla de cursos.
3. Eliminar el campo "email" de la tabla de profesores.
4. Cambiar el tipo de dato del campo "nombre" en alumnos a VARCHAR(150).
5. Crear una tabla para registrar usuarios del sistema (admin, profesor, alumno).

---

## ✍️ DML - Manipulación de Datos (10 ejercicios)

6. Insertar 5 alumnos en la tabla `Alumnos`.
7. Insertar 3 profesores con diferentes especialidades.
8. Crear 3 cursos y asignar profesores.
9. Inscribir alumnos en cursos.
10. Registrar 2 notas por alumno en cada curso.
11. Actualizar el apellido de un alumno.
12. Borrar una inscripción.
13. Actualizar el profesor de un curso.
14. Insertar una nota faltante.
15. Cambiar la nota final de un alumno a 10.

---

## ⚖️ Funciones Escalares (5 ejercicios)

16. Crear una función que calcule el promedio de un alumno dado curso y notas.
17. Crear una función que calcule el porcentaje de asistencia.
18. Crear una función que devuelva la edad de un alumno según su fecha de nacimiento.
19. Crear una función que devuelva "Aprobado" o "Desaprobado" según promedio.
20. Usar una función en un SELECT para todos los alumnos.

---

## ⚙️ Stored Procedures (5 ejercicios)

21. Crear un procedimiento para registrar una nueva nota.
22. Crear un procedimiento para inscribir un alumno a un curso.
23. Crear un procedimiento para cambiar el profesor de un curso.
24. Crear un procedimiento para borrar todas las inscripciones de un alumno.
25. Crear un procedimiento para mostrar el resumen de notas de un alumno.

---

## 🗓 Joins (INNER, LEFT, RIGHT) (5 ejercicios)

26. Mostrar los nombres de los alumnos y los cursos en los que están inscritos (INNER JOIN).
27. Mostrar todos los cursos, aunque no tengan inscriptos (LEFT JOIN).
28. Mostrar todos los alumnos y sus notas (aunque no tengan notas).
29. Mostrar profesores y los cursos que dictan.
30. Mostrar alumnos junto a sus profesores, usando joins entre 3 tablas.

---

## 🎓 Subconsultas (5 ejercicios)

31. Mostrar alumnos con promedio mayor al promedio general.
32. Mostrar el alumno con la nota más alta en un curso.
33. Mostrar cursos que no tengan inscriptos.
34. Mostrar alumnos que están inscritos en más de un curso.
35. Mostrar profesores que dictan más de un curso.

---

## ⚠️ Triggers (5 ejercicios)

36. Crear un trigger que registre en una tabla de logs cuando se inserta una nueva inscripción.
37. Crear un trigger que evite que se borre un alumno si tiene inscripciones.
38. Crear un trigger que actualice un campo "ultimo\_cambio" en notas.
39. Crear un trigger que bloquee notas mayores a 10.
40. Crear un trigger que envíe un mensaje (PRINT) al modificar datos en cursos.

---

## ✏️ Ejercicios de Repaso General (10 ejercicios)

41. Mostrar el promedio general de todos los alumnos.
42. Mostrar cuántos alumnos tiene cada curso.
43. Listar los cursos con más de 3 inscriptos.
44. Mostrar los 5 alumnos con mejor promedio.
45. Listar los alumnos ordenados por edad descendente.
46. Mostrar alumnos que nunca fueron inscriptos.
47. Mostrar el promedio de notas por curso.
48. Mostrar los profesores que no dictan ningún curso.
49. Listar alumnos y cantidad total de cursos que están cursando.
50. Crear una vista que muestre: alumno, curso, nombre del profesor y promedio.

---

## 🔗 Recursos sugeridos

* [SQL Fiddle](https://sqlfiddle.com/) para probar tus consultas.
* [DB Fiddle](https://www.db-fiddle.com/) para trabajar con MySQL o PostgreSQL.
* [W3Schools SQL](https://www.w3schools.com/sql/)

---

## 📚 Recomendaciones

* Siempre respeta las claves foráneas.
* Proba cada instrucción paso a paso.
* Usa `SELECT *` para verificar los cambios.
* Comentá tu código para entenderlo más adelante.

---

¡A programar! 🚀

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
