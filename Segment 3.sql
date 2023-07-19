-- Segment 3: Production Statistics and Genre Analysis
-- -	Retrieve the unique list of genres present in the dataset.
-- -	Identify the genre with the highest number of movies produced overall.
-- -	Determine the count of movies that belong to only one genre.
-- -	Calculate the average duration of movies in each genre.
-- -	Find the rank of the 'thriller' genre among all genres in terms of the number of movies produced.
USE imdb;

-- select * from genre;


-- Retrieve the unique list of genres present in the dataset. 
SELECT DISTINCT genre
FROM genre;


-- Identify the genre with the highest number of movies produced overall
SELECT g.genre, count(*) AS count
FROM movie AS m
JOIN genre AS g
ON m.id = g.movie_id
GROUP BY genre
ORDER BY count DESC
LIMIT 1;


-- Determine the count of movies that belong to only one genre
WITH genre_count AS (
    SELECT movie_id, COUNT(genre) AS count_of_genre
    FROM genre
    GROUP BY movie_id
)
SELECT COUNT(movie_id)
FROM genre_count
WHERE count_of_genre = 1;


-- Calculate the average duration of movies in each genre 
SELECT genre, AVG(duration) AS avg_duration
FROM movie AS m
JOIN genre AS g
ON m.id = g.movie_id
GROUP BY genre;


-- Find the rank of the 'thriller' genre among all genres in terms of the number of movies produced
SELECT genre, movie_count, genre_rank
FROM (
  SELECT genre, COUNT(*) AS movie_count,
         DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS genre_rank
	FROM movie AS m
	JOIN genre AS g
	ON m.id = g.movie_id
	GROUP BY genre
) subquery
WHERE genre = 'Thriller';



