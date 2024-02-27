/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
WITH revenue_data AS (
    SELECT
        f.title,
        SUM(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) AS revenue
    FROM
        film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY
        f.title
),
total_revenue AS (
    SELECT
        SUM(revenue) AS total
    FROM
        revenue_data
),
ranked_films AS (
    SELECT
        RANK() OVER (ORDER BY revenue DESC) AS rank,
        title,
        revenue
    FROM
        revenue_data
)
SELECT
    rf.rank,
    rf.title,
    rf.revenue,
    SUM(rf.revenue) OVER (ORDER BY rf.revenue DESC) AS "total revenue",
    TO_CHAR((SUM(rf.revenue) OVER (ORDER BY rf.revenue DESC) / tr.total) * 100, 'FM9900.00') AS "percent revenue"
FROM
    ranked_films rf,
    total_revenue tr
ORDER BY
    rank, title;
