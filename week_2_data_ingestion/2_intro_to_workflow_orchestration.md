# Workflow Orchestration

## What is a Data Pipeline?
A script or chain of scripts that takes in data as input, and output data files too. In week 1, we created some sort of script that can be qualified as a data pipeline (see illustration). But this way of coding a pipeline is not ideal, we need to split them up into smaller parts (see illustration). This is so that when a part of the script fails, it can be pinpointed to re-run and the process downstream would not be voided.

![1](https://user-images.githubusercontent.com/86598825/152671203-ff113ecc-92d0-486e-b8fa-922a98cc529b.jpg)
![2](https://user-images.githubusercontent.com/86598825/152671206-0209ca2f-94c8-4f76-ae14-2103d02c24df.jpg)
