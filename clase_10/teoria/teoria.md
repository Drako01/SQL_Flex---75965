# Transacciones y BackUp en SQL

## 🧠 ¿Qué es una Transacción en SQL?

Una **transacción** es un conjunto de instrucciones SQL que se ejecutan como una **unidad indivisible** de trabajo.

### 📌 Características clave

* Todas las instrucciones dentro de la transacción deben **ejecutarse con éxito**.
* Si ocurre un error, se puede **cancelar todo** (rollback).
* Solo cuando estamos seguros, se **confirma todo** con un commit.

Es como escribir un documento de Word:

* Vas escribiendo (como insertar datos).
* Podés guardar cambios (commit) o deshacer los últimos cambios (rollback).

---

## 🛠️ PASO A PASO DEL EJEMPLO

### 1. **Creamos la base de datos y usamos esa base**

```sql
CREATE DATABASE IF NOT EXISTS coderhouse3;
USE coderhouse3;
```

> ✅ Esto crea una base de datos llamada `coderhouse3` y selecciona esa base para trabajar.

---

### 2. **Creamos las tablas**

```sql
CREATE TABLE alumnos (...)
CREATE TABLE cursos (...)
CREATE TABLE inscripciones (...)
```

> ✅ Estas instrucciones crean las tablas donde vamos a guardar:

* `alumnos`: información personal.
* `cursos`: lista de cursos disponibles.
* `inscripciones`: quién se anotó a qué curso.

La tabla `inscripciones` usa **claves foráneas (FOREIGN KEY)** para conectar alumnos y cursos.

---

### 3. **Agregamos algunos datos**

---

### ✅ Objetivo

* Evitar inscripciones duplicadas.
* Insertar una nueva inscripción si no existe.
* Retornar un mensaje indicando el resultado.
* Poder ser usado dentro de una transacción de forma segura.

---

### 📦 Estructura esperada

Las tablas utilizadas son las que definiste antes:

* `alumnos(id_alumno)`
* `cursos(id_curso)`
* `inscripciones(id_alumno, id_curso, inscription_at)`

---

### 🧠 Procedimiento: `inscribir_alumno_seguro`

```sql
DELIMITER //

CREATE PROCEDURE inscribir_alumno_seguro(IN p_id_alumno INT, IN p_id_curso INT)
BEGIN
    DECLARE existe_alumno INT DEFAULT 0;
    DECLARE existe_curso INT DEFAULT 0;
    DECLARE existe_inscripcion INT DEFAULT 0;

    -- Validar si el alumno existe
    SELECT COUNT(*) INTO existe_alumno
    FROM alumnos
    WHERE id_alumno = p_id_alumno;

    -- Validar si el curso existe
    SELECT COUNT(*) INTO existe_curso
    FROM cursos
    WHERE id_curso = p_id_curso;

    -- Si no existe el alumno o el curso, mostrar mensaje de error y finalizar
    IF existe_alumno = 0 THEN
        SELECT '❌ El alumno no existe.' AS mensaje;
    ELSEIF existe_curso = 0 THEN
        SELECT '❌ El curso no existe.' AS mensaje;
    ELSE
        -- Verificar si ya está inscrito
        SELECT COUNT(*) INTO existe_inscripcion
        FROM inscripciones
        WHERE id_alumno = p_id_alumno AND id_curso = p_id_curso;

        IF existe_inscripcion > 0 THEN
            SELECT '⚠️ El alumno ya está inscrito en este curso.' AS mensaje;
        ELSE
            INSERT INTO inscripciones (id_alumno, id_curso)
            VALUES (p_id_alumno, p_id_curso);
            SELECT '✅ Inscripción realizada correctamente.' AS mensaje;
        END IF;
    END IF;
END;
//

DELIMITER ;

```

---

### ✅ ¿Cómo usarlo?

```sql
CALL inscribir_alumno_seguro(1, 2);
```

Este ejemplo intenta inscribir al alumno con `id = 1` en el curso con `id = 2`.

---

### 🧩 Usarlo dentro de una transacción

Podés incluir este procedimiento dentro de una transacción sin problemas:

```sql
START TRANSACTION;

CALL inscribir_alumno_seguro(1, 2);

-- Podés agregar más instrucciones aquí...

COMMIT;
```

---

### 📌 Notas

* Este procedimiento es una forma **segura y recomendada** de manejar lógica con modificaciones (`INSERT`) en la base de datos.
* Puede ser usado dentro de una transacción, lo cual permite agrupar múltiples operaciones de forma atómica.
* Si necesitás, se puede extender para validar si el alumno o curso existen antes de intentar inscribir.
* Retorna un mensaje de éxito o advertencia mediante un `SELECT`, que puede ser capturado por el cliente (Workbench, PHP, Java, etc.).

---

> ✅ Insertamos 3 alumnos y 3 cursos. Ya tenemos datos con los cuales trabajar.

---

### 4. **Iniciamos la Transacción**

```sql
START TRANSACTION;
```

> 🔄 Acá comienza **la transacción**. Todo lo que hagamos después **no será permanente** hasta que usemos `COMMIT`. Si algo sale mal, podemos **deshacerlo**.

---

### 5. **Primer Inserción**

```sql
INSERT INTO inscripciones (id_alumno, id_curso) VALUES (1,1);
SAVEPOINT despues_del_primero;
```

> ✍️ Inscribimos al alumno 1 en el curso 1.
> 💾 Creamos un **punto de guardado** llamado `despues_del_primero`, por si queremos volver a este estado.

---

### 6. **Segunda Inserción**

```sql
INSERT INTO inscripciones (id_alumno, id_curso) VALUES (2,1);
SAVEPOINT despues_del_segundo;
```

> ✍️ Inscribimos al alumno 2 en el curso 1.
> 💾 Creamos otro punto de guardado.

---

### 7. **Tercera Inserción**

```sql
INSERT INTO inscripciones (id_alumno, id_curso) VALUES (3,1);
SAVEPOINT despues_del_tercero;
```

> ✍️ Inscribimos al alumno 3 en el curso 1.
> 💾 Guardamos el estado nuevamente.

---

### 8. **Cuarta Inserción (Error)**

```sql
INSERT INTO inscripciones (id_alumno, id_curso) VALUES (1,4);
SAVEPOINT despues_del_cuarto;
```

> ⚠️ **Error probable**: No existe el curso con `id_curso = 4`, ya que solo creamos cursos con ID 1, 2 y 3.
> 🛑 Esto **rompería la transacción** si no la manejamos bien.

---

### 9. **Deshacemos el último paso**

```sql
ROLLBACK TO despues_del_tercero;
```

> 🔙 Deshacemos **todo lo que vino después del SAVEPOINT `despues_del_tercero`**, o sea: la cuarta inserción fallida.

---

### 10. **Confirmamos los cambios**

```sql
COMMIT;
```

> 💾 Todo lo que hicimos **hasta el punto `despues_del_tercero` se guarda de forma permanente** en la base de datos.
> Ya no se puede deshacer desde acá.

---

## 💡 ¿Qué aprendemos con este ejemplo?

1. Las transacciones permiten controlar **qué cambios se guardan** y **cuáles se descartan**.
2. Los **SAVEPOINTS** nos permiten **volver a un punto específico** sin deshacer toda la transacción.
3. El **ROLLBACK** sirve para **revertir errores** sin afectar lo que ya estaba bien.
4. El **COMMIT** es lo que **confirma y guarda todo de forma definitiva**.

---

## 🔄 Ejemplo ampliado

Agreguemos un ejemplo con más cursos y un rollback total:

```sql
START TRANSACTION;

-- Inscribimos varios alumnos
CALL inscribir_alumno_seguro(1, 2); -- OK
CALL inscribir_alumno_seguro(2, 2); -- OK
CALL inscribir_alumno_seguro(3, 5); -- ERROR (no existe curso 5)

ROLLBACK; -- Cancelamos todo

-- Ninguna inscripción fue guardada.
```

> ✅ Como ocurrió un error en el último paso, decidimos **cancelar toda la transacción**.
> Esto asegura que la base de datos **nunca quede en un estado incorrecto o incompleto**.

---

## ✅ RESUMEN VISUAL

