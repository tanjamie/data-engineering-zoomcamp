# Set up Environment on GCP

## Virtual Machine Instance
![photo_2022-02-06_09-05-34](https://user-images.githubusercontent.com/86598825/152664472-3832c41f-a6af-4f8c-b5af-f719d898a182.jpg)

The image above shows how the virtual machine set up previously interacts with the localhost

## Run ingest data script in vm
1. Extra: To find the name of the network used by docker for this vm, do `docker network ls`
2. Build image using `docker build -t taxi_ingest:v001`
  - This will throw an error about being unable to start ny_taxi_postgres_data
  - If you try doing `ls` to look into ny_taxi_postgres_data, you will also be denied, it is because the directory belong to user "root" not "20jam"
  - To see what is inside, do `sudo ls ny_taxi_postgres_data` and check the owner of the directory, do `ls -lh`
  - This also means, docker cannot look what is inside ny_taxi_postgres_data, but we don't actually need that file to build the docker image so the solution would be to ignore ny_taxi_postgres_data using .dockerignore
    - Option 1: In VScode, create ".dockerignore" file and add relative path to ny_taxi_postgres_data file. Then, run docker build agian
    - Option 2: 
      - Create a new directory "data" which is owned by our user rather than root
      - Then, in docker-compose.yaml, update volume path to `"./data/ny_taxi_postgres_data:/var/lib/postgresql/data:rw`
      - In .dockerignore, put "data" instead
      - Make sure to save changes, do `docker-compose down` and `docker-compose up` again, before building image with `docker build -t taxi_ingest:v001`
