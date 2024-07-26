{{ config(
    materialized='incremental',
    unique_key='CATEGORY_ID'
) }}

with staged_data as (
   select
        $1 as CATEGORY_ID,
        $2 AS CATEGORY_NAME,
        current_timestamp() as LOAD_TIMESTAMP
FROM @EXT_CATEGORY_STG (FILE_FORMAT => 'my_csv_format')
    {% if is_incremental() %}
    where load_timestamp > (select max(load_timestamp) from {{ this }})
    {% endif %})

SELECT * FROM staged_data