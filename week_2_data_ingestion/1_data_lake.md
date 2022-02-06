# Introduction to Data Lake
## What is Data Lake?
    - Central repository that holds big data form many sources
        - Data stored can be structured, semi structured or unstructured
    - Its purpose is to ingest as much data and as quickly as possible, then make it available and accessible to multiple users
        - Generally associate with somr sort of metadata for faster access
    - Extensively used in machine learning and analytical solutions
    - Features of a data lake solution: 
        - Secure
        - Scalable
        - Hardware should be inexpensive

## Data Lake VS Data Warehouse
### Data Lake
- Usually unstructured data
- Target users: Data Scientist, Data Analyst
- Stores huge amounts of data
- Use cases: Stream processing, ML, real-time analytics

### Data Warehouse
- Generally structured
- Target user: Data Analyst
- Store generally small amount of data
- Use cases: Batch processing, BI reporting

### Why have Data Lakes when there was already Data Warehouses?
- Companies realize the value of data
    - Data Warehouse can only store a relatively small amount of data, thus cannot accomodate to the need to store as much as data as what is wanted by companies
- Need for cheap storage of Big Data
- Cannot always define structure of data
- Store and access data quickly
    - Not unlike in Data Warehouses where a team needs to develope structure of data, the relationships etc, for it to be useful
- Usefulness of data realized later in the project lifecycle, so storage of data is essential
- Increase in data scientists and R&D on data products

## Export-Transform-Load (ETL) vs Export-Load-Transport (ELT)
- ETL is mainly used for a small amount of data whereas ELT is used for large amounts of data
- ETL is a data warehouse solution, whereas ELT provides data lake support 
- ETL builds on the "Schema on write" idea where a well-defined schema, relationships etc is defined before data is written, whereas ELT is based on "Schema on read" idea where data is written before the schema is specified

## Gotcha of Data Lake
- Convert into Data Swamp
    - Data Swamp is difficult to use and be useful
    - There are many reasons a Data Lake turns into a Data Swamp
        - No versioning
        - Incompatible schema for same data without versioning
        - Joins not possible
            - e.g. no foreign keys available
- No metadata associated
    - Makes it difficult for a person to use or figure out how to use the data

## Cloud provider for Data Lake
- Google Cloud Platform (GCP) - Cloud Storage
- Amazon Web Services (AWS) - S3
- AZURE - Azure Blob

*fin*
