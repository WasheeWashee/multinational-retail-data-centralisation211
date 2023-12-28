import pandas as pd
import numpy as np
import dateutil.parser

class DataCleaning:
    
    def __init__(self):
        pass
    
    def clean_dates(self, df, column):
        return df[column].apply(lambda x: dateutil.parser.parse(x).strftime('%d/%m/%Y'))
    
    def clean_store_continent(self, continent):
        if "ee" in continent:
            return continent.replace("ee", "")
        else:
            return continent
        
    def date_checker(self, year):
        if isinstance(year, float):
            return year
        else:
            return np.nan


    def clean_user_data(self, df):
        df.drop(columns = "index")
        df = df.dropna()
        df = df[df.address != "NULL"]
        if "date_of_birth" in list(df.columns):
            df = self.clean_dates(df, "date_of_birth")
        if "join_dates" in list(df.columns):
            df = self.clean_dates(df, "join_dates")
        return df
    
    def clean_card_data(self,df):
        df = df[df.card_number != "NULL"]
        return df
    
    def clean_store_data(self, df):
        df["continent"] = df["continent"].apply(self.clean_store_continent)
        df = df[df.lat == None]
        df = self.clean_dates(df, "opening_date")
        df = df.dropna(inplace = True)
        return df
     
    def convert_kg(self, weight):
        if isinstance(weight, float):
            return weight
        elif weight.endswith('.'):
            return float(weight.split()[0].replace("g", "")) 
        if "x" in weight: 
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
        column_list = ["first_name", "last_name", "1"]
        df = df.drop(columns = column_list)
        df = df.dropna()
        return df

    def clean_event_data(self, df):
        df = df.dropna()
        df = df["year"].apply(self.date_checker)
        df["Combined_Date"] = pd.to_datetime(df[['year', 'month', 'day']], dayfirst = True)
        df_combined = df.join(df["Combined_Date"])
        return df_combined
