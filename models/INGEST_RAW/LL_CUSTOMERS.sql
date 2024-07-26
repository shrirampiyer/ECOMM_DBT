{{ config(
    materialized='incremental',
    unique_key='CUSTOMER_ID'
) }}

with staged_data as (
   select
        $1 as CUSTOMER_ID,
        $2 AS FIRST_NAME,
        $3 AS LAST_NAME,
        $4 AS EMAIL,
        $5 AS PHONE_NUMBER,
        $6 AS ADDRESS,
        $7 AS CITY,
        $8 AS STATE,
        $9 AS COUNTRY,
        $10 AS POSTAL_CODE,
        current_timestamp() as LOAD_TIMESTAMP
FROM @EXT_CUST_STG (FILE_FORMAT => 'my_csv_format')
    {% if is_incremental() %}
    where load_timestamp > (select max(load_timestamp) from {{ this }})
    {% endif %})


select
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    ADDRESS,
    CITY,
    STATE,
    COUNTRY,
    POSTAL_CODE,
    load_timestamp
from staged_data
