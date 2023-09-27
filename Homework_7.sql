USE shop;
-- 1)  1.Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT
	users.id,
	users.name
FROM orders
JOIN users 
ON (users.id=orders.user_id);

-- 2)  2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT 
	products.id, 
	products.name AS product,
    catalogs.name
FROM products 
LEFT JOIN catalogs 
ON catalogs.id = products.catalog_id;

