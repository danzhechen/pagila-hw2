/*
 * Select the titles of all films that the customer with customer_id=1 has rented more than 1 time.
 *
 * HINT:
 * It's possible to solve this problem both with and without subqueries.
 */
SELECT film.title
FROM film
WHERE film.film_id IN (
    SELECT inventory.film_id
    FROM rental
    INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
    WHERE rental.customer_id = 1
    GROUP BY inventory.film_id
    HAVING COUNT(inventory.film_id) > 1
);
