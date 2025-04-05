
# 📘 Ejemplos de Vistas en SQL

A continuación te muestro varios ejemplos prácticos de cómo crear vistas en SQL usando un sistema de cursos con tablas como `alumnos`, `cursos` e `inscripciones`.

---

## 1. 🧾 Vista básica de Alumnos

Muestra los datos más importantes de cada alumno.

```sql
CREATE VIEW vista_alumnos_basico AS
SELECT 
    id_alumno, 
    nombre, 
    apellido, 
    email 
FROM alumnos;
```

---

## 2. 👨‍🎓 Vista Alumnos + Cursos

Relaciona cada alumno con el curso en el que está inscripto.

```sql
CREATE VIEW vista_alumnos_cursos AS
SELECT 
    a.id_alumno,
    CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    c.nombre_curso
FROM inscripciones i
JOIN alumnos a ON i.id_alumno = a.id_alumno
JOIN cursos c ON i.id_curso = c.id_curso;
```

---

## 3. 🎯 Vista con Filtro - Curso "SQL Avanzado"

Muestra solo los alumnos inscriptos al curso "SQL Avanzado".

```sql
CREATE VIEW vista_inscriptos_sql AS
SELECT 
    a.nombre, 
    a.apellido,
    c.nombre_curso
FROM inscripciones i
JOIN alumnos a ON i.id_alumno = a.id_alumno
JOIN cursos c ON i.id_curso = c.id_curso
WHERE c.nombre_curso = 'SQL Avanzado';
```

---

## 4. 📊 Vista con Agregado - Cantidad de inscriptos por curso

Cuenta cuántos alumnos hay por curso.

```sql
CREATE VIEW vista_cantidad_inscripciones AS
SELECT 
    c.id_curso,
    c.nombre_curso,
    COUNT(i.id_alumno) AS cantidad_inscriptos
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.id_curso, c.nombre_curso;
```

---

## 5. 🕒 Vista de Inscripciones recientes (últimos 7 días)

Muestra las inscripciones que ocurrieron en la última semana.

```sql
CREATE VIEW vista_inscripciones_recientes AS
SELECT 
    a.nombre,
    a.apellido,
    c.nombre_curso,
    i.inscription_at
FROM inscripciones i
JOIN alumnos a ON i.id_alumno = a.id_alumno
JOIN cursos c ON i.id_curso = c.id_curso
WHERE i.inscription_at >= CURDATE() - INTERVAL 7 DAY;
```

---

## 6. 📑 Vista de Detalle completo (ordenado por fecha)

Incluye todos los datos relevantes de la inscripción, ordenados por fecha.

```sql
CREATE VIEW vista_detalle_inscripciones AS
SELECT 
    i.id_inscripcion,
    a.nombre,
    a.apellido,
    a.email,
    c.nombre_curso,
    c.duracion,
    i.inscription_at
FROM inscripciones i
JOIN alumnos a ON i.id_alumno = a.id_alumno
JOIN cursos c ON i.id_curso = c.id_curso
ORDER BY i.inscription_at DESC;
```

---

## 7. 🕵️ Vista anonimizada (sin mostrar email)

Muestra solo el nombre inicial y apellido, ocultando el email.

```sql
CREATE VIEW vista_anonima_alumnos AS
SELECT 
    id_alumno,
    CONCAT(SUBSTRING(nombre,1,1), '. ', apellido) AS nombre_visible
FROM alumnos;
```

---

## 8. 🎓 Vista de alumnos en más de un curso

Muestra alumnos que están inscriptos en **más de un curso**.

```sql
CREATE VIEW vista_alumnos_multicurso AS
SELECT 
    a.id_alumno,
    CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    COUNT(i.id_curso) AS cantidad_cursos
FROM alumnos a
JOIN inscripciones i ON a.id_alumno = i.id_alumno
GROUP BY a.id_alumno
HAVING cantidad_cursos > 1;
```

---

## ♻️ Reemplazar una vista con `OR REPLACE`

Permite actualizar el contenido de una vista sin eliminarla previamente.

```sql
CREATE OR REPLACE VIEW vista_alumnos_basico AS
SELECT 
    id_alumno, 
    nombre, 
    apellido, 
    email 
FROM alumnos;
```

---

## ❌ Eliminar una vista

```sql
DROP VIEW vista_alumnos_cursos;
```

---

✅ **TIP**: Las vistas se pueden usar como tablas normales. Por ejemplo:

```sql
SELECT * FROM vista_cantidad_inscripciones;
```

---


## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
