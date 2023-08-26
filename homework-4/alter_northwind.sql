-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products
ADD CONSTRAINT chk_unit_price CHECK (unit_price > 0)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products
ADD CONSTRAINT chk_discontinued CHECK (discontinued IN (0, 1))

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
SELECT * INTO discontinued_products FROM products WHERE discontinued = 1

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products;

DELETE FROM products WHERE discontinued = 1;

--удалить то удалил поля со значением discontinued = 1, а вот связь восстановить не смог,
--выдает ошибку Ключ (product_id)=(42) отсутствует в таблице "products"
--в чем ошибка и на что обратить внимание, может что с ключами недопонял, с остальным вроде все хорошо
ALTER TABLE order_details ADD CONSTRAINT fk_order_details_products FOREIGN KEY (product_id) REFERENCES products (product_id)