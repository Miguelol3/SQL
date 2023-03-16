-- For this project, I queried a database that contains two tables with Netflix Data. 
-- Table 1: Netflix People - contains (1) show_id (2) director and (3) cast
-- Table 2: Netflix Titles - contains (1) show_id and more information about 5000+ movies/shows

#1 - How many movie titles are there in the database? (movies only)
SELECT COUNT(*) FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
WHERE type = 'Movie';


#2 - When was the most recent batch of tv shows and/or movies added to the database?
SELECT MAX(DATE(date_added)) FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
WHERE date_added IS NOT NULL;


#3 - List all the movies and tv shows in alphabetical order.
SELECT title FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
ORDER BY 1 ASC;


#4 - Who was the Director for the movie Bright Star?
SELECT
  np.director
  ,nt.title
FROM "CharlotteChaze/BreakIntoTech"."netflix_people" AS np
LEFT JOIN "CharlotteChaze/BreakIntoTech"."netflix_titles_info" AS nt ON nt.show_id = np.show_id
WHERE nt.title = 'Bright Star'


#5 - What is the oldest movie in the database and what year was it made?
SELECT
  title
  ,release_year
FROM "CharlotteChaze/BreakIntoTech"."netflix_titles_info"
WHERE type = 'Movie'
ORDER BY 2 ASC
LIMIT 1;
