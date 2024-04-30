-- This model selects data from the 'Playlist' source and generates surrogate keys.

-- Define a staging table for the 'Playlist' source data with the minimum PlaylistId per Name.
with stg_playlistt as (
    SELECT MIN(Playlistid) AS Playlistid, Name 
    FROM {{ source('chinook', 'Playlist') }} 
    GROUP BY Name
)

-- Select and generate surrogate keys for playlists.
select 
    -- Generate a surrogate key for the 'Playlistid' column.
    {{ dbt_utils.generate_surrogate_key(['p.Playlistid']) }} as Playlistkey,
    -- Select the original 'Playlistid' column.
    Playlistid, 
    -- Select the 'Name' column.
    Name
from stg_playlistt p 
-- Group by Playlistid and Name.
group by Playlistid, Name
