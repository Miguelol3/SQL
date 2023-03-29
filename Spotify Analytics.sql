-- For the following exploration, I downloaded the 'Spotify Top 50 Songs in 2021' dataset from Kaggle.
-- Source: https://www.kaggle.com/datasets/equinxx/spotify-top-50-songs-in-2021
-- I started by creating a table and then inserted the data into it via the import tool in SQLiteStudio.

-- Table Creation:
CREATE TABLE master_db.Spotifydata (
  id INTEGER PRIMARY KEY,
  artist_name VARCHAR NOT NULL,
  track_name VARCHAR NOT NULL,
  track_id VARCHAR NOT NULL,
  popularity INTEGER NOT NULL,
  danceability DECIMAL(4,3) NOT NULL,
  energy DECIMAL(4,3) NOT NULL,
  song_key INTEGER NOT NULL,
  loudness DECIMAL(5,3) NOT NULL,
  song_mode INTEGER NOT NULL,
  speechiness DECIMAL(5,4) NOT NULL,
  acousticness DECIMAL(6,5) NOT NULL,
  instrumentalness DECIMAL(8,7) NOT NULL,
  liveness DECIMAL(5,4) NOT NULL,
  valence DECIMAL(4,3) NOT NULL,
  tempo DECIMAL(6,3) NOT NULL,
  duration_ms INTEGER NOT NULL,
  time_signature INTEGER NOT NULL);
  

-- #1. Which 3 artists were the most 'successful' in 2021?
SELECT artist_name, COUNT(*) FROM spotifydata
GROUP BY artist_name
ORDER BY 2 DESC
LIMIT 3;


-- #2. I feel like throwing a small gathering, which songs performed better than average in terms of danceability and energy?
SELECT
artist_name
,track_name
,popularity
,danceability
,energy
FROM spotifydata 
WHERE danceability > (SELECT AVG(danceability) FROM spotifydata)
AND energy > (SELECT AVG(energy) FROM spotifydata)
ORDER BY 3 DESC;


-- #3. Okay, I made the list - how many hours of music did I end up with?
SELECT SUM (duration_ms) / 60000 AS minutes FROM spotifydata
WHERE danceability > (SELECT AVG(danceability) FROM spotifydata)
AND energy > (SELECT AVG(energy) FROM spotifydata)
/* Only 59 minutes! It seems like we can only have a pregame, not a full on party :( */


-- #4. Calculate the average popularity by artist, and then assign those who have an average above 90 as a 'Top Star'
WITH pop_calc AS (
SELECT artist_name, avg(popularity) AS avg_pop FROM spotifydata
GROUP BY 1)

SELECT
artist_name
,avg_pop
,'Top Star' AS Tag
FROM pop_calc
WHERE avg_pop > 90
ORDER BY 2 DESC;
