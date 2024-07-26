{{ config(
    materialized='incremental',
    unique_key='ORDER_ID'
) }}
with staged_data as (
    select
        $1 as ORDER_ID,
        $2 AS CUSTOMER_ID,
        $3 AS ORDER_DATE,
        $4 AS TOTAL_AMOUNT,
        $5 AS SHIPPING_ADDRESS,
        $6 AS CITY,
        $7 AS STATE,
        $8 AS COUNTRY,
        $9 AS POSTAL_CODE,
        current_timestamp() as load_timestamp
FROM @EXT_ORD_STG (FILE_FORMAT => 'my_csv_format')
    {% if is_incremental() %}
    where load_timestamp > (select max(load_timestamp) from {{ this }})
    {% endif %})

select * from staged_data