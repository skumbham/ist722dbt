-- This model selects data from the 'Track', 'Album', 'Genre', and 'Artist' sources and generates surrogate keys.

-- Define a staging table for the 'Track', 'Album', and 'Genre' sources.
with 
stg_trackgeal as (
    select 
        -- Select all columns from the 'Track' source.
        t.*, 
        -- Alias the 'Name' column from 'Genre' as 'Genre_name'.
        ge.Name as Genre_name, 
        -- Select the 'title' column from 'Album'.
        a.title, 
        -- Select the 'ArtistId' column from 'Album'.
        a.ArtistId  
    from 
        {{ source('chinook','Track')}}  t 
    -- Left join 'Album' on 'albumid'.
    Left join   {{ source('chinook','Album')}} a on a.albumid = t.albumid
    -- Left join 'Genre' on 'genreid'.
    left join  {{ source('chinook','genre')}} ge on ge.genreid = t.genreid 
),
-- Define a staging table for the 'Artist' source data.
stg_artist as (
    select * from {{ source('chinook','Artist')}}
)
-- Select and generate surrogate keys for artists and tracks, joining with track, album, genre, and artist information.
select 
    -- Generate a surrogate key for the 'ArtistId' column.
    {{ dbt_utils.generate_surrogate_key(['a.ArtistId']) }} as artistkey, 
    -- Generate a surrogate key for the 'TrackId' column.
    {{ dbt_utils.generate_surrogate_key(['tgl.TrackId']) }} as trackkey,
    -- Select the original 'TrackId' column.
    tgl.TrackId, 
    -- Select the original 'ArtistId' column from 'Album'.
    a.ArtistId,
    -- Select the original 'AlbumId' column from 'Track'.
    tgl.AlbumId, 
    -- Alias the 'Name' column from 'Track' as 'Song_Name'.
    tgl.Name as Song_Name, 
    -- Alias the 'Name' column from 'Artist' as 'Artist_name'.
    a.Name as Artist_name, 
    -- Select the 'Genre_name' column from 'stg_trackgeal'.
    tgl.Genre_name,
    -- Generate a flag to indicate if the song has been released.
    case 
        -- Check if 'TrackId' and 'ArtistId' are not null.
        when tgl.TrackId is not null and a.ArtistId is not null then '1' 
        else '0' 
    end as Song_releases
-- Join 'stg_artist' with 'stg_trackgeal'.
from 
    stg_artist a 
    -- Left join 'stg_trackgeal' on 'ArtistId'.
    left join stg_trackgeal tgl on a.ArtistId = tgl.ArtistId
