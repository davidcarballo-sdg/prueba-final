{{ config(materialized='view') }}

select
    l_orderkey as order_key,
    sum(l_quantity) as total_items,
    sum(l_extendedprice) as gross_revenue,
    sum(l_extendedprice * (1 - l_discount)) as net_revenue
from {{ source('tpch', 'LINEITEM') }}
group by 1