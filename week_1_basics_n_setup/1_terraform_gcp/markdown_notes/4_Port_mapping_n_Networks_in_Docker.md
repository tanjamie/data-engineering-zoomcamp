# Set up Environment on GCP

## Virtual Machine Instance
![photo_2022-02-06_09-05-34](https://user-images.githubusercontent.com/86598825/152664472-3832c41f-a6af-4f8c-b5af-f719d898a182.jpg)

The image above shows how the virtual machine set up previously interacts with the localhost

## Run ingest data script in vm
1. Build image using `docker build -t taxi_ingest:v001 .`
    - This will throw an error about being unable to start ny_taxi_postgres_data
    - If you try doing `ls` to look into ny_taxi_postgres_data, you will also be denied, it is because the directory belong to user "root" not "20jam"
    - To see what is inside, do `sudo ls ny_taxi_postgres_data` and check the owner of the directory, do `ls -lh`
    - This also means, docker cannot look what is inside ny_taxi_postgres_data, but we don't actually need that file to build the docker image so the solution would be to ignore ny_taxi_postgres_data using .dockerignore
      - Option 1: In VScode, create ".dockerignore" file and add relative path to ny_taxi_postgres_data file. Then, run docker build agian
      - Option 2: 
        - Create a new directory "data" which is owned by our user rather than root
        - Then, in docker-compose.yaml, update volume path to `"./data/ny_taxi_postgres_data:/var/lib/postgresql/data:rw`
        - In .dockerignore, put "data" instead
        - Make sure to save changes, do `docker-compose down` and do `sudo rm -rf ny_taxi_postgres_data` to remove the folder
        - `docker-compose up` again, you can do `ls -lh` to check that data belongs to you
        - Building image with `docker build -t taxi_ingest:v001 .`
2. Run ingest script on Docker
    - `URL="https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv"` to specify source of data
    - `docker run -it --network=2_docker_sql_default taxi_ingest:v001 --user=root --password=root --host=pgdatabase --port=5432 --db=ny_taxi --table_name=yellow_taxi_trips --url=${URL}` to run the ingestion script
      - Find your network name using `docker network ls`
      - Your user, password and host are specified in docker-compose
      - Be careful with the port you put, don't be tempted to change it just yet. Ingestion script is in the vm host itself and doesn't go through localhost to connect to the database. This means even if you've changed port previously, you will still use 5432 here since that's the port used on postgres
        - By extension, even if you take out the port configuration parts for postgres in docker-compose, the system will still be able to find postgresql
    - While the ingestion script is running, you can pgcli into the database to see the number of rows in yellow_taxi_trips increase

*fin*
