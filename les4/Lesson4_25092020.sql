-- CRUD (данные)
-- create INSERT
-- read SELECT
-- update UPDATE
-- delete DELETE, TRUNCATE

-- insert ... values

insert into users (id, name, surname, email, phone, gender, birthday, hometown, photo_id, pass, created_at) values (101, 'Kean', 'Pitrelli', 'kpitrelli0@slate.com', '3145908520', 'M', '1974-01-31 21:01:58', 'Isehara', 10034, 'f2dcaddcc91754b9ca378e5d5c94e3a0e1283960', '2020-04-17 01:26:11');

insert into users (name, surname, email, phone, gender, birthday, hometown, photo_id, pass) values ('Marisa', 'Hannibal', 'mhannibal1@examiner.com', '8852114358', 'F', '1994-02-13 10:22:04', 'Likiep', NULL, '1925f4eb3086cff8214f92dc4aa7bfc06cd136c6');

insert into users values (103, 'Vergil', 'Buick', 'vbuick2@ucla.edu', '9031408309', 'M', '2019-08-11 09:54:15', 'Dalumangcob', 10233, '1613fa0d95a59ce4784a72c789ba22aef22e0c1e', '2019-01-25 20:24:13');

insert into users (id, name, surname, email, phone, gender, birthday, hometown, photo_id, pass, created_at) values (107, 'Christy', 'Shimman', 'cshimman6@jalbum.net', '5471389302', 'M', '2009-10-31 05:16:01', 'Libertad', 10598, 'c9fc321dd0ad43f6cda7cd0e78191f618cf867f6', '2020-04-06 08:53:33'),
(108, 'Rodger', 'Wollrauch', 'rwollrauch7@globo.com', '3751985104', 'M', '1985-12-18 19:05:05', 'Sabandia', 10266, 'c5a3906df28f8686d6e1b922395cd5894f2f2f79', '2020-01-16 17:31:02'),
(109, 'Stephanie', 'Hastler', 'shastler8@cdbaby.com', '9345242255', 'F', '1977-07-16 17:28:26', 'Al Kh?niq', 10459, '0e150d1d9b94ab8a6a9a5a0ac8b479b4d96045f7', '2020-06-28 13:18:57'),
(110, 'Taylor', 'Boshers', 'tboshers9@unc.edu', '6472283735', 'M', '1999-02-25 03:55:30', 'Jieshan', 10199, 'c7cd2809c88deac86eeadbd43d78c3773612317d', '2020-05-15 20:27:02');

-- insert ... set

insert into users 
set
name='Marlowe', surname='Anthonsen', email='manthonsen5@symantec.com', phone='2104183290', gender='M', birthday='1967-01-24 20:35:22', hometown='Kembangkerang Satu', pass='140f4fb351e218e4aab69f138d673c5744512631';


-- insert ... select

insert communities
select * from snet1.communities order by id;

-- select

select * from communities;
select * from communities order by id; -- ASC  сортировка по возрастанию  -- DESC - сортировка по убыванию
select surname, name, phone from users;
select * from users limit 10;
select * from users limit 10 offset 10;
select * from users limit 3 offset 8; -- идентично select * from users limit 8, 3;
select concat(surname,' ',name) persons from users;
select name, concat(substring(name,1,1), '. ',surname) persons from users;
select distinct hometown from users;
select * from users where hometown= 'Xinmin';
select name, surname, birthday from users where birthday >= '1985-01-01' order by birthday desc;
select name, surname, birthday from users where birthday >= '1985-01-01' and birthday <= '1990-01-01';
select name, surname, birthday from users where birthday between '1985-01-01' and '1990-01-01';
select name, surname, hometown from users where hometown !='Starigrad';
select name, surname, hometown from users where hometown <>'Starigrad';
select name, surname, hometown from users where hometown in ('Starigrad', 'Gœsdorf');

select name, surname, hometown from users where hometown = 'Starigrad'
or hometown = 'Gœsdorf';

select name, surname, hometown, gender from users 
	where (hometown = 'Starigrad' or hometown = 'Gœsdorf') and gender='M';

select name, surname, hometown from users where hometown not in ('Starigrad', 'Gœsdorf');
select name, surname from users where surname like 'Sa%';
select name, surname from users where surname like '%on';
select name, surname from users where surname like 'Sa_%on';

select count(*) from users;
select min(birthday) from users;
select max(birthday) from users;

select hometown, count(*) from users group by hometown;
select hometown, count(*) from users group by hometown having count(*) >=5;

-- UPDATE

update friend_requests set status = 'approved'
	where initiator_user_id = 1 and target_user_id = 2;


-- TRUNCATE
delete from communities where name = 'Биология клетки';
delete from communities where id between 1 and 10;
delete from communities;



set foreign_key_checks = 0; -- отключаем внешние ключи
truncate table communities; 
set foreign_key_checks = 1; -- включаем внешние ключи



show create table users_communities;

CREATE TABLE `users_communities` (
  `user_id` bigint unsigned NOT NULL,
  `community_id` bigint unsigned NOT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) on delete set null on update set null,
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
)