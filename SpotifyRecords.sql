select * from artists_details

select * from playlist_details

select * from track_audio_features

select artist_id,artist_name,song_name,MAX(popularity) from artists_details a
inner join playlist_details p
on a.song_id = p.song_id
group by artist_id,artist_name,song_name
order by MAX(popularity) desc
