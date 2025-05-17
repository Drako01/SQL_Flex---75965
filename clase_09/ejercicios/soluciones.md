# Soluciones: Triggers y DCL en MySQL

## Parte 1: Triggers

### Ejercicio 1

```sql
CREATE TABLE log_estudiantes (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    accion VARCHAR(20),
    fecha_accion DATETIME
);

DELIMITER //
CREATE TRIGGER after_insert_estudiante
AFTER INSERT ON estudiantes
FOR EACH ROW
BEGIN
    INSERT INTO log_estudiantes (id_estudiante, accion, fecha_accion)
    VALUES (NEW.id_estudiante, 'INSERT', NOW());
END;//
DELIMITER ;
```

### Ejercicio 2

```sql
DELIMITER //
CREATE TRIGGER before_delete_inscripcion
BEFORE DELETE ON inscripciones
FOR EACH ROW
BEGIN
    IF OLD.fecha_inscripcion < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar una inscripción anterior a hoy';
    END IF;
END;//
DELIMITER ;
```

### Ejercicio 3

```sql
CREATE TABLE historial_cambios_curso (
    id_curso INT,
    nombre_anterior VARCHAR(100),
    nombre_nuevo VARCHAR(100),
    fecha_cambio DATETIME
);

DELIMITER //
CREATE TRIGGER before_update_nombre_curso
BEFORE UPDATE ON cursos
FOR EACH ROW
BEGIN
    IF OLD.nombre_curso <> NEW.nombre_curso THEN
        INSERT INTO historial_cambios_curso (id_curso, nombre_anterior, nombre_nuevo, fecha_cambio)
        VALUES (OLD.id_curso, OLD.nombre_curso, NEW.nombre_curso, NOW());
    END IF;
END;//
DELIMITER ;
```

### Ejercicio 4

```sql
CREATE TABLE auditoria_estudiantes (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    accion VARCHAR(10),
    fecha_accion DATETIME
);

DELIMITER //
CREATE TRIGGER after_delete_estudiante
AFTER DELETE ON estudiantes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_estudiantes (id_estudiante, accion, fecha_accion)
    VALUES (OLD.id_estudiante, 'DELETE', NOW());
END;//
DELIMITER ;
```

## Parte 2: DCL

### Ejercicio 5

```sql
CREATE USER 'profesor'@'localhost' IDENTIFIED BY 'educacion123';
```

### Ejercicio 6

```sql
GRANT SELECT, INSERT ON institucion.inscripciones TO 'profesor'@'localhost';
```

### Ejercicio 7

```sql
CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'auditorpass';
GRANT SELECT ON institucion.* TO 'auditor'@'localhost';
```

### Ejercicio 8

```sql
REVOKE INSERT ON institucion.cursos FROM 'profesor'@'localhost';
```

### Ejercicio 9

```sql
SHOW GRANTS FOR 'profesor'@'localhost';
```

Esto mostrará una lista de los privilegios asignados al usuario `profesor`.

### Ejercicio 10

```sql
DROP USER 'auditor'@'localhost';
```

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
