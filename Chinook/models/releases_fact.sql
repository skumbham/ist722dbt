-- releases_fact.sql

{{ config(materialized='table') }}

WITH album_counts AS (
    SELECT
        ArtistId,
        COUNT(AlbumId) AS AlbumReleaseCount
    FROM {{ ref('stg_album') }}
    GROUP BY ArtistId
),
track_counts AS (
    SELECT
        alb.ArtistId,
        COUNT(trk.TrackId) AS TrackReleaseCount
    FROM {{ ref('stg_track') }} trk
    JOIN {{ ref('stg_album') }} alb ON trk.AlbumId = alb.AlbumId
    GROUP BY alb.ArtistId
)
SELECT
    a.Name AS ArtistName,
    COALESCE(ac.AlbumReleaseCount, 0) AS AlbumReleaseCount,
    COALESCE(tc.TrackReleaseCount, 0) AS TrackReleaseCount
FROM {{ ref('stg_artist') }} a
LEFT JOIN album_counts ac ON a.ArtistId = ac.ArtistId
LEFT JOIN track_counts tc ON a.ArtistId = tc.ArtistId
