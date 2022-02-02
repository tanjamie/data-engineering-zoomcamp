# Connect pgAdmin and Postgresql
## pgAdmin
1. What is it?
    - Previously, we used `pgcli` to interact with Postgres via the command line.
    - pgAdmin is a web-based GUI tool used to interact with a Postgres session, and this makes the interaction more convinient.
2. Install pgAdmin
    - Download pgAdmin [here](https://www.pgadmin.org/download/)
    - The traditional way is to just download the version of pdAdmin that works on your OS
    - But here, we will pull Docker image from Docker Hub using `docker pull dpage/pgadmin4` to use pgAdmin on Docker
3. Run pgAdmin on Docker
      ```
      docker run -it -d \
        -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
        -e PGADMIN_DEFAULT_PASSWORD="root" \
        -p 8080:80 \
        dpage/pgadmin4
      ```
      - Environmental variables `PGADMIN_DEFAULT_EMAIL` is essentially a user and `PGADMIN_DEFAULT_PASSWORD` is self-explanatory
      - Again `-p 8080:80` to map local machine port `8080` to the container port `80`
      - `dpage/pgadmin4` to pull image

## Navigate pgAdmin in Docker
1. Understand mechanisms to access pgadmin via localhost
    - Search `localhost:8080` in your browser and login to pgAdmin using email `admin@admin.com` and password `root`
    - In pgAdmin, right click on "Servers" option on the left tab, choose "Create" then "Server..." to create a new server
      - Under *General* tab: Give the server a "Name" e.g. Local docker
      - In *Connection* tab: First, give "Host name/address", in this case, it's `localhost`. Next, update *Username* to `root` and "Password" to `root`
      - Then, "save" changes
    - You should get an error `Unable to connect to server: connection to server at "localhost" ...` This is because pgAdmin is trying to find Postgres within the pgAdmin container it is running on (specifically, it is running in the localhost in the container). It won't be able to find Postgres because Postgres is on a separate container. What we need now, is to link the two containers together i.e. putting the two containers in one network so the containers can "see" each other!
2. Create a network between pgAdmin and Postgres container
    - Start a network with `docker network create pg-network`. If you need to remove the network, use `docker network rm pg-network`.
    - Stop the existing Postgres and pgAdmin container first! This can be easily done on docker desktop.
    - Set up and put a Postgres and pgadmin container into one network
        ```
        docker run -it -d \
          -e POSTGRES_USER="root" \
          -e POSTGRES_PASSWORD="root" \
          -e POSTGRES_DB="ny_taxi" \
          -v "c:/Users/20jam/Documents/GitHub/data-engineering-zoomcamp/week_1_basics_n_setup/2_docker_sql/ny_taxi_postgres_data":/var/lib/postgresql/data \
          -p 5431:5432 \
          --network=pg-network \
          --name pg-database \
          postgres:13
        ```
         - `--network` specifies the network connection to use, so we need provide a network's name
         - `--name` specifies the name of the postgres container in the network. This will be useful in discovering the postgres container within the network
         -  Check that we still have the data in the previous Postgres db in the new container with network configurations, using `pgcli -h localhost -p 5431 -u root -d ny_taxi` and `SELECT COUNT(1) FROM yellow_tripdata_2021-01.csv;`. To provide an explanation, the state of the previous container persisted because -v was set up previously and is reused in this instance.
        ```
        docker run -it -d \
          -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
          -e PGADMIN_DEFAULT_PASSWORD="root" \
          -p 8080:80 \
          --network=pg-network \
          --name pgadmin \
          dpage/pgadmin4
        ```
      - Similarly, the code above connects pgAdmin with Postgres in the network.
    -  To check that connection is set up successfully: 
      - Browse `localhost:8080`, sign in with `admin@admin.com` and `root`. Again, right click on "Servers", choose "Create" and "Servers..." 
      - In General tab: Input "Name" e.g. `Docker localhost`
      - In Connection tab: Input "Host name/address"  as `pg-database` i.e. Postgres' container name/identifier, this helps pgAdmin find Postgres in the network
      - Change "Username" and "Password" to the one used currently i.e. `root` for both

*fin*
