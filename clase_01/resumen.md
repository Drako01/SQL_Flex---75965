
## **📌 Clase 01**
### **Unidad 1: Bases de Datos Relacionales**
🎯 **Objetivos de la clase**  
1. Definir qué es una base de datos.  
2. Identificar los componentes de una base de datos.  
3. Presentar los tipos de bases de datos y su importancia.  
4. Explicar el glosario técnico clave.  
5. Definir qué es una base de datos relacional y sus aspectos generales.  
6. Identificar los componentes de una base de datos relacional.  

---


# **📌 Contenido de la clase**
## **1️⃣ ¿Qué es una Base de Datos?**
🎯 **Definición**  
Una base de datos (DB) es un conjunto organizado de información que permite almacenar, gestionar y recuperar datos de manera eficiente.

📌 **Ejemplo práctico:**  
Piensa en una hoja de cálculo donde guardas una lista de clientes con nombres, correos y teléfonos. Si esta información crece demasiado, Excel deja de ser eficiente. Aquí es donde entra una base de datos.

📌 **Importancia:**  
- Permite almacenar grandes volúmenes de información.  
- Facilita el acceso y la manipulación de los datos.  
- Asegura la integridad y seguridad de la información.  

---

## **2️⃣ Componentes de una Base de Datos**
1. **Datos:** Información almacenada en tablas.  
2. **Software de Base de Datos:** Programa que gestiona los datos (Ej.: MySQL, PostgreSQL, SQL Server).  
3. **Usuarios:** Personas o sistemas que interactúan con la base de datos.  
4. **Lenguaje de Consulta:** Como SQL, para manejar los datos.  

📌 **Ejemplo:**  
Una base de datos de una tienda online tiene:  
- Tabla `Clientes` (con nombres, correos y teléfonos).  
- Tabla `Pedidos` (con productos comprados y montos).  

---

## **3️⃣ Tipos de Bases de Datos y su Importancia**
📌 **Tipos de bases de datos más comunes:**  
1. **Bases de Datos Relacionales (SQL)**: Organizan datos en tablas relacionadas. Ejemplo: MySQL.  
2. **Bases de Datos No Relacionales (NoSQL)**: Usan documentos o clave-valor (Ej.: MongoDB).  

📌 **Comparación rápida:**  
| Característica | Relacional (SQL) | No Relacional (NoSQL) |
|--------------|-----------------|------------------|
| Estructura | Tablas y relaciones | Documentos o claves |
| Ejemplo | MySQL, PostgreSQL | MongoDB, Firebase |
| Uso típico | Aplicaciones empresariales | Big Data, Apps móviles |

---

## **4️⃣ Glosario Técnico Clave**
- **SQL (Structured Query Language):** Lenguaje para manejar bases de datos relacionales.  
- **Tabla:** Conjunto de datos organizados en filas y columnas.  
- **Registro:** Cada fila dentro de una tabla.  
- **Campo:** Cada columna dentro de una tabla.  
- **Clave Primaria (Primary Key):** Identificador único de cada registro.  
- **Clave Foránea (Foreign Key):** Relaciona una tabla con otra.  

📌 **Ejemplo visual de tabla:**  
| ID | Nombre | Email |  
|----|--------|----------------|  
| 1  | Juan  | juan@gmail.com |  
| 2  | Ana   | ana@gmail.com  |  

Aquí, el campo `ID` es la **Clave Primaria**.

---

## **5️⃣ ¿Qué es una Base de Datos Relacional?**
🎯 **Definición**  
Una base de datos relacional organiza los datos en tablas que pueden relacionarse entre sí mediante claves primarias y claves foráneas.

📌 **Ejemplo de Relación entre Tablas:**  
1. **Tabla `Clientes`**  
   | ClienteID | Nombre | Email |  
   |----------|--------|----------------|  
   | 1        | Juan  | juan@gmail.com |  
   | 2        | Ana   | ana@gmail.com  |  

2. **Tabla `Pedidos`**  
   | PedidoID | ClienteID | Producto |  
   |---------|----------|------------|  
   | 101     | 1        | Laptop     |  
   | 102     | 2        | Teléfono   |  

**Relación:** `Pedidos.ClienteID` es una **Clave Foránea** que conecta con `Clientes.ClienteID`.

---

## **6️⃣ Ejercicio Práctico en Vivo**
✍ **Objetivo:** Crear una base de datos simple y hacer consultas en SQL.  

📌 **Pasos:**  
1. **Crear la base de datos:**  
```sql
CREATE DATABASE Tienda;
USE Tienda;
```

2. **Crear la tabla `Clientes`:**  
```sql
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);
```

3. **Insertar datos:**  
```sql
INSERT INTO Clientes (ClienteID, Nombre, Email) 
VALUES (1, 'Juan Pérez', 'juan@gmail.com'),
       (2, 'Ana Gómez', 'ana@gmail.com');
```

4. **Consultar datos:**  
```sql
SELECT * FROM Clientes;
```

📌 **Desafío:**  
- Crear una tabla `Pedidos` con `PedidoID`, `ClienteID` y `Producto`.  
- Insertar registros en `Pedidos`.  
- Hacer una consulta para obtener los pedidos de cada cliente.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  