# Terraform Concepts & Setting up Google Cloud Provider (GCP)

## Terraform Concepts Overview
### Introduction: What is Terraform?
1. Open-source tool by HashiCorp, used for provisioning infrastructure resources e.g. vm, containers, networking resources, using declarative condiguration files
2. Takes an Infrastructure=as-Code (IaC) approach to build, change and manage infrastructure in a safe, consistent and repeatable way by defining resource configuration that you can version, reuse and share (p.s. like a Git version control, but for infrastructure)
3. Manages configuration in source control to maintain an ideal provisioning state for testing and production environment
4. Supports DevOps best practices for change management
### Advantages of Terraform
1. Infrastructure lifecycle management
2. Version control commits
3. Very useful for stack-based deployments, and with cloud providers such as AWS, GCP, Azure, KBS...
4. State-based approach to track resource changes throughout deployments

## Pre-Requisites
### Install Terraform Client

### Get Started on GCP account 
The course uses GCP free version (up to EUR 300 credits with 90 days lifecycle):
1. Create an account with your Google email ID
2. Setup your first project e.g. "dtc-dez", and note down the project ID
    - Choose the correct project name at the dropdown at the top blue bar or create a new project
    - To ceate a new project, give a project name e.g. "dtc-dez"
    - Edit Project ID so it is more likely to be unique. To randomly generate a new project id, click onto the refresh button
    - Click onto create. From here, go back to the dropdown to find select the project created
4. Setup service account & authentication for this project, and download auth-keys (.json)
    - Firstly, what is a service account? It is an account for services, and it's where all the required configuration are done under. The account provides the credentials needed to access all the GCP services in return, and helps services on GCP interact with each other without the use of the Owner or Admin account. But, it has stricter and limited permissions!
    - Create and setup a service account
      - Click onto the tribar >> IAM & Admin >> Service Account >> "+ CREATE SERVICE ACCOUNT"
      - 1) Enter service account name, service account then create and continue. Note, service account do not have to be unique because it is already unique since its combined with the service email address of the project
      - 2) Under "Grant this service account access to project", go to basic then add a viewer role for now
      - 3) Not required for now, but useful when setting up a production environment with multiple users associated to the service account which share the same permissions
    - Download auth-keys
      - Under the action column, click onto the ellipsis and choose "Manage Keys"
      - Select "Add Key", "New Key" and select "JSON" before creating
      - The auth-key JSON file pop-up should appear, save the file and take note of its location
6. Download SDK for local setup
7. Set environment variable to point to your downloaded GCP auth-keys

## Workshop: Setup GCP for Project
