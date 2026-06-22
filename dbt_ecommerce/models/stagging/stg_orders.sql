select
    order_id,
    customer_id,
    cast(order_date as date) as order_date,

    case
        when lower(status) in ('completed', 'complete') then 'completed'
        when lower(status) in ('cancelled', 'canceled') then 'cancelled'
        when lower(status) = 'pending' then 'pending'
        else 'unknown'
    end as order_status

from {{ source('raw', 'raw_orders') }}
where order_id is not null