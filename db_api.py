import psycopg2
#sudo pip install psycopg2
#https://wiki.postgresql.org/wiki/Python

#The try block lets you test a block of code for errors.
try:
    con = psycopg2.connect(dbname = 'db_name', host = 'localhost', port = '5432', user = 'postgres', password = 'your_password')

    #Establish a connection to the database by creating a cursor object
    #Allows Python code to execute PostgreSQL command in a database session.
    #Cursors are created by the connection.cursor() method: they are bound to the connection
    #for the entire lifetime and all the commands are executed in the context of the database
    #session wrapped by the connection.
    cur = con.cursor()
    #sql_query = '''select id, name, dept_name, salary from instructor'''

    #The execute routine executes an SQL statement.
    cur.execute('''select id, name, dept_name, salary from instructor''')
    print("\nSelecting rows from instructor table using cursor.fetchall")
    #The fetchall routine fetches all (remaining) rows of a query result, returning a list.
    #An empty list is returned when no rows are available.
    records = cur.fetchall()

    print("\nPrint each row and it's columns values\n")
    for row in records:
        print("id = ", row[0])
        print("name = ", row[1])
        print("dept_name = ", row[2])
        print("salary = ", row[3], '\n')

#The except block lets you handle the error.
except(Exception, psycopg2.Error) as error:
    print("Error while fetching data from PostgreSQL", error)

#The finally block lets you execute code, regardless of the result of the try- and except blocks.
finally:
    if(con):
        cur.close()
        con.close()
        print("PostgreSQL connection is closed\n")
