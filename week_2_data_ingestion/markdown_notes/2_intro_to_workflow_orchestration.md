# Workflow Orchestration

## What is a Data Pipeline?
A Data Pipeline is a script or chain of scripts that takes in data as input, and output data too. In week 1, we created some sort of script that can be qualified as a data pipeline (figure 1). But this way of coding a pipeline is not ideal, we need to split them up into smaller parts. This is so that when a part of the script fails, it can be pinpointed to re-run and the process downstream would not be voided.
![1](https://user-images.githubusercontent.com/86598825/152671203-ff113ecc-92d0-486e-b8fa-922a98cc529b.jpg)

### Simple Example of how Orchestration can look like
![2](https://user-images.githubusercontent.com/86598825/152672249-dee9a0e6-4994-474b-869e-6d8f73d53ccf.jpg)
- Instead of URL month can be the main parameter. This enables running the same pipeline for different months. One way to implement this:
  - Write 2 python scripts and 1 bash script that glues everything together
  - This way is not very convinient because we would need to use specify the try logic when a part of the pipeline fails. Workflow tools e.g. MAKE, can help specify that wget script needs to run before the ingest script is executed

### Complex Example of how Orchestration can look like
![3](https://user-images.githubusercontent.com/86598825/152672255-4f0ac84a-084b-4c34-9f39-71537324efdd.jpg)
Workflow can become very complicated with multiple jobs, in this case 5, that can have components which run in parallel with each other.

## Workflow Work Station
### We have this workflow, but how do we execute? 
- How do we make sure that job number 1 runs first, then job 2, job 3, etc. 
- How do we make sure that we have some sort of retrying mechanism when some parts of the pipeline fails e.g. sudden faulty internet connection, gcs temporarily down etc?

### The answer is WORKFLOW ENGINES!
- Allow us to define DAG and parametrize the graph
- It has some retrying mechanism, based on the history and logs it collects
- There are many tools available that can act as a Workflow Engine:
  - MAKE >> Only for local orchestration and for smaller workflows
  - LUIGI
  - APACHE AIRFLOW >> Will be used in this course
  - PREFECT

*fin*
