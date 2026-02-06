{{ config(materialized='view') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

line_items as (
    select * from {{ ref('stg_lineitems') }}
)

select
    -- Identificadores de ambas tablas
    l.order_id,
    l.line_number,
    o.customer_id,
    l.part_id,
    l.supplier_id,
    
    -- Fechas y Estados
    o.order_date,
    o.order_status,
    l.return_flag,
    l.line_status,
    
    -- Métricas de Ventas
    l.quantity,
    l.extended_price,
    l.discount_percentage,
    l.tax_rate,
    
    -- Cálculo de Importes (Lógica TPC-H Q1)
    (l.extended_price * (1 - l.discount_percentage)) as discounted_price,
    (l.extended_price * (1 - l.discount_percentage) * (1 + l.tax_rate)) as total_charge

from line_items l
join orders o on l.order_id = o.order_id