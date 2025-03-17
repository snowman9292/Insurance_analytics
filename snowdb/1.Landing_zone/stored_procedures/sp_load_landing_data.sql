--A stored procedure loads raw data from internal stage  into Snowflake landing tables.

CREATE OR REPLACE PROCEDURE sp_load_landing_cust_data()
RETURNS STRING
LANGUAGE SQL
AS 
$$
    COPY INTO landing.customer_data 
    FROM @landing_stage/customer_data.csv
    FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);
    RETURN 'Landing data loaded successfully!';
$$;
