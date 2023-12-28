/* Milestone 4 Task 1 */

SELECT country_code,
    COUNT(*) AS total_no_stores
FROM dim_store_details
GROUP BY country_code
ORDER BY total_no_stores DESC;

/* Milestone 4 Task 2 */

SELECT locality,
    COUNT(*) AS total_no_stores
FROM dim_store_details
GROUP BY locality
ORDER BY total_no_stores DESC;

/* Milestone 4 Task 3 */

SELECT dim_date_times.month,
    SUM(product_quantity * dim_products.product_price) AS total_sales
FROM orders_table
JOIN dim_date_times ON orders_table.date_uuid = dim_date_times.date_uuid
JOIN dim_products ON orders_table.product_code = dim_products.product_code
GROUP BY dim_date_times.month
ORDER BY total_sales DESC;

/* Milestone 4 Task 4 */

SELECT count(product_quantity) AS number_of_sales,
    SUM(product_quantity) AS product_quantity_count,
    CASE
        WHEN dim_store_details.store_type = 'Web Portal' THEN 'Web'
        ELSE 'Offline'
    END AS location
FROM orders_table
JOIN dim_store_details ON orders_table.store_code = dim_store_details.store_code
GROUP BY location
ORDER BY number_of_sales;

/* Milestone 4 Task 5 */

SELECT dim_store_details.store_type,
    SUM(product_quantity * dim_products.product_price) as total_sales,
    SUM(product_quantity * dim_products.product_price)/(SUM(SUM(product_quantity * dim_products.product_price)) over ()) * 100 AS percentage_total
FROM orders_table
JOIN dim_store_details ON orders_table.store_code = dim_store_details.store_code
JOIN dim_products ON orders_table.product_code = dim_products.product_code
GROUP BY dim_store_details.store_type
ORDER BY total_sales DESC;

/* Milestone 4 Task 6 */

SELECT dim_date_times.year,
    dim_date_times.month,
    SUM(product_quantity * dim_products.product_price) as total_sales
FROM orders_table
JOIN dim_date_times ON orders_table.date_uuid = dim_date_times.date_uuid
JOIN dim_products ON orders_table.product_code = dim_products.product_code
GROUP BY dim_date_times.year, dim_date_times.month
ORDER BY total_sales DESC;

/* Milestone 4 Task 7 */

SELECT country_code,
    SUM(staff_numbers) AS total_staff_numbers
FROM dim_store_details
GROUP BY country_code
ORDER BY total_staff_numbers DESC;

/* Milestone 4 Task 8 */

SELECT SUM(product_quantity * dim_products.product_price) as total_sales,
    dim_store_details.country_code,
    dim_store_details.store_type
FROM orders_table
JOIN dim_products ON orders_table.product_code = dim_products.product_code
JOIN dim_store_details ON orders_table.store_code = dim_store_details.store_code
WHERE dim_store_details.country_code = 'DE'
GROUP BY dim_store_details.store_type, dim_store_details.country_code
ORDER BY total_sales;

/* Milestone 4 Task 9 */

WITH purchase_time_gap AS (
    SELECT timestamp,
    LEAD(timestamp) OVER (ORDER BY combined_date, timestamp) AS next_purchase_time,
    year
    FROM dim_date_times
)

SELECT dim_date_times.year
    AVG(next_purchase_time - dim_date_times.timestamp) AS average_time_taken
FROM purchase_time_gap
GROUP BY dim_date_times.year
ORDER BY average_time_taken DESC;

