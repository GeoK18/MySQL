-- Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.


drop table if exists users;
create table users (
  id int (5) default '1',
  name varchar(255)
 );
 insert into users values(default, 'Имя');
 select * from users;
