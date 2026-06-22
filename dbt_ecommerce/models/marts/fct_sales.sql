{{ config(materialized='table') }}

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,

    p.payment_method,
    p.total_payment_amount,
    p.has_paid_payment,

    r.gross_revenue,
    coalesce(f.refund_amount, 0) as refund_amount,
    r.gross_revenue - coalesce(f.refund_amount, 0) as net_revenue,

    r.total_quantity,
    r.total_items

from {{ ref('stg_orders') }} o
left join {{ ref('int_order_revenue') }} r
    on o.order_id = r.order_id
left join {{ ref('int_order_refunds') }} f
    on o.order_id = f.order_id
left join {{ ref('int_order_payments') }} p
    on o.order_id = p.order_id
where o.order_status = 'completed'