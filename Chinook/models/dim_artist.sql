with stg_artist as (
    select * from {{ source('chinook','Artist')}}
)
Select {{ dbt_utils.generate_surrogate_key(['stg_artist.Artistid']) }} 
       as artistkey, 
        Artistid, Name as Artist_Name
from stg_artist 