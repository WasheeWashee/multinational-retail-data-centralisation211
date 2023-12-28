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

ALTER TABLE dim_users
    ALTER COLUMN first_name TYPE VARCHAR(255),
    ALTER COLUMN last_name TYPE VARCHAR(255),
    ALTER COLUMN date_of_birth TYPE DATE USING date_of_birth::DATE,
    ALTER COLUMN country_code TYPE VARCHAR(3),
    ALTER COLUMN user_uuid TYPE UUID USING user_uuid::UUID,
    ALTER COLUMN join_date TYPE DATE USING join_date::DATE;

/* Error with cleaning here */

/* Milestone 3 Task 3 */

UPDATE dim_store_details
    SET latitude = CONCAT(lat, latitude);

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

/* Error with cleaning here */

/* Milestone 3 Task 4 */

UPDATE dim_products
    SET product_price = replace(product_price, '£', '')

ALTER TABLE dim_products
    ADD COLUMN weight_class VARCHAR(14);

UPDATE dim_products
SET weight_class =
CASE
    WHEN weight < 2 THEN 'Light'
    WHEN weight >= 2 AND weight < 40 THEN 'Mid_Sized'
    WHEN weight >= 40 AND weight < 140 THEN 'Heavy'
    WHEN weight >= 140 THEN 'Truck_Required'
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
    ALTER COLUMN weight TYPE FLOAT,
    ALTER COLUMN "EAN" TYPE VARCHAR(17),
    ALTER COLUMN product_code TYPE VARCHAR(11),
    ALTER COLUMN date_added TYPE DATE USING date_added::DATE,
    ALTER COLUMN uuid TYPE UUID USING uuid::UUID,
    ALTER COLUMN still_available TYPE BOOL USING still_available::BOOL,
    ALTER COLUMN weight_class TYPE VARCHAR(14);

/* Messed up the Bool column, redo */

/* Milestone 3 Task 6 */

ALTER TABLE dim_date_times
    ALTER COLUMN month TYPE VARCHAR(2),
    ALTER COLUMN year TYPE VARCHAR(4),
    ALTER COLUMN day TYPE VARCHAR(2),
    ALTER COLUMN time_period TYPE VARCHAR(10),
    ALTER COLUMN date_uuid TYPE UUID USING date_uuid::UUID;

/* Cleaning issue here */

/* Milestone 3 Task 7 */


ALTER TABLE dim_card_details
    ALTER COLUMN card_number TYPE VARCHAR(19),
    ALTER COLUMN expiry_date TYPE VARCHAR(5),
    ALTER COLUMN date_payment_confirmed TYPE DATE USING date_payment_confirmed::DATE;

/* Cleaning issue here */ 


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
    ADD FOREIGN KEY (dim_date_times_key) REFERENCES dim_date_times(dim_date_times_key),
    ADD FOREIGN KEY (dim_users_key) REFERENCES dim_users(dim_users),
    ADD FOREIGN KEY (dim_card_details_key) REFERENCES dim_card_details(dim_card_details_key),
    ADD FOREIGN KEY (dim_store_details_key) REFERENCES dim_store_details(dim_store_details_key),
    ADD FOREIGN KEY (dim_products_key) REFERENCES dim_products(dim_products_key);