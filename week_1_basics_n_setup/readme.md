# Course Overview
- [Video](https://www.youtube.com/watch?v=bkJZDmreIpA&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
- [Slides](https://www.slideshare.net/AlexeyGrigorev/data-engineering-zoomcamp-introduction)

# Section Materials & Instructions
We suggest to watch the videos in the same order as in this document. The last video (setting up the environment) is optional, but you can check it earlier if you have troubles setting up the environment and following along the videos.

## Docker + Postgres
- [x] [Introduction to Docker](https://www.youtube.com/watch?v=EYNwNlOrpr0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
    - Why do we need Docker
    - Creating a simple "data pipeline" in Docker
- [x] [Ingesting NY Taxi Data to Postgres](https://www.youtube.com/watch?v=2JM-ziJt0WI&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
    - Running Posgtres locally with Docker
    - Exploring the NY Taxi dataset
    - Ingesting the data to the database
- [x] [Connecting pgAdmin and Postgres](https://www.youtube.com/watch?v=hCAIVe9N0ow&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
    - The pgAdmin tool
    - Docker networks
- [x] [Putting the ingestion script to Docker](https://www.youtube.com/watch?v=B1WwATwf-vY&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
    - Converting the Jupyter notebook to a Python script
    - Parametrizing the script with argparse
    - Dockerizing the ingestion script
- [x] [Running Postgres and pgAdmin with Docker-Compose](https://www.youtube.com/watch?v=hKI6PkPhpa0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
    - Why do we need Docker-compose
    - Docker-compose YAML file
    - Running multiple containers with docker-compose up
- [x] [SQL refreshser](https://www.youtube.com/watch?v=QEcps_iskgg&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
    - Adding the Zones table
    - Inner joins
    - Basic data quality checks
    - Left, Right and Outer joins
    - Group by
- [x] Optional: If you have some problems with docker networking, check [Port Mapping and Networks in Docker](https://www.youtube.com/watch?v=tOr4hTsHOzU&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
    - Docker networks
    - Port forwarding to the host environment
    - Communicating between containers in the network
    - dockerignore file

## GCP + Terraform
- [x] [Introduction to GCP (Google Cloud Platform)](https://www.youtube.com/watch?v=18jIzE41fJ4&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
- [x] [Introduction to Terraform Concepts & GCP Pre-Requisites](https://www.youtube.com/watch?v=Hajwnmj0xfQ&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
- [x] [Workshop: Creating GCP Infrastructure with Terraform](https://www.youtube.com/watch?v=dNkEgO-CExg&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
- [x] Configuring terraform and GCP SDK on Windows

## If you have problems setting up the env, you can check this video on:
- [x] [Setting up the environment on cloud VM](https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
    - Generating SSH keys
    - Creating a virtual machine on GCP
    - Connecting to the VM with SSH
    - Installing Anaconda
    - Installing Docker
    - Creating SSH config file
    - Accessing the remote machine with VS Code and SSH remote
    - Installing docker-compose
    - Installing pgcli
    - Port-forwarding with VS code: connecting to pgAdmin and Jupyter from the local computer
    - Installing terraform
    - Using sftp for putting the credentials to the remote machine
    - Shutting down and removing the instance


# Environment setup
For this section of the course you'll need:
- Python 3 (e.g. installed with Anaconda)
- Google Cloud SDK
- Docker with docker-compose
- Terraform


# Homework
- [x] Questions & Answers

*fin*
