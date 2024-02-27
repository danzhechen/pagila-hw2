/*
 * A group of social scientists is studying American movie watching habits.
 * To help them, select the titles of all films that have never been rented by someone who lives in the United States.
 *
 * NOTE:
 * Not every film in the film table is available in the store's inventory,
 * and you should only return films in the inventory.
 *
 * NOTE:
 * This can be solved by either using a LEFT JOIN or by using the NOT IN clause and a subquery.
 * For this problem, you should use the NOT IN clause;
 * in problem 07b you will use the LEFT JOIN clause.
 *
 * NOTE:
 * This is the last problem that will require you to use a particular method to solve the query.
 * In future problems, you may choose whether to use the LEFT JOIN or NOT IN clause if they are more applicable.
 */
SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id NOT IN (
    SELECT DISTINCT i.film_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN customer c ON r.customer_id = c.customer_id
    JOIN address a ON a.address_id = c.address_id
    JOIN city ct ON a.city_id = ct.city_id
    JOIN country co ON ct.country_id = co.country_id
    WHERE co.country = 'United States'
)
GROUP BY f.title
ORDER BY f.title;
