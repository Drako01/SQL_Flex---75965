
# 📚 SQL DML + Subconsultas (MySQL) — Clase de 2 horas

> **Objetivo:** que el alumno maneje **INSERT, UPDATE, DELETE** (DML) y sepa aplicar **subconsultas** dentro de DML (INSERT/UPDATE/DELETE), con criterio y sin romper la base. Cero humo, 100% práctico.

---

## ⏱️ Agenda sugerida (2 hs)

1. **(10')** Set up rápido + repaso de tablas
2. **(25')** DML básico: `INSERT`, `UPDATE`, `DELETE` (todas las variantes útiles)
3. **(35')** Subconsultas en DML: `INSERT ... SELECT`, `UPDATE ... WHERE/SET (subquery)`, `DELETE ... WHERE (subquery)`
4. **(20')** Transacciones + restricciones + “anti-multas” (FK, UNIQUE, IGNORE, upsert)
5. **(20')** Ejercicios guiados
6. **(10')** Desafíos + Q&A

---

## 🧱 Setup (usar tal cual)

> MySQL 8.x. Copiar/pegar en tu cliente y ejecutar por bloques.  
> **Nota**: si ya existe, borra la DB para un arranque limpio (opcional).

```sql
DROP DATABASE IF EXISTS coderhouse;
CREATE DATABASE IF NOT EXISTS coderhouse;
USE coderhouse;

CREATE TABLE IF NOT EXISTS alumnos(
    id_alumno INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    edad INT UNSIGNED DEFAULT NULL,
    telefono VARCHAR(20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR(30) DEFAULT 'Argentina'
);

CREATE TABLE IF NOT EXISTS categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS cursos(
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(50) NOT NULL,
    id_categoria INT,
    CONSTRAINT fk_curso_categoria
        FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

CREATE TABLE IF NOT EXISTS inscripciones (
    idx_alumno INT,
    idx_curso INT,
    inscription_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idx_alumno, idx_curso),
    FOREIGN KEY (idx_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (idx_curso) REFERENCES cursos(id_curso)
);
```

### 📦 Datos de ejemplo (semilla)

```sql
-- Categorías
INSERT INTO categoria (nombre_categoria) VALUES
('Programación'), ('Datos'), ('Cloud'), ('UX');

-- Cursos
INSERT INTO cursos (nombre_curso, id_categoria) VALUES
('SQL Inicial', (SELECT id_categoria FROM categoria WHERE nombre_categoria='Datos')),
('TypeScript',   (SELECT id_categoria FROM categoria WHERE nombre_categoria='Programación')),
('Docker',       (SELECT id_categoria FROM categoria WHERE nombre_categoria='Cloud')),
('Figma',        (SELECT id_categoria FROM categoria WHERE nombre_categoria='UX')),
('PostgreSQL',   (SELECT id_categoria FROM categoria WHERE nombre_categoria='Datos'));

-- Alumnos
INSERT INTO alumnos (nombre, apellido, email, dni, edad, telefono, nacionalidad) VALUES
('Ana',   'Gómez',   'ana.gomez@example.com', 30111222, 25, '1130000001', 'Argentina'),
('Luis',  'Pérez',   'luis.perez@example.com', 28999888, 30, '1130000002', 'Uruguay'),
('Mara',  'Suárez',  'mara.suarez@example.com', 31222333, 22, '1130000003', 'Chile'),
('Diego', 'Ramos',   NULL,                       29888777, 28, NULL,          'Argentina'),
('Juan',  'López',   'juan.lopez@example.com',   27123456, 35, '1130000004', 'Paraguay');

-- Inscripciones
INSERT INTO inscripciones (idx_alumno, idx_curso)
SELECT a.id_alumno, c.id_curso
FROM alumnos a
JOIN cursos c ON c.nombre_curso IN ('SQL Inicial','TypeScript')
WHERE a.nombre IN ('Ana','Luis','Mara');

-- Validaciones rápidas
SELECT * FROM alumnos;
SELECT * FROM cursos;
SELECT * FROM inscripciones;
```

---

## 🎯 DML Básico — Lo imprescindible

### 1) `INSERT`

**A. Insert simple (todas las columnas requeridas):**

```sql
INSERT INTO alumnos (nombre, apellido, email, dni, edad, telefono, nacionalidad)
VALUES ('Carla','Domínguez','carla.dominguez@example.com', 32777888, 27, '1130000010', 'Argentina');
```

**B. Insert múltiple (bulk):**

```sql
INSERT INTO cursos (nombre_curso, id_categoria) VALUES
('MySQL Avanzado', (SELECT id_categoria FROM categoria WHERE nombre_categoria='Datos')),
('Kubernetes',     (SELECT id_categoria FROM categoria WHERE nombre_categoria='Cloud'));
```

**C. Insert con `DEFAULT` y `NULL`:**

```sql
INSERT INTO alumnos (nombre, apellido, email, dni, edad, telefono, nacionalidad)
VALUES ('Sofía','Rivas', NULL, 33444555, NULL, NULL, DEFAULT);
```

**D. `INSERT ... SELECT` (sin subconsulta compleja todavía):**

```sql
-- Inscribir a todos los alumnos con email en el curso 'Docker'
INSERT INTO inscripciones (idx_alumno, idx_curso)
SELECT id_alumno, (SELECT id_curso FROM cursos WHERE nombre_curso='Docker')
FROM alumnos
WHERE email IS NOT NULL;
```

**E. `INSERT IGNORE` (omite errores por UNIQUE):**

```sql
INSERT IGNORE INTO alumnos (nombre, apellido, email, dni)
VALUES ('Ana','Gómez','ana.gomez@example.com', 30111222); -- ya existe
```

**F. UPSERT: `ON DUPLICATE KEY UPDATE`**

```sql
INSERT INTO alumnos (nombre, apellido, email, dni)
VALUES ('Ana','Gómez','ana.gomez@nuevo.com', 30111222)
ON DUPLICATE KEY UPDATE email = VALUES(email);
```

---

### 2) `UPDATE`

**A. Update básico con `WHERE`:**

```sql
UPDATE alumnos
SET telefono = '1139999999'
WHERE email = 'luis.perez@example.com';
```

**B. Update múltiple de columnas:**

```sql
UPDATE alumnos
SET nacionalidad = 'Argentina', edad = edad + 1
WHERE nacionalidad IN ('Chile','Uruguay');
```

**C. `ORDER BY ... LIMIT` (MySQL):**

```sql
-- Subimos 1 año a los 2 alumnos más jóvenes
UPDATE alumnos
SET edad = edad + 1
ORDER BY edad ASC
LIMIT 2;
```

**D. Update con JOIN (alternativa a subconsulta):**

```sql
UPDATE alumnos a
JOIN inscripciones i ON i.idx_alumno = a.id_alumno
JOIN cursos c ON c.id_curso = i.idx_curso
SET a.nacionalidad = 'Argentina'
WHERE c.nombre_curso = 'SQL Inicial' AND a.nacionalidad <> 'Argentina';
```

---

### 3) `DELETE`

**A. Delete básico:**

```sql
DELETE FROM inscripciones
WHERE idx_alumno = (SELECT id_alumno FROM alumnos WHERE email='mara.suarez@example.com')
  AND idx_curso = (SELECT id_curso FROM cursos WHERE nombre_curso='TypeScript');
```

**B. `ORDER BY ... LIMIT` (MySQL):**

```sql
-- Borrar la inscripción más antigua
DELETE FROM inscripciones
ORDER BY inscription_at ASC
LIMIT 1;
```

**C. Respeto a FK (el orden importa):**

```sql
-- ❌ Esto fallará si hay inscripciones que referencian el curso
DELETE FROM cursos WHERE nombre_curso = 'SQL Inicial';

-- ✅ Primero borro las inscripciones del curso, luego el curso
DELETE FROM inscripciones
WHERE idx_curso = (SELECT id_curso FROM cursos WHERE nombre_curso='SQL Inicial');

DELETE FROM cursos WHERE nombre_curso = 'SQL Inicial';
```

> **Tip:** tu schema no tiene `ON DELETE CASCADE`. Por eso, **primero** borra en tablas hijas.

---

## 🧠 Subconsultas en DML (el plato fuerte)

### 1) `INSERT ... SELECT` (subconsultas en SELECT)

```sql
-- Inscribir a todos los alumnos NO inscriptos aún a 'PostgreSQL' si tienen email
INSERT INTO inscripciones (idx_alumno, idx_curso)
SELECT a.id_alumno, c.id_curso
FROM alumnos a
CROSS JOIN (SELECT id_curso FROM cursos WHERE nombre_curso='PostgreSQL') c
WHERE a.email IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM inscripciones i
  WHERE i.idx_alumno = a.id_alumno AND i.idx_curso = c.id_curso
);
```

### 2) `UPDATE` con subconsulta en `SET`

```sql
-- Setear id_categoria correcto en cursos, basado en su nombre
UPDATE cursos c
SET c.id_categoria = (
  SELECT id_categoria FROM categoria cat
  WHERE (cat.nombre_categoria = 'Datos'     AND c.nombre_curso IN ('SQL Inicial','PostgreSQL','MySQL Avanzado'))
     OR (cat.nombre_categoria = 'Programación' AND c.nombre_curso = 'TypeScript')
     OR (cat.nombre_categoria = 'Cloud'     AND c.nombre_curso IN ('Docker','Kubernetes'))
     OR (cat.nombre_categoria = 'UX'        AND c.nombre_curso = 'Figma')
  LIMIT 1
);
```

### 3) `UPDATE` con subconsulta en `WHERE` (IN / EXISTS)

```sql
-- Marcar como 'Argentina' a alumnos inscriptos en al menos un curso de la categoría 'Datos'
UPDATE alumnos a
SET nacionalidad = 'Argentina'
WHERE EXISTS (
  SELECT 1
  FROM inscripciones i
  JOIN cursos c ON c.id_curso = i.idx_curso
  JOIN categoria cat ON cat.id_categoria = c.id_categoria
  WHERE i.idx_alumno = a.id_alumno
    AND cat.nombre_categoria = 'Datos'
);
```

### 4) `DELETE` con subconsulta

```sql
-- Borrar inscripciones de cursos de la categoría 'UX'
DELETE FROM inscripciones
WHERE idx_curso IN (
  SELECT id_curso FROM cursos
  WHERE id_categoria = (SELECT id_categoria FROM categoria WHERE nombre_categoria='UX')
);

-- Borrar alumnos sin ninguna inscripción
DELETE FROM alumnos a
WHERE NOT EXISTS (SELECT 1 FROM inscripciones i WHERE i.idx_alumno = a.id_alumno);
```

### 5) Subconsulta correlacionada (patrón clásico)

```sql
-- Poner teléfono NULL a alumnos que solo estén inscriptos en un único curso
UPDATE alumnos a
SET telefono = NULL
WHERE 1 = (
  SELECT COUNT(*) FROM inscripciones i
  WHERE i.idx_alumno = a.id_alumno
);
```

### 6) CTE (`WITH`) en MySQL 8 aplicadas a DML

```sql
WITH cursos_datos AS (
  SELECT id_curso FROM cursos c
  JOIN categoria cat ON cat.id_categoria = c.id_categoria
  WHERE cat.nombre_categoria = 'Datos'
)
UPDATE inscripciones i
JOIN cursos_datos cd ON cd.id_curso = i.idx_curso
SET inscription_at = CURRENT_TIMESTAMP;
```

> **Nota:** MySQL permite `WITH` antes de `SELECT/UPDATE/DELETE`. Útil para legibilidad en DML más complejos.

---

## 🧯 Transacciones, seguridad y trucos anti-drama

```sql
-- Siempre prueba cambios grandes dentro de una transacción
START TRANSACTION;

-- Ejemplo: subir edad +1 a inscriptos en 'TypeScript'
UPDATE alumnos a
JOIN inscripciones i ON i.idx_alumno = a.id_alumno
JOIN cursos c ON c.id_curso = i.idx_curso
SET a.edad = a.edad + 1
WHERE c.nombre_curso = 'TypeScript';

-- Revisión rápida
SELECT a.id_alumno, a.nombre, a.edad FROM alumnos a
WHERE a.id_alumno IN (SELECT idx_alumno FROM inscripciones WHERE idx_curso = (SELECT id_curso FROM cursos WHERE nombre_curso='TypeScript'));

-- Si todo OK:
COMMIT;
-- Si encontraste un problema:
-- ROLLBACK;
```

**Buenas prácticas rápidas:**

- Siempre usar `WHERE` en `UPDATE/DELETE` (o transacción + `SELECT` de control).
- Validar cardinalidad de subconsultas escalar (que devuelva 0/1 fila).
- Para upsert, preferir `ON DUPLICATE KEY UPDATE` sobre `INSERT IGNORE`.
- Documentar supuestos (sin `ON DELETE CASCADE`, borrar hijos primero).

---

## 🧪 Ejercicios guiados (con solución)

> **Antes de empezar**: vuelve a correr el _Setup_ si destrozaste datos. 😉

### Ejercicio 1 — Insert masivo inteligente

**Enunciado:** Inscribí a todos los alumnos **argentinos** en el curso **'Docker'**, pero solo si **no están ya inscriptos**.

**Solución:**

```sql
INSERT INTO inscripciones (idx_alumno, idx_curso)
SELECT a.id_alumno, c.id_curso
FROM alumnos a
JOIN cursos c ON c.nombre_curso='Docker'
WHERE a.nacionalidad='Argentina'
AND NOT EXISTS (
  SELECT 1 FROM inscripciones i WHERE i.idx_alumno=a.id_alumno AND i.idx_curso=c.id_curso
);
```

---

### Ejercicio 2 — Update con subconsulta correlacionada

**Enunciado:** Seteá `nacionalidad='Argentina'` a cualquier alumno cuya **única** inscripción sea a un curso de la categoría **'Datos'**.

**Solución:**

```sql
UPDATE alumnos a
SET nacionalidad='Argentina'
WHERE EXISTS (
  SELECT 1
  FROM inscripciones i
  JOIN cursos c ON c.id_curso = i.idx_curso
  JOIN categoria cat ON cat.id_categoria = c.id_categoria
  WHERE i.idx_alumno = a.id_alumno AND cat.nombre_categoria='Datos'
)
AND 1 = (
  SELECT COUNT(*) FROM inscripciones i2 WHERE i2.idx_alumno = a.id_alumno
);
```

---

### Ejercicio 3 — Delete con `NOT EXISTS`

**Enunciado:** Borrá **solo** las inscripciones de alumnos que **no tengan email** (pero mantené los alumnos).

**Solución:**

```sql
DELETE FROM inscripciones i
WHERE NOT EXISTS (
  SELECT 1 FROM alumnos a
  WHERE a.id_alumno = i.idx_alumno AND a.email IS NOT NULL
);
```

---

### Ejercicio 4 — UPSERT ordenado

**Enunciado:** Insertá o actualizá el email de `dni = 29888777` a `diego.ramos@coder.com`.

**Solución:**

```sql
INSERT INTO alumnos (nombre, apellido, email, dni)
VALUES ('Diego','Ramos','diego.ramos@coder.com', 29888777)
ON DUPLICATE KEY UPDATE email = VALUES(email);
```

---

### Ejercicio 5 — CTE en `DELETE`

**Enunciado:** Eliminá todas las inscripciones de cursos de **'Cloud'** usando CTE.

**Solución:**

```sql
WITH cursos_cloud AS (
  SELECT c.id_curso
  FROM cursos c
  JOIN categoria cat ON cat.id_categoria = c.id_categoria
  WHERE cat.nombre_categoria = 'Cloud'
)
DELETE i FROM inscripciones i
JOIN cursos_cloud cc ON cc.id_curso = i.idx_curso;
```

---

## 🔍 Chequeos útiles para el profe (y para no pisar el palito)

```sql
-- Ver alumnos sin inscripciones
SELECT a.*
FROM alumnos a
LEFT JOIN inscripciones i ON i.idx_alumno = a.id_alumno
WHERE i.idx_alumno IS NULL;

-- Top cursos por cantidad de inscriptos
SELECT c.nombre_curso, COUNT(*) AS cantidad
FROM inscripciones i
JOIN cursos c ON c.id_curso = i.idx_curso
GROUP BY c.id_curso
ORDER BY cantidad DESC;

-- Duplicidad potencial por email o dni (debería ser 1 siempre)
SELECT email, COUNT(*) FROM alumnos GROUP BY email HAVING COUNT(*) > 1;
SELECT dni, COUNT(*) FROM alumnos GROUP BY dni HAVING COUNT(*) > 1;
```

---

## 🧩 Bonus de comparación: JOIN vs Subconsulta
>
> Mismo resultado, dos enfoques. Que el alumno compare **legibilidad** y **rendimiento** según el caso.

**Con subconsulta:**

```sql
UPDATE alumnos
SET edad = edad + 1
WHERE id_alumno IN (
  SELECT i.idx_alumno
  FROM inscripciones i
  JOIN cursos c ON c.id_curso = i.idx_curso
  WHERE c.nombre_curso = 'TypeScript'
);
```

**Con JOIN:**

```sql
UPDATE alumnos a
JOIN inscripciones i ON i.idx_alumno = a.id_alumno
JOIN cursos c ON c.id_curso = i.idx_curso
SET a.edad = a.edad + 1
WHERE c.nombre_curso = 'TypeScript';
```

---

## ✅ Cierre (mensaje para el alumno)

- Dominar **DML** te da control total de los datos.  
- Las **subconsultas** son tu navaja suiza para escribir operaciones expresivas sin perder atomicidad.  
- Si la operación es grande o sensible: **transacción + verificación + commit**.  
- Y si algo falla: **ROLLBACK** y a iterar.

> Si esto te gustó, la próxima clase metemos índices, planes de ejecución y bloqueos… para que tu SQL vuele sin humo 🚀
