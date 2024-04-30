-- This model selects data from the 'invoice' source and generates surrogate keys.

-- Select and generate surrogate keys for invoices and customers.
select 
    -- Generate a surrogate key for the 'InvoiceId' column.
    {{ dbt_utils.generate_surrogate_key(['InvoiceId']) }} as invoicekey, 
    -- Generate a surrogate key for the 'CustomerId' column.
    {{ dbt_utils.generate_surrogate_key(['CustomerId']) }} as customerkey,
    -- Select the original 'InvoiceId' column.
    InvoiceId, 
    -- Select the original 'CustomerId' column.
    CustomerId, 
    -- Alias the 'Total' column as 'Invoice_Total'.
    Total as Invoice_Total,
    -- Cast 'Invoicedate' to TIMESTAMP and alias as 'Invoicedate'.
    CAST(Invoicedate AS TIMESTAMP) AS Invoicedate,
    -- Concatenate 'billingCity', 'billingstate', and 'billingCountry' columns as 'Maps_address'.
    concat(billingCity, ', ', COALESCE(billingstate, 'N/A'), ',', billingCountry) as Maps_address
from {{ source('chinook','invoice')}}
