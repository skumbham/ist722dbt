# Chinook Data Warehouse with dbt and Snowflake

This repository contains the dimensional models for the Chinook database, implemented using dbt (Data Build Tool) and Snowflake. These models are designed to facilitate efficient querying and analysis of the Chinook database, which is a sample database representing a digital media store.

## Project Structure

The project is organized as follows:

- **models/**
  - **dim_artist.sql**: Dimension table for artists.
  - **dim_customer.sql**: Dimension table for customers.
  - **dim_customertrackreview.sql**: Dimension table for customer track reviews.
  - **dim_date.sql**: Dimension table for dates.
  - **dim_invoice.sql**: Dimension table for invoices.
  - **dim_playlist.sql**: Dimension table for playlists.
  - **dim_playlisttrack.sql**: Dimension table for playlist tracks.
  - **dim_track.sql**: Dimension table for tracks.
  - **fact_artistreleases.sql**: Fact table for artist releases.
  - **fact_playlisttracksadded.sql**: Fact table for tracks added to playlists.
  - **fact_trackreview.sql**: Fact table for track reviews.
  - **fact_tracksales.sql**: Fact table for track sales.
  - **obt_tracksales.sql**: Operational business table for track sales.
  - **sources.yml**: Source configuration for dbt models.

## Setup Instructions

### Prerequisites

- **Snowflake**: A cloud-based data warehousing service.
- **dbt Cloud**: A cloud-based service for running dbt projects.

### Getting Started

1. **Clone the Repository**
   ```sh
   git clone https://github.com/skumbham/ist722dbt.git
   cd ist722dbt

### Project Details

- **Dimensional Models**: These models transform raw data into a star schema, making it suitable for analysis.
- **Surrogate Keys**: Utilized `dbt_utils` to generate surrogate keys for various tables.
- **Sentiment Analysis**: Incorporated sentiment analysis for customer reviews.
- **Data Handling**: Managed null values and concatenated names and addresses effectively.
