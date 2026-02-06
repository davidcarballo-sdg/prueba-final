{{ config(
    materialized='table'
) }}

select
    -- Keys
    c_custkey as customer_id,
    c_nationkey as nation_id,
    
    -- Informacion Descriptiva
    c_name as customer_name,
    c_address as address,
    c_phone as phone_number,
    
    -- Informacion de Negocio
    c_acctbal as account_balance,
    c_mktsegment as market_segment

    -- c_comment as comment

from {{ source('tpch', 'CUSTOMER') }}