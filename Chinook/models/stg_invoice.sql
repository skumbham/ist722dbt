-- stg_invoice.sql

{{ config(materialized='view') }}

SELECT
    InvoiceId,
    CustomerId,
    CAST(InvoiceDate AS DATE) AS InvoiceDate,  -- Ensures the invoice date is treated as a date
    BillingAddress,
    BillingCity,
    BillingState,
    BillingCountry,
    BillingPostalCode,
    CAST(Total AS FLOAT) AS Total  -- Ensures the total is in a float format for consistency
FROM {{ source('chinook', 'invoice') }}
