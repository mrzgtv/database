-- Суть проекта состоит в сборе (пополнении, обновлении) статистических данных спортивных команд (в данном случае, хоккейных), можно применить и к другим командным видам спорта.

-- Состоит из 8 таблиц представленных во вложенной диаграмме.

-- teams;   -- таблица хранящая список всех команд, в какой конференции и каком дивизионе они выступают.

-- nationalities; -- таблица хранящая список национальностей, которые могут быть у игроков.

-- positions; -- таблица хранящая список амплуа (позиций) игроков на поле.

-- stadiums; -- список всех стадионов, где играют команды.

-- all_players; -- таблица хранящая список всех игроков, всех команд.

-- players_contract; -- таблица сроков контрактов игроков с командами.

-- games_summary; -- список всех проведенных игр, счет матчей.

-- goals_and_assists; -- голы, ассистенты.

-- Таблицы teams, nationalities, positions, stadiums - могут быть обновлены, но такое может произойти очень редко.

-- Таблицы all_players, players_contract - Обновляются либо при приходе/уходе игрока в одну из команд лиги. Либо при переходе игрока из одной команды лиги, в другую команду лиги.

-- Таблица games_summary может быть использована в качестве календаря игр (обновляется при старте сезона, данные могут изменяться только при переносе даты игры или места проведения игры (очень редко).

-- Основная таблица, в которую вносятся/изменяются данные - goals_and_assists. Хранит данные обо всех голах, забитых в матчах.
-- На основе данной таблицы в данной работе формируются результаты матчей, личная статистика игроков (показаны в представлениях). В теории, на основе этих данных могут формираваться представления с общей статистикой команд, а также турнирная таблица лиги.


-- Задачи, которая решает данная БД.
-- Хранение статистической информации (как за 1 сезон, так и за много сезонов (лет)). 
-- Выявления лидеров сезона (игроков, команд). 
-- Возможность вывода статистических подборок по позициям игроков, по их национальности, по датам проведения матчей (например, для выевления лучшего игрока недели, месяца и тд.).

drop database if exists project2310;

create database project2310;

use project2310;

drop table if exists teams;   -- таблица хранящая список всех команд, в какой конференции и каком дивизионе они выступают.

create table teams(
	id serial primary key, 
	team_name varchar(50),
	short_name varchar(3),
	conference varchar(50), 
	division varchar(50)
);

insert into teams values
	(1, 'Boston Bruins', 'BOS', 'Eastern', 'Atlantic'),
	(2, 'Tampa Bay Lightning', 'TBL', 'Eastern', 'Atlantic'),
	(3, 'Toronto Maple Leafs', 'TOR', 'Eastern', 'Atlantic'),
	(4, 'Florida Panthers', 'FLA', 'Eastern', 'Atlantic'),
	(5, 'Montréal Canadiens', 'MTL', 'Eastern', 'Atlantic'),
	(6, 'Buffalo Sabres', 'BUF', 'Eastern', 'Atlantic'),
	(7, 'Ottawa Senators', 'OTT', 'Eastern', 'Atlantic'),
	(8, 'Detroit Red Wings', 'DET', 'Eastern', 'Atlantic'),
	(9, 'Washington Capitals', 'WSH', 'Eastern', 'Metropolitan'),
	(10, 'Philadelphia Flyers', 'PHI', 'Eastern', 'Metropolitan'),
	(11, 'Pittsburgh Penguins', 'PIT', 'Eastern', 'Metropolitan'),
	(12, 'Carolina Hurricanes', 'CAR', 'Eastern', 'Metropolitan'),
	(13, 'New York Islanders', 'NYI', 'Eastern', 'Metropolitan'),
	(14, 'Columbus Blue Jackets', 'CBJ', 'Eastern', 'Metropolitan'),
	(15, 'New York Rangers', 'NYR', 'Eastern', 'Metropolitan'),
	(16, 'New Jersey Devils', 'NJD', 'Eastern', 'Metropolitan'),
	(17, 'St Louis Blues', 'STL', 'Western', 'Central'),
	(18, 'Colorado Avalanche', 'COL', 'Western', 'Central'),
	(19, 'Dallas Stars', 'DAL', 'Western', 'Central'),
	(20, 'Nashville Predators', 'NSH', 'Western', 'Central'),
	(21, 'Winnipeg Jets', 'WPG', 'Western', 'Central'),
	(22, 'Minnesota Wild', 'MIN', 'Western', 'Central'),
	(23, 'Chicago Blackhawks', 'CHI', 'Western', 'Central'),
	(24, 'Vegas Golden Knights', 'VGK', 'Western', 'Pacific'),
	(25, 'Edmonton Oilers', 'EDM', 'Western', 'Pacific'),
	(26, 'Vancouver Canucks', 'VAN', 'Western', 'Pacific'),
	(27, 'Calgary Flames', 'CGY', 'Western', 'Pacific'),
	(28, 'Arizona Coyotes', 'ARI', 'Western', 'Pacific'),
	(29, 'Anaheim Ducks', 'ANA', 'Western', 'Pacific'),
	(30, 'Los Angeles Kings', 'LAK', 'Western', 'Pacific'),
	(31, 'San Jose Sharks', 'SJS', 'Western', 'Pacific');



drop table if exists nationalities; -- таблица хранящая список национальностей, которые могут быть у игроков.

create table nationalities(
	id serial primary key, 
	country varchar(50) 
);

insert into nationalities values
	(1,	'Afghanistan'),
	(2,	'Albania'),
	(3,	'Algeria'),
	(4,	'Andorra'),
	(5,	'Angola'),
	(6,	'Antigua and Barbuda'),
	(7,	'Argentina'),
	(8,	'Armenia'),
	(9,	'Australia'),
	(10, 'Austria'),
	(11, 'Azerbaijan'),
	(12, 'Bahamas'),
	(13, 'Bahrain'),
	(14, 'Bangladesh'),
	(15, 'Barbados'),
	(16, 'Belarus'),
	(17, 'Belgium'),
	(18, 'Belize'),
	(19, 'Benin'),
	(20, 'Bhutan'),
	(21, 'Bolivia'),
	(22, 'Bosnia and Herzegovina'),
	(23, 'Botswana'),
	(24, 'Brazil'),
	(25, 'Brunei'),
	(26, 'Bulgaria'),
	(27, 'Burkina Faso'),
	(28, 'Burundi'),
	(29, 'Côte d-Ivoire'),
	(30, 'Cabo Verde'),
	(31, 'Cambodia'),
	(32, 'Cameroon'),
	(33, 'Canada'),
	(34, 'Central African Republic'),
	(35, 'Chad'),
	(36, 'Chile'),
	(37, 'China'),
	(38, 'Colombia'),
	(39, 'Comoros'),
	(40, 'Congo (Congo-Brazzaville)'),
	(41, 'Costa Rica'),
	(42, 'Croatia'),
	(43, 'Cuba'),
	(44, 'Cyprus'),
	(45, 'Czech Republic'),
	(46, 'DR Congo'),
	(47, 'Denmark'),
	(48, 'Djibouti'),
	(49, 'Dominica'),
	(50, 'Dominican Republic'),
	(51, 'Ecuador'),
	(52, 'Egypt'),
	(53, 'El Salvador'),
	(54, 'Equatorial Guinea'),
	(55, 'Eritrea'),
	(56, 'Estonia'),
	(57, 'Eswatini (fmr. "Swaziland")'),
	(58, 'Ethiopia'),
	(59, 'Fiji'),
	(60, 'Finland'),
	(61, 'France'),
	(62, 'Gabon'),
	(63, 'Gambia'),
	(64, 'Georgia'),
	(65, 'Germany'),
	(66, 'Ghana'),
	(67, 'Greece'),
	(68, 'Grenada'),
	(69, 'Guatemala'),
	(70, 'Guinea'),
	(71, 'Guinea-Bissau'),
	(72, 'Guyana'),
	(73, 'Haiti'),
	(74, 'Holy See'),
	(75, 'Honduras'),
	(76, 'Hungary'),
	(77,	'Iceland'),
	(78,	'India'),
	(79,	'Indonesia'),
	(80,	'Iran'),
	(81,	'Iraq'),
	(82,	'Ireland'),
	(83,	'Israel'),
	(84,	'Italy'),
	(85,	'Jamaica'),
	(86,	'Japan'),
	(87,	'Jordan'),
	(88,	'Kazakhstan'),
	(89,	'Kenya'),
	(90,	'Kiribati'),
	(91,	'Kuwait'),
	(92,	'Kyrgyzstan'),
	(93,	'Laos'),
	(94,	'Latvia'),
	(95,	'Lebanon'),
	(96,	'Lesotho'),
	(97,	'Liberia'),
	(98,	'Libya'),
	(99,	'Liechtenstein'),
	(100,	'Lithuania'),
	(101,	'Luxembourg'),
	(102,	'Madagascar'),
	(103,	'Malawi'),
	(104,	'Malaysia'),
	(105,	'Maldives'),
	(106,	'Mali'),
	(107,	'Malta'),
	(108,	'Marshall Islands'),
	(109,	'Mauritania'),
	(110,	'Mauritius'),
	(111,	'Mexico'),
	(112,	'Micronesia'),
	(113,	'Moldova'),
	(114,	'Monaco'),
	(115,	'Mongolia'),
	(116,	'Montenegro'),
	(117,	'Morocco'),
	(118,	'Mozambique'),
	(119,	'Myanmar (formerly Burma)'),
	(120,	'Namibia'),
	(121,	'Nauru'),
	(122,	'Nepal'),
	(123,	'Netherlands'),
	(124,	'New Zealand'),
	(125,	'Nicaragua'),
	(126,	'Niger'),
	(127,	'Nigeria'),
	(128,	'North Korea'),
	(129,	'North Macedonia'),
	(130,	'Norway'),
	(131,	'Oman'),
	(132,	'Pakistan'),
	(133,	'Palau'),
	(134,	'Palestine State'),
	(135,	'Panama'),
	(136,	'Papua New Guinea'),
	(137,	'Paraguay'),
	(138,	'Peru'),
	(139,	'Philippines'),
	(140,	'Poland'),
	(141,	'Portugal'),
	(142,	'Qatar'),
	(143,	'Romania'),
	(144,	'Russia'),
	(145,	'Rwanda'),
	(146,	'Saint Kitts and Nevis'),
	(147,	'Saint Lucia'),
	(148,	'Saint Vincent and the Grenadines'),
	(149,	'Samoa'),
	(150,	'San Marino'),
	(151,	'Sao Tome and Principe'),
	(152,	'Saudi Arabia'),
	(153,	'Senegal'),
	(154,	'Serbia'),
	(155,	'Seychelles'),
	(156,	'Sierra Leone'),
	(157,	'Singapore'),
	(158,	'Slovakia'),
	(159,	'Slovenia'),
	(160,	'Solomon Islands'),
	(161,	'Somalia'),
	(162,	'South Africa'),
	(163,	'South Korea'),
	(164,	'South Sudan'),
	(165,	'Spain'),
	(166,	'Sri Lanka'),
	(167,	'Sudan'),
	(168,	'Suriname'),
	(169,	'Sweden'),
	(170,	'Switzerland'),
	(171,	'Syria'),
	(172,	'Tajikistan'),
	(173,	'Tanzania'),
	(174,	'Thailand'),
	(175,	'Timor-Leste'),
	(176,	'Togo'),
	(177,	'Tonga'),
	(178,	'Trinidad and Tobago'),
	(179,	'Tunisia'),
	(180,	'Turkey'),
	(181,	'Turkmenistan'),
	(182,	'Tuvalu'),
	(183,	'Uganda'),
	(184,	'Ukraine'),
	(185,	'United Arab Emirates'),
	(186,	'United Kingdom'),
	(187,	'United States'),
	(188,	'Uruguay'),
	(189,	'Uzbekistan'),
	(190,	'Vanuatu'),
	(191,	'Venezuela'),
	(192,	'Vietnam'),
	(193,	'Yemen'),
	(194,	'Zambia'),
	(195,	'Zimbabwe');



drop table if exists positions; -- таблица хранящая список амплуа (позиций) игроков на поле.

create table positions(
	id serial primary key, 
	player_position varchar(2) -- LW - left winger (левый крайний нападающий), RW - right winger (правый крайний нападающий), C - center (центральный нападающий), D - defensman (защитник), G - goalie (goalkeeper, вратарь).
);

insert into positions values
	(1, 'LW'),
	(2, 'RW'),
	(3, 'C'),
	(4, 'D'),
	(5, 'G');

drop table if exists stadiums; -- список всех стадионов, где играют команды.

create table stadiums(
	id serial primary key,
	stadium_name varchar(100),
	stadium_location varchar(100),
	hometeam_id bigint unsigned not null,
	foreign key (hometeam_id) references teams (id)
);


insert into stadiums values
	(1, 'TD Garden', 'Boston, Massachusetts', '1'), -- Bruins
	(2, 'Amalie Arena', 'Tampa, Florida', '2'), -- Lightning
	(3, 'Scotiabank Arena', 'Toronto, Ontario', '3'), -- Maple Leafs
	(4, 'BB&T Center', 'Sunrise, Florida', '4'), -- Panthers
	(5, 'Bell Centre', 'Montreal, Quebec', '5'), -- Canadiens
	(6, 'KeyBank Center', 'Buffalo, New York', '6'), -- Sabres
	(7, 'Canadian Tire Centre', 'Ottawa, Ontario', '7'), -- Senators
	(8, 'Little Caesars Arena', 'Detroit, Michigan', '8'), -- Red Wings
	(9, 'Capital One Arena', 'Washington, D.C.', '9'), -- Capitals
	(10, 'Wells Fargo Center', 'Philadelphia, Pennsylvania', '10'), -- Flyers
	(11, 'PPG Paints Arena', 'Pittsburgh, Pennsylvania', '11'), -- Penguins
	(12, 'PNC Arena', 'Raleigh, North Carolina	', '12'), -- Hurricanes
	(13, 'Nassau Coliseum', 'Uniondale, New York', '13'), -- Islanders
	(14, 'Nationwide Arena', 'Columbus, Ohio', '14'), -- Blue Jackets
	(15, 'Madison Square Garden', 'New York, New York', '15'), -- Rangers
	(16, 'Prudential Center', 'Newark, New Jersey', '16'), -- Devils
	(17, 'Enterprise Center', 'St. Louis, Missouri', '17'), -- Blues
	(18, 'Pepsi Center', 'Denver, Colorado', '18'), -- Avalanche
	(19, 'American Airlines Center', 'Dallas, Texas', '19'), -- Stars
	(20, 'Bridgestone Arena', 'Nashville, Tennessee', '20'), -- Predators
	(21, 'Bell MTS Place', 'Winnipeg, Manitoba', '21'), -- Jets
	(22, 'Xcel Energy Center', 'Saint Paul, Minnesota', '22'), -- Wild
	(23, 'United Center', 'Chicago, Illinois', '23'), -- Blackhawks
	(24, 'T-Mobile Arena', 'Paradise, Nevada', '24'), -- Golden Knights
	(25, 'Rogers Place', 'Edmonton, Alberta', '25'), -- Oilers
	(26, 'Rogers Arena', 'Vancouver, British Columbia', '26'), -- Canucks
	(27, 'Scotiabank Saddledome', 'Calgary, Alberta', '27'), -- Flames
	(28, 'Gila River Arena', 'Glendale, Arizona', '28'), -- Coyotes
	(29, 'Honda Center', 'Anaheim, California', '29'), -- Ducks
	(30, 'Staples Center', 'Los Angeles, California', '30'), -- Kings
	(31, 'SAP Center', 'San Jose, California', '31'); -- Sharks


drop table if exists all_players; -- таблица хранящая список всех игроков, всех команд.

create table all_players(
	id serial primary key,
	name varchar(50),
	surname varchar(50),
	jersey_num bigint(2),
	position_id bigint unsigned not null,
	birth_date date,
	hometown varchar(50),
	nationality_id bigint unsigned not null,
	foreign key (position_id) references positions (id),
	foreign key (nationality_id) references nationalities (id)	
);

insert into all_players values
	(1, 'Ryan', 'Callahan', '24', '2', '1985-03-21', 'Rochester, NY', '187'),
	(2, 'Anthony', 'Cirelli', '71', '3', '1997-07-15', 'Etobicoke, ON', '33'),
	(3, 'Cory', 'Conacher', '89', '3', '1989-12-14', 'Burlington, ON', '33'),
	(4, 'Adam', 'Erne', '73',	'1',	'1995-04-20', 'New Haven, CT',	'187'),
	(5, 'Yanni', 'Gourde', '37',	'3',	'1991-12-15',	'Saint-Narcisse, QC',	'33'),
	(6, 'Tyler', 'Johnson', '9',	'3',	'1990-07-29',	'Spokane, WA',	'187'),
	(7, 'Mathieu', 'Joseph', '7',	'2',	'1997-02-09',	'Laval, QC',	'33'),
	(8, 'Alex', 'Killorn', '17',	'1',	'1989-09-14',	'Halifax, NS',	'33'),
	(9, 'Nikita', 'Kucherov', '86',	'2',	'1993-06-17',	'Maykop',	'144'),
	(10, 'Danick', 'Martel', '62',	'1',	'1994-12-12',	'Drummondville, QC',	'33'),
	(11, 'J.T.', 'Miller', '9',	'3',	'1993-03-14',	'East Palestine, OH',	'187'),
	(12, 'Ondrej', 'Palat', '18',	'1',	'1991-03-28',	'Frydek-Mistek',	'45'),
	(13, 'Cedric', 'Paquette', '13',	'3',	'1993-08-13',	'Gaspe, QC',	'33'),
	(14, 'Brayden', 'Point', '21',	'3',	'1996-03-13',	'Calgary, AB',	'33'),
	(15, 'Steven', 'Stamkos', '91',	'3',	'1990-02-07',	'Markham, ON',	'33'),
	(16, 'Erik', 'Cernak', '81',	'4',	'1997-05-28',	'Kosice',	'158'),
	(17, 'Braydon', 'Coburn', '55',	'4',	'1985-02-27',	'Shaunavon, SK',	'33'),
	(18, 'Cameron', 'Gaunce', '33',	'4',	'1990-03-19',	'Sudbury, ON',	'33'),
	(19, 'Dan', 'Girardi', '5',	'4',	'1984-04-29',	'Welland, ON',	'33'),
	(20, 'Victor', 'Hedman', '77',	'4',	'1990-12-18',	'Ornskoldsvik',	'169'),
	(21, 'Slater', 'Koekkoek', '68',	'4',	'1994-02-18',	'Winchester, ON',	'33'),
	(22, 'Ryan', 'McDonagh', '27',	'4',	'1989-06-13',	'St. Paul, MN',	'187'),
	(23, 'Jan', 'Rutta', '44',	'4',	'1990-07-29',	'Pisek',	'45'),
	(24, 'Mikhail', 'Sergachev', '98',	'4',	'1998-06-25',	'Nizhnekamsk',	'144'),
	(25, 'Anton', 'Stralman', '6',	'4',	'1986-08-01',	'Tibro',	'169'),
	(26, 'Louis', 'Domingue', '30',	'5',	'1992-03-06',	'St-Hyacinthe, QC',	'33'),
	(27, 'Edward', 'Pasquale', '80', '5', '1990-11-20', 'Toronto, ON', '33'),
	(28, 'Andrei', 'Vasilevskiy', '88', '5', '1994-07-25', 'Tyumen', '144'),
	(29, 'Justin', 'Abdelkader', 		'8',	'1',	'1987-02-25',	'Muskegon, MI',	'187'),
	(30, 'Andreas', 'Athanasiou', 		'28',	'1',	'1994-08-06', 'Woodbridge, ON',	'33'),
	(31, 'Tyler', 'Bertuzzi', 		'59',	'1',	'1995-02-24',	'Sudbury, ON',	'33'),
	(32, 'Jacob', 'de la Rose', 		'61',	'1',	'1995-05-20',	'Arvika',	'169'),
	(33, 'Christoffer', 'Ehn', 		'70',	'3',	'1996-04-05',	'Skara',	'169'),
	(34, 'Martin', 'Frk', 		'29',	'2',	'1993-10-05',	'Pelhrimov',	'45'),
	(35, 'Luke', 'Glendening',		'41',	'3',	'1989-04-28',	'Grand Rapids, MI',	'187'),
	(36, 'Darren', 'Helm', 		'43',	'1',	'1987-01-21',	'St. Andrews, MB',	'33'),
	(37, 'Taro', 'Hirose', 		'67',	'1',	'1996-06-30',	'Calgary, AB',	'33'),
	(38, 'Ryan', 'Kuffner', 		'56',	'1',	'1996-06-12',	'Ottawa, ON',	'33'),
	(39, 'Dylan', 'Larkin',		'71',	'3',	'1996-07-30',	'Waterford, MI',	'187'),
	(40, 'Anthony', 'Mantha', 		'39',	'2',	'1994-09-16',	'Longueuil, QC',	'33'),
	(41, 'Wade', 'Megan', 		'22',	'3',	'1990-07-22',	'Canton, NY',	'187'),
	(42, 'Frans', 'Nielsen',		'81',	'3',	'1984-04-24',	'Herning',	'47'),
	(43, 'Gustav', 'Nyquist', 		'14',	'3',	'1989-09-01',	'Halmstad',	'169'),
	(44, 'Matt', 'Puempel', 		'54',	'1',	'1993-01-24',	'Windsor, ON',	'33'),
	(45, 'Michael', 'Rasmussen', 		'27',	'3',	'1999-04-17',	'Surrey, BC',	'33'),
	(46,	'Dominic', 'Turgeon', 		'23',	'3',	'1996-02-25',	'Pointe-Claire, QC',	'33'),
	(47,	'Thomas', 'Vanek', 		'26',	'1',	'1984-01-19',	'Vienna',	'10'),
	(48,	'Luke', 'Witkowski', 		'28',	'2',	'1990-04-14',	'Holland, MI',	'187'),
	(49,	'Filip', 'Zadina', 		'11',	'2',	'1999-11-27',	'Pardubice',	'45'),
	(50,	'Madison', 'Bowey', 		'74',	'4',	'1995-04-22',	'Winnipeg, MB',	'33'),
	(51,	'Jake', 'Chelios', 		'84',	'4', '1991-03-08',	'Bloomfield Hills, MI',	'187'),
	(52,	'Dennis', 'Cholowski', 		'21',	'4',	'1998-02-15',	'Langley, BC',	'33'),
	(53,	'Trevor', 'Daley', 		'83',	'4',	'1983-10-09',	'Toronto, ON', '33'),
	(54,	'Danny', 'DeKeyser',		'65',	'4',	'1990-03-07',	'Detroit, MI',	'187'),
	(55,	'Jonathan', 'Ericsson', 		'52',	'4',	'1984-03-02',	'Karlskrona',	'169'),
	(56,	'Mike', 'Green', 		'27',	'4',	'1985-10-12',	'Calgary, AB',	'33'),
	(57,	'Joe', 'Hicketts',		'2',	'4',	'1996-05-04',	'Kamloops, BC',	'33'),
	(58,	'Filip', 'Hronek', 		'17',	'4',	'1997-11-02',	'Hradec Králové',	'45'),
	(59,	'Nick', 'Jensen', 		'3',	'4',	'1990-09-21',	'Rogers, MN',	'187'),
	(60,	'Niklas', 'Kronwall', 		'55',	'4',	'1981-01-12',	'Stockholm',	'169'),
	(61,	'Brian', 'Lashoff', 		'32',	'4',	'1990-07-16',	'Albany, NY',	'187'),
	(62,	'Dylan', 'McIlrath', 		'20',	'4',	'1992-04-20',	'Winnipeg, MB',	'33'),
	(63,	'Libor', 'Sulak', 		'47',	'4',	'1994-03-04',	'Pelhrimov',	'45'),
	(64,	'Jonathan', 'Bernier', 		'45',	'5',	'1988-08-07',	'Laval, QC',	'33'),
	(65,	'Kaden', 'Fulcher', 		'36',	'5',	'1998-09-23',	'Brigden, ON',	'33'),
	(66,	'Jimmy', 'Howard', 		'35',	'5',	'1984-03-26',	'Syracuse, NY',	'187'),
	(67,	'Noel', 'Acciari', 		'55',	'3',	'1991-12-01',	'Johnston, RI',	'187'),
	(68,	'David', 'Backes', 		'21',	'2',	'1984-05-01',	'Minneapolis, MN',	'187'),
	(69,	'Patrice', 'Bergeron',		'37',	'3',	'1985-07-24',	'Ancienne-Lorette, QC',	'33'),
	(70,	'Anders', 'Bjork', 		'10',	'1',	'1996-08-05',	'Mequon, WI',	'187'),
	(71,	'Anton', 'Blidh', 		'81',	'1',	'1995-03-14',	'Molnlycke',	'169'),
	(72,	'Paul', 'Carey',		'34',	'3',	'1988-09-24',	'Boston, MA',	'187'),
	(73,	'Colby', 'Cave', 		'12',	'3',	'1994-12-26',	'Battleford, SK',	'33'),
	(74,	'Peter', 'Cehlarik', 		'22',	'1',	'1995-08-02',	'Zilina',	'158'),
	(75,	'Charlie', 'Coyle', 		'13',	'3',	'1992-03-02',	'E. Weymouth, MA',	'187'),
	(76,	'Jake', 'DeBrusk', 		'74',	'1',	'1996-10-17',	'Edmonton, AB',	'33'),
	(77,	'Ryan', 'Donato', 		'6',	'3',	'1996-04-09',	'Boston, MA',	'187'),
	(78,	'Jakob Forsbacka', 'Karlsson', 		'23',	'3',	'1996-10-31',	'Stockholm',	'169'),
	(79,	'Trent', 'Frederic', 		'82',	'3',	'1998-02-11',	'St. Louis, MO',	'187'),
	(80,	'Danton', 'Heinen', 		'43',	'1',	'1995-07-05',	'Langley, BC',	'33'),
	(81,	'Marcus', 'Johansson', 		'90',	'3',	'1990-10-06',	'Landskrona',	'169'),
	(82,	'David', 'Krejci',		'46',	'3',	'1986-04-28',	'Sternberk',	'45'),
	(83,	'Karson', 'Kuhlman', 		'83',	'3',	'1995-09-26',	'Esko, MN',	'187'),
	(84,	'Sean', 'Kuraly', 		'52',	'3',	'1993-01-20',	'Dublin, OH',	'187'),
	(85,	'Brad', 'Marchand', 		'63',	'1',	'1988-05-11',	'Halifax, NS',	'33'),
	(86,	'Joakim', 'Nordstrom', 		'20',	'3',	'1992-02-25',	'Stockholm',	'169'),
	(87,	'David', 'Pastrnak', 		'88',	'2',	'1996-05-25',	'Havirov',	'45'),
	(88,	'Zach', 'Senyshyn', 		'19',	'2',	'1997-03-30',	'Ottawa, ON',	'33'),
	(89,	'Gemel', 'Smith' ,		'46',	'3',	'1994-04-16',	'Toronto, ON',	'33'),
	(90,	'Lee', 'Stempniak', 		'18',	'2',	'1983-02-04',	'West Seneca, NY',	'187'),
	(91,	'Chris', 'Wagner', 		'14',	'2',	'1991-05-27',	'Walpole, MA',	'187'),
	(92,	'Brandon', 'Carlo', 		'25',	'4',	'1996-11-26',	'Colorado Springs, CO',	'187'),
	(93,	'Zdeno', 'Chara', 		'33',	'4',	'1977-03-18',	'Trencin',	'158'),
	(94,	'Connor', 'Clifton', 		'75',	'4',	'1995-04-28',	'Long Branch, NJ',	'187'),
	(95,	'Matt', 'Grzelcyk', 		'48',	'4',	'1994-01-05',	'Charlestown, MA',	'187'),
	(96,	'Steven', 'Kampfer', 		'44',	'4',	'1988-09-24',	'Ann Arbor, MI',	'187'),
	(97,	'Torey', 'Krug',	'47',	'4',	'1991-04-12',	'Livonia, MI',	'187'),
	(98,	'Jeremy', 'Lauzon', 		'79',	'4',	'1997-04-28',	'Val Dor, QC',	'33'),
	(99,	'Charlie', 'McAvoy' ,		'73',	'4',	'1997-12-21',	'Long Beach, NY',	'187'),
	(100,	'Kevan', 'Miller', 		'86',	'4',	'1987-11-15',	'Los Angeles, CA',	'187'),
	(101,	'John', 'Moore' ,		'27',	'4',	'1990-11-19',	'Winnetka, IL',	'187'),
	(102,	'Urho', 'Vaakanainen' ,		'58',	'4',	'1999-01-01',	'Joensuu',	'60'),
	(103,	'Jakub', 'Zboril', 		'67', '4',	'1997-02-21',	'Brno',	'45'),
	(104,	'Jaroslav', 'Halak', 		'41',	'5',	'1985-05-13',	'Bratislava',	'158'),
	(105,	'Tuukka', 'Rask', 		'40',	'5',	'1987-03-10',	'Savonlinna',	'60'),
	(106,	'Lias', 'Andersson', 		'28',	'3',	'1998-10-13',	'Smogen',	'169'),
	(107,	'Matt', 'Beleskey', 		'39',	'1',	'1988-06-07',	'Windsor, ON',	'33'),
	(108,	'Connor', 'Brickley', 		'23',	'1',	'1992-02-25',	'Everett, MA',	'187'),
	(109,	'Pavel', 'Buchnevich', 		'89',	'2',	'1995-04-17',	'Cherepovets',	'144'),
	(110,	'Filip', 'Chytil', 		'72',	'3',	'1999-09-05',	'Kromeriz',	'45'),
	(111,	'Jesper', 'Fast',		'71',	'2',	'1991-12-02',	'Nassjo',	'169'),
	(112,	'Steven', 'Fogarty', 		'29',	'3',	'1993-04-19',	'Chambersburg, PA',	'187'),
	(113,	'Tim', 'Gettinger', 		'26',	'1',	'1998-04-14',	'Cleveland, OH',	'187'),
	(114,	'Kevin', 'Hayes', 		'13',	'3',	'1992-05-08',	'Dorchester, MA',	'187'),
	(115,	'Brett', 'Howden', 		'21',	'3',	'1998-03-29',	'Calgary, AB',	'33'),
	(116,	'Chris', 'Kreider',		'20',	'1',	'1991-04-30',	'Boxford, MA',	'187'),
	(117,	'Brendan', 'Lemieux', 		'48',	'1',	'1996-03-15',	'Denver, CO',	'187'),
	(118,	'Vinni', 'Lettieri', 		'95',	'3',	'1995-02-06',	'Excelsior, MN',	'187'),
	(119,	'Cody', 'McLeod', 		'55',	'1',	'1984-06-26',	'Binscarth, MB',	'33'),
	(120,	'Vladislav', 'Namestnikov', 		'90',	'3',	'1992-11-22',	'Zhukovskiy',	'144'),
	(121,	'Boo', 'Nieves', 		'15',	'3',	'1994-01-23',	'Syracuse, NY',	'187'),
	(122,	'Ryan', 'Spooner', 		'15',	'3',	'1992-01-30',	'Ottawa, ON',	'33'),
	(123,	'Ryan', 'Strome', 		'16',	'3',	'1993-07-11',	'Mississauga, ON',	'33'),
	(124,	'Jimmy', 'Vesey' ,		'13',	'1',	'1993-05-26',	'Boston, MA',	'187'),
	(125,	'Mika', 'Zibanejad',		'93',	'3',	'1993-04-18',	'Huddinge',	'169'),
	(126,	'Mats', 'Zuccarello', 		'36',	'2',	'1987-09-01',	'Oslo',	'130'),
	(127,	'Fredrik', 'Claesson', 		'33',	'4',	'1992-11-24',	'Stockholm',	'169'),
	(128,	'Tony', 'DeAngelo', 		'77',	'4',	'1995-10-24',	'Sewell, NJ',	'187'),
	(129,	'John', 'Gilmour', 		'58',	'4',	'1993-05-17',	'Montreal, QC',	'33'),
	(130,	'Libor', 'Hajek', 		'25',	'4',	'1998-02-04',	'Smrcek',	'45'),
	(131,	'Ryan', 'Lindgren', 		'55',	'4',	'1998-02-11',	'Burnsville, MN',	'187'),
	(132,	'Adam', 'McQuaid', 		'54',	'4', '1986-10-12',	'Charlottetown, PE',	'33'),
	(133,	'Neal', 'Pionk', 		'4',	'4',	'1995-07-29',	'Omaha, NE',	'187'),
	(134,	'Kevin', 'Shattenkirk', 		'22',	'4',	'1989-01-29',	'New Rochelle, NY',	'187'),
	(135,	'Brady', 'Skjei', 		'76',	'4',	'1994-03-26',	'Lakeville, MN',	'187'),
	(136,	'Brendan', 'Smith', 		'42',	'4',	'1989-02-08',	'Mimico, ON',	'33'),
	(137,	'Marc', 'Staal', 		'18',	'4',	'1987-01-13',	'Thunder Bay, ON',	'33'),
	(138,	'Alexandar', 'Georgiev', 		'40',	'5',	'1996-02-10',	'Ruse, BGR',	'144'),
	(139,	'Henrik', 'Lundqvist', 		'35',	'5',	'1982-03-02',	'Are',	'169');



drop table if exists players_contract; -- таблица сроков контрактов игроков с командами.

create table players_contract(
	player_id bigint unsigned not null,
	team_id bigint unsigned not null,
	date_signed date,
	date_expired date,
	foreign key (team_id) references teams (id),
	foreign key (player_id) references all_players (id)
);

insert into players_contract values
	('1',	'2',	'2015-07-01',	'2022-06-30'),
	('2',	'2',	'2015-07-01',	'2022-06-30'),
	('3',	'2',	'2015-07-01',	'2022-06-30'),
	('4',	'2',	'2015-07-01',	'2022-06-30'),
	('5',	'2',	'2015-07-01',	'2022-06-30'),
	('6',	'2',	'2015-07-01',	'2022-06-30'),
	('7',	'2',	'2015-07-01',	'2022-06-30'),
	('8',	'2',	'2015-07-01',	'2022-06-30'),
	('9',	'2',	'2015-07-01',	'2022-06-30'),
	('10',	'2',	'2015-07-01',	'2022-06-30'),
	('11',	'2',	'2015-07-01',	'2022-06-30'),
	('12',	'2',	'2015-07-01',	'2022-06-30'),
	('13',	'2',	'2015-07-01',	'2022-06-30'),
	('14',	'2',	'2015-07-01',	'2022-06-30'),
	('15',	'2',	'2015-07-01',	'2022-06-30'),
	('16',	'2',	'2015-07-01',	'2022-06-30'),
	('17',	'2',	'2015-07-01',	'2022-06-30'),
	('18',	'2',	'2015-07-01',	'2022-06-30'),
	('19',	'2',	'2015-07-01',	'2022-06-30'),
	('20',	'2',	'2015-07-01',	'2022-06-30'),
	('21',	'2',	'2015-07-01',	'2022-06-30'),
	('22',	'2',	'2015-07-01',	'2022-06-30'),
	('23',	'2',	'2015-07-01',	'2022-06-30'),
	('24',	'2',	'2015-07-01',	'2022-06-30'),
	('25',	'2',	'2015-07-01',	'2022-06-30'),
	('26',	'2',	'2015-07-01',	'2022-06-30'),
	('27',	'2',	'2015-07-01',	'2022-06-30'),
	('28',	'2',	'2015-07-01',	'2022-06-30'),
	('29',	'8',	'2015-07-01',	'2022-06-30'),
	('30',	'8',	'2015-07-01',	'2022-06-30'),
	('31',	'8',	'2015-07-01',	'2022-06-30'),
	('32',	'8',	'2015-07-01',	'2022-06-30'),
	('33',	'8',	'2015-07-01',	'2022-06-30'),
	('34',	'8',	'2015-07-01',	'2022-06-30'),
	('35',	'8',	'2015-07-01',	'2022-06-30'),
	('36',	'8',	'2015-07-01',	'2022-06-30'),
	('37',	'8',	'2015-07-01',	'2022-06-30'),
	('38',	'8',	'2015-07-01',	'2022-06-30'),
	('39',	'8',	'2015-07-01',	'2022-06-30'),
	('40',	'8',	'2015-07-01',	'2022-06-30'),
	('41',	'8',	'2015-07-01',	'2022-06-30'),
	('42',	'8',	'2015-07-01',	'2022-06-30'),
	('43',	'8',	'2015-07-01',	'2022-06-30'),
	('44',	'8',	'2015-07-01',	'2022-06-30'),
	('45',	'8',	'2015-07-01',	'2022-06-30'),
	('46',	'8',	'2015-07-01',	'2022-06-30'),
	('47',	'8',	'2015-07-01',	'2022-06-30'),
	('48',	'8',	'2015-07-01',	'2022-06-30'),
	('49',	'8',	'2015-07-01',	'2022-06-30'),
	('50',	'8',	'2015-07-01',	'2022-06-30'),
	('51',	'8',	'2015-07-01',	'2022-06-30'),
	('52',	'8',	'2015-07-01',	'2022-06-30'),
	('53',	'8',	'2015-07-01',	'2022-06-30'),
	('54',	'8',	'2015-07-01',	'2022-06-30'),
	('55',	'8',	'2015-07-01',	'2022-06-30'),
	('56',	'8',	'2015-07-01',	'2022-06-30'),
	('57',	'8',	'2015-07-01',	'2022-06-30'),
	('58',	'8',	'2015-07-01',	'2022-06-30'),
	('59',	'8',	'2015-07-01',	'2022-06-30'),
	('60',	'8',	'2015-07-01',	'2022-06-30'),
	('61',	'8',	'2015-07-01',	'2022-06-30'),
	('62',	'8',	'2015-07-01',	'2022-06-30'),
	('63',	'8',	'2015-07-01',	'2022-06-30'),
	('64',	'8',	'2015-07-01',	'2022-06-30'),
	('65',	'8',	'2015-07-01',	'2022-06-30'),
	('66',	'8',	'2015-07-01',	'2022-06-30'),
	('67',	'1',	'2015-07-01',	'2022-06-30'),
	('68',	'1',	'2015-07-01',	'2022-06-30'),
	('69',	'1',	'2015-07-01',	'2022-06-30'),
	('70',	'1',	'2015-07-01',	'2022-06-30'),
	('71',	'1',	'2015-07-01',	'2022-06-30'),
	('72',	'1',	'2015-07-01',	'2022-06-30'),
	('73',	'1',	'2015-07-01',	'2022-06-30'),
	('74',	'1',	'2015-07-01',	'2022-06-30'),
	('75',	'1',	'2015-07-01',	'2022-06-30'),
	('76',	'1',	'2015-07-01',	'2022-06-30'),
	('77',	'1',	'2015-07-01',	'2022-06-30'),
	('78',	'1',	'2015-07-01',	'2022-06-30'),
	('79',	'1',	'2015-07-01',	'2022-06-30'),
	('80',	'1',	'2015-07-01',	'2022-06-30'),
	('81',	'1',	'2015-07-01',	'2022-06-30'),
	('82',	'1',	'2015-07-01',	'2022-06-30'),
	('83',	'1',	'2015-07-01',	'2022-06-30'),
	('84',	'1',	'2015-07-01',	'2022-06-30'),
	('85',	'1',	'2015-07-01',	'2022-06-30'),
	('86',	'1',	'2015-07-01',	'2022-06-30'),
	('87',	'1',	'2015-07-01',	'2022-06-30'),
	('88',	'1',	'2015-07-01',	'2022-06-30'),
	('89',	'1',	'2015-07-01',	'2022-06-30'),
	('90',	'1',	'2015-07-01',	'2022-06-30'),
	('91',	'1',	'2015-07-01',	'2022-06-30'),
	('92',	'1',	'2015-07-01',	'2022-06-30'),
	('93',	'1',	'2015-07-01',	'2022-06-30'),
	('94',	'1',	'2015-07-01',	'2022-06-30'),
	('95',	'1',	'2015-07-01',	'2022-06-30'),
	('96',	'1',	'2015-07-01',	'2022-06-30'),
	('97',	'1',	'2015-07-01',	'2022-06-30'),
	('98',	'1',	'2015-07-01',	'2022-06-30'),
	('99',	'1',	'2015-07-01',	'2022-06-30'),
	('100',	'1',	'2015-07-01',	'2022-06-30'),
	('101',	'1',	'2015-07-01',	'2022-06-30'),
	('102',	'1',	'2015-07-01',	'2022-06-30'),
	('103',	'1',	'2015-07-01',	'2022-06-30'),
	('104',	'1',	'2015-07-01',	'2022-06-30'),
	('105',	'1',	'2015-07-01',	'2022-06-30'),
	('106',	'15',	'2015-07-01',	'2022-06-30'),
	('107',	'15',	'2015-07-01',	'2022-06-30'),
	('108',	'15',	'2015-07-01',	'2022-06-30'),
	('109',	'15',	'2015-07-01',	'2022-06-30'),
	('110',	'15',	'2015-07-01',	'2022-06-30'),
	('111',	'15',	'2015-07-01',	'2022-06-30'),
	('112',	'15',	'2015-07-01',	'2022-06-30'),
	('113',	'15',	'2015-07-01',	'2022-06-30'),
	('114',	'15',	'2015-07-01',	'2022-06-30'),
	('115',	'15',	'2015-07-01',	'2022-06-30'),
	('116',	'15',	'2015-07-01',	'2022-06-30'),
	('117',	'15',	'2015-07-01',	'2022-06-30'),
	('118',	'15',	'2015-07-01',	'2022-06-30'),
	('119',	'15',	'2015-07-01',	'2022-06-30'),
	('120',	'15',	'2015-07-01',	'2022-06-30'),
	('121',	'15',	'2015-07-01',	'2022-06-30'),
	('122',	'15',	'2015-07-01',	'2022-06-30'),
	('123',	'15',	'2015-07-01',	'2022-06-30'),
	('124',	'15',	'2015-07-01',	'2022-06-30'),
	('125',	'15',	'2015-07-01',	'2022-06-30'),
	('126',	'15',	'2015-07-01',	'2022-06-30'),
	('127',	'15',	'2015-07-01',	'2022-06-30'),
	('128',	'15',	'2015-07-01',	'2022-06-30'),
	('129',	'15',	'2015-07-01',	'2022-06-30'),
	('130',	'15',	'2015-07-01',	'2022-06-30'),
	('131',	'15',	'2015-07-01',	'2022-06-30'),
	('132',	'15',	'2015-07-01',	'2022-06-30'),
	('133',	'15',	'2015-07-01',	'2022-06-30'),
	('134',	'15',	'2015-07-01',	'2022-06-30'),
	('135',	'15',	'2015-07-01',	'2022-06-30'),
	('136',	'15',	'2015-07-01',	'2022-06-30'),
	('137',	'15',	'2015-07-01',	'2022-06-30'),
	('138',	'15',	'2015-07-01',	'2022-06-30'),
	('139',	'15',	'2015-07-01',	'2022-06-30');



drop table if exists games_summary; -- список всех проведенных игр, счет матчей.

create table games_summary(
	id serial primary key,
	hometeam_id bigint unsigned not null,
	awayteam_id bigint unsigned not null,
	venue_id bigint unsigned not null,
	game_date date,
	foreign key (hometeam_id) references teams (id),
	foreign key (awayteam_id) references teams (id),
	foreign key (venue_id) references stadiums (id)
);

insert into games_summary values
	(1, '2', '1', '2', '2018-12-06'),
	(2, '2', '15', '2', '2018-12-10'),
	(3, '15', '2', '15', '2019-02-02'),
	(4, '1', '2', '1', '2019-02-28'),
	(5, '2', '8', '2', '2019-03-09'),
	(6, '8', '2', '8', '2019-03-14'),
	(7, '1', '2', '1', '2019-03-15');


drop table if exists goals_and_assists; -- голы, ассистенты.

create table goals_and_assists(
	game_id bigint unsigned not null,
	scorer_id bigint unsigned,
	assist1_id bigint unsigned,
	assist2_id bigint unsigned,
	timing varchar(10),
	foreign key (game_id) references games_summary (id),
	foreign key (scorer_id) references all_players (id),
	foreign key (assist1_id) references all_players (id),
	foreign key (assist2_id) references all_players (id)
);

insert into goals_and_assists values
	(1, '87', '73', NULL, '02:04'),
	(1, '14', '9', '6', '14:59'),
	(1, '7', '8', '19', '42:40'),
	(1, '2', NULL, NULL, '44:03'),
	(1, '82', '87', '68', '58:15'),	
	(2, '114', '123', '120', '12:19'),
	(2, '15', '20', '11', '14:59'),
	(2, '114', '124', NULL, '15:07'),
	(2, '15', '20', '14', '26:09'),
	(2, '22', '14', '9', '32:42'),
	(2, '2', '16', NULL, '50:17'),
	(2, '15', '12', '17', '50:41'),
	(2, '111', '110', NULL, '57:34'),
	(2, '2', '8', '11', '59:21'),
	(3, '5', '22', '7', '06:51'),
	(3, '16', '1', '13', '24:41'),
	(3, '15', '20', '9', '28:33'),
	(3, '126', '125', '116', '36:17'),
	(3, '114', '125', '139', '46:49'),	
	(4, '76', '97', '105', '28:43'),
	(4, '67', '91', NULL, '51:47'),
	(4, '69', '80', '67', '52:32'),
	(4, '85', '80', '97', '53:15'),
	(4, '2', '12', NULL, '53:52'),	
	(5, '22', '16', '2', '03:06'),
	(5, '9', '14', '20', '11:56'),
	(5, '47', '60', '49', '39:56'),
	(5, '9', '24', '6', '53:53'),
	(5, '40', '60', '58', '59:04'),	
	(6, '50', '33', '45', '02:20'),
	(6, '36', NULL, NULL, '10:24'),
	(6, '29', '35', NULL, '23:43'),
	(6, '15', '11', '9', '32:57'),
	(6, '14', '15', '9', '41:46'),
	(6, '9', '20', '14', '48:24'),
	(6, '6', '16', '12', '48:50'),
	(6, '9', '14', NULL, '56:38'),
	(6, '45', '47', '49', '58:58');

insert into goals_and_assists values   -- ввод данных для проверки работы триггера
	(7, '9', NULL, NULL, '01:04'),
	(7, '9', NULL, NULL, '14:04'),
	(7, '9', NULL, NULL, '24:04');


insert into games_summary values -- ввод данных для проверки работы триггера
	(8, '1', '2', '1', '2019-03-15');

insert into goals_and_assists values -- ввод данных для проверки работы триггера
	(8, '9', NULL, NULL, '01:04'),
	(8, '9', NULL, NULL, '14:04'),
	(8, '9', NULL, NULL, '24:04');


create or replace view total_goals_by_players as   -- представление, показывающее таблицу всех игроков, забивавших голы. Отсортированы в порядке от забившего наибольшее количество голов к наименьшему количеству.
select player_id, name, surname, team_name, count(scorer_id) as goals
from goals_and_assists gaa 
join all_players ap 
on gaa.scorer_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date
group by ap.id
order by goals desc;


delimiter //   -- триггер, обновляющий представление total_goals_by_players после ввода новых данных в таблицу goals_and_assists.
drop trigger if exists goals_count //
create trigger goals_count after insert on goals_and_assists
for each row
begin 
	select count(scorer_id) into @goals from goals_and_assists;
end //

delimiter ;

create or replace view total_assist1_by_players as -- представление, показывающее таблицу всех игроков, отдававших последний пас перед голом. Отсортированы в порядке от большего к меньшему.
select player_id, name, surname, team_name, count(assist1_id) as assist1
from goals_and_assists gaa 
join all_players ap 
on gaa.assist1_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date
group by ap.id
order by assist1 desc;

create or replace view total_assist2_by_players as -- представление, показывающее таблицу всех игроков, отдававших первый пас перед голом. Отсортированы в порядке от большего к меньшему.
select player_id, name, surname, team_name, count(assist2_id) as assist2
from goals_and_assists gaa 
join all_players ap 
on gaa.assist2_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date
group by ap.id
order by assist2 desc;


create or replace view game1_result as -- представление показывающее итоговый счет матча №1
select team_name, count(*) as Final_score
from goals_and_assists gaa 
join all_players ap 
on gaa.scorer_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs 
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date 
and game_id = 1
group by team_id;

create or replace view game2_result as  -- представление показывающее итоговый счет матча №2
select team_name, count(*) as Final_score
from goals_and_assists gaa 
join all_players ap 
on gaa.scorer_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs 
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date 
and game_id = 2
group by team_id;

create or replace view game3_result as  -- представление показывающее итоговый счет матча №3
select team_name, count(*) as Final_score
from goals_and_assists gaa 
join all_players ap 
on gaa.scorer_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs 
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date 
and game_id = 3
group by team_id;

create or replace view game4_result as  -- представление показывающее итоговый счет матча №4
select team_name, count(*) as Final_score
from goals_and_assists gaa 
join all_players ap 
on gaa.scorer_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs 
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date 
and game_id = 4
group by team_id;

create or replace view game5_result as  -- представление показывающее итоговый счет матча №5
select team_name, count(*) as Final_score
from goals_and_assists gaa 
join all_players ap 
on gaa.scorer_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs 
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date 
and game_id = 5
group by team_id;

create or replace view game6_result as  -- представление показывающее итоговый счет матча №6
select team_name, count(*) as Final_score
from goals_and_assists gaa 
join all_players ap 
on gaa.scorer_id = ap.id
join players_contract pc 
on pc.player_id = ap.id
join teams t 
on t.id = pc.team_id 
join games_summary gs 
on gs.id = gaa.game_id
where 
date_signed <= game_date and  date_expired >= game_date 
and game_id = 6
group by team_id;


select * from all_players ap  -- простой запрос, показывающий всех игроков из России
where nationality_id = 144; -- 144 - Russia


select * from total_goals_by_players tgbp -- простой запрос, показывающий всех игроков, забивших 3 или более голов.
where goals >= 3;


select * from total_goals_by_players tgbp -- простой запрос, показывающий всех игроков команды New York Ranger, забивших 1 или более голов. Сортировка от наибольшего к наименьшему по столбцу goals.
where goals >= 1 and team_name = 'New York Rangers'
order by goals desc;






