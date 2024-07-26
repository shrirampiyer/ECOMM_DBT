{{
    config(
        materialized='view'
    )
}}

SELECT 
CUSTOMER_ID,
INITCAP(FIRST_NAME) AS FIRST_NAME,
INITCAP(LAST_NAME) AS LAST_NAME,
EMAIL,
PHONE_NUMBER, 
CONCAT(SUBSTRING(ADDRESS,1,3),',',' ',SUBSTRING(ADDRESS,5)) as ADDRESS,
CITY,
STATE,
COUNTRY,
CONCAT(SUBSTRING(POSTAL_CODE,1,2),'-',SUBSTRING(POSTAL_CODE,3,6) )AS POSTAL_CODE,
LOAD_TIMESTAMP
FROM
{{ ref('LL_CUSTOMERS') }}
