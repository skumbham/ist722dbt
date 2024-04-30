-- This model selects data from the 'invoiceline', 'Track', 'invoice', and 'DateDimension' sources and generates surrogate keys.

-- Define a staging table for the 'invoiceline', 'Track', and 'invoice' source data.
with 
stg_trackinvoiceline as (
    select 
        t.*, 
        il.invoiceid,
        il.quantity,
        -- Cast 'invoicedate' to TIMESTAMP and extract the date.
        LEFT(CAST(i.invoicedate AS TIMESTAMP), 10) AS invoicedate
    from 
        {{ source('chinook','invoiceline')}} il 
    join 
        {{ source('chinook','Track')}} t  on t.trackid = il.trackid
    join 
        {{ source('chinook','invoice')}} i on i.invoiceid = il.invoiceid 
),
-- Define a staging table for the 'DateDimension' source data.
stg_date as (
    SELECT * from {{ source('conformed','DateDimension')}}
)

-- Select and generate surrogate keys for invoices, tracks, and invoice dates, along with sales information.
SELECT 
    -- Generate a surrogate key for the 'invoiceid' column.
    {{ dbt_utils.generate_surrogate_key(['t.invoiceid']) }} as invoicekey, 
    -- Generate a surrogate key for the 'trackid' column.
    {{ dbt_utils.generate_surrogate_key(['t.trackid']) }} as trackkey,
    -- Select the 'DateKey' column from 'stg_date' as 'invoicedatekey'.
    d.DateKey as invoicedatekey, 
    -- Select the 'invoicedate' column from 'stg_trackinvoiceline'.
    t.invoicedate,
    -- Select the original 'trackid' column.
    t.trackid,
    -- Select the original 'invoiceid' column.
    t.invoiceid,
    -- Select the original 'UnitPrice' column.
    t.UnitPrice,
    -- Calculate the sum of 'Quantity' for each track.
    SUM(t.Quantity) AS Quantity, 
    -- Calculate the sum of the sold amount for each track.
    SUM(t.Quantity * t.UnitPrice) AS Soldamount
FROM 
    stg_trackinvoiceline t
-- Left join 'stg_date' on 'invoicedate'.
left join 
    stg_date d on t.invoicedate = d.date
GROUP BY 
    -- Group by columns for aggregation.
    t.UnitPrice,
    t.trackid,
    t.invoiceid,
    d.DateKey,
    t.invoicedate
