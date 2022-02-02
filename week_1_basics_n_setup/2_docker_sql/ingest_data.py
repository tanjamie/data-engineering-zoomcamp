#!/usr/bin/env python
# coding: utf-8

import argparse
from time import time
from sqlalchemy import create_engine
import pandas as pd
import os

def main(params):
    # read the parameters given
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    csv_name = "ingest_data_output.csv" # dummy name
    
    # download the csv using wget i.e. download data directly
    os.system(f'wget {url} -O {csv_name}')
    
    # start engine
    # (type of db)://(username):(password)@localhost:(local port)/(dbname)
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # set up chunked data
    df_iter = pd.read_csv(csv_name, iterator = True, chunksize = 100000)
    df = next(df_iter)

    # convert text type to datetime for columns containing date
    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    # connect and create empty table
    df.head(n = 0).to_sql(name = table_name, con = engine, if_exists = "replace")
    # connect and append to table
    while True:
        t_start = time()
        df = next(df_iter)
        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
        df.to_sql(name = "yellow_taxi_data", con = engine, if_exists = "append")
        t_end = time()
        print("Inserted another chunk ..., took %.3f seconds"%(t_end - t_start))

# to run the script
if __name__ == "__main__":
    # configure argparse
    parser = argparse.ArgumentParser(description = "Ingest CSV data to Postgresql")
    # arguments to take in: user, password, host, port , database name, table name, url to retrieve csv
    parser.add_argument("--user", help = "Username for Postgres")
    parser.add_argument("--password", help = "Password for Postgres")
    parser.add_argument("--host", help = "Host for Postgres")
    parser.add_argument("--port", help = "Port for Postgres")
    parser.add_argument("--db", help = "Database name for Postgres")
    parser.add_argument("--table_name", help = "Name of the table where we will write the results to")
    parser.add_argument("--url", help = "Url of the CSV file")
    args = parser.parse_args()
    
    # run and put arguments into the function
    main(args)

# fin