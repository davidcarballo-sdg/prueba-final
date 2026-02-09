{{ config(
    materialized='incremental',
    unique_key="lineitem_id"
) }}

select
    concat(l_orderkey, '-', l_linenumber) as lineitem_id, -- Clave unica para incremental
    -- Keys 
    l_orderkey as order_id,
    l_partkey as part_id,
    l_suppkey as supplier_id,
    l_linenumber as line_number,
    
    -- Metrics
    l_quantity as quantity,
    l_extendedprice as extended_price,
    l_discount as discount_percentage,
    l_tax as tax_rate,
    
    -- Dates & Status
    l_shipdate as ship_date,
    l_linestatus as line_status,
    l_returnflag as return_flag
from {{ source('tpch', 'LINEITEM') }}


{{ m_incremental_filter('ship_date') }}