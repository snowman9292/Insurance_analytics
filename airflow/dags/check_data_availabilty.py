#from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
#from airflow.providers.snowflake.operators.snowflake_operator import SnowflakeOperator
from airflow import DAG
#from airflow.providers.snowflake.sensors.snowflake import SnowflakeSqlSensor
#from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from airflow.providers.common.sql.sensors.sql import SqlSensor
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from datetime import datetime, timedelta


SNOWFLAKE_CONN_ID = 'snowflake-conn'

default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),
    'retries': 1,
}
with DAG('snowflake_data_pipeline',
         default_args=default_args,
         schedule_interval=timedelta(hours=1) )  as dag:

    check_new_data = SqlSensor(
        task_id='check_new_data',
        conn_id=SNOWFLAKE_CONN_ID,
        sql="""
        SELECT COUNT(*) FROM LANDING_ZONE.LANDING_CLAIM;       
        """,
        mode='poke',
        timeout=3600,
        poke_interval=300,
    )


    # Task to process the new data
    process_new_data = SqlSensor(
        task_id='process_new_data',
        conn_id=SNOWFLAKE_CONN_ID,
        sql='CALL staging_zone.move_data_to_staging();',
    )

    check_new_data >> process_new_data
