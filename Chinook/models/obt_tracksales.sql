-- This model selects data from the 'fact_tracksales', 'dim_invoice', and 'dim_track' models.

-- Define a staging table for the 'fact_tracksales' model.
with f_tracksales as (
    select * from {{ ref('fact_tracksales') }}
),
-- Define a staging table for the 'dim_invoice' model.
d_invoice as (
    select * from {{ ref('dim_invoice') }}
),
-- Define a staging table for the 'dim_track' model.
d_track as (
    select * from {{ ref('dim_track') }}
)
-- Select data from the staged models and join them to create a consolidated view.
select 
    -- Select all columns from the 'dim_invoice' model.
    i.*, 
    -- Select all columns from the 'dim_track' model.
    t.*, 
    -- Select the 'quantity' column from the 'f_tracksales' model.
    f.quantity, 
    -- Select the 'soldamount' column from the 'f_tracksales' model.
    f.soldamount
from 
    -- Left join the 'f_tracksales' staged table with the 'd_invoice' staged table on 'invoicekey'.
    f_tracksales f
left join 
    d_invoice i on i.invoicekey = f.invoicekey
-- Left join the 'f_tracksales' staged table with the 'd_track' staged table on 'trackkey'.
left join 
    d_track t on t.trackkey = f.trackkey
