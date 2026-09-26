from src.data.load_data import get_mysql_connection


connection = get_mysql_connection()

print("MySQL connection successful")
print("Database:", connection.database)

connection.close()
print("Connection closed")