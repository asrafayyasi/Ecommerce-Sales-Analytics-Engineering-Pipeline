select
    order_id,
    sum(quantity * unit_price) as gross_revenue,
    sum(quantity) as total_quantity,
    count(order_item_id) as total_items
from {{ ref('stg_order_items') }}
group by order_id