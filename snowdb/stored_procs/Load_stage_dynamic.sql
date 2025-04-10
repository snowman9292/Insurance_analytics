CREATE OR REPLACE PROCEDURE sp_load_stage_tables()
RETURNS STRING
LANGUAGE SQL
AS
$$
DECLARE landing_table STRING;
 staging_table STRING;
 cur CURSOR FOR 
    SELECT LANDING_TABLE, STAGING_TABLE FROM TABLE_MAPPING;

BEGIN
    -- Open cursor and fetch values
    --remove dups
    --handle NULLs
    -- clean up data
    -- add audit cols
    --. Standardize Case
    -- Trim Whitespace
    FOR rec IN cur DO
        -- Assign values to variables
        landing_table := rec.LANDING_TABLE;
        staging_table := rec.STAGING_TABLE;

        -- Load data dynamically from landing to staging
        
        EXECUTE IMMEDIATE 
        'INSERT INTO STAGING_ZONE.' || staging_table || 
        ' SELECT * FROM LANDING_ZONE.' || landing_table || ';';
    END FOR;

    RETURN 'Data loaded successfully for all mapped tables!';
END;
$$;


