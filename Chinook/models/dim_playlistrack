with stg_playlist as (
    SELECT MIN(Playlistid) AS Playlistid, Name from {{ source('chinook', 'Playlist') }} GROUP BY Name
),
stg_playlisttrack as (
    select Trackid, min(Playlistid) as Playlistid from {{ source('chinook', 'Playlisttrack') }} group by TrackId
)
select {{ dbt_utils.generate_surrogate_key(['pt.TrackId']) }} as trackkey, 
        {{ dbt_utils.generate_surrogate_key(['pl.Playlistid']) }} as Playlistkey ,
         pt.TrackId,pl.Playlistid,pl.Name as Playlist_Name 
from stg_playlist pl 
join stg_playlisttrack pt on pt.Playlistid= pl.Playlistid