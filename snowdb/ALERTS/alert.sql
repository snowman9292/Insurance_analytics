
--send a mail if the most recent execution was successful
    CREATE or replace ALERT notify_proc_completion
    WAREHOUSE = COMPUTE_WH
    SCHEDULE = '1 MINUTE'
    IF (EXISTS (
        SELECT 1 
        FROM INSURANCE_ANALYTICS.LANDING_ZONE.my_events
        where value like '%SUCCESS%'
        and sp_load_landing_to_staging
        and timestamp > CURRENT_TIMESTAMP - INTERVAL '5 MINUTE'
        AND  LOWER(resource_attributes:"snow.executable.name"::STRING) LIKE '%sp_load_landing_to_staging%'
            ))
    THEN
    CALL SYSTEM$SEND_EMAIL(
        'Load_status_notification',
        'rkorugan@gmail.com',
        'COUNT MATCHED ',
        'LOADING THE DATA '
    );
