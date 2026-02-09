{{ config(
    materialized='incremental',
    unique_key='order_item_key' 
) }}

with order_items as (
    select * from {{ ref('int_order_items') }}
    {{ m_incremental_filter('order_date') }}
)

select
    order_item_key,
    -- Las dimensiones clave para filtrar y agrupar
    order_id,
    line_number,
    customer_id,
    part_id,
    supplier_id,
    order_date,
    
    -- Los estados para análisis de ciclo de vida
    order_status,
    return_flag,
    line_status,
    
    -- Las métricas financieras finales ya calculadas
    quantity,
    extended_price,
    discounted_price,
    total_charge as net_amount -- Renombrado para el usuario de negocio
from order_items