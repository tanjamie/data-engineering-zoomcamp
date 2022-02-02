# Putting scripts into Docker

## What we have done so far?
  - Explore Docker
  - Running Postgres with Docker
  - Look into the NY Taxi Data
  - Populate Postgres database with the data
  - Connect Postgres with pgAdmin on Docker using a network
Before going into Docker-compose, we want to put data ingestion script with pipeline.py. This is so that the script downloads data and put them into the pipeline automatically, all in one place. This is a quick but dirty way, a better alternative is to use Airflow, which will be covered in next week's content.

## Put ingestion script into Docker
1. Convert upload-data.ipynb jupyter notebook into a python script
    - Run`jupyter nbconvert --to=script upload-data.ipynb` in the directory containing *upload-data.ipynb* on anaconda prompt
    - Clean output file and rename it to ingest_data.py
2. Let ingest_data.py cope with command line arguments then, run the .py script
    - This can be achieved with argparse library, [here](https://docs.python.org/3/library/argparse.html) is referenced
    - To run python script, it needs to incorporate `if __main__==__name__:`
    - See code and explanation in ingest_data.py
3. Check that downloading by ingest_data works:
    - Go into `localhost:8080`, sign in and access Query Tool, drop the existing `yellow_taxi_data` in the database
      - Access Query Tool option by right clicking on the left menu
      - Drop `yellow_taxi_data` using `DROP TABLE yellow_taxi_data;` in the Query Tool
    - Run ingest_data.py with the following code:
      ```
      URL="https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv"
      python ingest_data.py \
        --user=root \
        --password=root \
        --host=localhost \
        --port=5431 \
        --db=ny_taxi \
        --table_name=yellow_taxi_data \
        --url=${URL}
      ```
      > ALERT: Take note that this is not the safest way to parse password. The command lines may keep a record of it which are accessible. E.g. In Git Bash, `history` reveals the password entered in the command above. But this is the simplest way to run the python script, so let's stick with it for now.

      > **ERROR SOLVER** >> If you face `'wget' is not recognized as an internal or external command, operable program or batch file`, you need to install `wget`. It is an external library, so it needs to be installed and added to the list of environmental variables in our local machine to access it. This [article](https://builtvisible.com/download-your-website-with-wget/) does a good job at guiding the installation process.
    - To check that the program finished succesfully, run `$?` or `echo $?` in Git Bash
      - If command returns `bash: 1: command not found`, 1 or any non zero number indicates that it is not sucessful
      - If command returns `0`, script has finished running succesfully
      - In this case, we will see that program didn't finish successfully and we should be procesing this to exit successfully. But this is not the priority now, so it's just something to note. 
    - In any case, our data would have been successfully put into Postgresql. To check that data has been retrieved from the url successfully in chunks and put into Postgres: 
        - Go into `localhost:8080` pgAdmin again, right click onto the lefthand-side menu and select refresh
        - A table should be in Servers > Docker localhost > Database > ny_taxi > Schemas > Public > Tables

## Dockerize ingest data
1. In dockerfile, add `sqlalchemy` and `psycopg2` into the list of things to install, and configure it to run ingest_data.py
2. Build the docker image using the updated dockerfile with `docker build -t taxi_ingest:v001 .` whereby taxi_ingest is the name of the new image tagged v001
3. Run taxi_ingest:v001 image
    
    **Option A: (This won't work, but can you tell what is wrong?)**
      ```
      docker run taxi_ingest:v001 \
        --user=root \
        --password=root \
        --host=localhost \
        --port=5432 \
        --db=ny_taxi \
        --table_name=yellow_taxi_data \
        --url=${URL}
      ```
      - Should add `-it` after run so we can stop the program if need to
      - More importantly, the `host` here is `localhost`, this means we are connecting to the localhost within the container, which is not what we want. Using this code, the ingest_data.py script will not be able to find and connect to Postgresql
      - If you've accidentally ran the code above, `ctrl c` will not work, one way to go around it is:
        - In a new Git Bash terminal, identify the container's id using `docker ps`
        - Do `docker kill <container-id>`, substituting the container id into the code respectively
    
    **Option B: (This works fine, but it is slow, there is the last option that works better)**
      ```
      docker run -it \
        --network=pg-network \
        taxi_ingest:v001 \
          --user=root \
          --password=root \
          --host=localhost \
          --port=5432 \
          --db=ny_taxi \
          --table_name=yellow_taxi_data \
          --url=${URL}
      ``` 
      - Correcting the mistake from option A, the image is connected to the network! 
      - Note: The first level of indentation specifies docker arguments, the second are arguments to pass within the docker container
    
    **Option C: (This is faster)**    
      - Since the data has already been retrieved before from the original url once, we can make use of that copy of data
      - Start a http server in with `python -m http.server`, then enter `localhost:8000` to access all the file in our local directory
      - Now, to make docker load the data from this localhost, we need its identifier i.e. the ip address to the localhost. Get the ip address by executing `ipconfig` in a new terminal. The ip address is labeled "IPv4 Address".
      - To check that the ip address is correct, search `<ip-address>:8000` in the browser and it should return the same page as in `localhost:8000`
      - In that page, copy the link of the data file and use it to reset a `URL` variable. 
      - Run the following code with the updated host ` pg-database` to start executing `taxi_ingest:v001` in docker, retrieving data from our file directory localhost
    ```
    URL="http://172.23.160.1:8000/yellow_tripdata_2021-01.csv" # sample
    docker run -it \
    --network=pg-network \
    taxi_ingest:v001 \
      --user=root \
      --password=root \
      --host=pg-database \
      --port=5432 \
      --db=ny_taxi \
      --table_name=yellow_taxi_data \
      --url=${URL}
    ```

## Ending Comments
Note that this set up is only suitable for local testing. Outside of that, we would need:
- URL to a remote/cloud database
- Rather than executing this with docker, other software may also be used e.g. Kubernetes

*fin*
