-- This model selects data from the 'Artist' table in the 'chinook' source and generates surrogate keys.

-- Define a staging table for the 'Artist' source data.
with stg_artist as (
    select * from {{ source('chinook','Artist')}}
)

-- Select and generate surrogate keys for artists.
select 
    -- Generate a surrogate key using dbt_utils.generate_surrogate_key() function.
    {{ dbt_utils.generate_surrogate_key(['stg_artist.Artistid']) }} as artistkey, 
    -- Select the original Artistid.
    Artistid, 
    -- Alias the 'Name' column as 'Artist_Name'.
    Name as Artist_Name
from stg_artist
