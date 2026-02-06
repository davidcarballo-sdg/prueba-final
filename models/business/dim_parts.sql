{{ config(materialized='table') }}

with parts as (
    select * from {{ ref('stg_parts') }}
)

select
    part_id,
    part_name,
    brand,
    type,
    retail_price
from parts