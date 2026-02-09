{{ config(materialized='table') }}

with customers as (
    select * from {{ ref('stg_customers') }}
),
locations as (
    select * from {{ ref('int_customer_locations') }} -- Reutilizamos tu pieza
)

select
    c.customer_id,
    c.customer_name,
    c.market_segment,
    c.address,
    c.phone_number,
    l.nation_name,
    l.region_name
from customers c
join locations l on c.nation_id = l.nation_id