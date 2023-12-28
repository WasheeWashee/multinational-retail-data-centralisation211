import yaml
from sqlalchemy import inspect
from sqlalchemy import create_engine
from data_extraction import DataExtractor
from data_cleaning import DataCleaning

class DatabaseConnector:

    def read_db_creds(self, file_path):
        with open(file_path, 'r') as file:
            credentials = yaml.safe_load(file)
            return credentials
    
    def init_db_engine(self, file_path):
        credentials = self.read_db_creds(file_path)
        connection_string = f"{'postgresql'}+{'psycopg2'}://{credentials["USER"]}:{credentials["PASSWORD"]}@{credentials["HOST"]}:{credentials["PORT"]}/{credentials["DATABASE"]}"
        engine = create_engine(connection_string).connect()
        return engine
    
    def list_db_tables(self, engine):
        inspector = inspect(engine)
        return inspector.get_table_names()
    
    def upload_to_db(self, df, table_name, engine):
        df.to_sql(table_name, engine, if_exists = "replace")

if __name__ == "__main__":
    database_connector = DatabaseConnector()
    data_extractor = DataExtractor()    
    engine = database_connector.init_db_engine("db_creds.yaml")
    rds_table = data_extractor.read_rds_table(engine, "legacy_store_details")
    
    my_engine = database_connector.init_db_engine("my_creds.yaml")
    database_connector.upload_to_db(rds_table, "dim_store_details", my_engine)



