# 📘 100 Ejercicios de MySQL Workbench - Clase 04

Este documento contiene **100 ejercicios** para practicar **bases de datos en MySQL** con conceptos como **Stored Procedures, Funciones, Triggers, Vistas, Claves, Tablas y más**.

---

## 🔹 **1. Creación y Manipulación de Tablas**  

### 📌 **Ejercicios de Tablas y Claves**  

1. Crea una base de datos llamada `empresa`.  
2. Crea una tabla `empleados` con los campos: `id_empleado`, `nombre`, `apellido`, `email`, `fecha_contratacion`, `salario`.  
3. Agrega una **clave primaria** en `id_empleado`.  
4. Crea una tabla `departamentos` con `id_departamento`, `nombre_departamento`.  
5. Agrega una **clave foránea** en `empleados` para relacionarla con `departamentos`.  
6. Inserta 5 registros en `departamentos`.  
7. Inserta 10 registros en `empleados`, asignando departamentos aleatorios.  
8. Modifica el salario de todos los empleados en un 10%.  
9. Elimina a un empleado específico por `id_empleado`.  
10. Borra la tabla `empleados` sin afectar `departamentos`.  

---

## 🔹 **2. Consultas SQL y Uso de Claves**  

### 📌 **Ejercicios de Claves e Índices**  

11. Crea un **índice** en la columna `email` de `empleados` para mejorar la búsqueda.  
12. Crea una **clave candidata** en `email`.  
13. Crea una **clave concatenada** en `id_empleado` y `id_departamento`.  
14. Consulta todos los empleados de un departamento específico.  
15. Cuenta cuántos empleados hay en cada departamento.  
16. Muestra los empleados con salarios superiores a $5000.  
17. Encuentra el salario promedio de todos los empleados.  
18. Busca empleados cuyo apellido comience con "G".  
19. Encuentra el departamento con más empleados.  
20. Muestra los 3 empleados con los salarios más altos.  

---

## 🔹 **3. Vistas en MySQL**  

### 📌 **Ejercicios de Creación y Uso de Vistas**  

21. Crea una vista `vista_empleados` que muestre solo `nombre`, `apellido`, `salario`.  
22. Crea una vista `vista_departamentos` que muestre `id_departamento` y `cantidad de empleados`.  
23. Modifica `vista_empleados` para incluir `fecha_contratacion`.  
24. Usa `vista_empleados` para consultar empleados con salario mayor a $4000.  
25. Crea una vista `vista_altos_salarios` que muestre empleados con salario mayor al promedio.  
26. Borra la vista `vista_altos_salarios`.  
27. Crea una vista `vista_activos` que solo muestre empleados con fecha de contratación dentro del último año.  
28. Usa `vista_activos` para obtener el total de empleados recientes.  
29. Crea una vista con un `JOIN` entre `empleados` y `departamentos`.  
30. Verifica si se pueden modificar los datos a través de la vista anterior.  

---

## 🔹 **4. Stored Procedures (Procedimientos Almacenados)**  

### 📌 **Ejercicios de Procedimientos Almacenados**  

31. Crea un procedimiento `insertar_empleado(nombre, apellido, salario)`.  
32. Crea un procedimiento `aumentar_salario(id_empleado, porcentaje)`.  
33. Crea un procedimiento `eliminar_empleado(id_empleado)`.  
34. Crea un procedimiento `total_empleados_por_departamento(id_departamento)`.  
35. Crea un procedimiento `mostrar_salario_promedio()`.  
36. Llama a `mostrar_salario_promedio()` para ver el resultado.  
37. Crea un procedimiento `empleados_recientes(fecha_inicio, fecha_fin)`.  
38. Usa `empleados_recientes('2024-01-01', '2024-12-31')`.  
39. Modifica `insertar_empleado` para que valide si el salario es mayor a 1000.  
40. Borra el procedimiento `eliminar_empleado()`.  

---

## 🔹 **5. Funciones en MySQL**  

### 📌 **Ejercicios de Creación de Funciones**  

41. Crea una función `calcular_impuesto(salario) RETURNS DECIMAL(10,2)`.  
42. Crea una función `obtener_nombre_completo(id_empleado) RETURNS VARCHAR(255)`.  
43. Usa `obtener_nombre_completo(5)`.  
44. Crea una función `empleado_mas_antiguo()`.  
45. Crea una función `contar_empleados_por_departamento(id_departamento)`.  
46. Usa `contar_empleados_por_departamento(3)`.  
47. Crea una función `bono_anual(salario) RETURNS DECIMAL(10,2)`.  
48. Usa `bono_anual(5000)`.  
49. Crea una función `salario_total(id_empleado)`, que incluya bono e impuestos.  
50. Verifica si una función puede modificar datos en una tabla.  

---

## 🔹 **6. Triggers en MySQL**  

### 📌 **Ejercicios de Creación de Triggers**  

51. Crea un trigger `before_insert_empleado` para validar que el salario sea mayor a 1000.  
52. Crea un trigger `after_insert_empleado` que registre inserciones en una tabla `auditoria`.  
53. Inserta un empleado y verifica la auditoría.  
54. Crea un trigger `before_update_salario` que evite reducciones salariales.  
55. Intenta reducir un salario y observa el error.  
56. Crea un trigger `after_delete_empleado` para guardar registros eliminados en `empleados_eliminados`.  
57. Elimina un empleado y verifica en `empleados_eliminados`.  
58. Crea un trigger `before_insert_departamento` que impida nombres duplicados.  
59. Intenta insertar un departamento duplicado.  
60. Crea un trigger `after_update_departamento` para registrar cambios en nombres de departamentos.  

---

## 🔹 **7. Consultas Avanzadas con JOIN y Subconsultas**  

### 📌 **Ejercicios de Consultas Complejas**  

61. Encuentra el empleado con el salario más alto.  
62. Muestra todos los empleados junto con el nombre de su departamento.  
63. Encuentra los empleados que no tienen un departamento asignado.  
64. Muestra empleados con salarios superiores al promedio.  
65. Encuentra los empleados que se contrataron en el mismo mes.  
66. Muestra empleados cuyo salario es mayor que el promedio de su departamento.  
67. Encuentra los 3 departamentos con más empleados.  
68. Muestra los empleados que tienen el mismo apellido.  
69. Encuentra empleados que no han recibido aumento en 2 años.  
70. Muestra empleados con los mismos nombres pero diferentes apellidos.  

---

## 🔹 **8. Creación de un Diagrama E-R**  

### 📌 **Ejercicios de Modelado de Datos**  

71. Diseña un diagrama E-R con `empleados`, `departamentos` y `proyectos`.  
72. Agrega relaciones entre `empleados` y `proyectos`.  
73. Agrega una tabla intermedia `empleado_proyecto`.  
74. Genera el código SQL desde MySQL Workbench.  
75. Implementa el esquema en MySQL.  

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  

