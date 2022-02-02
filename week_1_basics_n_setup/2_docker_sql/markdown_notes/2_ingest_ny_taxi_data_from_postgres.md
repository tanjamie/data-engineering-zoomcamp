# Use Postgres in Docker

## Running Postgres locally with Docker
> You may choose to use Git Bash or Anaconda Prompt. Feel free to toggle between them too! ps. I tried running it on both, so either should work.
1. Start a Postgresql docker container
    ```
    docker run -it -d \
        -e POSTGRES_USER="root" \
        -e POSTGRES_PASSWORD="root" \
        -e POSTGRES_DB="ny_taxi" \
        -v "c:/Users/20jam/Documents/GitHub/data-engineering-zoomcamp/week_1_basics_n_setup/2_docker_sql/ny_taxi_postgres_data":/var/lib/postgresql/data \
        -p 5431:5432 \
        postgres:13
    ```
    - The command runs Postgresql image tagged version 13 interactively i.e. you may execute code to interfere with the program as it is executing, and in a detached manner i.e. you will not see the outputs from code running "behind the scenes"
    - User, password and db are environmental variables that are configured in the command
    - Volume helps map a directory in the Postgresql container to a directory on our local machine
        - It is set up by specifying (local directory):(container directory)
        - Other possible alternatives: `-v $(pwd)/local_filename:/var/lib/postgresql/data` or `-v /c/Users/20jam/.../ny_taxi_postgres_data:/var/lib/postgresql/data`
    - Command specifies (local port):(container port) to build connection between the two and access the port in the postgres container
    - Meanings of flags used
        - `-it` to run interactively
        - `-d` to run in detached mode
        - `-e` to specify environment variables
        - `-v` to specify volume
        - `-p` to indicate port
        - `\` is an escape character
    > **ERROR SOLVER** >> For any command prompt, if you face `Connection to server at localhost (::1) port 5432 failed fatal password authentication failed in docker` error, consider changing the port used on local machine that connects to Postgresql container. This is because, the previously used port is likely already in use. To check that, enter Command Prompt (for Windows) and run `netstat -ano | findstr 5431` to check if there are any services running on port `5431`
2. Create cli client to access database on Docker container
    - Execute `pip install pgcli` to install pgcli which is a library in python
    - Run `pgcli --help` to check if pgcli is installed properly
    - `pgcli -h localhost -p 5431 -u root -d ny_taxi` to connect database to localhost port `5431`
    > **ERROR SOLVER** >> If you encounter `Server closed the connection unexpectedly` which is probably because because Docker hasn't completely set up the Postgresql image, give it more time.
    > **ERROR SOLVER** >> If pgcli gets stuck here indefinately for you (in Git Bash), try Anaconda Prompt instead. If it works, do continue using Anaconda Prompt for the remaining tasks to interact with the Postgresql container. Otherwise, use Git Bash to execute linux commands :>
3. Test out the connection
    - Try `\dt` which lists all the tables in the Postgres database
    - Try `SELECT 1;`

## Exploring the NY Dataset
1. Download the dataset. There are a few ways to do that from the terminal:
    a. Download [NY Taxi Dataset](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page) [Jan 2021 Yellow Taxi Trip Records](https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv) manually (it's sometimes faster that way)
    b. Do `wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv` in a new terminal
    - In any case, check that dataset is in the intended directory using `ls`. The file may not show up immediately so wait a little.
2. To inspect the data, there are many possible ways at every step
    - Open file:
        a. Open it the csv manually, a minor caveat is that loading time may be longer for big files.
        b. `less yellow_tripdata_2021-01.csv`to see the entries in csv in the terminal but, presentation of data makes reading data difficult, especially for big files.
        c. If file is big, it would be worthwhile to take just the first n rows and save it separately for inspection. Do `head -n 100 yellow_tripdata_2021-01.csv > yellow_head.csv` to access the first 100 rows of yellow_tripdata_2021-01.csv and save them into a new file called yellow_head.csv.
3. Other explorations:
    - Count number of lines of data in the file using `wc -l yellow_tripdata_2021_01.csv` where `wc -l` translate to word count lines i.e. count how many lines.
    - To comprehend what each columns mean, read [Yellow Trips Data Dictionary](https://www1.nyc.gov/assets/tlc/downloads/pdf/data_dictionary_trip_records_yellow.pdf).

## Upload data into Postgres
1. Install Jupyter Notebook using `pip install jupyter`. Note that jupyter is in anaconda by default so no installation needed there.
2. Install sqlalchemy using `pip install sqlalchemy`. Again, the package is in anaconda by default. This library will be useful in building the connection between postgres and the docker container.
3. Write script to put data into Postgresql
    - Enter jupyter notebook using `jupyter notebook` command, then give it a few seconds to initialize in the browser
    - See code and explanation in upload-data.ipynb

*fin*
