/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */
SELECT
    rank,
    title,
    revenue,
    SUM(revenue) OVER (ORDER BY revenue DESC) AS "total revenue"
FROM(SELECT
    RANK () OVER (
        ORDER BY sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) DESC
    ) AS rank,
    title,
    sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) AS revenue
    FROM film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY f.title
) AS ranked_films
ORDER BY
    rank, title;
