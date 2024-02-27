/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */
SELECT
    EXTRACT (YEAR FROM r.rental_date) AS "Year",
    EXTRACT (MONTH FROM r.rental_date) AS "Month",
    SUM (p.amount) AS "Total Revenue"
FROM
    rental r
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY
    ROLLUP (
        EXTRACT (YEAR FROM rental_date),
        EXTRACT (MONTH FROM rental_date)
    )
ORDER BY "Year", "Month";
