{{ config(materialized='view') }}

with lineitems as (
    select * from {{ ref('stg_lineitems') }}
)

select
    *,
    -- sum_disc_price: l_extendedprice * (1-l_discount)
    (extended_price * (1 - discount_percentage)) as discounted_price,

    -- sum_charge: l_extendedprice * (1-l_discount) * (1+l_tax)
    (extended_price * (1 - discount_percentage) * (1 + tax_rate)) as total_charge

from lineitems