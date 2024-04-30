-- This model selects data from the 'customer_track_reviews' source and generates surrogate keys.

-- Define a staging table for the 'customer_track_reviews' source data.
with stg_trackreview as (
    select * from {{ source('chinook','customer_track_reviews')}}
)

-- Select and generate surrogate keys for customers and tracks, along with sentiment indicators.
select 
    -- Generate a surrogate key for the 'customerid' column.
    {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customerkey, 
    -- Generate a surrogate key for the 'trackid' column.
    {{ dbt_utils.generate_surrogate_key(['trackid']) }} as trackkey, 
    -- Select the original 'customerid' column.
    customerid, 
    -- Select the original 'trackid' column.
    trackid, 
    -- Generate a binary indicator for 'like' sentiment.
    case when sentiment ='like' then '1' else '0' end as likes, 
    -- Select the 'sentiment' column.
    sentiment,
    -- Generate a binary indicator for 'dislike' sentiment.
    case when sentiment ='dislike' then '1' else '0' end as dislikes
from stg_trackreview
