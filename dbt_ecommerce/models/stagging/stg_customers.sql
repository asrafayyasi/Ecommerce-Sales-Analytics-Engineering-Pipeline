select
    customer_id,
    customer_name,
    lower(email) as email,
    city,
    cast(signup_date as date) as signup_date
from {{ source('raw', 'raw_customers') }}
where customer_id is not null