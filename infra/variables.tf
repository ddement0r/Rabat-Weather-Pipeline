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

variable "appengine_service_account" {
  default = "rabat-weather-pipeline@appspot.gserviceaccount.com"
}

variable "schema" {
  default = [
    {
      "name" : "date",
      "mode" : "NULLABLE",
      "type" : "DATE",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "tempmax",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "tempmin",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "temp",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "feelslikemax",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "feelslikemin",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "feelslike",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "dew",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "humidity",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "precip",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "precipprob",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "precipcover",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "snow",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "snowdepth",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "windgust",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "windspeed",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "winddir",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "sealevelpressure",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "cloudcover",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "visibility",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "solarradiation",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "solarenergy",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "uvindex",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "sunrise",
      "mode" : "NULLABLE",
      "type" : "TIME",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "sunset",
      "mode" : "NULLABLE",
      "type" : "TIME",
      "description" : null,
      "fields" : []
    },
    {
      "name" : "moonphase",
      "mode" : "NULLABLE",
      "type" : "FLOAT",
      "description" : null,
      "fields" : []
    }
  ]
}
