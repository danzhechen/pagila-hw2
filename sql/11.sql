/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */
SELECT a.first_name ||' '||a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa on a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.film_id IN (
    SELECT film_id
    FROM film,
    unnest(special_features) AS feature
    WHERE feature = 'Behind the Scenes'
)
GROUP BY "Actor Name"
ORDER BY "Actor Name";
