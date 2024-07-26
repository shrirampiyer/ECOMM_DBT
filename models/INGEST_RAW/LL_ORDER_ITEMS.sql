{{ config(
    materialized='incremental',
    unique_key='ORDER_ITEM_ID'
) }}

with staged_data as (
   select
        $1 as ORDER_ITEM_ID,
        $2 AS ORDER_ID,
        $3 AS PRODUCT_ID,
        $4 AS QUANTITY,
        $5 AS PRICE,
        current_timestamp() as LOAD_TIMESTAMP
FROM @EXT_ORD_ITEMS_STG (FILE_FORMAT => 'my_csv_format')
    {% if is_incremental() %}
    where load_timestamp > (select max(load_timestamp) from {{ this }})
    {% endif %})

SELECT * FROM staged_data