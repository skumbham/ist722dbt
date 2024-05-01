-- stg_invoiceline.sql

{{ config(materialized='view') }}

SELECT
    InvoiceLineId,
    InvoiceId,
    TrackId,
    CAST(UnitPrice AS FLOAT) AS UnitPrice,  -- Ensures the unit price is in a float format
    Quantity
FROM {{ source('chinook', 'invoiceline') }}
