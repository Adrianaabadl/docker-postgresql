import psycopg2

conn = psycopg2.connect(
    dbname="bitcoin_engine",
    user="postgres",
    password="admin",  
    host="localhost",
    port="5432"
)

cur = conn.cursor()

cur.execute("SELECT COUNT(*) FROM public.bitcoin_data;")
row_count = cur.fetchone()[0]

print(f"Total de filas en bitcoin_data: {row_count}")

cur.close()
conn.close()
