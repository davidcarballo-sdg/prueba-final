{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

lineitem as (
    select * from {{ ref('stg_lineitems') }}
)

select
    -- Identificadores (Keys)
    l.order_id,
    l.part_id,
    l.supplier_id,
    o.customer_id,
    
    -- Fechas
    o.order_date,
    l.ship_date,
    
    -- Métricas a nivel de línea
    l.quantity,
    l.extended_price,
    l.discount_percentage,
    l.tax_rate,
    
    -- Cálculo de Ingreso Neto: extended_price * (1 - discount) * (1 + tax)
    (l.extended_price * (1 - l.discount_percentage) * (1 + l.tax_rate)) as net_revenue,
    
    -- Atributos de estado
    o.order_status,
    l.return_flag
    
from lineitem l
inner join orders o on l.order_id = o.order_id