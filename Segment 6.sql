-- Segment 6: Broader Understanding of Data
-- -	Classify thriller movies based on average ratings into different categories.
-- -	analyse the genre-wise running total and moving average of the average movie duration.
-- -	Identify the five highest-grossing movies of each year that belong to the top three genres.
-- -	Determine the top two production houses that have produced the highest number of hits among multilingual movies.
-- -	Identify the top three actresses based on the number of Super Hit movies (average rating > 8) in the drama genre.
-- -	Retrieve details for the top nine directors based on the number of movies, including average inter-movie duration, ratings, and more.


-- -	Classify thriller movies based on average ratings into different categories.
SELECT
  CASE
    WHEN avg_rating >= 9 THEN 'Excellent'
    WHEN avg_rating >= 7 THEN 'Very Good'
    WHEN avg_rating >= 5 THEN 'Good'
    ELSE 'Average or Below'
  END AS Rating_category,
  COUNT(*) AS Movie_count
FROM
  (
    SELECT m.title, r.avg_rating
    FROM movie m
    JOIN genre g ON m.id = g.movie_id
    JOIN ratings r ON m.id = r.movie_id
    WHERE g.genre = 'Thriller'
  ) AS subquery
GROUP BY rating_category;

-- analyse the genre-wise running total and moving average of the average movie duration
SELECT
  genre AS Genre, avg_duration AS Avg_duration,
  SUM(avg_duration) OVER (PARTITION BY genre ORDER BY year, title) AS Running_total,
  AVG(avg_duration) OVER (PARTITION BY genre ORDER BY year, title ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_average
FROM
  (
    SELECT g.genre , AVG(m.duration) AS Avg_duration, m.year,m.title
    FROM movie m
	JOIN genre g ON m.id = g.movie_id
    GROUP BY g.genre,m.year,m.title
  ) AS subquery
ORDER BY
  genre, year, title;


-- Identify the five highest-grossing movies of each year that belong to the top three genres.
WITH top_genres AS
(
SELECT genre,
    COUNT(m.id) AS movie_count,
	RANK () OVER (ORDER BY COUNT(m.id) DESC) AS genre_rank
FROM genre AS g
	LEFT JOIN movie AS m ON g.movie_id = m.id
	GROUP BY genre
)
,
top_grossing AS
(
SELECT g.genre, year, m.title as movie_name,worlwide_gross_income,
    RANK() OVER (PARTITION BY g.genre, year 
    ORDER BY CONVERT(REPLACE(TRIM(worlwide_gross_income), "$ ",""), UNSIGNED INT) DESC) AS movie_rank
FROM
movie AS m INNER JOIN
genre AS g ON g.movie_id = m.id
WHERE g.genre IN (SELECT DISTINCT genre FROM top_genres WHERE genre_rank<=3)
)
SELECT * 
FROM top_grossing
WHERE movie_rank<=5;

-- Determine the top two production houses that have produced the highest number of hits among multilingual movies.

SELECT m.production_company as Production_company ,COUNT(*) AS Hit_movie_count
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE r.avg_rating >= 8 AND m.production_company IS NOT NULL  AND m.languages LIKE '%,%'
GROUP BY m.production_company
ORDER BY hit_movie_count DESC
LIMIT 2;



-- Identify the top three actresses based on the number of Super Hit movies (average rating > 8) in the drama genre.

WITH actress_ratings AS
(
SELECT n.name as actress_name, SUM(r.total_votes) AS total_votes, COUNT(m.id) as movie_count,
	ROUND(SUM(r.avg_rating*r.total_votes)/SUM(r.total_votes),2) AS actress_avg_rating
FROM names AS n
INNER JOIN role_mapping AS a ON n.id=a.name_id
INNER JOIN movie AS m ON a.movie_id = m.id
INNER JOIN ratings AS r ON m.id=r.movie_id
INNER JOIN genre AS g ON m.id=g.movie_id
WHERE category = 'actress' AND lower(g.genre) ='drama'
GROUP BY actress_name
)
SELECT *,
	ROW_NUMBER() OVER (ORDER BY actress_avg_rating DESC, total_votes DESC) AS actress_rank
FROM
	actress_ratings
LIMIT 3;



-- Retrieve details for the top nine directors based on the number of movies, including average inter-movie duration, ratings, and more. 
SELECT
  n.name AS Director_name,
  COUNT(*) AS Movie_count,
  AVG(m.duration) AS Average_duration,
  AVG(r.avg_rating) AS Average_rating,
  MIN(m.date_published) AS Earliest_movie_date,
  MAX(m.date_published) AS Latest_movie_date
FROM names n
  JOIN director_mapping dm ON n.id = dm.name_id
  JOIN movie m ON dm.movie_id = m.id
  JOIN ratings r ON m.id = r.movie_id
GROUP BY n.name
ORDER BY movie_count DESC
LIMIT 9;