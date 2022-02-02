# Running Postgres and PgAdmin on Docker-compose

## Introduction to Docker-compose
1. What is Docker-compose?
    - Previously, we packaged our ingestion script to docker. But our configurations are all done in command line. This is similar for initializing the postgresql and pgAdmin containers. Notably, all of their configurations were done separately. This is where docker-compose comes in handy. Docker-compose is a utility that can take in configurations for multiple containers into one `.yaml` file, rather than putting all that in command on cmd. 
2. Installing Docker-compose?
    - Docker-compose is part of docker desktop but in Linux, this needs to be downloaded separately. 
    - If it is intalled properly in your machine, executing `docker-compose` in terminal should not throw an error.

## Configure containers in Docker-compose
1. Set up `.yaml` file
    - Create a new file called `docker-compose.yaml`
    - See `docker-compose.yaml` for the code and explanation
        - If you are using VScode and haven't installed the `Docker` extension, installing it might make life easier for you :D
2. Run docker-compose
    - Stop both pgadmin and postgres docker container, use `docker ps` to check if any other docker container is running
    - Run `docker-compose up -d` to run docker-compose.yaml
      - This initializes and configures the containers specified in the yaml file
      - Docker-compose helps set up a network for the containers created. That said, pgadmin and postgresql cannot yet "seeing" each other, even though they are in the same containre. 

## Configure container "communication"
- One could attribute the lack of communication to the missing specification of volume under pgadmin in docker-compose. But since we have not figure that out, this can be done within `localhost:8000`. Login to `localhost:8000`. Observe that the previous configuration on pgadmin in `localhost:8000` didn't persist because volume wasn't specified.
- Re-create server. Data table should be available after in that server.
    - Set "Name" under General tab (arbitrarily)
    - Set "Host name/address" as `pgdatabase` (recall: it's the name of the postgresql container set in docker-compose) under Connection tab
    - On the same tab, update both "Username" and "Password" to `root`

## Terminate program
- `Ctrl + c` if `-d` wasn't used in previously ran command to run docker-compose
- Execute `docker-compose down`
- `docker ps` to check that containers are no longer running

*fin*
