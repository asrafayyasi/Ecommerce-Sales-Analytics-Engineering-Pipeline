select
    order_id,
    sum(payment_amount) as total_payment_amount,

    max(case
        when payment_status = 'paid' then 1
        else 0
    end) as has_paid_payment,

    max(payment_method) as payment_method

from {{ ref('stg_payments') }}
group by order_id