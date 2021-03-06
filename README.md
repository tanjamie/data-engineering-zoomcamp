# data-engineering-zoomcamp

## Repository Description
Disclaimer: The study materials here are provided by Data Talks Club's Data Engineering Zoomcamp from 17th January - 13th March 2022. Here is the link to their [original repository](https://github.com/DataTalksClub/data-engineering-zoomcamp) and [course video playlist](https://www.youtube.com/playlist?list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb). This GitHub page is mainly used to store my progress, work done and notes (additional research and insights found) for the course. And for completelness, here's a mini guide to navigate the zoomcamp:
- Study Materials: Collated and organized on the original GitHub page (videos, slides, code, additional instructions)
- Have Questions? Search for similar issues in previous posts on `#course-data-engineering` [slack channel](https://datatalks.club/slack.html) to see if others have had the same error and solved it. Otherwise, post on the channel!
- To check for updates? `#announcements-course-data-engineering` slack channel


## The Syllabus & My Progress
### [Week 1: Introduction & Prerequisites](https://github.com/tanjamie/data-engineering-zoomcamp/tree/main/week_1_basics_n_setup)
- [x] Course overview
- [x] Introduction to GCP
- [x] Docker and docker-compose
- [x] Running Postgres locally with Docker
- [x] Setting up infrastructure on GCP with Terraform
- [x] Preparing the environment for the course
- [x] Homework

### Week 2: Data ingestion
- [ ] Data Lake
- [ ] Workflow orchestration
- [ ] Setting up Airflow locally
- [ ] Ingesting data to GCP with Airflow
- [ ] Ingesting data to local Postgres with Airflow
- [ ] Moving data from AWS to GCP (Transfer service)
- [ ] Homework

### Week 3: Data Warehouse
- [ ] Data warehouse (BigQuery) (25 minutes)
- [ ] What is a data warehouse solution
- [ ] What is big query, why is it so fast, Cost of BQ, (5 min)
- [ ] Partitoning and clustering, Automatic re-clustering (10 min)
- [ ] Pointing to a location in google storage (5 min)
- [ ] Loading data to big query & PG (10 min) -- using Airflow operator?
- [ ] BQ best practices
- [ ] Misc: BQ Geo location, BQ ML
- [ ] Alternatives (Snowflake/Redshift)

*In Progress*


## Overall Architecture
![arch_1](https://user-images.githubusercontent.com/86598825/150659774-1932544b-d4e1-4479-973c-dcb41b355b6e.jpg)


## What technologies are used? What are they for?
1. **Google Cloud Platform (GCP)** >> It is a cloud-based auto-scaling platform by Google
    - **Google Cloud Storage (GCS)** >> Used as data Lake i.e. a central repository to store all data at any scale
    - **BigQuery** >> Utilized as a data warehouse. A data warehouse integrates copies of transaction data from different source systems, manages and analyzes them
2. **Terraform** >> An Infrastructure-as-Code (IaC) tool used to build, change and version resources in the infrastructure safely and easily
4. **Docker** >> Used to containerize resources i.e. docker package applications into containers that combines the sources code with OS libraries and dependencies required for each of the container to run independently
6. **SQL** >> Database language used to interact with the database, thus useful for data analysis & exploration
7. **Airflow** >> Tool to manage workflow in data engineering pipelines i.e. scheduled and orchestrated data pipeline
8. **DBT** >> Tool that makes data transformation, during ETL (extract, transform, load), in warehouse more efficient
9. **Spark** >> An engine for large-scale data processing, which makes use of distributed processing i.e. divide enormous volume of data up for processing to take place in several different nodes running in a cluster i.e. networked computers
10. **Kafka** >> Framework to cope with streaming data i.e. data that is continuously generated by different sources


*fin*
