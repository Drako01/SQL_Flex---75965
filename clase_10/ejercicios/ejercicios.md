# Ejercicios Clase 10

## Transacciones

### 📁 `ejercicios.md`

# 🧠 Ejercicios de Práctica – Transacciones y Backup en MySQL Workbench

## 🎯 Objetivos de la clase

- Reconocer e implementar las sentencias del sublenguaje **TCL**.
- Identificar en qué situación usar cada sentencia (**COMMIT, ROLLBACK, SAVEPOINT**).
- Definir los conceptos **Backup** y **Restauración**.
- Identificar los componentes del proceso de **Backup & Restore**.
- Implementar **Backups** y **Restauraciones** en Workbench y línea de comandos.

---

## 🧪 SECCIÓN 1 – Transacciones (TCL)

### 🧩 Ejercicio 1: Insertar múltiples registros con COMMIT

1. Crear una base de datos `ejemplo_tcl`.
2. Crear una tabla `clientes` con id, nombre, email.
3. Iniciar una transacción e insertar 3 registros.
4. Ejecutar `COMMIT`.
5. Verificar que los datos se guardaron.

```sql
START TRANSACTION;

INSERT INTO clientes (nombre, email) VALUES ('Carlos', 'carlos@mail.com');
INSERT INTO clientes (nombre, email) VALUES ('Lucía', 'lucia@mail.com');
INSERT INTO clientes (nombre, email) VALUES ('Damián', 'damian@mail.com');

COMMIT;
````

---

### 🧩 Ejercicio 2: Usar ROLLBACK para deshacer errores

1. Iniciar una nueva transacción.
2. Insertar 2 registros nuevos en `clientes`.
3. Por error, intentá insertar uno con un email repetido.
4. Al fallar, usar `ROLLBACK`.
5. Verificar que no se insertó nada.

---

### 🧩 Ejercicio 3: Usar SAVEPOINT para retroceder parcialmente

1. Iniciar una transacción.
2. Insertar 3 productos en una tabla `productos`.
3. Usar `SAVEPOINT` después del primero y segundo insert.
4. Luego hacé un rollback al segundo punto.
5. Commit final.

```sql
START TRANSACTION;

INSERT INTO productos (nombre, precio) VALUES ('Mouse', 1500);
SAVEPOINT luego_del_mouse;

INSERT INTO productos (nombre, precio) VALUES ('Teclado', 3500);
SAVEPOINT luego_del_teclado;

INSERT INTO productos (nombre, precio) VALUES ('Monitor', 25000);

ROLLBACK TO luego_del_teclado;
COMMIT;
```

---

### 🧩 Ejercicio 4: Restaurar valores iniciales en múltiples tablas

1. Crear tablas `cuentas` y `movimientos`.
2. Insertar datos iniciales con una transacción.
3. Simular una transferencia entre cuentas usando transacciones.
4. Si algo falla, usar `ROLLBACK`.
5. Si todo está bien, `COMMIT`.

---

## 💾 SECCIÓN 2 – Backup y Restauración

### 📌 Ejercicio 5: Crear un backup completo con MySQL Workbench

1. Crear una base `backup_demo` con varias tablas y registros.
2. Ir a `Server > Data Export`.
3. Exportar la base completa a un archivo `.sql`.
4. Guardar el archivo en tu PC.

---

### 📌 Ejercicio 6: Eliminar una tabla por accidente (simulado)

1. Eliminar una tabla (por ejemplo, `empleados`).
2. Verificar que ya no existe.

```sql
DROP TABLE empleados;
```

---

### 📌 Ejercicio 7: Restaurar la base desde el backup

1. Ir a `Server > Data Import`.
2. Importar el archivo `.sql` creado en el Ejercicio 5.
3. Confirmar que la tabla eliminada volvió.

---

### 📌 Ejercicio 8: Crear un backup desde línea de comandos (si usás terminal)

```bash
mysqldump -u root -p backup_demo > backup_respaldo.sql
```

### 📌 Ejercicio 9: Restaurar el backup desde terminal

```bash
mysql -u root -p backup_demo < backup_respaldo.sql
```

---

## 📘 SECCIÓN 3 – Preguntas teóricas

1. ¿Qué diferencia hay entre `ROLLBACK` y `ROLLBACK TO SAVEPOINT`?
2. ¿En qué casos usarías `START TRANSACTION`?
3. ¿Qué ventaja tiene usar SAVEPOINT en vez de hacer un rollback completo?
4. ¿Qué datos incluye un archivo de backup `.sql`?
5. ¿Qué sucede si restaurás un backup sobre una base que ya tiene datos?

---

## 🧠 BONUS – Proyecto Integrador

Crea un sistema de inscripción a cursos:

1. Tablas: `alumnos`, `cursos`, `inscripciones`.
2. Simulá una transacción donde varios alumnos se inscriben.
3. Introducí un error (como un ID inexistente) a propósito.
4. Hacé rollback y corregilo.
5. Exportá un backup y volvé a importar para verificar todo.

---

## ✅ Checklist Final

- [ ] Sé usar `START TRANSACTION`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`.
- [ ] Puedo generar un backup en `.sql`.
- [ ] Sé restaurar desde Workbench y terminal.
- [ ] Identifico cuándo usar cada técnica.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
