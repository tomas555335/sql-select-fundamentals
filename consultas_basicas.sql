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
