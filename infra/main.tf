# Creating buckets for the data

resource "google_storage_bucket" "Historical_Raw_Data_Bucket" {
  name                     = var.gcs_bucket
  location                 = var.location
  storage_class            = "STANDARD"
  force_destroy            = true
  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "Temp_Raw_Data_Bucket" {
  name                     = var.temp_gcs_bucket
  location                 = var.location
  storage_class            = "STANDARD"
  force_destroy            = true
  public_access_prevention = "enforced"
}

# Creating Cloud Functions' Buckets

resource "google_storage_bucket" "Initial_Data_Retrieval_Function_Bucket" {
  name                     = var.initial_data_retrieval_function
  location                 = var.location
  storage_class            = "STANDARD"
  force_destroy            = true
  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "Daily_Data_Retrieval_Function_Bucket" {
  name                     = var.daily_data_retrieval_function
  location                 = var.location
  storage_class            = "STANDARD"
  force_destroy            = true
  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "Initial_Data_Processing_Function_Bucket" {
  name                     = var.initial_data_processing_function
  location                 = var.location
  storage_class            = "STANDARD"
  force_destroy            = true
  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "Daily_Data_Processing_Function_Bucket" {
  name                     = var.daily_data_processing_function
  location                 = var.location
  storage_class            = "STANDARD"
  force_destroy            = true
  public_access_prevention = "enforced"
}

# Uploading the source code to each bucket

resource "google_storage_bucket_object" "initial_data_retrieval_function" {
  name   = "initial-data-retrieval.zip"
  bucket = google_storage_bucket.Initial_Data_Retrieval_Function_Bucket.name
  source = "../cloud functions zip/initial-data-retrieval.zip"
  depends_on = [
    google_storage_bucket.Initial_Data_Retrieval_Function_Bucket
  ]
}

resource "google_storage_bucket_object" "daily_data_retrieval_function" {
  name   = "daily-data-retrieval.zip"
  bucket = google_storage_bucket.Daily_Data_Retrieval_Function_Bucket.name
  source = "../cloud functions zip/daily-data-retrieval.zip"
  depends_on = [
    google_storage_bucket.Daily_Data_Retrieval_Function_Bucket
  ]
}

resource "google_storage_bucket_object" "initial_data_processing_function" {
  name   = "initial-data-processing.zip"
  bucket = google_storage_bucket.Initial_Data_Processing_Function_Bucket.name
  source = "../cloud functions zip/load-to-bq.zip"
  depends_on = [
    google_storage_bucket.Initial_Data_Processing_Function_Bucket
  ]
}

resource "google_storage_bucket_object" "daily_data_processing_function" {
  name   = "daily-data-processing.zip"
  bucket = google_storage_bucket.Daily_Data_Processing_Function_Bucket.name
  source = "../cloud functions zip/daily-load-to-bq.zip"
  depends_on = [
    google_storage_bucket.Daily_Data_Processing_Function_Bucket
  ]
}

# Creating Cloud Scheduler Jobs

resource "google_cloud_scheduler_job" "initial_data_retrieval" {
  name        = var.initial_data_retrieval_schedule
  description = "This cron will trigger the initial cloud function to populate the data and will be disabled"
  schedule    = "30 22 * * *"
  time_zone   = "UTC + 1"
  region      = var.region
  http_target {
    uri         = google_cloudfunctions_function.initial-data-retrieval.https_trigger_url
    http_method = "GET"
  }
  depends_on = [
    google_cloudfunctions_function.initial-data-retrieval
  ]
}

resource "google_cloud_scheduler_job" "daily_data_retrieval" {
  name        = var.daily_data_retrieval_schedule
  description = "This cron will trigger the daily cloud function to populate the data"
  schedule    = "30 23 * * *"
  time_zone   = "UTC + 1"
  region      = var.region
  http_target {
    uri         = google_cloudfunctions_function.daily-data-retrieval.https_trigger_url
    http_method = "GET"
  }
  depends_on = [
    google_cloudfunctions_function.daily-data-retrieval
  ]
}

# Creating Cloud Function for Data Ingestion

resource "google_cloudfunctions_function" "initial-data-retrieval" {
  name                  = "initial-data-retrieval"
  description           = "This function is responsible for retrieving the historical weather data from the API and storing it in a GCS bucket."
  runtime               = "python38"
  entry_point           = "get_weather_data"
  timeout               = 3600
  region                = var.region
  available_memory_mb   = 2048
  source_archive_bucket = google_storage_bucket.Initial_Data_Retrieval_Function_Bucket.name
  source_archive_object = google_storage_bucket_object.initial_data_retrieval_function.name
  service_account_email = var.appengine_service_account
  trigger_http          = true
  environment_variables = {

    "WEATHER_API_BASE_URL" = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline",
    "WEATHER_LOCATION"     = "Rabat",
    "UNIT_GROUP"           = "metric",
    "CONTENT_TYPE"         = "CSV",
    "INCLUDE_PARAM"        = "days",
    "GCS_BUCKET"           = var.gcs_bucket,
    "SCHEDULER_JOB_NAME"   = var.initial_data_retrieval_schedule,
    "GCP_LOCATION"         = var.region,
    "GCP_PROJECT_ID"       = var.project_id,
    "WEATHER_API_KEY"      = var.api_keyV1

  }
  depends_on = [
    google_storage_bucket.Initial_Data_Retrieval_Function_Bucket,
    google_storage_bucket_object.initial_data_retrieval_function,
    google_storage_bucket.Historical_Raw_Data_Bucket
  ]
}

resource "google_cloudfunctions_function" "daily-data-retrieval" {
  name                  = "daily-data-retrieval"
  description           = "This function is responsible for retrieving the daily weather data from the API and storing it in a GCS bucket."
  runtime               = "python38"
  entry_point           = "get_weather_data"
  timeout               = 3600
  region                = var.region
  available_memory_mb   = 2048
  source_archive_bucket = google_storage_bucket.Daily_Data_Retrieval_Function_Bucket.name
  source_archive_object = google_storage_bucket_object.daily_data_retrieval_function.name
  service_account_email = var.appengine_service_account
  trigger_http          = true
  environment_variables = {

    WEATHER_API_BASE_URL = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline",
    WEATHER_LOCATION     = Rabat
    UNIT_GROUP           = metric
    CONTENT_TYPE         = CSV
    INCLUDE_PARAM        = days
    GCS_BUCKET           = var.gcs_bucket
    SCHEDULER_JOB_NAME   = var.daily_data_retrieval_schedule
    GCP_LOCATION         = var.region
    GCP_PROJECT_ID       = var.project_id
    TEMP_GCS_BUCKET      = var.temp_gcs_bucket
    "WEATHER_API_KEY"    = var.api_keyV1

  }
  depends_on = [
    google_storage_bucket.Daily_Data_Retrieval_Function_Bucket,
    google_storage_bucket_object.daily_data_retrieval_function,
    google_storage_bucket.Historical_Raw_Data_Bucket
  ]
}

resource "google_cloudfunctions_function" "initial-data-processing" {
  name                  = "load-to-bq"
  description           = "This function is responsible for processing the historical weather data and storing it in a BigQuery table."
  runtime               = "python38"
  entry_point           = "process_csv_data"
  timeout               = 3600
  region                = var.region
  available_memory_mb   = 2048
  source_archive_bucket = google_storage_bucket.Initial_Data_Processing_Function_Bucket.name
  source_archive_object = google_storage_bucket_object.initial_data_processing_function.name
  service_account_email = var.appengine_service_account
  trigger_http          = true
  environment_variables = {

    BIGQUERY_TABLE   = var.bigquery_table
    BIGQUERY_DATASET = var.bigquery_dataset
    GCS_BUCKET       = var.gcs_bucket


  }
  depends_on = [
    google_storage_bucket.Initial_Data_Processing_Function_Bucket,
    google_storage_bucket_object.initial_data_processing_function,
    google_storage_bucket.Historical_Raw_Data_Bucket
  ]
}

resource "google_cloudfunctions_function" "daily-data-processing" {
  name                  = "daily-data-processing"
  description           = "This function is responsible for processing the daily weather data and storing it in a BigQuery table."
  runtime               = "python38"
  entry_point           = "process_csv_data"
  timeout               = 3600
  region                = var.region
  available_memory_mb   = 2048
  source_archive_bucket = google_storage_bucket.Daily_Data_Processing_Function_Bucket.name
  source_archive_object = google_storage_bucket_object.daily_data_processing_function.name
  service_account_email = var.appengine_service_account
  trigger_http          = true
  environment_variables = {

    BIGQUERY_TABLE   = var.bigquery_table
    BIGQUERY_DATASET = var.bigquery_dataset
    TEMP_GCS_BUCKET  = var.temp_gcs_bucket

  }
  depends_on = [
    google_storage_bucket.Daily_Data_Processing_Function_Bucket,
    google_storage_bucket_object.daily_data_processing_function,
    google_storage_bucket.Temp_Raw_Data_Bucket
  ]
}

resource "google_bigquery_dataset" "Weather_Dataset" {
  dataset_id    = var.bigquery_dataset
  friendly_name = var.bigquery_dataset
  description   = "This dataset contains the weather data for the city of Rabat."
  location      = "US"

  access {
    role          = "OWNER"
    user_by_email = var.appengine_service_account
  }
}
