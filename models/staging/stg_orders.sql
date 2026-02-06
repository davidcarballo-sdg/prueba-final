{{ config(
    materialized='table',
    unique_key='o_orderkey'
) }}

select
    o_orderkey as order_id,
    o_custkey as customer_id,
    o_orderstatus as status,
    o_totalprice as total_price,
    o_orderdate as order_date
from {{ source('tpch', 'ORDERS') }}

{{ m_incremental_filter('o_orderdate') }} -- Llamada a la macro