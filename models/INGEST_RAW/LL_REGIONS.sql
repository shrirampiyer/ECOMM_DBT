{{ config(
    materialized='incremental',
    unique_key='REGION_ID'
) }}

with staged_data as (
   select
        $1 as REGION_ID,
        $2 AS REGION_NAME,
        $3 AS COUNTRY,
        current_timestamp() as LOAD_TIMESTAMP
FROM @EXT_REGIONS_STG (FILE_FORMAT => 'my_csv_format')
    {% if is_incremental() %}
    where load_timestamp > (select max(load_timestamp) from {{ this }})
    {% endif %})

SELECT * FROM staged_data
