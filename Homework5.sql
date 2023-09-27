/* 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их
текущими датой и временем.*/

UPDATE shop.users SET created_at = NOW(), updated_at = NOW();

/* 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы
типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10.
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/

ALTER TABLE users
MODIFY COLUMN created_at DATETIME,
MODIFY COLUMN updated_at DATETIME;

/* 3.  В таблице складских запасов storehouses_products в поле value могут встречаться самые
разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех
записей.*/

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
  (1, 54, 0),
  (1, 79, 2500),
  (1, 34, 0),
  (1, 82, 30),
  (1, 72, 500),
  (1, 64, 1);
  
 
 SELECT * FROM storehouses_products ORDER BY IF (value > 0, 0, 1), value;

/* 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и
мае. Месяцы заданы в виде списка английских названий (may, august) */

SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');

/* 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM
catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN. */

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

/* Практическое задание теме «Агрегация данных»
1. Подсчитайте средний возраст пользователей в таблице users. */

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age FROM users;

/* 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
Следует учесть, что необходимы дни недели текущего года, а не года рождения. */

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day, 
COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

/* 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы. */

SELECT ROUND(EXP(SUM(LN(id)))) FROM shop.users;



