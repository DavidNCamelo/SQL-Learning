/*HRank SQL intermediate certification*/

/*First excersice For each pair of city and product, return the names of the city and product,
as well the total amount spent on the product to 2 decimal places. 
Order the result by the amount spent from high to low then by city name and product name in ascending order.*/

SELECT ct.city_name, p.product_name, it.line_total_price
FROM city AS ct
INNER JOIN customer AS c ON ct.id = c.city_id
INNER JOIN invoice AS inv ON c.id = inv.customer_id
INNER JOIN invoice_item AS it ON inv.id = it.invoice_id
INNER JOIN product AS p ON p.id = it.product_id
ORDER BY it.line_total_price DESC, ct.city_name ASC, p.product_name ASC


/*Second Excercise List all customers who spent 25% or less than the average amount spent on all invoices. For
each customer, display their name and the amount spent to 6 decimal places. Order the
result by the amount spent from high to low.*/

SELECT c.customer_name, FORMAT(i.total_price, 6) AS amount_spent
FROM customer AS c
INNER JOIN invoice AS i ON c.id = i.customer_id
WHERE i.total_price <= (SELECT AVG(total_price)*0.25 FROM invoice)
ORDER BY i.total_price ASC



/*HRank Certification SQL Avanced Certification*/
/*There is a table with daily weather data over the last 6 months of 2020, including the
maximum, minimum, and average temperatures.
Write a query that gives month, monthly maximum, monthly minimum, monthly
average temperatures for the six months.
Round the nearest integer average*/

SELECT MONTH(record_date),
    MAX(CASE WHEN data_type = 'max' THEN data_value END) AS max,
    MIN(CASE WHEN data_type = 'min' THEN data_value END) AS min,
    ROUND(AVG(CASE WHEN data_type = 'avg' THEN data_value END)) AS avg
FROM temperature_records
GROUP BY MONTH(record_date)