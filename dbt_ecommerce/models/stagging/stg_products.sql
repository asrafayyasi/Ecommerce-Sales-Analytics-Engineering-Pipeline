select
    product_id,
    product_name,
    category,
    cast(cost as numeric) as cost
from {{ source('raw', 'raw_products') }}
where product_id is not null