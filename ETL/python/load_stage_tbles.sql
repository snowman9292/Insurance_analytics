import snowflake.connector

# Snowflake connection details
conn = snowflake.connector.connect(
    user='your_user',
    password='your_password',
    account='your_account'
)

cur = conn.cursor()

# List of table-to-file mappings
table_file_map = {
    'table1': 'table1_*.csv',
    'table2': 'table2_*.csv',
    'table3': 'table3_*.csv'
}

# Loop through tables and execute COPY INTO
for table, file_pattern in table_file_map.items():
    sql = f"""
    COPY INTO {table}
    FROM @your_internal_stage
    FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)
    PATTERN = '{file_pattern}';
    """
    cur.execute(sql)
    print(f"Data loaded into {table}")

cur.close()
conn.close()
