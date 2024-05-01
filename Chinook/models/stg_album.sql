-- stg_album.sql

{{ config(materialized='view') }}

SELECT
    AlbumId,
    TRIM(Title) AS Title,  -- Ensures no leading or trailing spaces in the album title
    ArtistId
FROM {{ source('chinook', 'Album') }}
