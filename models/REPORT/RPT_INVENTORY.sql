{{
    config(
        materialized='table'
    )
}}

SELECT
    P.PRODUCT_ID,
    P.PRODUCT_NAME,
    P.PRICE AS UNIT_PRICE,
    CT.CATEGORY_NAME,
    SUM(OI.QUANTITY) AS SOLD_QUANTITY,
    P.STOCK_QUANTITY - SUM(OI.QUANTITY) AS STOCK_INVENTORY,
    SUM(OI.QUANTITY) * P.PRICE AS REVENUE
FROM
    {{ ref('STG_PRODUCTS') }} AS P 
LEFT JOIN 
    {{ ref('STG_ORDER_ITEMS') }} AS OI 
    ON P.PRODUCT_ID = OI.PRODUCT_ID
LEFT JOIN 
    {{ ref('STG_CATEGORY') }} AS CT
    ON P.CATEGORY_ID = CT.CATEGORY_ID
GROUP BY 
    P.PRODUCT_ID,
    P.PRODUCT_NAME,
    P.PRICE,
    CT.CATEGORY_NAME,
    P.STOCK_QUANTITY
