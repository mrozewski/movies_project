
--Directors
--String agg allowsus to group by director, getting all of their films and genres

SELECT d.director_name, STRING_AGG(m.series_title, ', ') AS titles, 
	STRING_AGG(m.genre, ', ') AS genres, 
	AVG(m.imdb_rating) AS avg_imdb_rating, 
	AVG(m.meta_score) AS avg_meta_score, 	
	SUM(m.gross) AS total_gross
FROM directors as d
JOIN movies as m
ON d.director_name= m.director
GROUP BY d.director_name
ORDER BY AVG(m.meta_score) DESC;

--genre analysis
--For genres with more than 5 titles, find their average stats
--(Cast float columns as numeric)

SELECT genre,  COUNT(series_title) AS number_movies,
	ROUND(AVG(gross), 0) AS avg_gross, 
	ROUND(AVG(budget_x), 0) AS avg_budget, 
	ROUND(AVG(runtime), 0) AS avg_runtime,
	ROUND(CAST(AVG(imdb_rating) AS NUMERIC), 1) AS avg_imdb_rating,
	ROUND(CAST(AVG(meta_score) AS NUMERIC), 1) AS avg_meta_score
FROM movies
GROUP BY genre
HAVING count(series_title) > 5

--Rating Analysis
--For the common movie ratings (G, PG, PG-13, R), find the average stats

SELECT certificate as rating, COUNT(series_title) as titles, 
	ROUND(AVG(runtime), 0) as avg_runtime, 
	ROUND(AVG(gross), 0) as avg_gross, 
	ROUND(AVG(CAST(imdb_rating AS NUMERIC)), 2) AS avg_imdb_rating,
	ROUND(AVG(CAST(meta_score AS NUMERIC)), 2) as avg_meta_score
FROM movies
WHERE certificate in ('G','PG','PG-13','R')
GROUP BY certificate
ORDER BY avg_meta_score DESC;
