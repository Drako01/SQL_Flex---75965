# 📚 Tutorial: Cómo importar un archivo `.csv` en MySQL Workbench usando `LOAD DATA INFILE`

---

## 1. Crear la base de datos y la tabla

Primero, creamos la base de datos (si no existe) y una tabla donde vamos a importar los datos.

```sql
CREATE DATABASE IF NOT EXISTS coderhouse2;
USE coderhouse2;

CREATE TABLE alumnos (
    id_alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    email VARCHAR(100) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    telefono VARCHAR(20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR(30) DEFAULT "Argentina",
    fecha_inscripcion TIMESTAMP,
    instituto VARCHAR(100) DEFAULT NULL,
    edad INT NOT NULL
) DEFAULT CHARSET=utf8mb4;
```

✅ **Nota:** Siempre usar `DEFAULT CHARSET=utf8mb4` para evitar problemas de caracteres especiales como "ñ", "á", "é", etc.

---

## 2. Preparar correctamente el archivo `.csv`

Muy importante:

- El archivo `.csv` debe estar **codificado en UTF-8** (no ANSI).
- Para verificarlo o convertirlo:
  
  ### En **Notepad++**

  1. Abrí el archivo `.csv`.
  2. Ir a menú `Codificación`.
  3. Si dice `ANSI`, hacer clic en:
     - `Codificación > Convertir a UTF-8 (sin BOM)`.
  4. Guardar (`Ctrl + S`).

✅ Ahora sí tu archivo tiene una codificación correcta.

---

## 3. Mover el archivo `.csv` a la carpeta correcta

Por temas de seguridad, **MySQL solo permite importar archivos desde una carpeta especial**.

Mover el archivo `.csv` a:

```
C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
```

✅ **Importante:** Esta carpeta existe siempre que tengas instalado MySQL Server en Windows.

---

## 4. Ejecutar el comando `LOAD DATA INFILE`

Ahora que todo está listo, ejecutamos este comando:

```sql
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/alumnos.csv'
INTO TABLE alumnos
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
```

✅ **Qué hace cada parte:**

- `CHARACTER SET utf8mb4`: Le dice a MySQL que los datos vienen en UTF-8 real.
- `FIELDS TERMINATED BY ','`: Cada dato está separado por comas.
- `OPTIONALLY ENCLOSED BY '"'`: Los campos pueden estar entre comillas `"`.
- `LINES TERMINATED BY '\n'`: Cada fila nueva es un salto de línea.
- `IGNORE 1 LINES`: Ignora la primera línea (los encabezados del archivo).

---

## 5. ¿Errores comunes y cómo solucionarlos?

| Error | Causa | Solución |
|:---|:---|:---|
| `Error Code: 2068 LOAD DATA LOCAL INFILE file request rejected due to restrictions on access.` | No usar `LOCAL` o configuración de servidor. | Usar `LOAD DATA INFILE` normal y mover archivo a `/Uploads/`. |
| `Error Code: 1290 secure-file-priv` | MySQL no permite importar desde cualquier carpeta. | Mover archivo a `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/`. |
| `Error Code: 1366 Incorrect string value '\xF1oz'` | Archivo `.csv` en ANSI o mal convertido. | Convertir archivo a UTF-8 real usando Notepad++. |
| `Error Code: 1300 Invalid utf8mb3 character string` | `CHARACTER SET` incorrecto en el comando. | Usar `CHARACTER SET utf8mb4` en el `LOAD DATA INFILE`. |

---

# 🎉 ¡Listo

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
