-- This model selects data from the 'DateDimension' source.

-- Select data from the 'DateDimension' source.
select     
    -- Cast 'datekey' to an integer and alias as 'datekey'.
    datekey::int as datekey,
    -- Select the 'date' column.
    date,
    -- Select the 'year' column.
    year,
    -- Select the 'month' column.
    month,
    -- Select the 'quarter' column.
    quarter,
    -- Select the 'day' column.
    day, 
    -- Select the 'dayofweek' column.
    dayofweek,
    -- Select the 'weekofyear' column.
    weekofyear,
    -- Select the 'dayofyear' column.
    dayofyear,
    -- Select the 'quartername' column.
    quartername,
    -- Select the 'monthname' column.
    monthname,
    -- Select the 'dayname' column.
    dayname,
    -- Select the 'weekday' column.
    weekday
from {{ source('conformed','DateDimension')}}
