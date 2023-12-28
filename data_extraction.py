import pandas as pd
from tabula import read_pdf
import requests
import boto3

class DataExtractor:
    
    def __init__(self):
        pass

    def read_rds_table(self, engine, table_name):
        query = f"SELECT * FROM {table_name}"
        df = pd.read_sql(query, engine)
        return df
    
    def retrieve_pdf_data(self, link):
        df_table = read_pdf(f"{link}", pages = "all")
        pd_df = pd.concat(df_table)
        return pd_df
    
    def api_key(self):
        api_dict = {"x-api-key": "yFBQbwXe9J3sd6zWVAMrK6lcxxr0q1lr2PT6DDMX"}
        return api_dict
    
    def list_number_of_stores(self, endpoint, headers_dict):
        response = requests.get(endpoint, headers = headers_dict)
        return response.json()
    
    def retrieve_stores_data(self, endpoint):
        num_stores = self.list_number_of_stores("https://aqj7u5id95.execute-api.eu-west-1.amazonaws.com/prod/number_stores", self.api_key())
        df = []
        for i in range(num_stores["number_stores"]):
            store_endpoint = f"{endpoint}/{i}"
            response = requests.get(store_endpoint, headers = self.api_key())
            df.append(pd.json_normalize(response.json()))
        pd_df = pd.concat(df)
        return pd_df
    
    def extract_from_s3(self):
        s3 = boto3.client("s3")
        response = s3.get_object(Bucket='data-handling-public', Key='products.csv')
        s3_df = pd.read_csv(response.get("Body"))
        return s3_df
    
    def retrieve_JSON_data(self):
        response = requests.get("https://data-handling-public.s3.eu-west-1.amazonaws.com/date_details.json")
        response_json = response.json()
        df = pd.DataFrame([])
        for column in response_json.keys():
            col_values = []
            for i in response_json[column].keys():
                col_values.append(response_json[column][i])
            df[column] = col_values
        return df

 
