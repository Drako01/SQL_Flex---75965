# 📚 CLASE: **Importación y Gestión de Datos con MySQL**

## 🎯 OBJETIVO

Que el alumno:

- Sepa importar datos a MySQL por Workbench y consola.
- Sepa exportar datos de MySQL.
- Entienda **qué es la integridad referencial** y **qué son las restricciones**.
- Aprenda **Delete Cascade** y **Update Cascade**.
- Trabaje con archivos CSV y JSON para importar/exportar datos.

---

# 🧩 PARTE 1 — Conceptos Básicos (20 min)

## 1. ¿Qué es importar datos?
>
> **Importar** = Cargar datos a una base de datos desde un archivo externo (ej: CSV, JSON, SQL, etc).

**Ejemplo real:**  
Imagina que te dan una lista de alumnos en Excel y la quieres cargar en tu base de datos MySQL. Eso sería *importar*.

---

## 2. ¿Qué es exportar datos?
>
> **Exportar** = Sacar datos de una base de datos y guardarlos en un archivo (para backup, mover datos, etc).

**Ejemplo real:**  
Tienes una base de datos con productos. Quieres pasar esa lista a otro sistema. Exportas a un archivo CSV o SQL.

---

# 🧩 PARTE 2 — Procesos de Importación y Exportación

## 3. Exportar contenido en MySQL Workbench

**Ejemplo paso a paso:**

1. Ir a **Workbench** > **Server** > **Data Export**.
2. Seleccionar base de datos o tablas.
3. Elegir el formato de exportación (`.sql` generalmente).
4. Clic en **Start Export**.

**¿Qué hace esto?**  
Crea un archivo `.sql` que tiene todos los comandos para reconstruir esa base de datos.

---

## 4. Importar contenido en MySQL Workbench

**Ejemplo paso a paso:**

1. Ir a **Workbench** > **Server** > **Data Import**.
2. Seleccionar el archivo `.sql` a importar.
3. Indicar si se crea una nueva base de datos o se importa en una existente.
4. Clic en **Start Import**.

---

## 5. Importar vía Terminal o Consola

**Ejemplo simple:**

```bash
mysql -u usuario -p basededatos < archivo.sql
```

- `-u usuario`: tu usuario de MySQL.
- `-p`: te pedirá la contraseña.
- `basededatos`: el nombre de la base a donde quieres importar.
- `archivo.sql`: el archivo que quieres importar.

**Ejemplo real:**

```bash
mysql -u root -p mi_base < backup.sql
```

---

## 6. Archivos CSV y JSON

- **CSV** = Comma Separated Values (valores separados por comas).
- **JSON** = JavaScript Object Notation (estructura de objetos).

**Ejemplo de CSV:**

```csv
id,nombre,edad
1,Juan,20
2,Ana,22
```

**Ejemplo de JSON:**

```json
[
  { "id": 1, "nombre": "Juan", "edad": 20 },
  { "id": 2, "nombre": "Ana", "edad": 22 }
]
```

**Cómo generar CSV/JSON:**

- Usando Excel o Google Sheets (Guardar como CSV).
- Usando Notepad, VSCode, etc (para JSON manualmente).

---

# 🧩 PARTE 3 — Integridad Referencial

## 7. ¿Qué es la integridad referencial?

> Las relaciones entre tablas deben tener sentido lógico.  
> No puede existir un "detalle" que apunte a algo que no existe en la tabla "principal".

**Ejemplo sencillo:**

- Tabla **Clientes**:  
  - id_cliente = 1 → Juan
- Tabla **Pedidos**:
  - id_pedido = 1, id_cliente = 1 (ok)
  - id_pedido = 2, id_cliente = 99 (¿cliente 99? error 🚫)

---

## 8. Restricciones de Integridad Referencial

Cuando creas relaciones entre tablas, puedes aplicar restricciones como:

- **ON DELETE CASCADE**: Si borras un cliente, borras sus pedidos.
- **ON UPDATE CASCADE**: Si cambias el id del cliente, también se actualizan sus pedidos.

---

## 9. Delete Cascade y Update Cascade

**Ejemplo práctico:**

```sql
CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(50)
);

CREATE TABLE pedidos (
  id_pedido INT PRIMARY KEY,
  id_cliente INT,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);
```

---

**¿Qué pasa con esto?**

- Si borro un cliente ➔ también se borran sus pedidos automáticamente.
- Si cambio el id del cliente ➔ también se actualiza el id en pedidos.

**Demostración:**

```sql
DELETE FROM clientes WHERE id_cliente = 1;
-- automáticamente borra todos los pedidos de ese cliente
```

```sql
UPDATE clientes SET id_cliente = 10 WHERE id_cliente = 1;
-- automáticamente actualiza los pedidos a id_cliente=10
```

---

# 🧩 PARTE 4 — Actividades prácticas en clase

## 🔥 Actividad 1

**Crear estas tablas y probar DELETE CASCADE y UPDATE CASCADE:**

```sql
CREATE DATABASE tienda;
USE tienda;

CREATE TABLE categorias (
  id_categoria INT PRIMARY KEY,
  nombre VARCHAR(50)
);

CREATE TABLE productos (
  id_producto INT PRIMARY KEY,
  nombre VARCHAR(50),
  id_categoria INT,
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);
```

**Insertar datos:**

```sql
INSERT INTO categorias VALUES (1, 'Electrónica'), (2, 'Ropa');

INSERT INTO productos VALUES (1, 'Celular', 1), (2, 'Camiseta', 2);
```

**Probar:**

- Borrar una categoría (`DELETE FROM categorias WHERE id_categoria = 1;`).
- Actualizar id de categoría (`UPDATE categorias SET id_categoria = 3 WHERE id_categoria = 2;`).

---

## 🔥 Actividad 2

**Importar un CSV a MySQL Workbench**

1. Crear tabla:

```sql
CREATE TABLE alumnos (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  edad INT
);
```

2. Crear un archivo `alumnos.csv`:

```csv
id,nombre,edad
1,Lucas,21
2,Martina,23
3,Sebastián,20
```

3. Importar en Workbench:  
   > Table Data Import Wizard ➔ elegir archivo ➔ configurar columnas ➔ importar.

4. Consultar:

```sql
SELECT * FROM alumnos;
```

---

# 📋 RESUMEN FINAL

- Importar = cargar datos externos.
- Exportar = sacar datos.
- Integridad referencial = no permitir errores en relaciones.
- Delete Cascade = borrar en cascada.
- Update Cascade = actualizar en cascada.

---


## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
