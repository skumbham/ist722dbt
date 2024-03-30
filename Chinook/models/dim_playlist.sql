with stg_playlistt as (
    SELECT MIN(Playlistid) AS Playlistid, Name from {{ source('chinook', 'Playlist') }} GROUP BY Name
)
select {{ dbt_utils.generate_surrogate_key(['p.Playlistid']) }} as Playlistkey,Playlistid, Name
from stg_playlistt p 
group by Playlistid,Name