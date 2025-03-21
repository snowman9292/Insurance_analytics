import snowflake.connector
import os

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
GITHUB_REPO_PATH = "/home/runner/work/Insurance_analytics/Insurance_analytics/"
CSV_DIR = os.path.join(GITHUB_REPO_PATH, "feeds")  # Path to the 'feeds' directory

# Define table and file mappings
table_file_map = {
    'landing_claim': 'landing_claim.csv',
    'landing_customer': 'landing_customer.csv',
    'landing_product': 'landing_product.csv',
    'landing_policy':  'landing_policy.csv',
    'landing_sales': 'landing_sales.csv'    
}
#put the cvs files into internal stage
# Loop through tables and execute COPY INTO
for table, file_pattern in table_file_map.items():
    csv_file = os.path.join(CSV_DIR, f"{table}.csv")
    if os.path.exists(csv_file):
        put_command = f"PUT file://{csv_file} @{SNOWFLAKE_STAGE}"
        print(put_command)
        cursor.execute(put_command)
        print(f"✅ Uploaded {csv_file} to Snowflake Internal Stage.")
    else:
        print(f"File not found: {csv_file}")
    put_command = f"PUT file://{csv_file} @{SNOWFLAKE_STAGE}"
    cursor.execute(put_command)
    sql = f"""
    COPY INTO {table}
    FROM @{SNOWFLAKE_STAGE}
    FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)
    files = '{file_pattern}';
    """
   
    print(sql)
    cursor.execute(sql)
    print(f"✅ Data loaded into {table}")

cursor.close()
conn.close()
