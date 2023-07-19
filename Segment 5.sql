-- Segment 5: Crew Analysis
-- -	Identify the columns in the names table that have null values.
-- -	Determine the top three directors in the top three genres with movies having an average rating > 8.
-- -	Find the top two actors whose movies have a median rating >= 8.
-- -	Identify the top three production houses based on the number of votes received by their movies.
-- -	Rank actors based on their average ratings in Indian movies released in India.
-- -	Identify the top five actresses in Hindi movies released in India based on their average ratings.
select * from names;

use imdb;

-- -	Identify the columns in the names table that have null values.

-- SELECT COUNT(*) AS Id_null
-- FROM names
-- WHERE id IS NULL;

-- SELECT COUNT(*) AS Name_null
-- FROM names
-- WHERE name IS NULL;

-- SELECT COUNT(*) AS Height_null
-- FROM names
-- WHERE height IS NULL;

-- SELECT COUNT(*) AS DOB_null
-- FROM names
-- WHERE date_of_birth IS NULL;

-- SELECT COUNT(*) AS known_for_movies_null
-- FROM names
-- WHERE known_for_movies IS NULL;

SELECT
( SELECT COUNT(*)  FROM names WHERE id IS NULL) AS Title_null,
( SELECT COUNT(*)  FROM names WHERE name IS NULL) AS Name_null,
( SELECT COUNT(*)  FROM names WHERE height IS NULL) AS Height_null,
( SELECT COUNT(*)  FROM names WHERE date_of_birth IS NULL) AS DOB_null,
( SELECT COUNT(*)  FROM names WHERE known_for_movies IS NULL) AS known_for_movies_null;


-- -	Identify the top three production houses based on the number of votes received by their movies
SELECT m.production_company AS Production_House, r.total_votes as Vots
FROM movie AS m 
JOIN ratings AS r ON r.movie_id =  m.id
ORDER BY total_votes DESC
LIMIT 3;

-- Determine the top three directors in the top three genres with movies having an average rating > 8

SELECT n.name AS Director_name, g.genre as Genre, AVG(r.avg_rating) AS Average_rating
FROM names n
JOIN director_mapping dm ON dm.name_id = n.id
JOIN movie m ON m.id = dm.movie_id
JOIN genre g ON g.movie_id = m.id
JOIN ratings r ON r.movie_id = m.id
WHERE r.avg_rating > 8
GROUP BY n.name, g.genre
ORDER BY average_rating DESC
LIMIT 3;

-- Find the top two actors whose movies have a median rating >= 8

SELECT n.name as Actor_name, r.median_rating as Median_Rating
FROM names AS n
INNER JOIN role_mapping AS a ON n.id = a.name_id
INNER JOIN movie AS m ON a.movie_id = m.id
INNER JOIN ratings AS r ON m.id = r.movie_id
WHERE r.median_rating >= 8 AND a.category = 'actor'
ORDER BY median_rating DESC
LIMIT 2;

-- Rank actors based on their average ratings in Indian movies released in India.

SELECT n.name, r.avg_rating AS average_rating
FROM names n
JOIN role_mapping rm ON n.id = rm.name_id
JOIN ratings r ON rm.movie_id = r.movie_id
JOIN movie m ON r.movie_id = m.id
WHERE m.country = 'India'
GROUP BY n.name, r.avg_rating
ORDER BY average_rating DESC;


-- -	Identify the top five actresses in Hindi movies released in India based on their average ratings
SELECT n.name, AVG(r.avg_rating) AS Average_rating
FROM names n
JOIN role_mapping rm ON n.id = rm.name_id
JOIN movie m ON rm.movie_id = m.id
JOIN ratings r ON m.id = r.movie_id
WHERE rm.category = 'actress' AND m.languages = 'Hindi' AND m.country = 'India'
GROUP BY n.name
ORDER BY average_rating DESC
LIMIT 5;