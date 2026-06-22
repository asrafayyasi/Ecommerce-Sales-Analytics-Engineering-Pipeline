{{ config(materialized='table') }}

select
    p.product_id,
    p.product_name,
    p.category,

    sum(oi.quantity) as total_quantity_sold,
    sum(oi.quantity * oi.unit_price) as gross_revenue,
    sum(oi.quantity * (oi.unit_price - p.cost)) as estimated_gross_profit

from {{ ref('stg_order_items') }} oi
left join {{ ref('stg_orders') }} o
    on oi.order_id = o.order_id
left join {{ ref('dim_products') }} p
    on oi.product_id = p.product_id
where o.order_status = 'completed'
group by
    p.product_id,
    p.product_name,
    p.category
order by gross_revenue desc