| Comando SQL          | ¿Qué hace?                                 |
| -------------------- | ------------------------------------------ |
| `START TRANSACTION`  | Inicia una transacción                     |
| `SAVEPOINT nombre`   | Crea un punto intermedio de guardado       |
| `ROLLBACK TO nombre` | Revierte hasta ese punto, sin borrar todo  |
| `ROLLBACK`           | Revierte toda la transacción completa      |
| `COMMIT`             | Guarda todos los cambios de la transacción |

---

## Ejemplos

Vamos con un **paso a paso**, de un ejemplo **con y sin `SAVEPOINT`**, además de una tabla comparativa con **ventajas y desventajas**.

---

## 📘 **EJEMPLO 1: Transacción SIN `SAVEPOINT`**

```sql
START TRANSACTION;

-- Supongamos que existen los cursos con ID 1, 2 y 3
-- y los alumnos con ID 1, 2 y 3

-- Inscripciones válidas
CALL inscribir_alumno_seguro(1, 1);
CALL inscribir_alumno_seguro(2, 2);

-- Inserción con error (curso 99 no existe)
CALL inscribir_alumno_seguro(3, 99);

-- Al detectar el error, revertimos todo
ROLLBACK;

-- Nada de lo anterior fue guardado
```

🧠 **¿Qué pasó?**

* Los dos primeros `INSERT` eran correctos.
* El tercero falló.
* Con `ROLLBACK` **se canceló todo**, aunque había operaciones válidas.

---

## 📗 **EJEMPLO 2: Transacción CON `SAVEPOINT`**

```sql
START TRANSACTION;

-- Primer inscripción válida
CALL inscribir_alumno_seguro(1, 1);
SAVEPOINT paso_1;

-- Segunda inscripción válida
CALL inscribir_alumno_seguro(2, 2);
SAVEPOINT paso_2;

-- Tercer inscripción con error
CALL inscribir_alumno_seguro(3, 99); -- curso 99 no existe

-- Volvemos al punto anterior
ROLLBACK TO paso_2;

-- Confirmamos los dos primeros inserts
COMMIT;
```

🧠 **¿Qué pasó?**

* El error fue revertido sin borrar todo lo anterior.
* Se guardaron las dos primeras inscripciones.
* La inscripción fallida fue descartada.

---

## ⚖️ **Ventajas y Desventajas de usar `SAVEPOINT`**

| 🧩 Característica              | CON `SAVEPOINT`                                    | SIN `SAVEPOINT`                            |
| ------------------------------ | -------------------------------------------------- | ------------------------------------------ |
| 🎯 Control de errores          | Muy preciso. Podés volver a un paso intermedio     | Poca flexibilidad: todo o nada             |
| 💾 Datos salvados parcialmente | Sí, podés guardar lo válido y descartar lo erróneo | No, se pierde todo si hay un solo error    |
| 🧠 Complejidad del código      | Más complejo de escribir y entender                | Más simple                                 |
| ⏱️ Tiempo de ejecución         | Ligeramente mayor si usás muchos savepoints        | Más rápido, pero menos seguro              |
| 🛡️ Seguridad de los datos     | Más seguro ante errores puntuales                  | Riesgoso si no controlás todos los errores |

---

## 📝 Conclusión clara para principiantes

* Si **tenés pocos pasos** y **querés simplicidad**, usá transacciones normales sin `SAVEPOINT`.
* Si **estás haciendo muchas operaciones** y querés evitar perder todo por un solo error, **usá `SAVEPOINT` y `ROLLBACK TO`**.

---

## BackUp

---

## 💾 ¿Qué es un BACKUP?

> Un **backup** (o **respaldo**) es una **copia de seguridad** de los datos de una base de datos. Sirve para **proteger la información** frente a errores humanos, fallos técnicos, ataques informáticos o cualquier otro imprevisto.

---

## 🎯 ¿Para qué sirve un BACKUP?

| ✅ Usos del backup                      | 🧠 Ejemplos reales                       |
| -------------------------------------- | ---------------------------------------- |
| Recuperar información perdida          | Se borró una tabla por accidente         |
| Restaurar sistema tras una caída       | Se apagó el servidor sin guardar cambios |
| Migrar datos a otro servidor           | Cambiar de hosting o infraestructura     |
| Hacer pruebas sin afectar datos reales | Crear una copia y probar sobre esa copia |

