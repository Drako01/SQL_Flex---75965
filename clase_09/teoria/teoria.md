# Unidad 9: Triggers y Sublenguaje DCL

## 🧠 Objetivos de la clase

- Conocer el concepto general de un Trigger
- Familiarizarse con los tipos de Triggers
- Conocer la sintaxis e implementación de un Trigger
- Reconocer el implementar las sentencias del sublenguaje DCL
- Identificar en qué situación usar cada sentencia

---

## 📘 Parte 1: Material Teórico

### ¿Qué es un Trigger?

Un **Trigger** (o disparador) es un objeto de la base de datos que se asocia a una tabla y se ejecuta automáticamente en respuesta a ciertos eventos como `INSERT`, `UPDATE` o `DELETE`. Se utiliza para automatizar tareas, mantener la integridad de los datos y aplicar reglas de negocio directamente en la base de datos.

### Tipos de Triggers en MySQL

- **BEFORE INSERT**: Se ejecuta antes de insertar un nuevo registro.
- **AFTER INSERT**: Se ejecuta después de insertar un nuevo registro.
- **BEFORE UPDATE**: Se ejecuta antes de actualizar un registro existente.
- **AFTER UPDATE**: Se ejecuta después de actualizar un registro existente.
- **BEFORE DELETE**: Se ejecuta antes de eliminar un registro.
- **AFTER DELETE**: Se ejecuta después de eliminar un registro.

### Sintaxis General

```sql
DELIMITER //
CREATE TRIGGER nombre_del_trigger
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON nombre_de_la_tabla
FOR EACH ROW
BEGIN
    -- Instrucciones SQL
END;
//
DELIMITER ;
```

### ¿Cuándo usar Triggers?

- Para validar o modificar datos antes de que se realicen cambios en la base de datos.
- Para mantener registros de auditoría de cambios.
- Para aplicar reglas de negocio automáticamente.
- Para sincronizar datos entre tablas relacionadas.

---

## 🏫 Parte 2: Caso Práctico - Base de Datos de una Institución Educativa

### Estructura de la Base de Datos

Vamos a trabajar con las siguientes tablas:

- **estudiantes**: Información de los estudiantes.
- **cursos**: Información de los cursos ofrecidos.
- **inscripciones**: Registro de inscripciones de estudiantes en cursos.
- **auditoria\_inscripciones**: Registro de auditoría de las inscripciones.

### Creación de las Tablas

```sql
CREATE TABLE estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nacimiento DATE
);

CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE inscripciones (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha_inscripcion DATE,
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE auditoria_inscripciones (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT,
    accion VARCHAR(10),
    fecha_accion DATETIME
);
```

### Ejemplo 1: Trigger AFTER INSERT

Registrar en la tabla de auditoría cada vez que se realice una nueva inscripción.

```sql
DELIMITER //
CREATE TRIGGER after_insert_inscripcion
AFTER INSERT ON inscripciones
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_inscripciones (id_inscripcion, accion, fecha_accion)
    VALUES (NEW.id_inscripcion, 'INSERT', NOW());
END;
//
DELIMITER ;
```

### Ejemplo 2: Trigger BEFORE DELETE

Registrar en la tabla de auditoría antes de eliminar una inscripción.

```sql
DELIMITER //
CREATE TRIGGER before_delete_inscripcion
BEFORE DELETE ON inscripciones
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_inscripciones (id_inscripcion, accion, fecha_accion)
    VALUES (OLD.id_inscripcion, 'DELETE', NOW());
END;
//
DELIMITER ;
```

### Ejemplo 3: Trigger BEFORE UPDATE

Evitar que se modifique la fecha de inscripción después de ser registrada.

```sql
DELIMITER //
CREATE TRIGGER before_update_inscripcion
BEFORE UPDATE ON inscripciones
FOR EACH ROW
BEGIN
    IF NEW.fecha_inscripcion <> OLD.fecha_inscripcion THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite modificar la fecha de inscripción.';
    END IF;
END;
//
DELIMITER ;
```

---

## 🛠️ Parte 3: Implementación en MySQL Workbench

### Pasos para Crear un Trigger

1. Abre MySQL Workbench y conecta con tu servidor MySQL.
2. En el panel izquierdo, expande la base de datos y selecciona la tabla deseada.
3. Haz clic derecho en la tabla y selecciona **"Create Trigger..."**.
4. Se abrirá una nueva pestaña para definir el trigger:

   - **Trigger Name**: Nombre del trigger.
   - **Timing**: BEFORE o AFTER.
   - **Event**: INSERT, UPDATE o DELETE.
   - **Statement**: Código SQL que se ejecutará.
5. Escribe el código del trigger en la sección correspondiente.
6. Haz clic en **"Apply"** para crear el trigger.

Para una guía visual paso a paso, puedes consultar el siguiente tutorial:

