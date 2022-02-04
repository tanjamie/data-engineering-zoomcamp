# Terraform Concepts & Setting up Google Cloud Provider (GCP)

## Terraform Concepts Overview
### Introduction: What is Terraform?
1. Open-source tool by HashiCorp, used for provisioning infrastructure resources e.g. vm, containers, networking resources, using declarative condiguration files
2. Takes an Infrastructure-as-Code (IaC) approach to build, change and manage infrastructure in a safe, consistent and repeatable way by defining resource configuration that you can version, reuse and share (p.s. like a Git version control, but for infrastructure)
3. Manages configuration in source control to maintain an ideal provisioning state for testing and production environment
4. Supports DevOps best practices for change management
### Advantages of Terraform
1. Infrastructure lifecycle management
2. Version control commits
3. Very useful for stack-based deployments, and with cloud providers such as AWS, GCP, Azure, KBS...
4. State-based approach to track resource changes throughout deployments

## Pre-Requisites
### Install Terraform Client
Download zip from [here](https://www.terraform.io/downloads). Unzip the file and run terraform.exe. Then add PATH to system environment. The complete steps are illustrated well [here](https://www.radishlogic.com/terraform/how-to-install-terraform-in-windows-11/#Download).
> **ERROR SOLVER** >> If `terraform.exe` does not run for you, follow the instructions [here](https://www.radishlogic.com/terraform/how-to-install-terraform-in-windows-11/)

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
    - Google SDK is a CLI tool to interact with the cloud services e.g. list services, authenticate, from your local machine. To check if gcloud is already in your environment, do `gcloud -v`. If you need to install it (for "plain Windows"):
        - You will need a Linux-like environment e.g. GitBash, MinGW, cygwin
        - Download SDK in zip [here](https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip) or from the [source](https://cloud.google.com/sdk/docs/downloads-interactive)
        - Unzip the file and run the `install.sh` script
        - During installation, you might see `The installation is unable to automatically update your system PATH. Please add `C:\tools\google-cloud-sdk\bin`. Adjust your `.bashrc` to include the `PATH` using these [instructions](https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path), or add the `PATH` system-wide like [this](https://gist.github.com/nex3/c395b2f8fd4b02068be37c961301caa7)
        - Point Google Cloud to the correct Python installation. In Anaconda, do `export CLOUDSDK_PYTHON=~/Anaconda3/python`
        - To check that it works, again do `gcloud -v`
8. Set environment variable to point to your downloaded GCP auth-keys
    - Google Cloud SDK Authentication
        - Now, we will need the keys we have previously downloaded. Take note of its location, e.g. `C:/Users/Username/.../ny-rides.json` p.s. I renamed my file, yours should be similar to your project ID
        - Check that it is indeed that key we just created using timestamp `ls -ltr C:/Users/Username/.../ny-rides.json`
        - Set `GOOGLE_APPLICATION_CREDENTIALS` to point to the file using `export GOOGLE_APPLICATION_CREDENTIALS="C:/Users/Username/Use/Your/Own/PATH/ny-rides.json"`
        - Option 1: Authenticate with `gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS`
            > **ERROR SOLVER** >> If you encounter `Python was not found ...` (1) Do `python --version` to check that there is python (2) Check environmental path (3) Got to "Start", search for "Manage App Execution Aliases" and turn of those related to python
        - Option 2: Do `gcloud auth application-default login`
            > **ERROR SOLVER** >> If you get `WARNING: Cannot find a quota project to add to ADC ...`, run `PROJECT_NAME="put_your_project_id_here" then `gcloud auth application-default set-quota-project ${PROJECT_NAME}`
        - To check that authentication is successful, do `gcloud auth list`
        - You can repeat the above to refresh service account's auth-token if it has expired

## Create Infrastructure for our Project with Terraform
1. What we need:
    - Google Cloud Storage (GCS) is a bucket in the GCP environment and can act as Data Lake i.e. storage of raw data in a more organized way
    - Big Query is the Google-equivalent data warehouse
2. Add permissions for previously created service account
    - Add more roles for the user/service (in this case, Terraform) so it has ownership level position, i.e. it can create, update, delete, write, grant others access etc.
        - Go to IAM & Admin >> IAM >> Click onto the pencil icon for the correct "Principal"
        - Add predefined "Storage Admin" role to use GCS, but note this only provides permission to the bucket itself
        - Add predefined "Storage Object Admin" role to grant our service permissions to the objects within the bucket
        - Add predefined "BigQuery Admin"
    - In production, a service account is only attached to one service for security and customed role would be assigned instead of the predefined ones
2. Enable APIs
    - For this, make sure you are in the right project
    - The local machine and the cloud do not interact directly with each other, but through the APIs i.e. APIs are the enablers of communication, so we need to enable the respective APIs
        - For IAM itself: Search "Identity and Access Management (IAM) API" and click "Enable"
        - For IAM Credentials: Search "IAM Service Account Credentials API" and click "Enable"
3. Terraform configuration
    - There are 3 files: `main.tf`, `variables.tf`, `.tfstate` (optional: resources.tf, output.tf)

## Workshop: Setup GCP for Project
