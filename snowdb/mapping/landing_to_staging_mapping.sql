
USE DATABASE Insurance_analytics;
USE SCHEMA LANDING_ZONE;


CREATE TABLE IF NOT EXISTS landing_to_staging( 
    landing_table STRING,
    staging_table STRING
); 
