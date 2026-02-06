{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),
customers as (
    select * from {{ ref('stg_customers') }}
)

select
    o.order_id,
    o.order_date,
    o.total_price,
    c.name as customer_name,
    c.phone_number
from orders o
left join customers c on o.customer_id = c.customer_id