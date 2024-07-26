{{
    config(
        materialized='view'
    )
}}

SELECT * FROM {{ ref('LL_CATEGORY') }}