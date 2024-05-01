-- obt.sql

{{ config(materialized='table') }}

SELECT
    a.ArtistId,
    a.Name AS ArtistName,
    t.TrackId,
    t.TrackName,
    t.AlbumId,
    al.Title AS AlbumName,
    t.MediaTypeId,
    t.GenreId,
    t.Composer,
    t.Milliseconds,
    t.Bytes,
    t.UnitPrice AS TrackUnitPrice,
    fs.SaleQuantity,
    fs.TotalSalesRevenue,
    ms.SaleMonth,
    ms.MonthlyQuantity,
    ms.MonthlySalesAmount
FROM {{ ref('stg_artist') }} a
LEFT JOIN {{ ref('stg_album') }} al ON a.ArtistId = al.ArtistId
LEFT JOIN {{ ref('stg_track') }} t ON al.AlbumId = t.AlbumId
LEFT JOIN {{ ref('fact_sales') }} fs ON t.TrackId = fs.TrackId
LEFT JOIN {{ ref('monthly_song_sales_fact') }} ms ON t.TrackId = ms.TrackId
GROUP BY
    a.ArtistId, a.Name, t.TrackId, t.TrackName, t.AlbumId, t.MediaTypeId,
    t.GenreId, t.Composer, t.Milliseconds, t.Bytes, t.UnitPrice, al.Title,
    fs.SaleQuantity, fs.TotalSalesRevenue, ms.SaleMonth, ms.MonthlyQuantity, ms.MonthlySalesAmount
