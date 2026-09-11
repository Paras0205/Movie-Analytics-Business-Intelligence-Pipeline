USE movie_analytics;

SHOW TABLES;

DESCRIBE movies;

-- total movies
SELECT COUNT(*) AS total_movies
FROM movies;

-- avg rating
SELECT
    ROUND(AVG(vote_average), 2) AS avg_rating
FROM movies;

-- avg popularity
SELECT
    ROUND(AVG(popularity), 2) AS avg_popularity
FROM movies;

-- total audience votes
SELECT
    SUM(vote_count) AS total_votes
FROM movies;

-- no of language
SELECT
    COUNT(DISTINCT original_language) AS total_languages
FROM movies;

-- highest-rated movies
SELECT
    id,
    title,
    vote_average
FROM movies
ORDER BY vote_average DESC
LIMIT 10;

-- movies having highest audience engangment
SELECT
    id,
    title,
    vote_count
FROM movies
ORDER BY vote_count DESC
LIMIT 10;

-- Top movies by rating with sufficient audience votes
SELECT
    id,
    title,
    vote_average,
    vote_count
FROM movies
WHERE vote_count >= 1000
ORDER BY vote_average DESC
LIMIT 10;

-- most popular movies
SELECT title,popularity
FROM movies
ORDER BY popularity DESC
LIMIT 10;

-- movies released each year
SELECT
    YEAR(release_date) AS release_year,
    COUNT(*) AS movie_count
FROM movies
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
ORDER BY release_year;

-- average rating for each year
SELECT
    YEAR(release_date) AS release_year,
    ROUND(AVG(vote_average), 2) AS avg_rating
FROM movies
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
ORDER BY release_year;

-- audience engagement changed over time
SELECT
    YEAR(release_date) AS release_year,
    ROUND(AVG(vote_count), 0) AS avg_vote_count
FROM movies
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
ORDER BY release_year;

-- years produced the most movies
SELECT
    YEAR(release_date) AS release_year,
    COUNT(*) AS movie_count
FROM movies
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
ORDER BY movie_count DESC
LIMIT 10;

-- years had the highest average movie rating
SELECT
    YEAR(release_date) AS release_year,
    ROUND(AVG(vote_average), 2) AS avg_rating,
    COUNT(*) AS movie_count
FROM movies
WHERE release_date IS NOT NULL
GROUP BY YEAR(release_date)
HAVING COUNT(*) >= 20
ORDER BY avg_rating DESC
LIMIT 10;

-- languages have the most movies
SELECT
    original_language,
    COUNT(*) AS movie_count
FROM movies
GROUP BY original_language
ORDER BY movie_count DESC
LIMIT 10;

-- languages have the highest average rating
SELECT
    original_language,
    ROUND(AVG(vote_average), 2) AS avg_rating,
    COUNT(*) AS movie_count
FROM movies
GROUP BY original_language
HAVING COUNT(*) >= 20
ORDER BY avg_rating DESC
LIMIT 10;

-- languages have the strongest audience engagement
SELECT
    original_language,
    ROUND(AVG(vote_count), 0) AS avg_vote_count,
    COUNT(*) AS movie_count
FROM movies
GROUP BY original_language
HAVING COUNT(*) >= 20
ORDER BY avg_vote_count DESC
LIMIT 10;

