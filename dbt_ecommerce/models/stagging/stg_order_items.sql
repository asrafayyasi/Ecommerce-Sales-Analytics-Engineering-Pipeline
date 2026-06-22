select
    order_item_id,
    order_id,
    product_id,
    cast(quantity as integer) as quantity,
    cast(unit_price as numeric) as unit_price
from {{ source('raw', 'raw_order_items') }}
where order_item_id is not null