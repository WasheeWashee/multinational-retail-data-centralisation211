# from database_utils import DatabaseConnector
# from 

# database_connector = DatabaseConnector()
# data_extractor = DataExtractor()
# data_cleaner = DataCleaning()

### Milestone 2 Task 3
    
## Initialising the engine

# credentials = database_connector.read_db_creds("db_creds.yaml")
# aicore_engine = database_connector.init_db_engine("db_creds.yaml")
# my_db_engine = database_connector.init_db_engine("my_creds.yaml")

## Cleaning the data of the selected table

# table_list = database_connector.list_db_tables(aicore_engine)
# n = input("Please input the index of the table to clean (0 = legacy_store_details, 1 = legacy_users, 2 = orders_table): ")
# table = table_list[int(n)]
# df = data_extractor.read_rds_table(aicore_engine, table)
# df = data_cleaner.clean_user_data(df)

## Uploading cleaned data to database

# database_connector.upload_to_db(df, "dim_users", my_db_engine)
# print("Dataframe Uploaded")

### Milestone 2 Task 4
        
## Retrieving data from PDF > Clean data of null values > Upload data to database

# pdf_df = data_extractor.retrieve_pdf_data("https://data-handling-public.s3.eu-west-1.amazonaws.com/card_details.pdf")
# pdf_df_clean =  data_cleaner.clean_card_data(pdf_df)
# database_connector.upload_to_db(pdf_df_clean, "dim_card_details", my_db_engine)
# print("Dataframe Uploaded")

### Milestone 2 Task 5

## Retrieve store data from API > Clean data of NULL, erroneous data, fixes times > Upload data to database

# store_df = data_extractor.retrieve_stores_data("https://aqj7u5id95.execute-api.eu-west-1.amazonaws.com/prod/store_details")
# store_df_clean = data_cleaner.clean_store_data(store_df)
# database_connector.upload_to_db(store_df_clean, "dim_store_details", my_db_engine)
# print("Dataframe Uploaded")

### Milestone 2 Task 6

## Retrieve Product Data from S3 Bucket > Convert all weights to KG > Clean data of NULL data > Upload data to database

# product_df = data_extractor.extract_from_s3()
# product_df_weights = data_cleaner.convert_product_weights(product_df)
# product_df_clean = data_cleaner.clean_products_data(product_df_weights)
# database_connector.upload_to_db(product_df_clean, "dim_products", my_db_engine)
# print("Dataframe Uploaded")

### Milestone 2 Task 7

## List out db_tables > Extract orders data > Remove "first_name", "last_name", "1" from the table > Upload data to database

# tables_list = database_connector.list_db_tables(aicore_engine)
# table = tables_list[2]
# orders_df = data_extractor.read_rds_table(aicore_engine, table)
# orders_df_clean = data_cleaner.clean_orders_data(orders_df)
# database_connector.upload_to_db(orders_df_clean.drop("level_0", axis = 1), "orders_table", my_db_engine)
# print("Dataframe Uploaded")

### Milestone 2 Task 8

## Retrieve events JSON data from link > Clean data of NULL/Na values, merge day, month and year columns > Upload data to database

# events_df = data_extractor.retrieve_JSON_data()
# events_df_clean = data_cleaner.clean_event_data(events_df)
# database_connector.upload_to_db(events_df_clean, "dim_date_times")
# print("Dataframe Uploaded")