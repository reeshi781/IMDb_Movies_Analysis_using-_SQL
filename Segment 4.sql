-- Segment 4: Ratings Analysis and Crew Members
-- -	Retrieve the minimum and maximum values in each column of the ratings table (except movie_id).
-- -	Identify the top 10 movies based on average rating.
-- -	Summarise the ratings table based on movie counts by median ratings.
-- -	Identify the production house that has produced the most number of hit movies (average rating > 8).
-- -	Determine the number of movies released in each genre during March 2017 in the USA with more than 1,000 votes.
-- -	Retrieve movies of each genre starting with the word 'The' and having an average rating > 8.



-- Retrieve the minimum and maximum values in each column of the ratings table (except movie_id)
SELECT
  MIN(avg_rating) AS Min_avg_rating,
  MAX(avg_rating) AS Max_avg_rating,
  MIN(total_votes) AS Min_total_votes,
  MAX(total_votes) AS Max_total_votes,
  MIN(median_rating) AS Min_median_rating,
  MAX(median_rating) AS Max_median_rating
FROM ratings;

-- Identify the top 10 movies based on average rating. 

SELECT m.title AS Title, r.avg_rating AS Avg_rating
FROM movie m
JOIN ratings r ON m.id = r.movie_id
ORDER BY r.avg_rating DESC
LIMIT 10;


-- Summarise the ratings table based on movie counts by median ratings.

SELECT median_rating AS Median_rating , COUNT(*) AS Movie_count
FROM ratings
GROUP BY median_rating
ORDER BY movie_count DESC;


-- Identify the production house that has produced the most number of hit movies (average rating > 8)

SELECT m.production_company, COUNT(*) AS Movies
FROM movie AS m
JOIN ratings AS r ON r.movie_id = m.id
WHERE r.avg_rating > 8 AND m.production_company IS NOT NULL
GROUP BY m.production_company
ORDER BY Movies DESC
LIMIT 1;


-- Determine the number of movies released in each genre during March 2017 in the USA with more than 1,000 vote
SELECT g.genre, COUNT(*) AS movie_count
FROM movie m
JOIN genre g ON m.id = g.movie_id
JOIN ratings r ON m.id = r.movie_id
WHERE m.country = 'USA'
  AND YEAR(m.date_published) = 2017
  AND MONTH(m.date_published) = 3
  AND r.total_votes > 1000
GROUP BY g.genre;

-- Retrieve movies of each genre starting with the word 'The' and having an average rating > 8
SELECT g.genre, m.title, r.avg_rating as Avg_rating
FROM movie m
JOIN genre g ON m.id = g.movie_id
JOIN ratings r ON m.id = r.movie_id
WHERE m.title LIKE 'The%'
  AND r.avg_rating > 8
ORDER BY g.genre, m.title;
