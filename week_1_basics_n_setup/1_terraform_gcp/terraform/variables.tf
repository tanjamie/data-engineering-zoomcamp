# locals == constants
locals { 
  data_lake_bucket = "dtc_data_lake"
}

variable "project" {
  description = "Your GCP Project ID"
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default = "asia-southeast1"
  # it is good practice to place all your resources in one region, that's why this variable is declared
  # communicate between resources within region is also cheaper
  type = string
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  default = "STANDARD"
}

variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to"
  type = string
  default = "trips_data_all"
}

# not needed/used now because there is already the locals (constant) variable
variable "bucket_name" {
    description = "The name of the Google Cloud Storage bucket. Must be globally unique."
    default = ""
}

# not needed/used now because it is also a part of locals
variable "TABLE_NAME" {
    description = "BigQuery Table"
    type = string
    default = "ny_trips"
}