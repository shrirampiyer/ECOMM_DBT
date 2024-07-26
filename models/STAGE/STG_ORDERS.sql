{{
    config(
        materialized='view'
    )
}}

SELECT 
ORDER_ID,
CUSTOMER_ID,
TO_DATE(ORDER_DATE,'YYYY-MM-DD') AS ORDER_DATE,
TOTAL_AMOUNT :: FLOAT AS TOTAL_AMOUNT,
CONCAT(SUBSTRING(SHIPPING_ADDRESS,1,3),',',' ',SUBSTRING(SHIPPING_ADDRESS,5)) as SHIPPING_ADDRESS,
CITY,
STATE,
COUNTRY,
CONCAT(SUBSTRING(POSTAL_CODE,1,2),'-',SUBSTRING(POSTAL_CODE,3,6) )AS POSTAL_CODE,
LOAD_TIMESTAMP
FROM {{ ref('LL_ORDERS') }}