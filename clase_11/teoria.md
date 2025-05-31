# Clase 11 

## 📘 1. Introducción al Data Warehouse (DW)

### ¿Qué es un Data Warehouse?

Un Data Warehouse es un sistema que centraliza y consolida grandes volúmenes de datos provenientes de múltiples fuentes, permitiendo su análisis y consulta eficiente. Se caracteriza por ser:

* **Orientado a temas**: Organiza los datos por áreas de interés (ventas, clientes, etc.).
* **Integrado**: Combina datos de diferentes fuentes en un formato coherente.
* **No volátil**: Una vez almacenados, los datos no se modifican.
* **Variable en el tiempo**: Almacena datos históricos para análisis a lo largo del tiempo.

### Componentes principales de un DW

1. **Fuentes de datos**: Sistemas operacionales, archivos planos, APIs, etc.
2. **Proceso ETL (Extract, Transform, Load)**: Extrae datos de las fuentes, los transforma y los carga en el DW.
3. **Almacén de datos**: Base de datos centralizada (en este caso, MySQL).
4. **Metadatos**: Información sobre la estructura y el significado de los datos.
5. **Herramientas de acceso**: Aplicaciones para consulta y análisis de datos.

### Ejemplo práctico en MySQL Workbench

Utilizando MySQL Workbench, puedes diseñar un esquema de estrella (star schema) que incluye:([Stack Overflow][1])

* **Tabla de hechos**: Contiene datos cuantitativos (por ejemplo, ventas).
* **Tablas de dimensiones**: Contienen datos descriptivos relacionados (por ejemplo, clientes, productos, tiempo).

Este enfoque facilita la realización de consultas analíticas eficientes.([Tableau][2])

---

## 📊 2. Introducción al Business Intelligence (BI)

### ¿Qué es Business Intelligence?

Business Intelligence es un conjunto de estrategias y herramientas que transforman datos en información útil para la toma de decisiones empresariales.

### Componentes del BI

1. **Fuentes de datos**: Internas (CRM, ERP) y externas (redes sociales, datos de mercado).
2. **Integración de datos**: Procesos ETL para consolidar y limpiar los datos.
3. **Almacenamiento de datos**: Data Warehouse o Data Marts.
4. **Análisis de datos**: Herramientas que permiten explorar y modelar los datos.
5. **Visualización de datos**: Dashboards, informes y gráficos interactivos.
6. **Toma de decisiones**: Uso de la información analizada para estrategias empresariales.

### Ejemplo práctico en MySQL

Puedes crear vistas o consultas que agreguen información relevante, como ventas por región o análisis de tendencias temporales. Estas consultas pueden integrarse con herramientas de visualización para generar dashboards interactivos.

---

## 🧠 3. Rol del Data Warehouse y del Business Intelligence

* **Data Warehouse**: Actúa como el repositorio centralizado que almacena datos históricos y consolidados, sirviendo como la base para el análisis.([Atlan][3])

* **Business Intelligence**: Utiliza los datos del DW para generar insights, identificar patrones y apoyar la toma de decisiones estratégicas.



---

## 📚 Recursos adicionales

Para profundizar en los temas tratados, te recomiendo los siguientes recursos:

* **Componentes de un Data Warehouse**: Una guía detallada sobre los elementos que conforman un DW.&#x20;

* **Conceptos y aplicaciones del Business Intelligence**: Explora los fundamentos y aplicaciones prácticas del BI.&#x20;

* **Diseño de un Data Warehouse con MySQL Workbench**: Tutorial paso a paso para crear un DW utilizando MySQL.&#x20;

* **Video tutorial sobre diseño de Data Warehouse en MySQL**: Una guía visual para comprender el proceso de diseño.&#x20;

---

