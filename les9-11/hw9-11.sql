-- Видеоурок №9


-- Практическое задание по теме “Транзакции, переменные, представления”


-- Задание №1 


DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
use sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(45) NOT NULL,
	birthday_at DATE DEFAULT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM users;

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop_online.users WHERE id = 1;
COMMIT;

SELECT * FROM users;

-- Задание №2

use shop_online;
CREATE OR REPLACE VIEW prods_desc(prod_id, prod_name, cat_name) AS
SELECT p.id AS prod_id, p.name, cat.name
FROM products AS p
LEFT JOIN catalogs AS cat 
ON p.catalog_id = cat.id;

SELECT * FROM prods_desc;



-- Практическое задание по теме “Администрирование MySQL” 

-- Задание №1

DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop_online.* TO 'shop_reader'@'localhost';

-- test
INSERT INTO catalogs(name)
 -- denied for this user
VALUES('New catalog');
 -- success
SELECT * FROM catalogs;

-- shop - доступны любые операции в пределах базы данных shop
DROP USER IF EXISTS 'shop'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT ALL ON shop_online.* TO 'shop'@'localhost';
GRANT GRANT OPTION ON shop_online.* TO 'shop'@'localhost';

-- test
INSERT INTO catalogs(name)
 -- success
VALUES('New catalog');
 -- have new catalog
SELECT * FROM catalogs;


--  Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- Задание №1

DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END //
delimiter ;

CALL hello();

-- Задание №2

DROP TRIGGER IF EXISTS nullTrigger;
delimiter //
CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
delimiter ;

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 5000, 2); -- FAIL ! Trigger Warning

INSERT INTO products (name, description, price, catalog_id)
VALUES ("GeForce GTX 1080", NULL, 15000, 12); -- success

INSERT INTO products (name, description, price, catalog_id)
VALUES ("GeForce GTX 1080", "Мощная видеокарта", 15000, 12); -- success






-- Видеоурок №11


-- Задание №1



DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


-- **********  TRIGGER ON users  **********
DROP TRIGGER IF EXISTS watchlog_users;
delimiter //
CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;


-- **********  TRIGGER ON catalogs  **********
DROP TRIGGER IF EXISTS watchlog_catalogs;
delimiter //
CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;


-- **********  TRIGGER ON products  **********
delimiter //
CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;


-- **********  Tests for users  **********
SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('Кнехт', '1900-01-01');

SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('Liu Kangh', '1900-01-01'),
		('Sub-Zero', '1103-01-01'),
		('Scorpion', '1103-01-01'),
		('Raiden', '0000-00-01');

SELECT * FROM users;
SELECT * FROM logs;


-- **********  Tests for catalogs  **********
SELECT * FROM catalogs;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES ('Оперативная память'),
		('Куллера'),
		('Аксессуары');

SELECT * FROM catalogs;
SELECT * FROM logs;


-- **********  Tests for products  **********
SELECT * FROM products;
SELECT * FROM logs;

INSERT INTO products (name, description, price, catalog_id)
VALUES ('PATRIOT PSD34G13332', 'Оперативная память', 3000.00, 13),
		('DARK ROCK PRO 4 (BK022)', 'Куллера', 500.00, 14),
		('Коврик', 'Коврик для мыши', 150.00, 15);

SELECT * FROM products;
SELECT * FROM logs;






