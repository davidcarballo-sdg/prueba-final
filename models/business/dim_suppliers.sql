{{ config(materialized='table') }}

with suppliers as (
    select * from {{ ref('stg_suppliers') }}
),
locations as (
    select * from {{ ref('int_customer_locations') }} -- Reutilizamos la misma pieza
)

select
    s.supplier_id,
    s.supplier_name,
    s.account_balance,
    s.address,
    s.phone_number,
    l.nation_name,
    l.region_name
from suppliers s
join locations l on s.nation_id = l.nation_id