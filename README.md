# Rabat Weather Data Pipeline

## Project Overview

This project is a comprehensive data pipeline designed to automate the collection, processing, and storage of weather data for Rabat, Morocco. Built on Google Cloud Platform (GCP), it leverages various services including Cloud Storage, Cloud Functions, Cloud Scheduler, and BigQuery. The entire infrastructure is provisioned using Terraform, allowing for effective disaster recovery and easy replication of the environment.

### Google Cloud Storage (GCS) Buckets

- **Historical Raw Data Bucket**: Stores all historical weather data, serving as a long-term storage solution.
- **Temporary Raw Data Bucket**: Holds the most recent weather data for daily processing before transfer to BigQuery.

### Cloud Functions

- **Initial Data Retrieval (`initial-data-retrieval`)**:
  - Retrieves a significant amount of historical weather data.
  - Stores this data in the Historical Raw Data Bucket.
  - Triggers `initial_data_processing` function for subsequent processing.
  - Upon completion, it deletes the Cloud Scheduler job that initiated it.

- **Initial Data Processing (`initial_data_processing`)**:
  - Processes the historical data from the Temporary Raw Data Bucket.
  - Transforms and loads the data into BigQuery.

- **Daily Data Retrieval (`daily-data-retrieval`)**:
  - Fetches the latest weather data each day.
  - Stores the data in both the Historical and Temporary Raw Data Buckets.
  - Triggers `daily_data_processing` function for processing.

- **Daily Data Processing (`daily_data_processing`)**:
  - Processes the daily weather data from the Temporary Raw Data Bucket.
  - Appends the processed data to the BigQuery table.
  - Empties the Temporary Raw Data Bucket, preparing it for the next day.

### Cloud Scheduler Jobs

- **Initial Data Retrieval Job**: Schedules the `initial-data-retrieval` function to run once, initiating the historical data collection, it is deleted upon completion.
- **Daily Data Retrieval Job**: Scheduled to run daily, triggering the `daily-data-retrieval` function for ongoing data collection.

### BigQuery Resources

- **Weather Dataset**: A dedicated dataset for housing weather data tables.
- **Weather Table**: Stores processed weather data, ready for analysis and querying.

### Data Flow and Processing

- **Initial Setup and Historical Data Processing**:
  - Begins with a one-time execution of `initial-data-retrieval`, fetching and storing historical weather data.
  - The data is processed by `initial_data_processing` and stored in BigQuery.
- **Daily Data Retrieval and Processing**:
  - The `daily-data-retrieval` function operates daily, gathering new weather data.
  - The `daily-data-processing` function processes this data and appends it to the BigQuery table.

### Terraform Configuration

- The project's infrastructure, including GCS buckets, Cloud Functions, and BigQuery resources, is defined and managed using Terraform.
- Terraform provides a repeatable and version-controlled deployment method, crucial for disaster recovery and infrastructure management.

## Security and Setup Instructions

### Service Account Credentials

- The project utilizes a service account for GCP resource management. For security reasons, the file containing these credentials is not included in the project.
- You must replace the `credentials_example.json` with an actual configuration file. Follow these instructions:
  - Replace placeholders like `<PROJECT_ID>`, `<PRIVATE_KEY_ID>`, `<YOUR_PRIVATE_KEY>`, `<CLIENT_EMAIL>`, and `<CLIENT_ID>` with your specific values.
  - `<CLIENT_EMAIL_ENCODED>` should be the URL-encoded version of the client email.
  - Keep the actual private key and sensitive information confidential and secure.
- Proper permissions should be granted to the used service account.

### Terraform Setup

1. **Terraform Installation**: Ensure Terraform is installed in your environment.
2. **Service Account Key**: Place your service account key file in a secure location and reference it in your Terraform configuration.
3. **Initialize Terraform**: Run `terraform init` to initialize the working directory containing Terraform configuration files.
4. **Apply Terraform Configuration**: Execute `terraform apply` to create the resources as defined in the configuration files.

### API Key Configuration

- For accessing the weather data API, an API key is required. The key is not included in the project for security reasons.
- Replace the contents of `API_KEY_EXAMPLE` with your actual API key.

## Conclusion

This project showcases a scalable and automated solution for weather data collection and analysis within GCP. It emphasizes security, efficiency, and reliability, ensuring consistent data processing and availability for insightful analysis.