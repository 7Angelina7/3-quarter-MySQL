-- 1)  Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
-- в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	id BIGINT(20) NOT NULL,
	user_name VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


-- **********  TRIGGER ON users  **********
DROP TRIGGER IF EXISTS log_users;
delimiter //
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, id, user_name)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;


-- **********  TRIGGER ON catalogs  **********
DROP TRIGGER IF EXISTS log_catalogs;
delimiter //
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, id, user_name)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;


-- **********  TRIGGER ON products  **********
DROP TRIGGER IF EXISTS log_products;
delimiter //
CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, id, user_name)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;


-- **********  Tests for users  **********
SELECT * FROM users;
SELECT * FROM logs;


INSERT INTO users (name, birthday_at)
VALUES ('Михаил', '1985-07-07'),
		('Степан', '1980-01-10'),
		('Дмитрий', '1989-12-01');

SELECT * FROM users;
SELECT * FROM logs;


-- **********  Tests for catalogs  **********
SELECT * FROM catalogs;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES ('Игровой компьютер'),
		('Термопаста'),
		('Кулер для процессора');

SELECT * FROM catalogs;
SELECT * FROM logs;


-- **********  Tests for products  **********
SELECT * FROM products;
SELECT * FROM logs;

INSERT INTO products (name, desription, price, catalog_id)
VALUES ('intel Xeon E5 2630v3', 'Игровой компьютер', 36000.00, 8),
		('Arctic MX-6 4 грамма ACTCP00080A', 'Термопаста', 900.00, 9),
		('ID-COOLING SE-224-XTS BLACK', 'Кулер для процессора', 2150.00, 10);

SELECT * FROM products;
SELECT * FROM logs;

-- 2) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DROP TABLE IF EXISTS test_users; 
CREATE TABLE test_users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATE,
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
 	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


DROP PROCEDURE IF EXISTS insert_into_users ;
delimiter //
CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 1000000;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO test_users(name, birthday_at) VALUES (CONCAT('user_', j), NOW());
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //
delimiter ;


-- test
SELECT * FROM test_users;

CALL insert_into_users();

SELECT * FROM test_users LIMIT 3;
