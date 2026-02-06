{{ config(materialized='view') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

line_items as (
    select * from {{ ref('stg_lineitems') }}
)

select
    -- Identificadores
    l.order_id,
    l.part_id,
    l.line_number,
    
    -- Datos de Dimensión (denormalización temprana)
    o.order_date,
    o.order_status,
    
    -- Cálculos de Negocio
    l.quantity,
    l.extended_price,
    l.discount_percentage,
    l.tax_rate,
    
    -- Cálculo del Item Price: (Price * (1 - Discount)) * (1 + Tax)
    (l.extended_price * (1 - l.discount_percentage) * (1 + l.tax_rate)) as net_item_price,
    
    -- Cálculo del Descuento total aplicado
    (l.extended_price * l.discount_percentage) as discount_amount

from line_items l
join orders o on l.order_id = o.order_id