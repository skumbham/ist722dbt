-- monthly_song_sales_fact.sql

{{ config(materialized='table') }}

SELECT
    st.TrackId,
    st.TrackName,
    DATE_TRUNC('month', inv.InvoiceDate) AS SaleMonth,
    SUM(il.Quantity) AS MonthlyQuantity,
    SUM(il.Quantity * il.UnitPrice) AS MonthlySalesAmount
FROM {{ ref('stg_invoiceline') }} il
JOIN {{ ref('stg_invoice') }} inv ON il.InvoiceId = inv.InvoiceId
JOIN {{ ref('stg_track') }} st ON il.TrackId = st.TrackId
GROUP BY st.TrackId, st.TrackName, DATE_TRUNC('month', inv.InvoiceDate)
