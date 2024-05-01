-- dim_invoice.sql
SELECT
    invoiceid,
    customerid AS customerkey,  -- Ensure foreign key references are correct
    invoicedate,
    total AS invoice_total,
    invoiceid AS invoicekey  -- Assuming invoicekey is a surrogate key generated elsewhere
FROM {{ source('chinook', 'invoice') }}