[1]: https://stackoverflow.com/questions/42494115/creating-a-dwh-like-star-schema-in-mysql?utm_source=chatgpt.com "Creating a \"DWH like\" Star Schema in MySQL - Stack Overflow"
[2]: https://www.tableau.com/business-intelligence/what-is-business-intelligence?utm_source=chatgpt.com "Business intelligence: A complete overview | Tableau"
[3]: https://atlan.com/data-warehouse-101/?utm_source=chatgpt.com "What is a Data Warehouse? Purpose, Components & Future - Atlan"

---

## 🎯 Tema del ejemplo: Ventas de productos

### 🧱 1. Crear Base de Datos

```sql
CREATE DATABASE IF NOT EXISTS datawarehouse_demo;
USE datawarehouse_demo;
```

---

### 📐 2. Crear tablas de dimensiones

```sql
-- Dimensión Tiempo
CREATE TABLE dim_tiempo (
    id_tiempo INT PRIMARY KEY,
    fecha DATE,
    anio INT,
    mes INT,
    dia INT,
    trimestre INT
);

-- Dimensión Producto
CREATE TABLE dim_producto (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    categoria VARCHAR(50),
    marca VARCHAR(50)
);

-- Dimensión Cliente
CREATE TABLE dim_cliente (
    id_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    region VARCHAR(50),
    genero VARCHAR(10)
);
```

---

### 📊 3. Crear tabla de hechos

```sql
-- Tabla de Hechos: Ventas
CREATE TABLE hecho_ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_tiempo INT,
    id_producto INT,
    id_cliente INT,
    cantidad INT,
    total DECIMAL(10, 2),
    FOREIGN KEY (id_tiempo) REFERENCES dim_tiempo(id_tiempo),
    FOREIGN KEY (id_producto) REFERENCES dim_producto(id_producto),
    FOREIGN KEY (id_cliente) REFERENCES dim_cliente(id_cliente)
);
```

---

### 🧪 4. Insertar datos de prueba

```sql
-- Tiempos
INSERT INTO dim_tiempo VALUES
(1, '2024-01-15', 2024, 1, 15, 1),
(2, '2024-02-20', 2024, 2, 20, 1);

-- Productos
INSERT INTO dim_producto VALUES
(1, 'Notebook Acer', 'Electrónica', 'Acer'),
(2, 'Mouse Logitech', 'Accesorios', 'Logitech');

-- Clientes
INSERT INTO dim_cliente VALUES
(1, 'Juan Pérez', 'CABA', 'Masculino'),
(2, 'Laura Gómez', 'Buenos Aires', 'Femenino');

-- Ventas
INSERT INTO hecho_ventas (id_tiempo, id_producto, id_cliente, cantidad, total) VALUES
(1, 1, 1, 2, 2000.00),
(2, 2, 2, 1, 500.00);
```

---

### 📈 5. Consultas típicas de BI

**Ventas totales por categoría de producto:**

```sql
SELECT dp.categoria, SUM(hv.total) AS total_ventas
FROM hecho_ventas hv
JOIN dim_producto dp ON hv.id_producto = dp.id_producto
GROUP BY dp.categoria;
```

**Ventas por mes y región:**

```sql
SELECT dt.mes, dc.region, SUM(hv.total) AS total_ventas
FROM hecho_ventas hv
JOIN dim_tiempo dt ON hv.id_tiempo = dt.id_tiempo
JOIN dim_cliente dc ON hv.id_cliente = dc.id_cliente
GROUP BY dt.mes, dc.region
ORDER BY dt.mes;
```

**Clientes que compraron más de una vez:**

```sql
SELECT dc.nombre_cliente, COUNT(*) AS cantidad_compras
FROM hecho_ventas hv
JOIN dim_cliente dc ON hv.id_cliente = dc.id_cliente
GROUP BY dc.id_cliente
HAVING COUNT(*) > 1;
```

---

### ✅ Resultado

Con este esquema y estos scripts, vas a tener un entorno básico pero funcional para:

* Explicar cómo funciona un Data Warehouse.
* Ejecutar consultas analíticas.
* Mostrar la relación entre tablas de dimensiones y hechos.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  

