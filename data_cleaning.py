import pandas as pd
import numpy as np
import dateutil.parser

class DataCleaning:
    
    def __init__(self):
        pass
    
    def clean_dates(self, df, column):
        df[column].apply(lambda x: dateutil.parser.parse(x).strftime('%d/%m/%Y'))
        return df
    
    def clean_store_continent(self, continent):
        if "ee" in continent:
            return continent.replace("ee", "")
        else:
            return continent

    def clean_user_data(self, df):
        drop_list = ["index"]
        classifications = ["GB", "DE", "US"]
        df.drop(columns = drop_list)
        df = df.dropna()
        df = df[df.address != "NULL"]
        df = df.loc[df["country_code"].isin(classifications)]
        df = self.clean_dates(df, "join_date")
        df = self.clean_dates(df, "date_of_birth")
        return df
    
    def clean_card_data(self,df):
        classifications = ["VISA 16 digit", "JCB 15 digit", "Discover", "VISA 13 digit", "American Express", "Mastercard", "Maestro", "Visa 19 digit", "Diners Club / Carte Blanche", "JCB 16 digit"]
        df = df.loc[df["card_provider"].isin(classifications)]
        df = df[df.card_number != "NULL"]
        return df
    
    def clean_store_data(self, df):
        classifications = ["Europe", "America"]
        df["continent"] = df["continent"].apply(self.clean_store_continent)
        df = df.loc[df["continent"].isin(classifications)]
        df = self.clean_dates(df, "opening_date")
        df = df[df.address != "NULL"]
        return df
     
    def convert_kg(self, weight):
        if isinstance(weight, float):
            return weight
        elif weight.endswith('.'):
            return float(weight.split()[0].replace("g", "")) 
        elif "x" in weight: 
            weight_list = weight.split()
            combined_weight = float(weight_list[0])*float(weight_list[2].replace("g", ""))/1000
            return combined_weight
        elif 'ml' in weight:
            return float(weight.replace("ml", ""))/1000
        elif 'kg' in weight:
            return float(weight.replace("kg", ""))
        elif 'g' in weight:
            return float(weight.replace("g", ""))/1000  
        else:
            return np.nan
        
    def convert_product_weights(self, df):
        df["weight"] = df["weight"].apply(self.convert_kg)
        return df
    
    def clean_products_data(self, df):
        clean_data = df.dropna()
        return clean_data

    def clean_orders_data(self, df):
        drop_list = ["first_name", "last_name", "1"]
        df = df.drop(columns = drop_list)
        df = df.dropna()
        return df

    def clean_event_data(self, df):
        classifications = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        df = df.loc[df["month"].isin(classifications)]
        df = df.dropna()
        df['combined_date'] = pd.to_datetime(df[['year', 'month', 'day']])
        return df
