/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */
SELECT title
FROM film f
JOIN (
    SELECT film_id, unnest(special_features) as feature
    FROM film
) AS sf ON f.film_id = sf.film_id 
WHERE f.rating = 'G'
AND sf.feature = 'Trailers'
ORDER BY title;
