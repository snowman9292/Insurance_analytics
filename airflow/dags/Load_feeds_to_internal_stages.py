from airflow import DAG
#from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from airflow.operators.python import PythonOperator
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
#from airflow.providers.snowflake.operators.snowflake import SnowflakeQueryOperator
from datetime import datetime, timedelta
import os
from airflow.operators.bash import BashOperator
import pendulum
from airflow.sensors.sql import SqlSensor
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from airflow.operators.empty import EmptyOperator



# Define SQL script path
sql_script_path = "/home/ravi/analytics_platform/Insurance_analytics/snowsql/snowsql_master.sql"
SNOWFLAKE_CONN_ID = "snowflake-conn"
# Define Indian Standard Time (IST)
local_tz = pendulum.timezone("Asia/Kolkata")
BUSINESS_EMAIL = "business_team@example.com"
REQUIRED_FILES = ["landing_claim.csv.gz", "landing_customer.csv.gz", "landing_policy.csv.gz","landing_product.csv.gz","landing_sales.csv.gz"]

# Function to execute Python script'
def run_my_script():
    script_path = "/home/ravi/analytics_platform/Insurance_analytics/ETL/python/load_stage_table.py"
     # Update this path
    os.system(f"python3 {script_path}")

# Default arguments for the DAG
default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2024, 3, 21),
    "retries": 1,
    "retry_delay": timedelta(minutes=1),
}

# Define the DAG
dag = DAG(
    "Load_feed_files",
    default_args=default_args,
    description="Run SQL script first, then execute Python script every 5 minutes",
    schedule_interval="*/5 * * * *",  # Runs every 5 minutes
    template_searchpath=["/home/ravi/analytics_platform/Insurance_analytics/snowsql"],
    catchup=False
)
# Define DAG
default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2025, 3, 30, tzinfo=local_tz),
    "retries": 3,
    "retry_delay": timedelta(minutes=5),
}
with DAG(
        dag_id="Load_Landing_tables",
        default_args=default_args,
        schedule_interval="*/5 * * * *",  # Runs every 5 minutes
        catchup=False,
        tags=["snowflake", "sensor"],
        template_searchpath=["/home/ravi/analytics_platform/Insurance_analytics/snowsql"],

) as dag:

    sql_last = """
    LIST @INSURANCE_ANALYTICS.LANDING_ZONE.LANDING_INTERNAL_STAGE;
    WITH stage_files AS (
        SELECT SPLIT_PART("name", '/', -1) AS filename        
        FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))
    )
    SELECT COUNT(*) FROM stage_files
    WHERE filename IN ('{{ params.required_files | join("', '") }}')
    HAVING COUNT(*) = '{{ params.required_files | length }}'; 
    """
# Step 4: Wait for required files using SnowflakeSensor
wait_for_files = SqlSensor(
				task_id="wait_for_required_files",
				conn_id=SNOWFLAKE_CONN_ID,
				sql=sql_last,
				mode="poke",  # Keeps checking until condition is met
				poke_interval=30,  # Check every 60 seconds
				timeout=1800,  # Timeout after 30 minutes
				params={"required_files": REQUIRED_FILES}
				)
#Load Landing Tables
Load_landing_tables = PythonOperator(
    task_id="Load_landing_tables",
    python_callable=run_my_script,
    dag=dag,
)
#Load stage table
Load_staging = EmptyOperator(task_id="Load_stage")
#Load RAWVault Tables using DBT
Load_rawvault = EmptyOperator(task_id="Load_rv")
#Load Business vault Tables using DBT
Load_business_vault = EmptyOperator(task_id="Load_BV")


# Set execution order: SQL → Python
wait_for_files >> Load_landing_tables >> Load_staging >> Load_rawvault >> Load_business_vault
