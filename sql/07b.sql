/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN (
    SELECT DISTINCT i.film_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN customer c ON r.customer_id = c.customer_id
    JOIN address a ON a.address_id = c.address_id
    JOIN city ct ON a.city_id = ct.city_id
    JOIN country co ON ct.country_id = co.country_id
    WHERE co.country = 'United States'
)
AS rented_in_us ON i.film_id = rented_in_us.film_id
WHERE rented_in_us.film_id IS NULL
GROUP BY f.title
ORDER BY f.title;
