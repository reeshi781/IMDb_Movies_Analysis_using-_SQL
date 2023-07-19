
-- Top genres based on average ratings
SELECT g.genre, AVG(r.avg_rating) AS average_rating
FROM genre g
JOIN movie m ON g.movie_id = m.id
JOIN ratings r ON m.id = r.movie_id
GROUP BY g.genre
ORDER BY average_rating DESC;

-- Top production houses based on hit movie count
SELECT m.production_company, COUNT(*) AS hit_movie_count
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE r.avg_rating > 8 and production_company IS NOT NULL
GROUP BY m.production_company
ORDER BY hit_movie_count DESC;