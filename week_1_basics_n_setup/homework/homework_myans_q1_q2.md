# Week 1 Homework: My Attempt

# Question 1. Google Cloud SDK
Install Google Cloud SDK. What's the version you have? To get the version, run `gcloud --version`

```
# MY ANSWER
Google Cloud SDK 370.0.0
bq 2.0.73
core 2022.01.21
gsutil 5.6
```

## Google Cloud account
Create an account in Google Cloud and create a project.

# Question 2. Terraform
Now install terraform and go to the terraform directory (week_1_basics_n_setup/1_terraform_gcp/terraform). After that, run
    - `terraform init`
    - `terraform plan`
    - `terraform apply`
Apply the plan and copy the output (after running `apply`) to the form. It should be the entire output - from the moment you typed `terraform init` to the very end.

```
20jam@LAPTOP-3UT82IK7 MINGW64 ~/Documents/GitHub/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform (main)
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/google from the dependency lock file
- Using previously-installed hashicorp/google v4.9.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

20jam@LAPTOP-3UT82IK7 MINGW64 ~/Documents/GitHub/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform (main)
$ terraform plan
var.project
  Your GCP Project ID

  Enter a value: intense-vault-339709


Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.dataset will be created
  + resource "google_bigquery_dataset" "dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "trips_data_all"
      + delete_contents_on_destroy = false
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "asia-southeast1"
      + project                    = "intense-vault-339709"
      + self_link                  = (known after apply)

      + access {
          + domain         = (known after apply)
          + group_by_email = (known after apply)
          + role           = (known after apply)
          + special_group  = (known after apply)
          + user_by_email  = (known after apply)

          + view {
              + dataset_id = (known after apply)
              + project_id = (known after apply)
              + table_id   = (known after apply)
            }
        }
    }

  # google_storage_bucket.data-lake-bucket will be created
  + resource "google_storage_bucket" "data-lake-bucket" {
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "ASIA-SOUTHEAST1"
      + name                        = "dtc_data_lake_intense-vault-339709"
      + project                     = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = true
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "Delete"
            }

          + condition {
              + age                   = 30
              + matches_storage_class = []
              + with_state            = (known after apply)
            }
        }

      + versioning {
          + enabled = true
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.

20jam@LAPTOP-3UT82IK7 MINGW64 ~/Documents/GitHub/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform (main)
$ terraform apply
var.project
  Your GCP Project ID

  Enter a value: intense-vault-339709


Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.dataset will be created
  + resource "google_bigquery_dataset" "dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "trips_data_all"
      + delete_contents_on_destroy = false
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "asia-southeast1"
      + project                    = "intense-vault-339709"
      + self_link                  = (known after apply)

      + access {
          + domain         = (known after apply)
          + group_by_email = (known after apply)
          + role           = (known after apply)
          + special_group  = (known after apply)
          + user_by_email  = (known after apply)

          + view {
              + dataset_id = (known after apply)
              + project_id = (known after apply)
              + table_id   = (known after apply)
            }
        }
    }

  # google_storage_bucket.data-lake-bucket will be created
  + resource "google_storage_bucket" "data-lake-bucket" {
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "ASIA-SOUTHEAST1"
      + name                        = "dtc_data_lake_intense-vault-339709"
      + project                     = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = true
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "Delete"
            }

          + condition {
              + age                   = 30
              + matches_storage_class = []
              + with_state            = (known after apply)
            }
        }

      + versioning {
          + enabled = true
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.dataset: Creating...
google_storage_bucket.data-lake-bucket: Creating...
google_storage_bucket.data-lake-bucket: Creation complete after 1s [id=dtc_data_lake_intense-vault-339709]
google_bigquery_dataset.dataset: Creation complete after 2s [id=projects/intense-vault-339709/datasets/trips_data_all]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

## Prepare Postgres
Run Postgres and load data as shown in the videos. We'll use the yellow taxi trips from January 2021: `wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv`. You will also need the dataset with zones:`wget https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv`.
Download this data and put it to Postgres.
 
 *fin*