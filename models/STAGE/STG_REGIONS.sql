{{
    config(
        materialized='view'
    )
}}

SELECT
REGION_ID,
INITCAP(REGION_NAME),
INITCAP(COUNTRY)
FROM 
{{ ref('LL_REGIONS') }}