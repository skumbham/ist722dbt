-- This model selects data from the 'Track', 'Genre', 'MediaType', and 'Album' sources and generates surrogate keys.

-- Define staging tables for the 'Track', 'Genre', 'MediaType', and 'Album' sources.
with 
stg_track as (
    select * from {{ source('chinook','Track')}}
),
stg_genre as (
    select * from {{ source('chinook','genre')}}
),
stg_mediatype as (
    select * from {{ source('chinook','mediatype')}}
),
stg_album as (
    select * from {{ source('chinook','Album')}}
)
-- Select and generate surrogate keys for tracks, joining with genre, media type, and album information.
select 
    -- Generate a surrogate key for the 'TrackId' column.
    {{ dbt_utils.generate_surrogate_key(['tr.TrackId']) }} as trackkey, 
    -- Select the original 'TrackId' column.
    tr.TrackId, 
    -- Alias the 'Name' column as 'Song_Name'.
    tr.Name as Song_Name, 
    -- Alias the 'title' column from 'Album' as 'album_name'.
    al.title as album_name, 
    -- Select the 'ArtistId' column from 'Album'.
    al.ArtistId, 
    -- Select the 'Name' column from 'Genre'.
    g.Name as Genre, 
    -- Select the 'Name' column from 'MediaType'.
    mt.Name as MediaType, 
    -- Select the 'Composer' column.
    Composer,
    -- Select the 'Milliseconds' column.
    Milliseconds,
    -- Select the 'Bytes' column.
    Bytes,
    -- Select the 'UnitPrice' column.
    UnitPrice,
    -- Calculate 'Minutes' from 'Milliseconds'.
    (Milliseconds/60000) as Minutes  
from 
    -- Join 'stg_track' with 'stg_genre', 'stg_mediatype', and 'stg_album'.
    stg_track tr
    -- Left join 'stg_genre' on 'GenreId'.
    left join stg_genre g on g.GenreId = tr.GenreId
    -- Left join 'stg_mediatype' on 'MediaTypeId'.
    left join stg_mediatype mt on mt.MediaTypeId = tr.MediaTypeId 
    -- Left join 'stg_album' on 'AlbumId'.
    left join stg_album al on al.AlbumId = tr.AlbumId
