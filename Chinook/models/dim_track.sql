-- dim_track.sql
SELECT
    trackid,
    name AS song_name,
    genreid AS genre,  -- Join needed with genre table if genre name is required
    mediatypeid AS mediatype,  -- Join needed with mediatype table if media type name is required
    composer,
    milliseconds,
    bytes,
    unitprice AS unit_price,
    trackid AS trackkey  -- Assuming trackkey is a surrogate key generated elsewhere
FROM {{ source('chinook', 'Track') }}