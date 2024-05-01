-- fact_sales.sql

WITH sales_data AS (
    SELECT
        il.TrackId,
        SUM(il.Quantity) AS QuantitySold,
        SUM(il.Quantity * il.UnitPrice) AS TotalSalesRevenue
    FROM {{ source('chinook', 'invoiceline') }} il
    GROUP BY il.TrackId
),
track_info AS (
    SELECT
        t.TrackId,
        t.Name AS TrackName,
        a.ArtistId,
        a.Name AS ArtistName
    FROM {{ source('chinook', 'Track') }} t
    JOIN {{ source('chinook', 'Album') }} al ON t.AlbumId = al.AlbumId
    JOIN {{ source('chinook', 'Artist') }} a ON al.ArtistId = a.ArtistId
)
SELECT
    ti.TrackName,
    ti.ArtistName,
    sd.QuantitySold,
    sd.TotalSalesRevenue
FROM sales_data sd
JOIN track_info ti ON sd.TrackId = ti.TrackId