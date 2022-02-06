# How to Setup the Airflow Environment with Docker-compose?
## Components of an Airflow Installation
![arch-diag-airflow](https://user-images.githubusercontent.com/86598825/152673804-bdcb0b2b-7ffc-40ee-a215-822694057d02.png)
1. Webserver >> A handy graphical user interface to inspect, trigger and debug the behavior of tags and tasks. This is available on localhost:8080.
2. Scheduler >> Component responsible for scheduling jobs:
    - Handles both triggering and scheduled workflows
    - Submits task to the executor to run
    - Monitors all tasks and tags
    - Triggers the task instances once their dependencies are complete
3. Worker >> Component which executes the tasks given by the scheduler
4. Metadata database >> Backend to the airflow environment. It is used by the scheduler, executor, and web server to store the state of the environment
5. Other components in the docker-compose services (optional)
    - Redis >> Message broker that forwards messages from the scheduler to the worker
    - Flower >> Monitoring the environment available on localhost:5555
    - Airflow init service >> Initialization service (customed to the workshop's design) which initializes configuration such as backend, user credentials, environment variables etc.

## Pre-requisites to Setup the Environment
1. To standardize across the project's config, rename the service account keys that you created from previous week i.e. `ny-rides.json` to `google_credentials.json` and store it on `$HOME` directory (on local machine) using the following code:
      ```
      cd ~ && mkdir -p ~/.google/credentials/
      mv <path/to/your/service-account-authkeys>.json ~/.google/credentials/google_credentials.json
      ```
2. You may need to upgrade your docker-compose version to v2.x+, and set the memory for your Docker Engine to minimum 5GB (ideally 8GB). If insufficient memory is allocated, it might cause airflow-webserver to continuously restart.
    - Go to Docker Desktop setting "preferences", enter "resources" and edit "memory"

## Airflow Setup
1. Create a sub-directory called `airflow` in your project directory
2. Import the official image and setup the latest Airflow version with `curl -LfO 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml'`
3. It cloud be overwhelming to see a lot of services in here. But this is only a quick-start template, and as you proceed you'll figure out which unused servicescan be removed
4. Set the Airflow user 
    - On Linux, the quick-start needs to know your host user-id and needs to have group id set to 0. Otherwise, the file created in "dags", "logs" and "plugins' will be created with root user. You have to make sure to configure them for the docker-compose:
