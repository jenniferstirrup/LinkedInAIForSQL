from sqlalchemy import create_engine

# Database connection parameters
server = "database-1.crmk0oqauuoa.us-east-1.rds.amazonaws.com,1433"
database = "HSSportsDB"
username = "admin"
password = "Docile-Latch4-Reconcile"  # Replace with your actual password

# Connection string
connection_string = f"mssql+pyodbc://{username}:{password}@{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server"

# Create the engine
try:
    engine = create_engine(connection_string)
    connection = engine.connect()
    print("Connection to SQL Server database successful")
except Exception as e:
    print("Error while connecting to SQL Server:", e)
finally:
    if 'connection' in locals():
        connection.close()
