{{ config(materialized='table') }}

select
    date_trunc('month', order_date)::date as revenue_month,
    count(distinct order_id) as total_orders,
    count(distinct customer_id) as total_customers,
    sum(gross_revenue) as gross_revenue,
    sum(refund_amount) as refund_amount,
    sum(net_revenue) as net_revenue,
    avg(net_revenue) as average_order_value
from {{ ref('fct_sales') }}
group by 1
order by 1