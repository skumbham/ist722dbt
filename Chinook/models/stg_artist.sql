-- stg_artist.sql

{{ config(materialized='view') }}

SELECT
    ArtistId,
    TRIM(Name) AS Name  -- Removes any leading/trailing spaces in the artist name
FROM {{ source('chinook', 'Artist') }}
