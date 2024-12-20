import pyodbc

# Define the connection string
connection_string = (
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=yourdatabasegoeshere.yourservergoeshere.rds.amazonaws.com,1433;'
    'DATABASE=HSSportsDB;'
    'UID=admin;'
    'PWD=yourpasswordgoeshere;'
    'Trusted_connection=No'
)

# Establish the connection
connection = pyodbc.connect(connection_string)

# Create a cursor object
cursor = connection.cursor()

# Example query
cursor.execute("SELECT GETDATE()")

# Fetch and print the results
for row in cursor.fetchall():
    print(row)

# Close the connection
connection.close()


