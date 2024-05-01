-- dim_customer.sql
SELECT
    customerid,
    firstname,
    lastname,
    company,
    address,
    city,
    state,
    country,
    postalcode,
    phone,
    email
FROM {{ source('chinook', 'customer') }}