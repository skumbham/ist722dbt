# Chinook Data Warehouse with dbt and Snowflake

This repository contains the dimensional models and data transformations for the **Chinook Data Warehouse** project, implemented using dbt (Data Build Tool) and Snowflake. Completed as part of the MS in Applied Data Science program at Syracuse University's School of Information Studies, this project focuses on building a robust, scalable data warehouse for a sample digital media store (Chinook database) using star schema, dimensional modeling, and data warehousing best practices.

## Project Overview

The objective of this project is to create a data warehouse in Snowflake using dbt to structure and transform raw data from the **Chinook database**. The data warehouse allows efficient querying and analysis of media sales, customer behaviors, and track reviews. The project models raw data from sources such as Amazon S3 into structured, accessible tables in Snowflake, utilizing a star schema for optimized querying. Data is refreshed daily at midnight, ensuring timely insights.

## Project Structure

The project files are organized as follows:

- **models/**
  - **dim_artist.sql**: Dimension table capturing artist metadata.
  - **dim_customer.sql**: Dimension table containing customer details, including demographics.
  - **dim_customertrackreview.sql**: Dimension table with customer reviews, capturing feedback and ratings for each track.
  - **dim_date.sql**: Dimension table for dates, facilitating time-based analysis and trends.
  - **dim_invoice.sql**: Dimension table for invoices, representing transaction records.
  - **dim_playlist.sql**: Dimension table for playlists, detailing playlist metadata.
  - **dim_playlisttrack.sql**: Dimension table linking playlists and tracks.
  - **dim_track.sql**: Dimension table for track metadata, including genre and album details.
  - **fact_artistreleases.sql**: Fact table capturing artist release data, supporting analysis of release patterns.
  - **fact_playlisttracksadded.sql**: Fact table containing information on tracks added to playlists, enabling playlist activity analysis.
  - **fact_trackreview.sql**: Fact table for track reviews, integrating sentiment analysis for a qualitative perspective on customer reviews.
  - **fact_tracksales.sql**: Fact table for track sales, with metrics such as quantity sold and revenue by track.
  - **obt_tracksales.sql**: The **One Big Table (OBT)**, a consolidated table providing an accessible summary of key sales metrics, updated daily to ensure real-time insights.
  - **sources.yml**: Source configuration for dbt models, defining the raw data sources from Amazon S3 for the transformation in Snowflake.

## Setup Instructions

### Prerequisites

- **Snowflake**: A cloud-based data warehouse.
- **dbt Cloud**: A cloud service for managing and running dbt projects.
- **Amazon S3**: Data source for raw files, configured to Snowflake for streamlined access.

### Getting Started

1. **Clone the Repository**
   ```sh
   git clone https://github.com/skumbham/ist722dbt.git
   cd ist722dbt
    ```
2. **Configure dbt Cloud**

   Set up dbt Cloud with your Snowflake credentials to connect to the data warehouse and configure access to data stored in Amazon S3.

3. **Run dbt Models**

   Execute dbt commands to build the models in Snowflake, transforming raw data into structured, analytics-ready tables.

## Data Pipeline

The data pipeline is automated to run every 24 hours, pulling raw data from Amazon S3 into Snowflake. This ensures the data is consistently updated and transformed, allowing for real-time insights. The workflow includes:

- **Data Ingestion:** Raw data from Amazon S3 is ingested into Snowflake, where it’s stored and prepared for transformation.
- **Transformation:** Using dbt, raw data is transformed into staging tables (e.g., `stg_invoice`, `stg_track`, `stg_album`) and subsequently into dimension and fact tables.
- **Daily Refresh:** An automated daily refresh is scheduled at midnight, ensuring that the data warehouse reflects the latest data.

## Project Details

- **Dimensional Models:** Dimensional models are organized in a star schema, facilitating efficient querying and reporting. Dimension tables like `dim_customer` and `dim_track` structure essential metadata, while fact tables such as `fact_tracksales` track metrics by track.
- **One Big Table (OBT):** The OBT (`obt_tracksales.sql`) consolidates data into a single table, simplifying reporting by centralizing essential sales metrics and minimizing the need for complex joins.
- **Surrogate Keys:** Using `dbt_utils`, surrogate keys are generated for dimension tables, enabling efficient joins and enhancing data consistency.
- **Sentiment Analysis:** Sentiment analysis is applied to customer track reviews within the `fact_trackreview.sql` table, providing a qualitative understanding of customer preferences.
- **Data Handling:** The models are configured to handle null values and concatenate fields (e.g., names and addresses), ensuring clean, complete data in the data warehouse.

## Visualization and Insights

The data model supports comprehensive reporting and insights, enabling users to analyze:

- **Track Sales:** The fact tables capture details on track sales, including metrics like quantity sold and total revenue, supporting analyses of sales trends.
- **Customer Reviews:** By incorporating sentiment analysis, the project enables qualitative insights into customer preferences and satisfaction.
- **Release Trends:** `fact_artistreleases.sql` captures artist releases, helping identify patterns in media releases.
- **Playlist Activity:** `fact_playlisttracksadded.sql` provides insights into playlist dynamics and user engagement with tracks.

## Usage

To replicate or extend this project:

1. **Clone the Repository:** Follow the instructions above to download and set up the repository.
2. **Run the Cleaning Script:** Execute the provided dbt models to transform and load data into Snowflake.
3. **Access Insights:** Access the final OBT and other fact tables to conduct business intelligence analysis on sales, customer preferences, and media consumption trends.

## Contribution

Contributions to this project are welcome. Areas for improvement include:

- **Enhancing Data Cleaning:** Improve the handling of null values or optimize city name corrections.
- **Extending Analysis:** Add new dimensions or fact tables to capture additional metrics.
- **Optimizing Performance:** Implement or suggest improvements for dbt model efficiency and Snowflake performance.

## Contact

For questions or discussions, please [open an issue](https://github.com/skumbham/ist722dbt/issues/new) in this repository.

---

This project aligns with the **MS in Applied Data Science Program Learning Outcomes**:

- **Outcome 1:** Collected, stored, and accessed data efficiently using Snowflake, dbt, and Amazon S3.
- **Outcome 2:** Applied the full data science lifecycle to develop actionable insights.
- **Outcome 3:** Created dimensional models and an OBT to support scalable business intelligence.
- **Outcome 4:** Utilized SQL and dbt to transform and manage datasets.
- **Outcome 5:** Documented and presented findings to support stakeholders’ understanding.
- **Outcome 6:** Ensured ethical data handling practices with a focus on data quality and transparency.

