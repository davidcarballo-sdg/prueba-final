{{ config(materialized='table') }} -- Requisito: materialización en tabla 

select
    c_custkey as customer_id,
    c_name as name,
    c_nationkey as nation_id,
    c_phone as phone_number
from {{ source('tpch', 'CUSTOMER') }}