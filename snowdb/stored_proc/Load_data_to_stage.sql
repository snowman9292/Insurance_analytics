CREATE OR REPLACE PROCEDURE move_data_to_staging()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
  -- Start transaction
  BEGIN TRANSACTION;
  
  -- Insert data from landing to staging table
  INSERT INTO INSURANCE_ANALYTICS.STAGING_ZONE.STAGING_CLAIM
  SELECT * FROM INSURANCE_ANALYTICS.LANDING_ZONE.LANDING_CLAIM;
  
  -- Optionally, truncate the landing table after moving data
  -- TRUNCATE TABLE INSURANCE_ANALYTICS.LANDING_ZONE.LANDING_CLAIM;
  
  -- Commit transaction
  COMMIT;
  
  RETURN 'Data moved successfully';
EXCEPTION
  WHEN OTHERS THEN
    -- Rollback transaction in case of error
    ROLLBACK;
    RETURN 'Data move failed: ' || ERROR_MESSAGE();
END;
$$;
