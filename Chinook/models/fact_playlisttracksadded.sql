with stg_track as (
    select * from {{ source('chinook','Track')}}
),stg_playlist as (
    SELECT MIN(PlaylistId) as PlaylistId, Name 
FROM {{ source('chinook', 'Playlist') }}
GROUP BY Name
),
stg_playlisttrack as (
    select Trackid, min(Playlistid) as Playlistid from {{ source('chinook', 'Playlisttrack') }} group by TrackId
)
SELECT {{ dbt_utils.generate_surrogate_key(['p.Playlistid']) }} as playlistkey, 
        {{ dbt_utils.generate_surrogate_key(['t.TrackId']) }} as trackkey,
        p.Playlistid, t.TrackId, p.Name as playlist_name, 
        case when t.TrackId is not null and p.Playlistid is not null  then '1' else '0' end  AS Tracks_added
FROM stg_playlisttrack pt
right JOIN stg_playlist p ON p.Playlistid = pt.Playlistid
left JOIN stg_track t ON pt.TrackId = t.TrackId