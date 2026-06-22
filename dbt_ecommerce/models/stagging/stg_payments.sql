select
    payment_id,
    order_id,
    payment_method,
    cast(payment_amount as numeric) as payment_amount,

    case
        when lower(payment_status) = 'paid' then 'paid'
        when lower(payment_status) = 'failed' then 'failed'
        when lower(payment_status) = 'pending' then 'pending'
        else 'unknown'
    end as payment_status

from {{ source('raw', 'raw_payments') }}
where payment_id is not null