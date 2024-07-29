--Normalize tables


-- Separate actors from movies table, create serial index to match back. Actos are listed under 4 potential
-- "star" columns

CREATE TABLE actors (
	actor_id SERIAL PRIMARY KEY,
	actor_name VARCHAR(255)
);

INSERT INTO actors (actor_name)
SELECT DISTINCT star1 FROM movies_with_budget
UNION
SELECT DISTINCT star2 FROM movies_with_budget
UNION
SELECT DISTINCT star3 FROM movies_with_budget
UNION
SELECT DISTINCT star4 FROM movies_with_budget;

--Add actor_id columns

ALTER TABLE movies_with_budget ADD star1_id INT;
ALTER TABLE movies_with_budget ADD star2_id INT;
ALTER TABLE movies_with_budget ADD star3_id INT;
ALTER TABLE movies_with_budget ADD star4_id INT;

--Replacing actor_name with respective actor_id

UPDATE movies_with_budget as m
SET star1_id = a.actor_id
FROM actors as a
WHERE m.star1 = a.actor_name;

UPDATE movies_with_budget as m
SET star2_id = a.actor_id
FROM actors as a
WHERE m.star2 = a.actor_name;

UPDATE movies_with_budget as m
SET star3_id = a.actor_id
FROM actors as a
WHERE m.star3 = a.actor_name;

UPDATE movies_with_budget as m
SET star4_id = a.actor_id
FROM actors as a
WHERE m.star4 = a.actor_name;

--Drop actor_name columns

ALTER TABLE movies_with_budget DROP COLUMN star1;
ALTER TABLE movies_with_budget DROP COLUMN star2;
ALTER TABLE movies_with_budget DROP COLUMN star3;
ALTER TABLE movies_with_budget DROP COLUMN star4;



--Same with directors

CREATE TABLE directors (
	director_id SERIAL PRIMARY KEY,
	director_name VARCHAR(255)
);

INSERT INTO directors (director_name)
SELECT DISTINCT director
FROM movies_with_budget;


UPDATE movies_with_budget as m
SET m.director_id = d.director_id
FROM directors as d
WHERE m.director_id = d.director_name;

ALTER TABLE movies_with_budget DROP COLUMN director;