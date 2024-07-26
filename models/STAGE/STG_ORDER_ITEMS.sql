{{
    config(
        materialized='view'
    )
}}

SELECT
ORDER_ITEM_ID,
ORDER_ID,
PRODUCT_ID,
QUANTITY :: INT AS QUANTITY,
LOAD_TIMESTAMP
FROM 
{{ ref('LL_ORDER_ITEMS') }}