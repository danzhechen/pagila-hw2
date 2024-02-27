/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */
SELECT f1.title
FROM (
    SELECT film_id, title
    FROM film,
    unnest(special_features) AS feature1
    WHERE feature1 = 'Behind the Scenes'
) AS f1
INNER JOIN(
    SELECT film_id, title
    FROM film,
    unnest(special_features) AS feature2
    WHERE feature2 = 'Trailers'
) AS f2 ON f1.film_id = f2.film_id
ORDER BY f1.title;
