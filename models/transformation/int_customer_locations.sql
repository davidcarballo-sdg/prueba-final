{{ config(materialized='view') }}

with nations as (
    select * from {{ ref('stg_nations') }}
),
regions as (
    select * from {{ ref('stg_region') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['n.nation_id']) }} as location_key,
    n.nation_id,
    n.nation_name,
    r.region_name
from nations n
join regions r on n.region_id = r.region_id