[Crear Triggers en MySQL Workbench: Guía Paso a Paso](https://mysqlya.com.ar/tutoriales/crear-trigger-mysql-workbench/)

---

## 📚 Parte 4: Sentencias DCL (Data Control Language)

Las sentencias DCL se utilizan para controlar los permisos y la seguridad en la base de datos.

## 🔐 Parte Complementaria: DCL - Control de Acceso en MySQL

### ¿Qué es DCL?

**DCL (Data Control Language)** es el subconjunto del lenguaje SQL que se utiliza para definir permisos y controlar el acceso a los datos en una base de datos.

Las sentencias principales son:

- `GRANT`: Para otorgar privilegios.
- `REVOKE`: Para revocar privilegios.
- `CREATE USER`: Para crear nuevos usuarios.
- `DROP USER`: Para eliminar usuarios existentes.

---

## 👤 Creación de Usuarios

```sql
CREATE USER 'nombre_usuario'@'localhost' IDENTIFIED BY 'contraseña';
```

**Ejemplo:**

```sql
CREATE USER 'profesor1'@'localhost' IDENTIFIED BY 'segura123';
```

Esto crea un usuario que solo puede conectarse desde la misma máquina del servidor MySQL.

---

## 🔑 Asignación de Permisos

### GRANT

Otorga privilegios al usuario para acceder a ciertos objetos.

```sql
GRANT privilegios ON base_datos.tabla TO 'usuario'@'host';
```

**Privilegios comunes:**

- `SELECT`, `INSERT`, `UPDATE`, `DELETE`: Acciones sobre datos.
- `ALL PRIVILEGES`: Otorga todos los permisos.
- `TRIGGER`: Permiso para crear triggers.

**Ejemplos:**

```sql
-- Permitir a profesor1 ver e insertar datos en la tabla inscripciones
GRANT SELECT, INSERT ON institucion.inscripciones TO 'profesor1'@'localhost';

-- Permitir a profesor1 crear triggers
GRANT TRIGGER ON institucion.* TO 'profesor1'@'localhost';
```

---

## ❌ Revocación de Permisos

### REVOKE

Quita privilegios otorgados anteriormente.

```sql
REVOKE privilegios ON base_datos.tabla FROM 'usuario'@'host';
```

**Ejemplo:**

```sql
REVOKE INSERT ON institucion.inscripciones FROM 'profesor1'@'localhost';
```

---

## 🔄 Visualización de Permisos

Puedes revisar qué privilegios tiene un usuario con:

```sql
SHOW GRANTS FOR 'profesor1'@'localhost';
```

---

## 🧽 Eliminación de Usuarios

```sql
DROP USER 'profesor1'@'localhost';
```

---

## 🛠 Cómo hacerlo en MySQL Workbench

1. Abre **MySQL Workbench** y conecta a tu servidor.
2. Ve a **Server > Users and Privileges**.
3. En la pestaña **Users**, haz clic en **Add Account**.
4. Completa:

   - Username
   - Host: localhost o %
   - Password
5. En la pestaña **Administrative Roles** y **Schema Privileges**, selecciona los permisos deseados.
6. Haz clic en **Apply** para crear y configurar el usuario.

---

## ✅ Buenas Prácticas

- Usa `localhost` para usuarios internos del servidor.
- Asigna solo los privilegios estrictamente necesarios (principio de menor privilegio).
- Usa contraseñas fuertes.
- Evita usar la cuenta `root` para tareas diarias.
- Crea cuentas específicas para tareas automatizadas (como triggers).

---

## 📘 Ejercicio para la Clase

1. Crear el usuario `coordinador@localhost` con permisos para leer y escribir en las tablas `estudiantes`, `cursos` e `inscripciones`.
2. Crear el usuario `auditor@localhost` con acceso solo de lectura a toda la base.
3. Quitarle a `coordinador` el permiso de insertar en `cursos`.

---

## Manejo de permisos volviendo al ejemplo anterior

### GRANT

Otorga permisos a un usuario.

```sql
GRANT SELECT, INSERT ON nombre_base_datos.* TO 'usuario'@'localhost';
```

### REVOKE

Revoca permisos previamente otorgados.

```sql
REVOKE INSERT ON nombre_base_datos.* FROM 'usuario'@'localhost';
```

### Uso de DCL en el Contexto de Triggers

Es importante asegurarse de que los usuarios que crean o modifican triggers tengan los permisos adecuados. Por ejemplo, para crear un trigger, el usuario debe tener el privilegio `TRIGGER` en la base de datos.

```sql
GRANT TRIGGER ON nombre_base_datos.* TO 'usuario'@'localhost';
```

---

## 🧩 Parte 5: Actividades Prácticas

1. **Crear un Trigger AFTER INSERT**: Que registre en una tabla de auditoría cada vez que se inscribe un estudiante en un curso.
2. **Crear un Trigger BEFORE DELETE**: Que impida eliminar una inscripción si la fecha de inscripción es anterior a la fecha actual.
3. **Modificar Permisos con DCL**: Otorgar y revocar permisos a un usuario para que pueda crear triggers en la base de datos.

---

## 🎥 Recursos Adicionales

- [Tutorial en Video: Cómo crear un TRIGGER en MySQL Workbench](https://www.youtube.com/watch?v=C2s-qbcyIS8)
- [Implementación de Triggers en SQL: Caso de Estudio de una Base de Datos Estudiantil](https://www.entredata.org/fundamentos-de-sql/implementacion-de-triggers-en-sql-caso-de-estudio-de-una-base-de-datos-estudiantil)

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
