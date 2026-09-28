-- ══════════════════════════════════════════
-- TechStore — Consultas Básicas SELECT
-- Autor: Tomás
-- Fecha: 28/09/2026
-- ══════════════════════════════════════════

-- Consulta 1: Exploración general de la tabla sales
-- Usar SELECT * tiene sentido en etapas tempranas de exploración, pruebas en entornos de desarrollo 
-- o cuando se necesita auditar rápidamente el esquema completo y validar la carga de datos.
-- NO tiene sentido usarlo en entornos productivos, reportes recurrentes o APIs, ya que transfiere 
-- columnas innecesarias por red, penaliza el rendimiento de memoria/caché y vuelve el código frágil 
-- si la estructura de la tabla cambia con el tiempo.
SELECT *
FROM sales;


-- Consulta 2: Selección de columnas específicas para finanzas
-- Se seleccionan únicamente los campos esenciales requeridos para la conciliación y facturación,
-- reduciendo la sobrecarga de I/O y asegurando una consulta limpia.
SELECT 
    customer_id,
    product_id,
    total_amount
FROM sales;


-- Consulta 3: Selección con alias en español para stakeholders
-- Renombramos los campos con nombres de negocio comprensibles en snake_case
-- para evitar ambigüedades con usuarios no técnicos.
SELECT 
    order_date   AS fecha_pedido,
    product_name AS nombre_producto,
    quantity     AS cantidad_unidades
FROM sales;
2. Archivo README.md
Markdown
# TechStore — Consultas Básicas SELECT y Alias

Este proyecto contiene las consultas de extracción y formato de datos iniciales para el área de finanzas de **TechStore**, estructuradas bajo buenas prácticas de SQL y optimización de consultas.

---

## Preguntas Técnicas y Documentación

### 1. ¿Por qué es mala práctica usar `SELECT *` en producción?

El uso indiscriminado del comodín `*` en aplicaciones o pipelines productivos genera problemas críticos en tres dimensiones:

* **Rendimiento e I/O de red:** `SELECT *` fuerza al motor de base de datos a leer y transferir por red todas las columnas de la tabla (incluso aquellas pesadas como `TEXT` o atributos irrelevantes para la operación). Por ejemplo, si una tabla contiene 40 columnas y la interfaz solo muestra 3, el motor desperdicia ancho de banda, memoria RAM de buffer y capacidad de I/O en disco.
* **Mantenibilidad y fragilidad del código:** Si el esquema de la base de datos se modifica (se agrega, elimina o reordena una columna), las aplicaciones que esperan datos por posición o esquemas fijos pueden fallar de forma imprevista (*breaking changes*). Declarar explícitamente las columnas (`SELECT customer_id, total_amount`) blinda la consulta ante cambios estructurales futuros.
* **Seguridad y exposición de datos:** Consultar todas las columnas puede exponer accidentalmente información confidencial o sensible (datos personales, emails o contraseñas cifradas) a capas de la aplicación o reportes que no deberían tener acceso a ellos.

---

### 2. ¿Por qué son importantes los alias para un stakeholder no técnico?

En las bases de datos transaccionales, las tablas y columnas suelen nombrarse en inglés técnico, con abreviaciones o convenciones pensadas para desarrolladores (por ejemplo, `total_amount`, `qty`, `cust_id`).

Para un analista o directivo del área de finanzas, encontrarse con un encabezado como `total_amount` puede generar ambigüedad:
* ¿Es el monto neto o bruto?
* ¿Tiene impuestos incluidos?
* ¿Está expresado en moneda local o dólares?

El uso de un alias explícito transforma esa variable técnica en una entidad clara del dominio del negocio:

```sql
-- Salida técnica difícil de interpretar de un vistazo:
SELECT total_amount FROM sales;

-- Salida de negocio directa y sin ambigüedades:
SELECT total_amount AS monto_total_facturado FROM sales;
