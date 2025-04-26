# Ejercicios de Importación, Exportación e Integridad Referencial en MySQL

## 👉 Importación y Exportación de Datos

1. Exportar una base de datos completa a un archivo `.sql` usando Workbench.
2. Exportar solo una tabla específica a un archivo `.sql`.
3. Importar un archivo `.sql` a una nueva base de datos vacía.
4. Importar un archivo `.sql` en una base de datos existente.
5. Exportar datos de una tabla a un archivo CSV usando Workbench.
6. Importar datos desde un archivo CSV en una tabla vacía.
7. Corregir errores comunes al importar CSV (ej: delimitadores incorrectos).
8. Exportar datos de una consulta (resultado) a CSV.
9. Exportar datos de una tabla a un archivo JSON manualmente.
10. Crear un archivo JSON de datos y simular su carga en MySQL (parsearlo).

## 👉 Trabajo con Archivos CSV y JSON

11. Crear un archivo CSV de productos (id, nombre, precio) y cargarlo en MySQL.
12. Crear un archivo JSON de clientes (id, nombre, email) para usar en simulaciones.
13. Convertir un archivo Excel a CSV para importarlo en MySQL.
14. Corregir un CSV que tenga encabezados incorrectos antes de importar.
15. Importar un CSV que tiene valores NULL representados como `""` (vacío).
16. Crear un CSV de alumnos con errores (campos mezclados) y corregirlo antes de importar.
17. Generar un archivo CSV desde datos exportados de MySQL.
18. Generar un archivo JSON desde datos exportados de MySQL.
19. Crear y cargar una planilla de pagos de sueldos en CSV en una tabla MySQL.
20. Crear y cargar una planilla de asistencia de alumnos en CSV en una tabla MySQL.

## 👉 Integridad Referencial

21. Crear dos tablas relacionadas: autores y libros.
22. Insertar autores y luego libros asociados correctamente.
23. Intentar insertar un libro sin autor válido (ver error de integridad referencial).
24. Crear tablas con claves foráneas correctamente declaradas.
25. Romper intencionalmente una relación para analizar el error.
26. Eliminar un autor y ver qué pasa con sus libros (sin CASCADE).
27. Actualizar el ID de un autor y ver qué pasa en la tabla libros (sin CASCADE).

## 👉 Delete Cascade

28. Crear tablas `categorias` y `productos` con ON DELETE CASCADE.
29. Insertar varias categorías y productos asociados.
30. Borrar una categoría y verificar que los productos se borran automáticamente.
31. Crear tablas `departamentos` y `empleados` con ON DELETE CASCADE.
32. Insertar departamentos y empleados.
33. Eliminar un departamento y observar el comportamiento en empleados.
34. Crear una restricción de clave foránea con CASCADE manualmente en una tabla ya existente.
35. Revertir un cambio: eliminar la restricción CASCADE.

## 👉 Update Cascade

36. Crear tablas `clientes` y `facturas` con ON UPDATE CASCADE.
37. Insertar clientes y facturas.
38. Actualizar el ID de un cliente y verificar el cambio automático en facturas.
39. Modificar una tabla existente para agregar ON UPDATE CASCADE a una clave foránea.
40. Realizar una prueba de actualización en cascada en un sistema de órdenes y usuarios.

## 👉 Ejercicios Combinados

41. Exportar una base de datos con tablas relacionadas.
42. Importar esa base en otra PC o servidor.
43. Crear una base nueva y restaurar un backup.
44. Crear CSVs de "inscriptos", "cursos" y "inscripciones" e importarlos.
45. Crear una tabla `inscripciones` que relacione alumnos y cursos.
46. Borrar un alumno y verificar que se borran sus inscripciones (DELETE CASCADE).
47. Actualizar el ID de un curso y verificar que se actualicen las inscripciones (UPDATE CASCADE).
48. Crear una planilla en CSV con datos erróneos, detectar y corregir antes de importar.
49. Diseñar una base de datos pequeña que use integridad referencial y realizar pruebas de CASCADE.
50. Hacer backup de una base de datos y restaurarla en un ambiente nuevo desde consola.

---

# 📚 Recomendación Final

- Realizar los ejercicios primero en Workbench para familiarizarse.
- Luego repetir en consola para reforzar el manejo básico de terminal.
- Siempre validar los datos importados con `SELECT * FROM tabla;` luego de la carga.
- Usar `SHOW CREATE TABLE tabla;` para confirmar las restricciones y cascadas.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
