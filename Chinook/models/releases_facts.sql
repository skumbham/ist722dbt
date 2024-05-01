-- releases_fact.sql

WITH artist_albums AS (
    SELECT
        ar.ArtistId,
        ar.Name AS ArtistName,
        COUNT(DISTINCT al.AlbumId) AS AlbumsReleased
    FROM {{ source('chinook', 'Artist') }} ar
    JOIN {{ source('chinook', 'Album') }} al ON ar.ArtistId = al.ArtistId
    GROUP BY ar.ArtistId, ar.Name
),
artist_tracks AS (
    SELECT
        ar.ArtistId,
        COUNT(DISTINCT tr.TrackId) AS TracksReleased
    FROM {{ source('chinook', 'Artist') }} ar
    JOIN {{ source('chinook', 'Album') }} al ON ar.ArtistId = al.ArtistId
    JOIN {{ source('chinook', 'Track') }} tr ON al.AlbumId = tr.AlbumId
    GROUP BY ar.ArtistId
)
SELECT
    aa.ArtistName,
    aa.AlbumsReleased,
    at.TracksReleased
FROM artist_albums aa
JOIN artist_tracks at ON aa.ArtistId = at.ArtistId
