{{ config(materialized='table') }}

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="(select min(order_date) from " ~ ref('stg_orders') ~ ")",
        end_date="(select dateadd(day, 1, max(order_date)) from " ~ ref('stg_orders') ~ ")"
    ) }}
)

select
    date_day as date_id,
    year(date_day) as year,
    month(date_day) as month,
    quarter(date_day) as quarter,
    dayname(date_day) as day_name,
    monthname(date_day) as month_name,
    case 
        when dayname(date_day) in ('Sat', 'Sun') then true 
        else false 
    end as is_weekend
from date_spine