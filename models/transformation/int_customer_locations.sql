{{ config(materialized='view') }}

with nations as (
    select * from {{ ref('stg_nations') }}
),
regions as (
    select * from {{ ref('stg_region') }}
)

select
    n.nation_id,
    n.nation_name,
    r.region_name
from nations n
join regions r on n.region_id = r.region_id