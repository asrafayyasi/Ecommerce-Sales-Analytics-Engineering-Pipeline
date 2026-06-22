{{ config(materialized='table') }}

select
    product_id,
    product_name,
    category,
    cost
from {{ ref('stg_products') }}