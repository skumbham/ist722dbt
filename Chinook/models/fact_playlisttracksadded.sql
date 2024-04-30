-- This model selects data from the 'Track', 'Playlist', and 'Playlisttrack' sources and generates surrogate keys.

-- Define a staging table for the 'Track' source data.
with 
stg_track as (
    select * from {{ source('chinook','Track')}}
),
-- Define a staging table for the 'Playlist' source data with the minimum PlaylistId per Name.
stg_playlist as (
    SELECT MIN(PlaylistId) as PlaylistId, Name 
    FROM {{ source('chinook', 'Playlist') }}
    GROUP BY Name
),
-- Define a staging table for the 'Playlisttrack' source data with the minimum PlaylistId per TrackId.
stg_playlisttrack as (
    select Trackid, min(Playlistid) as Playlistid 
    from {{ source('chinook', 'Playlisttrack') }} 
    group by TrackId
)
-- Select and generate surrogate keys for playlists and tracks, joining with playlist and track information.
SELECT 
    -- Generate a surrogate key for the 'Playlistid' column.
    {{ dbt_utils.generate_surrogate_key(['p.Playlistid']) }} as playlistkey, 
    -- Generate a surrogate key for the 'TrackId' column.
    {{ dbt_utils.generate_surrogate_key(['t.TrackId']) }} as trackkey,
    -- Select the original 'Playlistid' column.
    p.Playlistid, 
    -- Select the original 'TrackId' column.
    t.TrackId, 
    -- Alias the 'Name' column from 'Playlist' as 'playlist_name'.
    p.Name as playlist_name, 
    -- Generate a flag to indicate if tracks are added to the playlist.
    case 
        -- Check if 'TrackId' and 'Playlistid' are not null.
        when t.TrackId is not null and p.Playlistid is not null  then '1' 
        else '0' 
    end  AS Tracks_added
-- Right join 'stg_playlisttrack' with 'stg_playlist'.
FROM stg_playlisttrack pt
-- Right join 'stg_playlist' with 'stg_playlisttrack' on 'Playlistid'.
right JOIN stg_playlist p ON p.Playlistid = pt.Playlistid
-- Left join 'stg_track' with 'stg_playlisttrack' on 'TrackId'.
left JOIN stg_track t ON pt.TrackId = t.TrackId
