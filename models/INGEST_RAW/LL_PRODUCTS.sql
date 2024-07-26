{{ config(
    materialized='incremental',
    unique_key='PRODUCT_ID'
) }}

with staged_data as (
   select
        $1 as PRODUCT_ID,
        $2 AS PRODUCT_NAME,
        $3 AS CATEGORY_ID,
        $4 AS PRICE,
        $5 AS STOCK_QUANTITY,
        current_timestamp() as LOAD_TIMESTAMP
FROM @EXT_PRODUCTS_STG (FILE_FORMAT => 'my_csv_format')
    {% if is_incremental() %}
    where load_timestamp > (select max(load_timestamp) from {{ this }})
    {% endif %})

SELECT * FROM staged_data