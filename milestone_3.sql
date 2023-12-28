/* General Utility Functions to Find Max Length */

SELECT MAX(LENGTH(CAST({column} AS TEXT)))
FROM {table};

SELECT {column} FROM {table} ORDER BY length(CAST({column} AS TEXT)) DESC

/* Milestone 3 Task 1 */

ALTER TABLE orders_table
    ALTER COLUMN date_uuid TYPE UUID USING date_uuid::UUID,
    ALTER COLUMN user_uuid TYPE UUID USING user_uuid::UUID,
    ALTER card_number TYPE VARCHAR(19),
    ALTER store_code TYPE VARCHAR(12),
    ALTER product_code TYPE VARCHAR(11),
    ALTER product_quantity TYPE SMALLINT USING product_quantity::SMALLINT;

/* Milestone 3 Task 2 */

DELETE FROM dim_users
    WHERE user_uuid = 'NULL'

ALTER TABLE dim_users
    ALTER COLUMN first_name TYPE VARCHAR(255),
    ALTER COLUMN last_name TYPE VARCHAR(255),
    ALTER COLUMN date_of_birth TYPE DATE USING date_of_birth::DATE,
    ALTER COLUMN country_code TYPE VARCHAR(3),
    ALTER COLUMN user_uuid TYPE UUID USING user_uuid::UUID,
    ALTER COLUMN join_date TYPE DATE USING join_date::DATE;

/* Milestone 3 Task 3 */

UPDATE dim_store_details
    SET latitude = CONCAT(lat, latitude);

DELETE FROM dim_store_details
    WHERE latitude = 'N/A';

DELETE FROM dim_store_details
    WHERE staff_numbers = 'A97';

DELETE FROM dim_store_details
    WHERE staff_numbers = '80R';
        
DELETE FROM dim_store_details        
    WHERE staff_numbers = 'J78';
        
DELETE FROM dim_store_details
    WHERE staff_numbers = '30e';

DELETE FROM dim_store_details
    WHERE staff_numbers = '3n9';

ALTER TABLE dim_store_details
    ALTER COLUMN store_type TYPE VARCHAR(255),
    ALTER COLUMN longitude TYPE FLOAT USING longitude::FLOAT,
    ALTER COLUMN locality TYPE VARCHAR(255),
    ALTER COLUMN store_code TYPE VARCHAR(12),
    ALTER COLUMN staff_numbers TYPE SMALLINT USING staff_numbers::SMALLINT,
    ALTER COLUMN opening_date TYPE DATE USING opening_date::DATE,
    ALTER COLUMN latitude TYPE FLOAT USING latitude::FLOAT,
    ALTER COLUMN country_code TYPE VARCHAR(2),
    ALTER COLUMN continent TYPE VARCHAR(255);

ALTER TABLE dim_store_details
    ALTER COLUMN store_type DROP NOT NULL

/* Milestone 3 Task 4 */

UPDATE dim_products
    SET product_price = replace(product_price, '£', '')

ALTER TABLE dim_products
    ADD COLUMN weight_class VARCHAR(14);

UPDATE dim_products
SET weight_class =
CASE
    WHEN CAST(weight AS INT)  < 2 THEN 'Light'
    WHEN CAST(weight AS INT) >= 2 AND CAST(weight AS INT) < 40 THEN 'Mid_Sized'
    WHEN CAST(weight AS INT) >= 40 AND CAST(weight AS INT) < 140 THEN 'Heavy'
    WHEN CAST(weight AS INT) >= 140 THEN 'Truck_Required'
    ELSE 'Unknown'
END;

/* Milestone 3 Task 5 */

ALTER TABLE dim_products
    RENAME COLUMN removed TO still_available;

UPDATE dim_products
SET still_available =
CASE
    WHEN still_available = 'Still_available' THEN TRUE
    WHEN still_available = 'Removed' THEN FALSE
END;

