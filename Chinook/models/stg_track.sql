-- stg_track.sql

{{ config(materialized='view') }}

SELECT
    TrackId,
    Name AS TrackName,
    AlbumId,
    MediaTypeId,
    GenreId,
    Composer,
    Milliseconds,
    Bytes,
    CAST(UnitPrice AS FLOAT) AS UnitPrice  -- Ensures the price is in a float format
FROM {{ source('chinook', 'Track') }}