---

## 🔄 Tipos de Backup

| Tipo de Backup     | Qué guarda                                    | Ventajas                   | Desventajas                   |
| ------------------ | --------------------------------------------- | -------------------------- | ----------------------------- |
| 🟢 Completo (Full) | Toda la base de datos                         | Fácil de restaurar         | Requiere mucho espacio        |
| 🟡 Incremental     | Solo lo que cambió desde el **último backup** | Rápido, usa poco espacio   | Restaurar puede ser complejo  |
| 🔵 Diferencial     | Cambios desde el **último backup completo**   | Más rápido que el completo | Más grande que el incremental |

---

## ⚙️ ¿Cómo se hace un BACKUP en MySQL?

### 📌 1. Usando la línea de comandos (con `mysqldump`)

```bash
mysqldump -u usuario -p nombre_de_base > respaldo.sql
```

📌 Ejemplo:

```bash
mysqldump -u root -p coderhouse3 > backup_coderhouse3.sql
```

✅ Esto genera un archivo de texto (`.sql`) que contiene todas las instrucciones necesarias para **recrear la base de datos**, incluyendo:

* CREATE TABLE
* INSERT INTO
* Estructura y datos

---

### 📌 2. Restaurar un backup (con `mysql`)

```bash
mysql -u usuario -p nombre_de_base < respaldo.sql
```

📌 Ejemplo:

```bash
mysql -u root -p coderhouse3 < backup_coderhouse3.sql
```

---

### 📌 3. Desde MySQL Workbench

Si usás Workbench (interfaz gráfica):

* **Exportar backup**:

  * Menú: `Server` > `Data Export`
  * Seleccionás la base de datos
  * Elegís "Export to Self-Contained File"
  * Guardás el `.sql`

* **Importar backup**:

  * Menú: `Server` > `Data Import`
  * Elegís el archivo `.sql`
  * Seleccionás la base destino o creás una nueva
  * Ejecutás

---

## 🧪 Ejemplo práctico paso a paso

1. Tenés una base llamada `coderhouse3`.
2. Querés hacer un backup antes de probar algo riesgoso.

```bash
mysqldump -u root -p coderhouse3 > antes_del_experimento.sql
```

3. Ahora probás algo que daña los datos (borrás todo por error):

```sql
DROP TABLE alumnos;
```

4. ¡Ups! Pero como hiciste backup, lo recuperás así:

```bash
mysql -u root -p coderhouse3 < antes_del_experimento.sql
```

✅ ¡Listo! Recuperaste todo como estaba.

---

## 💾 ¿Qué es un Backup en MySQL?

Un **Backup** es una **copia de seguridad** de una base de datos. Sirve para **proteger los datos** en caso de errores humanos, fallas del sistema, corrupción de archivos, etc.

En MySQL, los backups se suelen guardar como archivos `.sql` que contienen todas las instrucciones necesarias para **recrear la base de datos, sus tablas y sus datos**.

---

## 🛠 Cómo hacer un Backup en MySQL Workbench (paso a paso)

### ✅ Paso 1: Abrir MySQL Workbench

* Iniciá **MySQL Workbench** y conectate a tu servidor MySQL.

---

### ✅ Paso 2: Ir a la herramienta de exportación

* En el menú superior, hacé clic en:
  **Server → Data Export**

---

### ✅ Paso 3: Elegir la base de datos a respaldar

* En la parte izquierda, vas a ver todas las bases de datos disponibles.
* Seleccioná la base de datos que querés exportar (por ejemplo: `coderhouse3`).

---

### ✅ Paso 4: Elegir qué exportar

* Podés marcar:

  * ✅ Toda la base de datos (todos los objetos)
  * ✅ O solo algunas tablas.

* Luego, marcá la opción:

  * 🔘 **Export to Self-Contained File**
    Esto genera un único archivo `.sql`.

* Elegí la **ruta de destino** y el **nombre del archivo** (`coderhouse3_backup.sql`, por ejemplo).

