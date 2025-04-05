# Clase: Vistas en SQL 

## ¿Qué es una Vista?

Una **vista** es una tabla virtual basada en el resultado de una consulta SQL. Aunque se comporta como una tabla, no almacena los datos por sí misma, sino que muestra los datos de una o varias tablas subyacentes.

### Ejemplo:
```sql
CREATE VIEW vista_alumnos AS
SELECT nombre, apellido FROM alumno;
```

Esta vista muestra solamente el nombre y apellido de los alumnos.

---

## Tipos de Vistas

### 1. Vistas Simples
Basadas en una sola tabla, sin funciones agregadas ni uniones.

```sql
CREATE VIEW vista_cursos AS
SELECT nombre_curso, duracion FROM curso;
```

### 2. Vistas Complejas
Pueden incluir JOINs, funciones agregadas, subconsultas, etc.

```sql
CREATE VIEW vista_alumnos_cursos AS
SELECT a.nombre, c.nombre_curso
FROM alumno a
JOIN curso c ON a.id_curso = c.id_curso;
```

---

## Objetivos de una Vista

- **Simplificar consultas**: Facilita el acceso a datos complejos.
- **Seguridad**: Se pueden ocultar columnas sensibles.
- **Abstracción**: Se puede modificar la estructura de las tablas sin afectar a las aplicaciones que usan las vistas.
- **Reutilización**: Usar una misma consulta en varios lugares.

---

## Creación y Actualización de Vistas

### Crear una Vista
```sql
CREATE VIEW vista_instituciones AS
SELECT nombre, ciudad FROM institucion;
```

### Actualizar una Vista con OR REPLACE
```sql
CREATE OR REPLACE VIEW vista_instituciones AS
SELECT nombre, ciudad, provincia FROM institucion;
```

Esto reemplaza la vista anterior con la nueva definición.

---

## Eliminación de una Vista

```sql
DROP VIEW vista_instituciones;
```

---

## Crear Vistas ya existentes (cuando las tablas ya existen)

Si ya tenemos las siguientes tablas:
- `alumno(id_alumno, nombre, apellido, id_curso)`
- `curso(id_curso, nombre_curso, id_categoria)`
- `categoria(id_categoria, nombre_categoria)`

Podemos crear una vista que relacione esta información:

```sql
CREATE VIEW vista_alumnos_detalle AS
SELECT a.nombre, a.apellido, c.nombre_curso, cat.nombre_categoria
FROM alumno a
JOIN curso c ON a.id_curso = c.id_curso
JOIN categoria cat ON c.id_categoria = cat.id_categoria;
```

---

## Aplicar Filtros a una Vista

Se pueden aplicar filtros directamente en la definición:

```sql
CREATE VIEW vista_alumnos_matematica AS
SELECT a.nombre, a.apellido
FROM alumno a
JOIN curso c ON a.id_curso = c.id_curso
WHERE c.nombre_curso = 'Matemática';
```

O bien aplicar filtros al consultar la vista:

```sql
SELECT * FROM vista_alumnos_detalle WHERE nombre_categoria = 'Ciencias';
```

---

## Crear una Vista con Más de una Tabla (JOINs)

### Ejemplo completo:
Tablas involucradas:
- **alumno**: (id_alumno, nombre, apellido, id_curso)
- **curso**: (id_curso, nombre_curso, duracion, id_categoria)
- **categoria**: (id_categoria, nombre_categoria)
- **institucion**: (id_institucion, nombre, ciudad)

Queremos una vista que muestre:
- Nombre del alumno
- Curso que está cursando
- Categoría del curso
- Ciudad de la institución

```sql
CREATE VIEW vista_completa_alumnos AS
SELECT a.nombre AS nombre_alumno, a.apellido,
       c.nombre_curso, cat.nombre_categoria,
       i.ciudad
FROM alumno a
JOIN curso c ON a.id_curso = c.id_curso
JOIN categoria cat ON c.id_categoria = cat.id_categoria
JOIN institucion i ON c.id_institucion = i.id_institucion;
```

Esto permite tener una vista global de la información para consultas más rápidas y ordenadas.

---

## Consideraciones Finales
- Una vista **no almacena datos**, solo la consulta.
- Se pueden consultar como si fueran tablas.
- Algunas vistas pueden no ser actualizables (por ejemplo si usan funciones agregadas o GROUP BY).
- Muy útiles en reportes, dashboards, y para ocultar detalles internos.



---

## Recursos Adicionales
- [Documentación oficial de MySQL sobre Vistas](https://dev.mysql.com/doc/refman/8.0/en/create-view.html)
- [W3Schools - SQL Views](https://www.w3schools.com/sql/sql_view.asp)



## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
