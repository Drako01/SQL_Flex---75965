# Ejercicios de DDL y Subconsultas:


- **DDL (Data Definition Language)**: `CREATE`, `ALTER`, `DROP`, etc.
- **DML (Data Manipulation Language)**: `INSERT`, `UPDATE`, `DELETE`, `SELECT`
- **Subconsultas**
- **Inserciones parciales**
- **Errores comunes al eliminar registros (por restricciones de integridad referencial)**

Voy a dividirlos en secciones temáticas para que estén organizados:

---

### 🏗️ **SECCIÓN 1: DDL - Crear estructuras (20 ejercicios)**

1. Crear una tabla `usuarios` con `id`, `nombre`, `email`, `fecha_nacimiento`.
2. Crear una tabla `productos` con `id`, `nombre`, `precio`, `stock`.
3. Crear una tabla `pedidos` con `id`, `usuario_id`, `fecha`.
4. Crear una tabla `detalle_pedidos` con `id`, `pedido_id`, `producto_id`, `cantidad`, `precio_unitario`.
5. Crear una tabla `categorias` y relacionarla con `productos`.
6. Agregar una columna `telefono` a `usuarios`.
7. Modificar el tipo de dato de `precio` en `productos` a `DECIMAL(10,2)`.
8. Agregar una restricción `UNIQUE` sobre `email` en `usuarios`.
9. Crear una clave foránea en `pedidos` hacia `usuarios`.
10. Crear una clave foránea en `detalle_pedidos` hacia `productos`.
11. Crear una clave foránea en `detalle_pedidos` hacia `pedidos`.
12. Crear una tabla `comentarios` con relación a `usuarios` y `productos`.
13. Crear una tabla intermedia `usuarios_roles` para una relación N:N entre `usuarios` y `roles`.
14. Eliminar la columna `telefono` de `usuarios`.
15. Eliminar la tabla `comentarios`.
16. Crear una tabla `direcciones` con una restricción `CHECK` para que el país sea “AR” o “UY”.
17. Usar `AUTO_INCREMENT` en una tabla `envios`.
18. Crear una vista `vista_usuarios_activos`.
19. Crear un índice en `productos(nombre)`.
20. Crear una tabla `logs` con una columna `timestamp` por defecto.

---

### 📝 **SECCIÓN 2: DML - Manipular datos (25 ejercicios)**

21. Insertar 3 usuarios.
22. Insertar 5 productos con diferentes precios.
23. Insertar parcialmente un usuario (solo nombre y email).
24. Insertar parcialmente un producto (nombre y stock).
25. Insertar un pedido con su detalle.
26. Actualizar el precio de todos los productos aumentando un 10%.
27. Cambiar el email de un usuario específico.
28. Eliminar un producto por ID.
29. Eliminar un usuario que tiene pedidos (¡provoca error!).
30. Insertar un producto con `NULL` en precio (probar si está permitido).
31. Insertar un detalle de pedido con cantidad `0` (con `CHECK` activado).
32. Insertar varios usuarios con `INSERT INTO ... VALUES (...), (...), (...);`
33. Insertar una dirección para un usuario existente.
34. Actualizar todos los usuarios nacidos antes del 2000.
35. Incrementar el stock de un producto en 20 unidades.
36. Eliminar todos los pedidos anteriores a una fecha.
37. Insertar un comentario sobre un producto.
38. Insertar un log con la fecha actual por defecto.
39. Eliminar un producto que tiene detalles de pedido (¡provoca error!).
40. Insertar una fila con clave foránea que no existe (¡provoca error!).
41. Insertar datos con funciones como `NOW()`, `UUID()`.
42. Copiar todos los productos caros a una tabla `productos_premium`.
43. Insertar un producto sin nombre (¡provoca error! si es `NOT NULL`).
44. Insertar un usuario con un email duplicado (¡provoca error!).
45. Actualizar el `stock` de un producto basado en una subconsulta de ventas.

