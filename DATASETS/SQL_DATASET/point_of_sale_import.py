import mysql.connector
import csv

# Connect to MySQL
conn = mysql.connector.connect(
    host="127.0.0.1",   
    user="root",        
    password="root",
    database="mahendra" 
)
cursor = conn.cursor()

# Open CSV file
with open("POINT_OF_SALE.csv", "r") as file:
    reader = csv.reader(file)
    next(reader)  # Skip the header row

    # Insert data into table
    query = """
        INSERT INTO point_of_sale (`Order Number`, `Product Key`, `Sales Quantity`, `Sales Amount`, `Cost Amount`)
        VALUES (%s, %s, %s, %s, %s)
    """
    for row in reader:
        cursor.execute(query, row)

# Commit and close
conn.commit()
cursor.close()
conn.close()

print("Data imported successfully!")
