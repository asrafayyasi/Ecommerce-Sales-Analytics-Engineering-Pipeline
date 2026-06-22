select
    order_id,
    sum(refund_amount) as refund_amount,
    count(refund_id) as total_refunds
from {{ ref('stg_refunds') }}
group by order_id