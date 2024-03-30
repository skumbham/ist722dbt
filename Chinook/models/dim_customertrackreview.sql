with stg_trackreview as (
    select * from {{ source('chinook','customer_track_reviews')}}
)
select {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customerkey, 
        {{ dbt_utils.generate_surrogate_key(['trackid']) }} as trackkey, customerid, trackid, sentiment 
    from stg_trackreview