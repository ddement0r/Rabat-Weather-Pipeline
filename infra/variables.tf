# Variables File

variable "region" {
  description = "The region where the resources are created."
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where the resources are created."
  default     = "us-central1"
}

variable "location" {
  description = "The location where the resources are created."
  default     = "US"
}

variable "gcs_bucket" {
  description = "The Historical Raw Data GCS bucket name"
  default     = "rabat-weather-raw"
}

variable "temp_gcs_bucket" {
  description = "The Temporary Raw Data GCS bucket name"
  default     = "rabat-weather-raw-temp"
}

variable "initial_data_retrieval_function" {
  description = "initial data retrieval function bucket"
  default     = "initial-data-retrieval-function"
}

variable "daily_data_retrieval_function" {
  description = "daily data retrieval function bucket"
  default     = "daily-data-retrieval-function"
}

variable "initial_data_processing_function" {
  description = "initial data processing function bucket"
  default     = "initial-data-processing-function"
}

variable "daily_data_processing_function" {
  description = "daily data processing function bucket"
  default     = "daily-data-processing-function"
}

variable "initial_data_retrieval_schedule" {
  default = "initial-retrieval"
}

variable "daily_data_retrieval_schedule" {
  default = "daily-retrieval"
}

variable "project_id" {
  default = "rabat-weather-pipeline"
}

variable "bigquery_dataset" {
  default = "RabatWeatherDataset"
}

variable "bigquery_table" {
  default = "CleanedWeatherData"
}

variable "api_keyV1" {
  default = "GMAXH2TBPZFX3VM24J3EAABCE"
}

variable "api_keyV2" {
  default = "K2QSGXPXL29WZJRTFWBFMW6GD"
}

variable "appengine_service_account" {
  default = "rabat-weather-pipeline@appspot.gserviceaccount.com"
}
