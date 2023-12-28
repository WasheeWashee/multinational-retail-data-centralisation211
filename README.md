# Multinational Retail Data Centralisation

## Project Description
1. The objective of the project was to store a multinational retail company's sales data into one centralised location, improving the accessibility of said data.
2. This first included extracting and cleaning the data from a variety of data sources, before uploading into a database in pgAdmin4.
3. Then a STAR-based schema was created for the database, ensuring each entry was casted to the correct data type, and creating relations between tables.
4. Finally, SQL was used to make queries on the data, giving insights into the data that can help the company to make more data-driven decisions.

## Installation Instructions

The packages used can be viewed in the requirements.txt file. They can be installed all at once by running the following in the terminal:

```
pip install -r requirements.txt
```

## Usage Instructions

The following modules were used in this project:
- Pandas
- Tabula-py
- Requests
- Boto3
- PyYAML
- SQLAlchemy
- dateutil

The user will need to create their own my_creds.yaml file, which will include the credentials of the pgAdmin4 database that the data is to be uploaded to. The db_creds.yaml and my_creds.yaml files should both be of the same format:

```
HOST: {your_host_name}
PASSWORD: {your_password}
USER: {your_username}
DATABASE: {your_database}
PORT: {your_port}
```
The commands required to extract, clean and upload the data are stored in milestone_2_commands.py. Similarly, the queries required to create the STAR-based schema are in milestone_3.sql, and the queries required to gather the necessary information requested by the company are in milestone_4.sql.

## File Structure

- database_utils.py contains a class that is used to read the database credentials, connect to the database, and upload extracted data there.
- data_extraction.py contains a class that is used to extract data from a variety of sources (e.g. PDF, API, S3 Bucket, RDS).
- data_cleaning.py contains a class that is used to clean the data of null, erroneous and inconsistent entries.
- milestone_2_commands.py contains the commands required for Milestone 2.
- milestone_3.sql contains the queries required for Milestone 3.
- milestone_4.sql contains the queries required for Milestone 4.
