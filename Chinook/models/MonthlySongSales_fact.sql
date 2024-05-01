-- MonthlySongSales_fact.sql

WITH monthly_sales AS (
    SELECT
        il.TrackId,
        DATE_TRUNC('month', CAST(i.InvoiceDate AS DATE)) AS SaleMonth,
        SUM(il.Quantity) AS MonthlyQuantity,
        SUM(il.Quantity * il.UnitPrice) AS MonthlySalesAmount
    FROM {{ source('chinook', 'invoiceline') }} il
    JOIN {{ source('chinook', 'invoice') }} i ON il.InvoiceId = i.InvoiceId
    GROUP BY il.TrackId, DATE_TRUNC('month', CAST(i.InvoiceDate AS DATE))
),
track_details AS (
    SELECT
        tr.TrackId,
        tr.Name AS TrackName
    FROM {{ source('chinook', 'Track') }} tr
)
SELECT
    td.TrackName,
    ms.SaleMonth,
    ms.MonthlyQuantity,
    ms.MonthlySalesAmount
FROM monthly_sales ms
JOIN track_details td ON ms.TrackId = td.TrackId
ORDER BY ms.SaleMonth, td.TrackName
