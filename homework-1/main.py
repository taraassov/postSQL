"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import psycopg2

# Подключение к базе данных PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="north",
    user="postgres",
    password="d2ds"
)

# Открытие файла employees_data.csv и чтение данных
with open('north_data/employees_data.csv', newline='') as csvfile:
    reader = csv.reader(csvfile)
    next(reader)  # Пропуск заголовка
    for row in reader:
        # Вставка данных в таблицу employees
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO employees (employee_id, first_name, last_name, title, birth_date, notes) VALUES (%s, %s, %s, %s, %s, %s)",
            (row[0], row[1], row[2], row[3], row[4], row[5])
        )
        conn.commit()

# Открытие файла customers_data.csv и чтение данных
with open('north_data/customers_data.csv', newline='') as csvfile:
    reader = csv.reader(csvfile)
    next(reader)  # Пропуск заголовка
    for row in reader:
        # Вставка данных в таблицу customers
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO customers (customer_id, company_name, contact_name) VALUES (%s, %s, %s)",
            (row[0], row[1], row[2])
        )
        conn.commit()

# Открытие файла orders_data.csv и чтение данных
with open('north_data/orders_data.csv', newline='') as csvfile:
    reader = csv.reader(csvfile)
    next(reader)  # Пропуск заголовка
    for row in reader:
        # Вставка данных в таблицу orders
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city) VALUES (%s, %s, %s, %s, %s)",
            (row[0], row[1], row[2], row[3], row[4])
        )
        conn.commit()

# Закрытие соединения с базой данных
conn.close()