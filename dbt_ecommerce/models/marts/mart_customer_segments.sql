{{ config(materialized='table') }}

select
    customer_segment,
    count(customer_id) as total_customers,
    sum(total_orders) as total_orders
from {{ ref('dim_customers') }}
group by customer_segment
order by total_customers desc