
-- Segment 1: Database - Tables, Columns, Relationships
-- -	What are the different tables in the database and how are they connected to each other in the database?
-- -	Find the total number of rows in each table of the schema.
-- -	Identify which columns in the movie table have null values

USE imdb;


-- 	What are the different tables in the database and how are they connected to each other in the database

SELECT table_name
 FROM INFORMATION_SCHEMA.TABLES 
 WHERE TABLE_SCHEMA = 'imdb';
 
 -- Find the total number of rows in each table of the schema.

 SELECT table_name, table_rows 
 FROM INFORMATION_SCHEMA.TABLES WHERE 
 TABLE_SCHEMA = 'imdb';
 
 
 
 
 -- Identify which columns in the movie table have null values
 
--  SHOW COLUMNS FROM movie WHERE`Null`='YES';
 
--  SELECT COUNT(*) AS title_nulls
-- FROM movie
-- WHERE title IS NULL;

-- SELECT COUNT(*) AS year_nulls
-- FROM movie
-- WHERE year IS NULL;

-- SELECT COUNT(*) AS date_published_nulls
-- FROM movie
-- WHERE date_published IS NULL;

-- SELECT COUNT(*) AS duration_nulls
-- FROM movie
-- WHERE duration IS NULL;

-- SELECT COUNT(*) AS country_nulls
-- FROM movie
-- WHERE country IS NULL;

-- SELECT COUNT(*) AS worlwide_gross_income_nulls
-- FROM movie
-- WHERE worlwide_gross_income IS NULL;

-- SELECT COUNT(*) AS languages_nulls
-- FROM movie
-- WHERE languages IS NULL;

-- SELECT COUNT(*) AS production_company_nulls
-- FROM movie
-- WHERE production_company IS NULL;

SELECT
(SELECT COUNT(*) FROM movie WHERE title IS NULL) AS title_nulls,
(SELECT COUNT(*) FROM movie WHERE year IS NULL) AS year_nulls,
(SELECT COUNT(*) FROM movie WHERE date_published IS NULL) AS date_published_nulls,
(SELECT COUNT(*) FROM movie WHERE duration IS NULL) AS duration_nulls,
(SELECT COUNT(*) FROM movie WHERE country IS NULL) AS country_nulls,
(SELECT COUNT(*) FROM movie WHERE worlwide_gross_income IS NULL) AS worlwide_gross_income_nulls,
(SELECT COUNT(*) FROM movie WHERE languages IS NULL) AS languages_nulls,
(SELECT COUNT(*) FROM movie WHERE production_company IS NULL) AS production_company_nulls;
