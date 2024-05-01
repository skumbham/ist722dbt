SELECT
    playlistid,
    name AS playlist_name
FROM {{ source('chinook', 'Playlist') }}