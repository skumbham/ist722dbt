-- This model selects data from the 'Playlist' and 'Playlisttrack' sources and generates surrogate keys.

-- Define a staging table for the 'Playlist' source data with the minimum PlaylistId per Name.
with stg_playlist as (
    SELECT MIN(Playlistid) AS Playlistid, Name 
    FROM {{ source('chinook', 'Playlist') }} 
    GROUP BY Name
),
-- Define a staging table for the 'Playlisttrack' source data with the minimum PlaylistId per TrackId.
stg_playlisttrack as (
    SELECT Trackid, MIN(Playlistid) AS Playlistid 
    FROM {{ source('chinook', 'Playlisttrack') }} 
    GROUP BY TrackId
)
-- Select and generate surrogate keys for tracks and playlists.
SELECT 
    -- Generate a surrogate key for the 'TrackId' column.
    {{ dbt_utils.generate_surrogate_key(['pt.TrackId']) }} AS trackkey, 
    -- Generate a surrogate key for the 'Playlistid' column.
    {{ dbt_utils.generate_surrogate_key(['pl.Playlistid']) }} AS Playlistkey,
    -- Select the original 'TrackId' column.
    pt.TrackId,
    -- Select the original 'Playlistid' column.
    pl.Playlistid,
    -- Alias the 'Name' column as 'Playlist_Name'.
    pl.Name AS Playlist_Name 
FROM stg_playlist pl 
-- Join the 'stg_playlist' and 'stg_playlisttrack' staging tables on 'Playlistid'.
JOIN stg_playlisttrack pt ON pt.Playlistid = pl.Playlistid
