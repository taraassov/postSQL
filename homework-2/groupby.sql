-- Напишите запросы, которые выводят следующую информацию:
-- 1. заказы, отправленные в города, заканчивающиеся на 'burg'. Вывести без повторений две колонки (город, страна) (см. таблица orders, колонки ship_city, ship_country)
SELECT DISTINCT ship_city, ship_country
FROM orders
WHERE ship_city LIKE '%burg';

-- 2. из таблицы orders идентификатор заказа, идентификатор заказчика, вес и страну отгрузки. Заказ отгружен в страны, начинающиеся на 'P'. Результат отсортирован по весу (по убыванию). Вывести первые 10 записей.
--У меня вопрос, а как я должен догадаться что вес в таблице указан как груз? weight и freight
SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country LIKE 'P%'
ORDER BY freight DESC
LIMIT 10;

-- 3. фамилию, имя и телефон сотрудников, у которых в данных отсутствует регион (см таблицу employees)
SELECT last_name, first_name, home_phone
FROM employees
WHERE region IS NULL;

-- 4. количество поставщиков (suppliers) в каждой из стран. Результат отсортировать по убыванию количества поставщиков в стране
SELECT country, COUNT(*) AS quantity
FROM suppliers
GROUP BY country
ORDER BY quantity DESC;

-- 5. суммарный вес заказов (в которых известен регион) по странам, но вывести только те результаты, где суммарный вес на страну больше 2750. Отсортировать по убыванию суммарного веса (см таблицу orders, колонки ship_region, ship_country, freight)
SELECT ship_country, ship_region, SUM(freight) AS weight
FROM orders
WHERE ship_region IS NOT NULL
GROUP BY ship_country, ship_region
HAVING SUM(freight) > 2750
ORDER BY weight DESC;

-- 6. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers) и работники (employees).
SELECT DISTINCT country
FROM customers
WHERE country IN (
   SELECT DISTINCT country
   FROM suppliers
) AND country IN (
   SELECT DISTINCT country
   FROM employees
)

-- 7. страны, в которых зарегистрированы и заказчики (customers) и поставщики (suppliers), но не зарегистрированы работники (employees).
SELECT DISTINCT country
FROM customers
WHERE country IN (
   SELECT DISTINCT country
   FROM suppliers
) AND country NOT IN (
   SELECT DISTINCT country
   FROM employees
)