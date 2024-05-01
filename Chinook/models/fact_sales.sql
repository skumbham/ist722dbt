-- fact_sales.sql

{{ config(materialized='table') }}

SELECT
    st.TrackId,
    st.TrackName,
    SUM(il.Quantity) AS SaleQuantity,
    SUM(il.Quantity * il.UnitPrice) AS TotalSalesRevenue
FROM {{ ref('stg_invoiceline') }} il
JOIN {{ ref('stg_track') }} st ON il.TrackId = st.TrackId
GROUP BY st.TrackId, st.TrackName