---

### ✅ Paso 5: Opciones adicionales

* Asegurate que esté marcada la opción:

  * ✅ **Include Create Schema**
  * ✅ **Dump Structure and Data**

Esto asegura que el archivo incluirá tanto las estructuras (tablas, etc.) como los datos.

---

### ✅ Paso 6: Iniciar el proceso

* Hacé clic en el botón **Start Export** (abajo a la derecha).
* Esperá unos segundos hasta que aparezca el mensaje de **“Export completed successfully”**.

---

## 📂 ¿Qué obtengo?

Un archivo `.sql` con todo el contenido de tu base de datos. Este archivo se puede usar luego para restaurar la base, incluso en otro servidor.

---

## 💡 Recomendaciones

* Hacé backups **frecuentemente**, especialmente antes de hacer cambios grandes.
* Guardá los backups en lugares **seguros** (disco externo, nube, etc.).
* Probá restaurar el backup de vez en cuando para verificar que funciona.

---

## **paso a paso para restaurar** ese backup en Workbench?

## 🔁 ¿Qué es Restaurar una Base de Datos?

Restaurar una base de datos es **recuperar los datos y estructuras** desde un archivo de backup `.sql`. Es útil cuando:

* Perdiste datos por error.
* Querés mover la base a otro servidor.
* Necesitás rehacer una base con datos previos.

---

## 🛠 Cómo Restaurar un Backup en MySQL Workbench (paso a paso)

### ✅ Paso 1: Abrir MySQL Workbench

* Abrí **MySQL Workbench** e iniciá sesión en tu servidor.

---

### ✅ Paso 2: Ir a la herramienta de importación

* En el menú superior, hacé clic en:
  **Server → Data Import**

---

### ✅ Paso 3: Seleccionar el archivo de backup

* En la sección "Import Options", elegí:

  * 🔘 **Import from Self-Contained File**
* Luego, buscá el archivo `.sql` que hiciste en el backup (por ejemplo, `coderhouse3_backup.sql`).

---

### ✅ Paso 4: Elegir dónde restaurarlo

* En la sección “Default Target Schema”, seleccioná la base de datos destino.

**¿No existe la base de datos aún?**

1. Hacé clic en **“New”** para crear una base nueva.
2. Poné un nombre (por ejemplo: `coderhouse3_restaurada`).
3. Hacé clic en **“OK”** y seleccionala como destino.

---

### ✅ Paso 5: Opciones de importación

* Asegurate de tener marcada la opción:

  * ✅ **Dump Structure and Data**

---

### ✅ Paso 6: Ejecutar la importación

* Hacé clic en **Start Import**.
* Esperá que se complete el proceso. Debería decir “Import Completed Successfully”.

---

## 🔎 Verificar que la restauración fue exitosa

* En el panel izquierdo (Schema), actualizá los esquemas.
* Buscá la base restaurada.
* Revisá las tablas, datos, y probá algunas consultas.

---

## 📌 Recomendaciones

* Restaurá en un entorno de prueba antes de hacerlo en producción.
* Siempre verificá que el archivo `.sql` esté completo.
* No interrumpas el proceso una vez iniciado.

---

## 🛡️ Buenas prácticas con Backups

| Consejo                                        | Por qué es útil                                      |
| ---------------------------------------------- | ---------------------------------------------------- |
| 🕓 Hacer backups diarios o semanales           | Para minimizar pérdida de información                |
| 🌐 Guardar copias en la nube o discos externos | Evita perder todo si falla tu PC o servidor          |
| 📄 Documentar los pasos para restaurar         | Ayuda en caso de emergencia                          |
| 🔒 Proteger los archivos de backup             | Contienen datos sensibles (usá contraseñas, cifrado) |
| ✅ Probar la restauración de vez en cuando      | Asegura que el backup funciona realmente             |

---

## 🎓 Conclusión sencilla

* Un backup es como un **seguro** para tus datos.
* Es **obligatorio** en proyectos profesionales.
* Se hace fácil con herramientas como `mysqldump` o Workbench.
* Es mejor tener **un backup que no necesitás** que necesitar uno que no hiciste.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
