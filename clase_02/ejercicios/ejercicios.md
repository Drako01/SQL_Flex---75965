
# 📝 Ejercicios de SQL - Clase 2

## **📌 1️⃣ Sentencia `SELECT`**
1. Seleccionar todos los registros de la tabla `alumnos`.  
   ```sql
   SELECT * FROM alumnos;
   ```
2. Seleccionar solo los nombres y apellidos de la tabla `alumnos`.  
3. Seleccionar los alumnos que sean de Argentina.  
4. Seleccionar los alumnos que tengan un `email` registrado (no `NULL`).  
5. Seleccionar los alumnos mayores de 18 años.  

## **📌 2️⃣ Uso de `WHERE` y Operadores**
6. Seleccionar los alumnos cuyo nombre comience con "J".  
7. Seleccionar los alumnos cuyo `dni` sea mayor a 30.000.000.  
8. Seleccionar los alumnos que no tengan `telefono` registrado.  
9. Seleccionar los alumnos que sean de Argentina o Uruguay.  
10. Seleccionar los alumnos que no sean de Argentina ni de Uruguay.  

## **📌 3️⃣ Uso de `ORDER BY` y `LIMIT`**
11. Seleccionar los alumnos y ordenarlos por apellido en orden ascendente.  
12. Seleccionar los alumnos y ordenarlos por `dni` en orden descendente.  
13. Seleccionar los 5 primeros alumnos registrados en la tabla.  
14. Seleccionar el alumno con el `dni` más alto.  
15. Seleccionar los últimos 3 alumnos registrados.  

## **📌 4️⃣ Uso de `INSERT`**
16. Insertar un nuevo alumno en la tabla `alumnos`.  
   ```sql
   INSERT INTO alumnos (nombre, apellido, email, dni, telefono, nacionalidad)
   VALUES ('Carlos', 'López', 'carlos.lopez@gmail.com', 37845612, '1122334455', 'Chile');
   ```
17. Insertar dos alumnos nuevos en la misma consulta.  
18. Insertar un alumno sin especificar `telefono`.  
19. Insertar un alumno sin especificar `email`.  
20. Insertar un alumno con `nacionalidad` diferente a Argentina.  

## **📌 5️⃣ Uso de `UPDATE`**
21. Cambiar el `email` de un alumno con `id_alumno = 2`.  
22. Modificar la `nacionalidad` de todos los alumnos de Chile a Perú.  
23. Cambiar el `telefono` de un alumno específico.  
24. Modificar el `apellido` de un alumno cuyo nombre sea "María".  
25. Aumentar en 1 el `dni` de todos los alumnos que sean de Argentina.  

## **📌 6️⃣ Uso de `DELETE`**
26. Eliminar un alumno cuyo `id_alumno = 5`.  
27. Eliminar todos los alumnos de Uruguay.  
28. Eliminar a los alumnos que no tengan `email` registrado.  
29. Eliminar todos los alumnos cuyo `telefono` sea `NULL`.  
30. Eliminar un alumno con `dni` menor a 30.000.000.  

## **📌 7️⃣ Funciones de Agregación (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)**
31. Contar cuántos alumnos hay en la tabla.  
32. Contar cuántos alumnos tienen `telefono` registrado.  
33. Obtener el `dni` más alto registrado en la tabla.  
34. Obtener el `dni` más bajo registrado en la tabla.  
35. Obtener la cantidad de alumnos por cada `nacionalidad`.  

## **📌 8️⃣ Uso de `GROUP BY` y `HAVING`**
36. Obtener el número de alumnos por nacionalidad.  
37. Contar cuántos alumnos tienen el mismo `apellido`.  
38. Obtener la cantidad de alumnos con `email` registrado y agrupar por nacionalidad.  
39. Seleccionar nacionalidades con más de 2 alumnos registrados.  
40. Obtener el promedio de `dni` de los alumnos por nacionalidad.  

## **📌 9️⃣ Uso de `JOIN`**
41. Seleccionar todos los pedidos y los nombres de los alumnos que los hicieron.  
   ```sql
   SELECT alumnos.nombre, pedidos.producto 
   FROM alumnos 
   INNER JOIN pedidos ON alumnos.id_alumno = pedidos.id_alumno;
   ```
42. Hacer un `LEFT JOIN` entre `alumnos` y `pedidos`.  
43. Hacer un `RIGHT JOIN` entre `alumnos` y `pedidos`.  
44. Seleccionar solo los alumnos que no han hecho pedidos (`LEFT JOIN` con `NULL`).  
45. Contar cuántos pedidos ha hecho cada alumno.  

## **📌 🔟 Uso de `UNION` y `INTERSECT`**
46. Unir los resultados de `alumnos` y `profesores` en una sola consulta.  
47. Obtener los `email` que aparecen tanto en `alumnos` como en `profesores`.  
48. Obtener los `dni` que aparecen en ambas tablas.  
49. Unir los alumnos de Argentina y Uruguay en una misma consulta.  
50. Seleccionar solo los alumnos que han hecho pedidos y unirlo con una lista de profesores que también han hecho pedidos.  

---

📌 **¡Practiquen estos ejercicios para fortalecer sus conocimientos en SQL! 🚀**  


---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  

