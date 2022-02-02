# Refresh SQL

1. Obtain more data from [here](https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv)
    - See added code and explanation in upload-data.ipynb, "More data for SQL refresher" section
      - If you have done `docker-compose down` previously, execute `docker-compose up` again to restart the containers
      - Run code to import pandas, set up engine and pull data in upload-data.ipynb
      - Go into `localhost:8000` to check that a table called zones is added to the database
        - Recall that previous server would not be preserved by default on pgAdmin because of the lack of volume under pgAdmin in docker-compose
        - But, it can be easily retrieved from setting up a server connecting to `pgdatabase` 
2. Basic SQL things to refresh
    - `SELECT ... FROM ... WHERE ...;` selects specified columns from the table mentioned given that some condition written in `WHERE` clause is fulfilled
    - How to do joins (inclduing the different variations)?
      - `SELECT ... FROM tableA a, tableB b, ... WHERE a.col1 = b.col1;` cross product tableA and tableB then only select rows fulfilling conditions in `WHERE` clause
      - `SELECT ... FROM tableA a JOIN tableB b ON a.col1 = b.col1 JOIN tableC c ON a.col1 = c.col1;` inner joins tableA and tableB, then inner joins tableC on condition specified
      - `SELECT ... FROM tableA a LEFT JOIN tableB b ON a.col1 = b.col1;` joins tableA and tableB where null values in tableA are retained
      - `SELECT ... FROM tableA a RIGHT JOIN tableB b ON a.col1 = b.col1;` joins tableA and tableB where null values in tableB are retained
      - `SELECT ... FROM tableA a OUTER JOIN tableB b ON a.col1 = b.col1;` joins tableA and tableB without dropping any null values
    - How to do group by?
      - `SELECT COUNT(1) FROM tableA GROUP BY datetime_column ORDER BY datetime_column ASC` counts number of rows there are on each date then order the rows by the date in ascending order
      - Data can be grouped by multiple data columns (same for order by) e.g. `SELECT COUNT(1) FROM tableA GROUP BY datetime_column ORDER, another_column ORDER BY datetime_column ASC, another_columns ASC;`
    - Additional utilities
      - `SELECT CONCAT(a.col1, " / ", b.col1) AS merged_col1 FROM tableA a, tableB b;` returns a column named merged_col1 where each row contains the concatenated strings from the columns specified
      - `SELECT DATE_TRUNC("DAY", datetime_column) FROM ...` truncates column so that time is removed and only have days remaining
      - `SELECT CAST(datetime_column AS DATE) AS day FROM ...` casts the column into a date format
      - Various kinds of aggregation function can also be used in `SELECT` clause

fin
