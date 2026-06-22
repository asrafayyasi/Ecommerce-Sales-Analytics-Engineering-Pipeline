select
    refund_id,
    order_id,
    cast(refund_amount as numeric) as refund_amount,
    cast(refund_date as date) as refund_date,
    refund_reason
from {{ source('raw', 'raw_refunds') }}
where refund_id is not null