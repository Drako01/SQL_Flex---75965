---

# Diapositiva 1: Título
**Importación, Exportación e Integridad Referencial en MySQL**
Clase Práctica - 2 horas

---

# Diapositiva 2: Objetivos

- Importar y exportar datos.
- Trabajar con CSV y JSON.
- Entender la integridad referencial.
- Usar DELETE CASCADE y UPDATE CASCADE.

---

# Diapositiva 3: Exportar Datos

**Desde Workbench:**

- Click derecho en base de datos → Export Data.
- Seleccionar "Export to Self-Contained File".
- Guardar `.sql`.

**Desde consola:**

```bash
mysqldump -u usuario -p basededatos > backup.sql
```

---

# Diapositiva 4: Importar Datos

**Desde Workbench:**

- File → Open SQL Script.
- Ejecutar el archivo `.sql`.

**Desde consola:**

```bash
mysql -u usuario -p basededatos < backup.sql
```

---

# Diapositiva 5: Importar CSV en MySQL

**Desde Workbench:**

- Table Data Import Wizard.
- Seleccionar archivo CSV.
- Mapear columnas.

**Importar manualmente:**

```sql
LOAD DATA INFILE 'ruta/archivo.csv'
INTO TABLE tabla
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

---

# Diapositiva 6: Exportar a CSV o JSON

**Exportar CSV:**

- Resultado de consulta → Export Resultset → CSV File.

**Exportar JSON:**

- Resultado de consulta → Export Resultset → JSON File.

**Desde consola:** (menos usado)

---

# Diapositiva 7: Integridad Referencial

**¿Qué es?**

- Mantener la coherencia entre tablas relacionadas.
- Evitar datos huérfanos (ej: facturas sin cliente).

**Clave Foránea:**

```sql
FOREIGN KEY (campo_hijo) REFERENCES tabla_padre(campo_padre)
```

---

# Diapositiva 8: Restricciones de Integridad

- No permitir valores sin correspondencia.
- Error si insertas un valor que no existe en la tabla padre.
- Protege la base de datos de errores humanos.

---

# Diapositiva 9: ON DELETE CASCADE

**Definición:**

- Si eliminas un registro padre, se eliminan los hijos automáticamente.

**Ejemplo:**

```sql
ON DELETE CASCADE
```

**Uso típico:**

- Eliminar un cliente → eliminar todas sus órdenes.

---

# Diapositiva 10: ON UPDATE CASCADE

**Definición:**

- Si cambias el ID en la tabla padre, el cambio se refleja automáticamente en los hijos.

**Ejemplo:**

```sql
ON UPDATE CASCADE
```

**Uso típico:**

- Actualizar el ID de un producto → actualizar todas las ventas.

---

# Diapositiva 11: Ejemplo Completo

**Tablas:**

- `autores` (id_autor, nombre)
- `libros` (id_libro, titulo, id_autor FK)

**Relación:**

```sql
FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
ON DELETE CASCADE
ON UPDATE CASCADE;
```

**Acciones:**

- Borrar autor = borrar libros.
- Cambiar ID autor = cambiar ID en libros.

---

# Diapositiva 12: Exportación / Importación: Buenas Prácticas

- Hacer backup antes de cambios grandes.
- Verificar datos después de importar.
- Validar integridad con SELECT.
- Usar nombres claros para archivos.

---

# Diapositiva 13: Ejercicios Prácticos

- Exportar base completa.
- Crear CSV de productos y cargarlo.
- Crear tablas relacionadas.
- Aplicar DELETE CASCADE y UPDATE CASCADE.
- Hacer backup e importarlo en otra base.

---

# Diapositiva 14: Cierre

**📊 Hoy aprendimos:**

- Importar/exportar.
- Manejar CSV/JSON.
- Respetar integridad referencial.
- Trabajar con CASCADE.

**📢 A practicar mucho!**
## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
---
