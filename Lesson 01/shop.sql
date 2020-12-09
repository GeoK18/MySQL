/*Интернет-магазин */

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL primary key,
  name VARCHAR(255) COMMENT 'Название раздела',
  unique unique_name(name(10)) /*запрет встаки разделов, которые уже добавлены в таблицу (10 символов)*/
  -- primary key (id, name(10)) /*Задаём первичный ключ по id и первым 10 символам столбца name*/
) COMMENT = 'Разделы интернет-магазина';

-- insert into catalogs values (null,'Процессоры');
-- insert into catalogs (id, name) values (null,'Процессоры'); /* явно задаём порядок столбцов*/
-- insert into catalogs values (default,'Процессоры');

insert ignore into catalogs values
  (default,'Процессоры'),
  (default,'Мат. платы'),
  (default,'Видеокарты');

 select id, name from catalogs; /*для извлечения данных, после select указываем список извлек столбцовб после from имя таблицы*/
 
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL primary key, 
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения', /*добавили ДР, чтобы давать скидку в ДР*/
  created_at DATETIME default CURRENT_TIMESTAMP, 
  updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP /*Дата и время последнего обновления пользователя */
) COMMENT = 'Покупатели';

insert into users (id, name, birthday_at) values (1, 'John', '1979-01-27');
select * from users;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL primary key, 
  name VARCHAR(255) COMMENT 'Название',
  desription TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT unsigned,
   created_at DATETIME default CURRENT_TIMESTAMP, 
  updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, /*Дата и время последнего обновления пользователя */
  key index_of_catalog_id(catalog_id)
  ) COMMENT = 'Товарные позиции';
  
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL primary key, 
  user_id INT unsigned,
  created_at DATETIME default CURRENT_TIMESTAMP, 
  updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, /*Дата и время последнего обновления пользователя */
  key index_of_user_id(user_id)
  
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products; /* Промежуточная таблица с заказом покупателя*/
CREATE TABLE orders_products (
  id SERIAL primary key, 
  order_id INT unsigned,
  product_id INT unsigned,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME default CURRENT_TIMESTAMP, 
  updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP /*Дата и время последнего обновления пользователя */
 -- key order_id(order_id)
 -- key product_id(product_id) /* Делаем индексацию по 2м параметрам product и order*/
  ) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts; /* Таблица для скидок*/
CREATE TABLE discounts (
  id SERIAL primary key, 
  user_id INT unsigned,
  product_id INT unsigned,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME, /*Начало действия скидки, если значение NULL, то скидка бессрочная*/
  finished_at DATETIME, /*Окончание действия скидки*/
  created_at DATETIME default CURRENT_TIMESTAMP, 
  updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, /*Дата и время последнего обновления пользователя */
  key index_of_user_id(user_id),
  key index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses; /* Таблица склада*/
CREATE TABLE storehouses (
  id SERIAL primary key, 
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME default CURRENT_TIMESTAMP, 
  updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP /*Дата и время последнего обновления пользователя */
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouse_products; /* Складские запасы*/
CREATE TABLE storehouse_products (
  id SERIAL primary key, 
  storehouse_id INT unsigned,
  product_id INT unsigned,
  volue INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME default CURRENT_TIMESTAMP, 
  updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP /*Дата и время последнего обновления пользователя */
) COMMENT = 'Запасы на складе';
