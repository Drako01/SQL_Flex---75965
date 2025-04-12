# 🧱 DDL (Data Definition Language) – Crear estructuras (1–20)

1. Crear una base de datos llamada `UniversidadDB`.
2. Crear una tabla `Estudiantes` con `id`, `nombre`, `apellido`, `email`, `fecha_nacimiento`.
3. Crear una tabla `Materias` con `id`, `nombre`, `anio`, `cuatrimestre`.
4. Crear una tabla `Inscripciones` con `id`, `id_estudiante`, `id_materia`, `fecha`.
5. Agregar una columna `telefono` a la tabla `Estudiantes`.
6. Crear una tabla `Profesores` con `id`, `nombre`, `apellido`, `especialidad`.
7. Crear una tabla `Cursos` con `id`, `nombre`, `profesor_id`, `anio`.
8. Establecer una relación de clave foránea entre `Cursos.profesor_id` y `Profesores.id`.
9. Crear un índice en la tabla `Estudiantes` para `email`.
10. Eliminar la columna `telefono` de `Estudiantes`.
11. Crear una tabla `Departamentos` con `id`, `nombre`, `presupuesto`.
12. Agregar una clave foránea entre `Profesores` y `Departamentos`.
13. Crear una tabla intermedia `Curso_Estudiante` para registrar qué estudiantes asisten a qué cursos.
14. Establecer una restricción para que el `email` de estudiantes sea único.
15. Modificar la columna `nombre` en `Estudiantes` para que acepte hasta 100 caracteres.
16. Crear una tabla `Notas` con `id`, `id_estudiante`, `id_materia`, `nota`, `fecha`.
17. Crear una vista que muestre nombre completo de estudiante + materias que cursa.
18. Crear una tabla `Administrativos` con sus propios campos y relación con `Departamentos`.
19. Crear una función almacenada para


