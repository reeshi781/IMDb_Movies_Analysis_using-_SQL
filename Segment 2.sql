-- Segment 2: Movie Release Trends
-- -	Determine the total number of movies released each year and analyse the month-wise trend.
-- -	Calculate the number of movies produced in the USA or India in the year 2019.
-- select * from movie;
USE imdb;


--  Determine the total number of movies released each year and analyse the month-wise trend. 
SELECT YEAR(date_published) AS year, 
MONTH(date_published) AS month, 
COUNT(*) AS total_movie
FROM movie
GROUP BY YEAR(date_published), MONTH(date_published);


-- Calculate the number of movies produced in the USA or India in the year 2019

SELECT COUNT(*) as Move_count
FROM movie
WHERE country IN('USA','INDIA')AND YEAR(date_published) = 2019;


SELECT 'Director_mapping' AS TableName, COUNT(*) AS TotalRows FROM Director_mapping
UNION ALL
SELECT 'Genre' AS TableName, COUNT(*) AS TotalRows FROM Genre
UNION ALL
SELECT 'Movie' AS TableName, COUNT(*) AS TotalRows FROM Movie
UNION ALL
SELECT 'Names' AS TableName, COUNT(*) AS TotalRows FROM Names
UNION ALL
SELECT 'Ratings' AS TableName, COUNT(*) AS TotalRows FROM Ratings;






