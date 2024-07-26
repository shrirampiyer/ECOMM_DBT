{{
    config(
        materialized='view'
    )
}}

SELECT
REGION_ID,
INITCAP(REGION_NAME) as REGION_NAME,
INITCAP(COUNTRY) AS COUNTRY
FROM 
{{ ref('LL_REGIONS') }}