select
    o.customer_id,
    count(distinct o.order_id) as total_orders,
    min(o.order_date) as first_order_date,
    max(o.order_date) as last_order_date
from {{ ref('stg_orders') }} o
where o.order_status = 'completed'
group by o.customer_id