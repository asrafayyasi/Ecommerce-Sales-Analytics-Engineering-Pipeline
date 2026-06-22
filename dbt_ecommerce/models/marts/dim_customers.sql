{{ config(materialized='table') }}

select
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.signup_date,

    coalesce(s.total_orders, 0) as total_orders,
    s.first_order_date,
    s.last_order_date,

    case
        when coalesce(s.total_orders, 0) >= 3 then 'loyal_customer'
        when coalesce(s.total_orders, 0) = 1 then 'new_customer'
        when coalesce(s.total_orders, 0) = 2 then 'repeat_customer'
        else 'no_order'
    end as customer_segment

from {{ ref('stg_customers') }} c
left join {{ ref('int_customer_order_summary') }} s
    on c.customer_id = s.customer_id