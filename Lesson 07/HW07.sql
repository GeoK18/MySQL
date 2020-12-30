# 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине


SELECT DISTINCT name 
  FROM users 
  INNER JOIN orders  
    ON users.id = orders.user_id;
    
    
 # 2)Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT  Prod.name AS product_name, Cat.name AS catalog_name 
FROM products Prod
INNER JOIN catalogs Cat on Cat.id = Prod.catalog_id;

# 3)  Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
# Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов



 CREATE TABLE IF NOT EXISTS flights(
 	id SERIAL PRIMARY KEY,
 	`from` VARCHAR(50) NOT NULL COMMENT 'en', 
 	`to` VARCHAR(50) NOT NULL COMMENT 'en'
 );

 CREATE TABLE  IF NOT EXISTS cities(
 	label VARCHAR(50) PRIMARY KEY COMMENT 'en', 
 	name VARCHAR(50) COMMENT 'ru'
 );

 ALTER TABLE flights
 ADD CONSTRAINT fk_from_label
 FOREIGN KEY(`from`)
 REFERENCES cities(label);

 ALTER TABLE flights
 ADD CONSTRAINT fk_to_label
 FOREIGN KEY(`to`)
 REFERENCES cities(label);

 INSERT INTO cities VALUES
 	('Moscow', 'Москва'),
 	('Saint Petersburg', 'Санкт-Петербург'),
 	('Novosibirsk', 'Новосибирск'),
 	('Kalinigrad', 'Калининград'),
 	('Perm', 'Пермь');

 INSERT INTO flights VALUES
 	(NULL, 'Moscow', 'Saint Petersburg'),
 	(NULL, 'Saint Petersburg', 'Perm'),
 	(NULL, 'Kalinigrad', 'Novosibirsk'),
 	(NULL, 'Moscow', 'Novosibirsk'),
 	(NULL, 'Perm', 'Kalinigrad');


SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	flight_id;
