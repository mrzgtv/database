-- Выполнение заданий по видеоуроку №5.

-- Тема «Операторы, фильтрация, сортировка и ограничение»

-- Задание №1

drop database if exists hw5;

create database hw5;

use hw5;

create table users(
	id serial primary key, 
	name varchar(50), 
	surname varchar(50), 
	created_at datetime, 
	updated_at datetime
);


insert into users (id, name, surname, created_at, updated_at) values ('Maje', 'Blader', NULL, NULL), ('Gustavus', 'Haggerstone', NULL, NULL), ( 'Michaelina', 'Gorelli', NULL, NULL), ('Clywd', 'Jayne', NULL, NULL), ('Susy', 'Hammerberger', NULL, NULL), ('Federica', 'Rivalant', NULL, NULL), ('Judi', 'Marrow', NULL, NULL), ('Ana', 'Berr', NULL, NULL), ('Cristina', 'Osgorby', NULL, NULL), ('Joana', 'Hamm', NULL, NULL);

update users set created_at = NOW(), updated_at = NOW(); -- обновляем данные в таблице (замена всех значений столбца created_at и updated_at на текущее время NOW() )

-- Задание №2

drop database if exists hw5;

create database hw5;

use hw5;

create table users(
	id serial primary key, 
	name varchar(50), 
	surname varchar(50),
	birthday_at date,
	created_at varchar(50), 
	updated_at varchar(50)
);

insert into users (name, surname, birthday_at, created_at, updated_at) values 
	('Maje', 'Blader', '1990-12-17', '30.10.2012 13:57', '15.10.2016 13:45'), 
	('Gustavus', 'Haggerstone', '1988-06-02', '15.03.2001 09:07', '31.10.2015 08:57'), 
	('Michaelina', 'Gorelli', '1965-01-27', '28.01.2013 17:52', '02.07.2015 02:58'), 
	('Clywd', 'Jayne', '1964-09-26', '19.12.2006 00:59', '31.01.2020 03:14'), 
	('Susy', 'Hammerberger', '2016-07-27', '10.10.2016 20:01', '11.10.2016 14:46'), 
	('Federica', 'Rivalant', '1991-12-30', '31.08.2000 13:49', '25.07.2018 14:59'), 
	('Judi', 'Marrow', '2011-04-17', '08.06.2019 22:41', '05.10.2020 07:22'), 
	('Ana', 'Berr', '1918-07-25', '01.03.2001 05:21', '20.03.2013 06:55'), 
	('Cristina', 'Osgorby', '2019-07-12', '18.09.2019 05:31', '14.05.2020 17:04'), 
	('Joana', 'Hamm', '1945-05-09', '05.06.2004 13:21', '16.07.2009 17:26');

update users set 
	created_at = str_to_date(created_at, '%d.%m.%Y %k:%i'),
	updated_at = str_to_date(updated_at, '%d.%m.%Y %k:%i');

alter table users change created_at created_at datetime default current_timestamp;
alter table users change updated_at updated_at datetime default current_timestamp on update current_timestamp;

-- Задание №3

drop table if exists storehouses_products;

create table storehouses_products(
	id serial primary key, 
	store_id int unsigned, 
	product_id int unsigned,
	value int unsigned
);

insert into storehouses_products (store_id, product_id, value) values
	(1, 10, 0),
	(1, 20, 2500),
	(1, 30, 0),
	(1, 40, 30),
	(1, 50, 500),
	(1, 60, 1);

select * from storehouses_products order by if (value > 0, 0, 1), value;



-- Задание №4

select name, surname from users where date_format(birthday_at, '%M') in ('December', 'July');



-- Выполнение заданий по видеоуроку №5.

-- Тема «Агрегация данных»

-- Задание №1

select avg(timestampdiff(year, birthday_at, now())) as avg_age from users;

-- Задание №2

select date_format(date(concat_ws('-', year(now()), month(birthday_at), day(birthday_at))), '%W') as new_date, count(*) as total_bd from users group by new_date order by total_bd desc;

-- Задание №3

drop table if exists task3;

create table task3(
	id serial primary key,
	value int unsigned
);

insert into task3 (value) values (1), (2), (3), (4), (5);

select round(exp(sum(ln(value)))) from task3;



