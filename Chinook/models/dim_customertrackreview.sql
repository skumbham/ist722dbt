-- This model selects data from the 'customer_track_reviews' source and generates surrogate keys.

-- Define a staging table for the 'customer_track_reviews' source data.
with stg_trackreview as (
    select * from {{ source('chinook','customer_track_reviews')}}
)

-- Select and generate surrogate keys for customer-track reviews.
select 
    -- Generate a surrogate key for the 'customerid' column.
    {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customerkey, 
    -- Generate a surrogate key for the 'trackid' column.
    {{ dbt_utils.generate_surrogate_key(['trackid']) }} as trackkey, 
    -- Select the original 'customerid' column.
    customerid, 
    -- Select the original 'trackid' column.
    trackid, 
    -- Select the 'sentiment' column.
    sentiment 
from stg_trackreview
