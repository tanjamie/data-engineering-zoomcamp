# Workflow Orchestration

## What is a Data Pipeline?
A Data Pipeline is a script or chain of scripts that takes in data as input, and output data too. In week 1, we created some sort of script that can be qualified as a data pipeline (figure 1). But this way of coding a pipeline is not ideal, we need to split them up into smaller parts (figure 2). This is so that when a part of the script fails, it can be pinpointed to re-run and the process downstream would not be voided.

![1](https://user-images.githubusercontent.com/86598825/152671203-ff113ecc-92d0-486e-b8fa-922a98cc529b.jpg)
figure 1
![2](https://user-images.githubusercontent.com/86598825/152671206-0209ca2f-94c8-4f76-ae14-2103d02c24df.jpg)
figure 2

### Simple Example of Orchestration
In figure 2, url is the main parameter inputted into the data pipeline. Alternatively, we can repeat this same pipeline for different months. Then, the parameter needed would be the months we want instead of the url. One way to implement this is:
- Write 2 python scripts and 1 bash script that glues everything together. But this is not very convinient because we would need to specify the try logic when a part of the pipeline fails. 
- Need MAKE to specify that wget script needs to run before ingest script is executed

### Complex Exampmle of Orchestration
