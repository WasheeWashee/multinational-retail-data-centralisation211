# Multinational Retail Data Centralisation

## Project Description
- The objective of the project was to store a multinational retail company's sales data into one centralised location, improving the accessibility of said data.
- This first included extracting and cleaning the data from a variety of data sources, before uploading into a database in pgAdmin4.
- Then a STAR-based schema was created for the database, ensuring each entry was casted to the correct data type, and creating relations between tables.
- Finally, SQL was used to make queries on the data, giving insights into the data that can help the company to make more data-driven decisions.

## Installation Instructions

The packages used can be viewed in the requirements.txt file. They can be installed all at once by running the following in the terminal:

```
pip install -r requirements.txt
```

## Usage Instructions

The following modules were used in this project:
- Pandas
- Tabula
- Requests
- Boto3
- PyYAML
- SQLAlchemy
- dateutil

The user will need to create their own my_creds.yaml file, which will include the credentials of the pgAdmin4 database that the data is to be uploaded to. The db_creds.yaml and my_creds.yaml files should both be of the same format:

'''
HOST: {your_host_name}
PASSWORD: {your_password}
USER: {your_username}
DATABASE: {your_database}
PORT: {your_port}
'''

Aside from this, the user will need the 
