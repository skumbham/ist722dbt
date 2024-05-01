-- dim_artist.sql
SELECT
    artistid,
    name AS artist_name,
    artistid AS artistkey  -- Assuming artistkey is a surrogate key generated elsewhere
FROM {{ source('chinook', 'Artist') }}