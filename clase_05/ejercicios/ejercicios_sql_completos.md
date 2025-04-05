
# 🧠 Ejercicios Prácticos de SQL


---

## 📌 PARTE 1: Consultas Básicas

### 1. Mostrar todos los alumnos

```sql
SELECT * FROM alumnos;
```

### 2. Listar todos los cursos ordenados por duración descendente

```sql
SELECT * FROM cursos
ORDER BY duracion DESC;
```

### 3. Buscar alumnos cuyo nombre comience con "A"

```sql
SELECT * FROM alumnos
WHERE nombre LIKE 'A%';
```

### 4. Mostrar los 5 cursos más largos

```sql
SELECT * FROM cursos
ORDER BY duracion DESC
LIMIT 5;
```

### 5. Obtener los emails de los alumnos únicos

```sql
SELECT DISTINCT email FROM alumnos;
```

---

## 📌 PARTE 2: Funciones de Agregado y Agrupaciones

### 6. Cantidad total de alumnos

```sql
SELECT COUNT(*) AS total_alumnos FROM alumnos;
```

### 7. Duración promedio de los cursos

```sql
SELECT AVG(duracion) AS promedio_duracion FROM cursos;
```

### 8. Cantidad de inscriptos por curso

```sql
SELECT id_curso, COUNT(id_alumno) AS cantidad
FROM inscripciones
GROUP BY id_curso;
```

---

## 📌 PARTE 3: Joins y Relaciones

### 9. Obtener el nombre del alumno y el nombre del curso en el que está inscripto

```sql
SELECT a.nombre, a.apellido, c.nombre_curso
FROM inscripciones i
JOIN alumnos a ON i.id_alumno = a.id_alumno
JOIN cursos c ON i.id_curso = c.id_curso;
```

### 10. Alumnos sin inscripción

```sql
SELECT a.*
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
WHERE i.id_alumno IS NULL;
```

---

## 📌 PARTE 4: Subconsultas

### 11. Mostrar los cursos con más inscriptos que el promedio

```sql
SELECT id_curso, COUNT(*) AS total
FROM inscripciones
GROUP BY id_curso
HAVING total > (SELECT AVG(cantidad)
                 FROM (SELECT COUNT(*) AS cantidad
                       FROM inscripciones
                       GROUP BY id_curso) subquery);
```

---

## 📌 PARTE 5: Vistas

### 12. Crear una vista con alumnos y su curso

```sql
CREATE VIEW vista_alumnos_cursos AS
SELECT a.nombre, a.apellido, c.nombre_curso
FROM inscripciones i
JOIN alumnos a ON i.id_alumno = a.id_alumno
JOIN cursos c ON i.id_curso = c.id_curso;
```

### 13. Vista de alumnos inscriptos en más de un curso

```sql
CREATE VIEW vista_multicurso AS
SELECT id_alumno, COUNT(*) AS cantidad
FROM inscripciones
GROUP BY id_alumno
HAVING cantidad > 1;
```

---

## 📌 PARTE 6: Stored Procedures

### 14. Procedimiento para contar inscripciones por día

```sql
DELIMITER //

CREATE PROCEDURE ObtenerInscripcionesPorDia()
BEGIN
  SELECT DATE(inscription_at) AS fecha, COUNT(*) AS cantidad
  FROM inscripciones
  GROUP BY fecha;
END //

DELIMITER ;

CALL ObtenerInscripcionesPorDia();
```

---

## 📌 PARTE 7: Triggers

### 15. Trigger para evitar inscripciones duplicadas

```sql
DELIMITER //

CREATE TRIGGER before_inscription_insert
BEFORE INSERT ON inscripciones
FOR EACH ROW
BEGIN
  DECLARE existe INT;
  SELECT COUNT(*) INTO existe
  FROM inscripciones
  WHERE id_alumno = NEW.id_alumno AND id_curso = NEW.id_curso;

  IF existe > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El Alumno ya está inscripto en este curso';
  END IF;
END //

DELIMITER ;
```

### 16. Trigger para actualizar contador de inscripciones

```sql
DELIMITER //

CREATE TRIGGER after_inscription_insert
AFTER INSERT ON inscripciones
FOR EACH ROW
BEGIN
  DECLARE curso_count INT;

  SELECT cantidad_inscripciones INTO curso_count
  FROM cursos_inscripciones_count
  WHERE id_curso = NEW.id_curso;

  IF curso_count IS NULL THEN
    INSERT INTO cursos_inscripciones_count (id_curso, cantidad_inscripciones)
    VALUES (NEW.id_curso, 1);
  ELSE
    UPDATE cursos_inscripciones_count
    SET cantidad_inscripciones = cantidad_inscripciones + 1
    WHERE id_curso = NEW.id_curso;
  END IF;
END //

DELIMITER ;
```

---



## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