---

### 🔎 **SECCIÓN 3: SELECT y Subconsultas (25 ejercicios)**

46. Listar todos los usuarios.
47. Listar productos cuyo precio es mayor al promedio.
48. Listar usuarios que han hecho pedidos.
49. Listar productos con menos de 10 en stock.
50. Obtener los 3 productos más caros.
51. Obtener el total de pedidos por usuario.
52. Obtener el total facturado por pedido.
53. Obtener la suma total facturada por usuario.
54. Listar los productos de un pedido usando JOIN.
55. Listar pedidos con sus usuarios y totales.
56. Usar subconsulta correlacionada para obtener el último pedido de cada usuario.
57. Listar usuarios que no han hecho pedidos.
58. Mostrar productos que nunca se han vendido.
59. Obtener la media de precio por categoría.
60. Listar los productos que están en más de 1 pedido.
61. Mostrar la fecha del primer pedido.
62. Mostrar la cantidad total de ventas por producto.
63. Mostrar el producto más vendido.
64. Mostrar los 5 usuarios con más compras.
65. Listar productos con stock mayor al promedio.
66. Listar todos los pedidos hechos en los últimos 30 días.
67. Obtener los pedidos con más de 3 productos.
68. Obtener usuarios que hayan comprado productos de la categoría "Electrónica".
69. Subconsulta para traer usuarios con más de 2 pedidos.
70. Subconsulta para traer productos que tienen precio igual al más caro.

---

### 🧩 **SECCIÓN 4: Subconsultas en `INSERT`, `UPDATE`, `DELETE` (15 ejercicios)**

71. Insertar en `logs` todos los usuarios con pedidos.
72. Actualizar `stock` de productos restando lo vendido (usando subconsulta).
73. Eliminar productos que nunca se han vendido (subconsulta `NOT IN`).
74. Insertar en `productos_backup` todos los productos caros (subconsulta).
75. Insertar en `clientes_vip` los usuarios con más de 5 pedidos.
76. Eliminar usuarios sin pedidos (subconsulta).
77. Actualizar a “descontinuado” los productos sin ventas recientes.
78. Insertar en `usuarios_mayores` todos los usuarios mayores de 30 años.
79. Insertar con `SELECT` productos con stock > 100.
80. Eliminar direcciones sin usuarios asociados.
81. Insertar en `comentarios_backup` los comentarios de productos eliminados.
82. Actualizar emails de prueba con dominio “@test.com”.
83. Eliminar pedidos sin detalles (usando `NOT EXISTS`).
84. Insertar en `usuarios_sin_telefono` aquellos con `telefono IS NULL`.
85. Insertar en `envios` todos los pedidos con fecha de hoy.

---

### 🧨 **SECCIÓN 5: Errores comunes y manejo (15 ejercicios)**

86. Eliminar un usuario con pedidos (viola FK).
87. Insertar un pedido con `usuario_id` inexistente (viola FK).
88. Insertar producto sin nombre (`NOT NULL`).
89. Insertar usuario con email duplicado (`UNIQUE`).
90. Eliminar producto con detalles en `detalle_pedidos` (viola FK).
91. Insertar detalle de pedido con cantidad negativa (viola `CHECK`).
92. Eliminar un pedido sin detalles (debería funcionar).
93. Insertar pedido con `NULL` en `fecha` (si no es `NOT NULL`, pasa).
94. Eliminar `categoria` que tiene productos asociados (viola FK).
95. Insertar dirección con país inválido (viola `CHECK`).
96. Eliminar `usuario` con comentarios (viola FK).
97. Eliminar `producto` que aparece en `comentarios`.
98. Eliminar todos los datos de una tabla sin `DELETE CASCADE`.
99. Crear tabla con tipo de dato inválido (`VARCHAR(-5)`).
100. Insertar `fecha_nacimiento` con formato incorrecto (`"31-02-2024"`).


---


## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
