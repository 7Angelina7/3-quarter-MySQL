USE shop;
USE sample;

-- Практическое задание по теме “Транзакции, переменные, представления”
-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;

INSERT INTO sample.users 
SELECT id, name 
FROM shop.users 
WHERE id = 1;

COMMIT;


-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".


DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(50) READS SQL DATA
BEGIN
	CASE  
		WHEN CURTIME() BETWEEN '06:00:00' AND '11:59:59' THEN RETURN 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '17:59:59' THEN RETURN 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '23:59:59' THEN RETURN 'Добрый вечер';
		WHEN CURTIME() BETWEEN '00:00:00' AND '05:59:59' THEN RETURN 'Доброй ночи';
	END CASE;
END//
DELIMITER ;

SELECT hello(); 