ALTER TABLE dim_products
    ALTER COLUMN product_price TYPE FLOAT USING product_price::FLOAT,
    ALTER COLUMN weight TYPE FLOAT USING weight::FLOAT,
    ALTER COLUMN "EAN" TYPE VARCHAR(17),
    ALTER COLUMN product_code TYPE VARCHAR(11),
    ALTER COLUMN date_added TYPE DATE USING date_added::DATE,
    ALTER COLUMN uuid TYPE UUID USING uuid::UUID,
    ALTER COLUMN still_available TYPE BOOL USING still_available::BOOL,
    ALTER COLUMN weight_class TYPE VARCHAR(14);

/* Milestone 3 Task 6 */

ALTER TABLE dim_date_times
    ALTER COLUMN month TYPE VARCHAR(2),
    ALTER COLUMN year TYPE VARCHAR(4),
    ALTER COLUMN day TYPE VARCHAR(2),
    ALTER COLUMN time_period TYPE VARCHAR(10),
    ALTER COLUMN date_uuid TYPE UUID USING date_uuid::UUID;

/* Milestone 3 Task 7 */

DELETE FROM dim_card_details
    WHERE date_payment_confirmed = 'NULL';

DELETE FROM dim_card_details
    WHERE expiry_date = '8YJ3TYH6Z5';

DELETE FROM dim_card_details
    WHERE expiry_date = '5VN8HOLMVE';

DELETE FROM dim_card_details
    WHERE expiry_date = 'NWS3P2W38H';

DELETE FROM dim_card_details
    WHERE expiry_date = '4FI5GTUVYG';

DELETE FROM dim_card_details
    WHERE expiry_date = '6JJKS7R0WA';

DELETE FROM dim_card_details
    WHERE expiry_date = 'RF1ACW165R';

DELETE FROM dim_card_details
    WHERE expiry_date = 'UMR9FIE22M';

DELETE FROM dim_card_details
    WHERE expiry_date = 'VNLNMWPJII';

DELETE FROM dim_card_details
    WHERE expiry_date = 'WDWMN9TU45';

DELETE FROM dim_card_details
    WHERE expiry_date = '2ANT8LW3I5';

DELETE FROM dim_card_details
    WHERE expiry_date = 'ZBGGFGY4H0';

DELETE FROM dim_card_details
    WHERE expiry_date = 'ACT9K6ECRJ';

DELETE FROM dim_card_details
    WHERE expiry_date = 'Q7VGWP7LH9';

DELETE FROM dim_card_details
    WHERE expiry_date = 'XRPE6C4GS9';

DELETE FROM dim_card_details
    WHERE card_number LIKE '?%'

SELECT card_number FROM dim_card_details ORDER BY length(CAST(card_number AS TEXT)) DESC;

ALTER TABLE dim_card_details
    ALTER COLUMN card_number TYPE VARCHAR(19),
    ALTER COLUMN expiry_date TYPE VARCHAR(5),
    ALTER COLUMN date_payment_confirmed TYPE DATE USING date_payment_confirmed::DATE;

/* Milestone 3 Task 8 */

ALTER TABLE dim_date_times
    ADD CONSTRAINT dim_date_times_key PRIMARY KEY (date_uuid);

ALTER TABLE dim_users
    ADD CONSTRAINT dim_users_key PRIMARY KEY (user_uuid);

ALTER TABLE dim_card_details
    ADD CONSTRAINT dim_card_details_key PRIMARY KEY (card_number);

ALTER TABLE dim_store_details
    ADD CONSTRAINT dim_store_details_key PRIMARY KEY (store_code);

ALTER TABLE dim_products
    ADD CONSTRAINT dim_products_key PRIMARY KEY (product_code);

/* Milestone 3 Task 9 */

ALTER TABLE orders_table
    ADD FOREIGN KEY (date_uuid) REFERENCES dim_date_times(date_uuid),
    ADD FOREIGN KEY (user_uuid) REFERENCES dim_users(user_uuid),
    ADD FOREIGN KEY (card_number) REFERENCES dim_card_details(card_number),
    ADD FOREIGN KEY (store_code) REFERENCES dim_store_details(store_code),
    ADD FOREIGN KEY (product_code) REFERENCES dim_products(product_code);