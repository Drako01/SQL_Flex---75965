# Guía de Ejercicios: Triggers y DCL en MySQL

## Parte 1: Triggers

### Ejercicio 1

Cree una tabla llamada `log_estudiantes` para registrar inserciones en la tabla `estudiantes`.

* Campos: `id_log`, `id_estudiante`, `accion`, `fecha_accion`
* Cree un trigger `AFTER INSERT` que registre en `log_estudiantes` cada vez que se inserta un nuevo estudiante.

---

### Ejercicio 2

Cree un trigger `BEFORE DELETE` sobre la tabla `inscripciones` que impida eliminar registros si la fecha de inscripción es anterior al día actual.

---

### Ejercicio 3

Implemente un trigger `BEFORE UPDATE` en la tabla `cursos` que registre los cambios de nombre del curso en una tabla `historial_cambios_curso` con los siguientes campos:

* `id_curso`, `nombre_anterior`, `nombre_nuevo`, `fecha_cambio`

---

### Ejercicio 4

Cree un trigger que se dispare `AFTER DELETE` en la tabla `estudiantes` y registre el evento en una tabla de auditoría llamada `auditoria_estudiantes`.

---

## Parte 2: DCL

### Ejercicio 5

Cree un nuevo usuario `profesor@localhost` con contraseña `educacion123`.

---

### Ejercicio 6

Asigne al usuario `profesor` los siguientes permisos sobre la base de datos `institucion`:

* Permisos de `SELECT` e `INSERT` sobre la tabla `inscripciones`

---

### Ejercicio 7

Cree un usuario `auditor@localhost` con permisos sólo de lectura (`SELECT`) sobre todas las tablas de la base de datos `institucion`.

---

### Ejercicio 8

Revoque del usuario `profesor` el permiso de insertar en la tabla `cursos`.

---

### Ejercicio 9

Utilizando MySQL Workbench, revise los permisos actuales del usuario `profesor` y documente lo que observa.

---

### Ejercicio 10

Elimine el usuario `auditor` de la base de datos.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
