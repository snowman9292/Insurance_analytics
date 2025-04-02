import snowflake.connector
import os
from dotenv import load_dotenv
# Load environment variables from .env file
load_dotenv()

# Snowflake connection details from environment variables
conn = snowflake.connector.connect(
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
    database=os.getenv("SNOWFLAKE_DATABASE"),
    schema=os.getenv("SNOWFLAKE_SCHEMA")
)

SNOWFLAKE_DB='INSURANCE_ANALYTICS.'
SNOWFLAKE_STAGE = f"{os.getenv('SNOWFLAKE_SCHEMA')}.{os.getenv('SNOWFLAKE_STAGE')}"
SNOWFLAKE_STAGE=SNOWFLAKE_DB+SNOWFLAKE_STAGE

print(SNOWFLAKE_STAGE)
cursor = conn.cursor()
# Define the local GitHub repo path (update this to match your repo structure)
#GITHUB_REPO_PATH = "/home/runner/work/Insurance_analytics/Insurance_analytics/"
LOCAL_REPO_PATH= "/home/ravi/analytics_platform/Insurance_analytics"
CSV_DIR = os.path.join(LOCAL_REPO_PATH, "feeds")  # Path to the 'feeds' directory

# Define table and file mappings
table_file_map = {    
    'landing_customer': 'landing_customer.csv.gz',
    'landing_claim': 'landing_claim.csv.gz',
    'landing_product': 'landing_product.csv.gz',
    'landing_policy':  'landing_policy.csv.gz',
    'landing_sales': 'landing_sales.csv.gz'    
}
#put the cvs files into internal stage


# Loop through tables and execute COPY INTO commnd
for table, file_pattern in table_file_map.items():
    sql =f"""
     TRUNCATE TABLE {table}
     """
    print(sql)
    cursor.execute(sql)
    print(f"Table  {table} truncated")
    sql = f"""
    COPY INTO {table}
    FROM @{SNOWFLAKE_STAGE}
    FILE_FORMAT = my_csv_format
    MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
    ON_ERROR = 'CONTINUE'
    files = ('{file_pattern}');
    """   
    print(sql)

    cursor.execute(sql)
    print(f"✅ Data loaded into {table}")

cursor.close()
conn.close()
