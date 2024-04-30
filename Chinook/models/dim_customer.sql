-- This model selects data from the 'customer' table in the 'chinook' source and generates surrogate keys.

-- Select and generate surrogate keys for customers.
select 
    -- Generate a surrogate key using dbt_utils.generate_surrogate_key() function.
    {{ dbt_utils.generate_surrogate_key(['CustomerId']) }} as customerkey,
    -- Select the original CustomerId.
    CustomerId, 
    -- Concatenate 'firstname' and 'Lastname' columns and alias as 'Customer_name'.
    concat(firstname, ', ', Lastname) as Customer_name, 
    -- Alias the 'Company' column as 'Company_name'.
    Company as Company_name,
    -- Alias the 'Address' column as 'Customer_Address'.
    Address as Customer_Address, 
    -- Alias the 'City' column as 'Customer_city'.
    City as Customer_city,
    -- Concatenate 'City', 'State', and 'Country' columns as 'Maps_address'.
    concat(City, ', ', COALESCE(State, 'N/A'), ',', Country) as Maps_address,
    -- Alias the 'Country' column as 'Customer_Country'.
    Country as Customer_Country, 
    -- Alias the 'PostalCode' column as 'Customer_Postalcode'.
    PostalCode as Customer_Postalcode,
    -- Use COALESCE to replace NULL 'State' values with 'N/A' and alias as 'Customer_State'.
    COALESCE(State, 'N/A') as Customer_State, 
    -- Alias the 'phone' column as 'customer_phone'.
    phone as customer_phone, 
    -- Alias the 'fax' column as 'customer_fax'.
    fax as customer_fax, 
    -- Alias the 'email' column as 'customer_Email'.
    email as customer_Email,
    -- Select the 'SupportRepId' column.
    SupportRepId
from {{ source('chinook', 'customer')}}
