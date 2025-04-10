CREATE OR REPLACE PROCEDURE sp_load_landing_to_staging()
RETURNS STRING
LANGUAGE SQL
AS
$$
DECLARE 
    landing_table STRING;
    staging_table STRING;
    landing_cols ARRAY;
    staging_cols ARRAY;
    col_list STRING;
    sql_stmt STRING;
BEGIN
    FOR record IN (SELECT LANDING_TABLE, STAGING_TABLE,LANDING_SCHEMA,STAGING_SCHEMA FROM TABLE_MAPPING) DO
        
        landing_table := record.LANDING_TABLE;
        staging_table := record.STAGING_TABLE;
        landing_schema:=record.LANDING_SCHEMA;
        staging_schema:=record.STAGING_SCHEMA;

        -- Get columns of landing table
        SELECT ARRAY_AGG(COLUMN_NAME) 
        FROM (
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = landing_table
        AND TABLE_SCHEMA = landing_schema -- optional if needed
        ORDER BY ORDINAL_POSITION
        );

      SELECT ARRAY_AGG(COLUMN_NAME) 
        FROM (
            SELECT COLUMN_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = staging_table
            AND TABLE_SCHEMA = staging_schema  -- optional if needed
            ORDER BY ORDINAL_POSITION
        );

      

        -- Compare column names
        IF landing_cols = staging_cols THEN
            -- Create comma-separated column list
            col_list := ARRAY_TO_STRING(landing_cols, ', ');

            -- Build dynamic insert statement
            sql_stmt := 'INSERT INTO STAGING_SCHEMA.' || staging_table || 
                        ' (' || col_list || ')' ||
                        ' SELECT ' || col_list || 
                        ' FROM LANDING_SCHEMA.' || landing_table || ';';

            -- Execute statement
            EXECUTE IMMEDIATE sql_stmt;
        ELSE
            -- Log mismatch
            RETURN 'Column mismatch between ' || landing_table || ' and ' || staging_table;
        END IF;

    END FOR;

    RETURN 'All matching tables loaded successfully.';
END;
$$;
