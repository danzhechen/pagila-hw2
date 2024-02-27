/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */
WITH TopProfitableFilms AS (
    SELECT inventory.film_id
    FROM film
    INNER JOIN inventory ON inventory.film_id = film.film_id
    INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
    INNER JOIN payment ON payment.rental_id = rental.rental_id
    GROUP BY inventory.film_id
    ORDER BY SUM(payment.amount) DESC
    LIMIT 5
)
SELECT DISTINCT customer.customer_id 
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN customer ON rental.customer_id = customer.customer_id
WHERE inventory.film_id IN (SELECT film_id FROM TopProfitableFilms)
ORDER BY customer.customer_id;
