#!/bin/bash

#snowsql  -f /home/ravi/analytics_platform/Insurance_analytics/snowsql/put_files.sql
#!/bin/bash
set -e  # Stop script on error
set -x  # Print commands (for debugging)

LOG_FILE="/tmp/snowsql_execution.log"

echo "Starting SnowSQL Execution..." | tee -a $LOG_FILE
snowsql -c sf_conn -f /home/ravi/analytics_platform/Insurance_analytics/snowsql/put_files.sql 2>&1 | tee -a $LOG_FILE
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo "SnowSQL Execution Failed!" | tee -a $LOG_FILE
    exit $EXIT_CODE
fi

echo "SnowSQL Execution Completed Successfully!" | tee -a $LOG_FILE
