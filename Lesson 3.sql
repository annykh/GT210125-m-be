-- Изменение таблиц и столбцов

-- alter table table_name1 -- изменение таблицы 
-- add column new_column_name data_type [constraint], -- добавление нового столбца (по умолч. в конец)
-- drop column column_name1, -- удаление столбца
-- modify column column_name1 new_data_type, -- изменение типа данных
-- change column column_name1 new_column_name data_type, -- переименование столбца(можно и тип данных изменить)
-- rename column column_name1 to new_column_name; -- переименование столбца

-- constraint - ограничение/атрибуты

-- Добавление нового столбца
-- alter table table_name1
-- add column new_column_name data_type [constraint];

-- Удаление столбца
-- alter table table_name1
-- drop column column_name1;

-- Добавление нового столбца с указанием позиции.

-- first в начало
-- after column_name после поля
-- before column_name до поля

-- alter table table_name1
-- add column new_column_name data_type [constraint] after column_name1;

use gt210125;

create table products(
	title varchar(128) not null,
    quantity int check(quantity > 0)
);

-- Добавить новое поле price тип данных int значение по умолчанию 0.
alter table products
add column price int default 0;

-- Добавить поле product_description, тип данных varchar(200). Вставить поле после quantity.
alter table products
add column product_description varchar(200) after quantity;

-- Изменить тип данных поля product_description на varchar(250).
alter table products
modify column product_description varchar(250);

-- Переименовать поле quantity на count и изменить тип данных на decimal(5, 2)
alter table products 
change column quantity count decimal(5, 2);
-- Error Code: 3959. Check constraint 'products_chk_1' uses column 'quantity', hence column cannot be dropped or renamed.	0.000 sec

-- Переименовать поле price на product_price и изменить тип данных на decimal(7, 2)
alter table products 
change column price product_price decimal(7, 2);

-- Переименовать поле title на item_title
-- Удалить поле product_description
-- Добавить новое поле id тип данных int primary key auto_increment. Вставить в начало таблицы.

alter table products
rename column title to item_title,
drop column product_description,
add column id int primary key auto_increment first;


-- Создать таблицу students1 с полями
-- fname строка(60) (не null)
-- lastname строка(100) (не null)
-- avg_mark целое число (от 0 до 5 вкл.)
-- gender строка(128) 

create table students1(
	fname varchar(60) not null,
    lastname varchar(100) not null,
    avg_mark int check(avg_mark between 0 and 5),
    gender varchar(128)
);

-- Добавить поле id integer primary key auto_increment в начало таблицы
-- Добавить поле age (тип целое число) после lastname
-- Поменять тип у gender на char(1)
-- Переименовать поле fname на firstname

alter table students1
add column id int primary key auto_increment first;

alter table students1
add column age int after lastname;

alter table students1
modify column gender char(1);

-- alter table students1
-- rename column fname to firstname;

alter table students1
change column fname firstname varchar(60);

insert into students1 (firstname, lastname, age, avg_mark, gender)
values ('John', 'Smith', 16, 4, 'M');

insert into students1 (firstname, lastname, age, avg_mark, gender)
values ('Helen', 'Brown', 16, 5, 'F');

insert into students1 (firstname, lastname, age, avg_mark, gender)
values ('Den', 'King', 15, 3, 'M');

insert into students1 (firstname, lastname, age, avg_mark, gender)
values ('Lily', 'Jameson', 15, 4, 'F');

select * from students1;

-- Обновление данных

-- update table_name1 -- обновление таблицы 
-- set column_name1 = new_value, column_name2 = new_value, ... -- имя_поля = новое_значение, ..
-- [where condition] -- условие

-- Поменять среднюю оценку студента Den King на 4.
update students1
set avg_mark = 4
where firstname = 'Den' and lastname = 'King';
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec

set sql_safe_updates = 0; -- Отключение безопасного режима

update students1
set avg_mark = 4
where firstname = 'Den' and lastname = 'King';

set sql_safe_updates = 1; -- Вкл. безопасного режима

-- Всем студентам уменьшить оценку на 1
set sql_safe_updates = 0;

update students1
set avg_mark = avg_mark - 1;

-- Увеличить возраст всех студентов на 1.
update students1
set age = age + 1;

-- Изменить имя на Derek и возраст на 18 для студента 'Den' 'King'.
update students1
set firstname = 'Derek', age = 18
where firstname = 'Den' and lastname = 'King';

-- Добавить поле school_no тип int
alter table students1
add column school_no int;

-- В поле school_no записать значение 124 для студентов с id 1, 3, 4.
update students1
set school_no = 124
where id in (1, 3, 4);
-- where id = 1 or id = 3 or id = 4

-- Где school_no = null, записать 0.
update students1
set school_no = 0
where school_no is null;

-- Удаление данных
-- delete from table_name1 -- удалеине данных из таблицы table_name1
-- where condition; -- условие

-- Удалить студента, где номер школы 0.
delete from students1
where school_no = 0;

-- Удалить всех студентов из таблицы 
delete from students1;

insert into students1 (firstname, lastname, age, avg_mark, gender, school_no)
values ('Ben', 'Brown', 17, 4, 'M', 126);

insert into students1 (firstname, lastname, age, avg_mark, gender, school_no)
values ('Daniel', 'Jonson', 17, 5, 'M', 126);

-- Очистить таблицу students1
truncate table students1;

insert into students1 (firstname, lastname, age, avg_mark, gender, school_no)
values ('Ben', 'Brown', 17, 4, 'M', 126);

select * from students1;

drop table employees;

create table employees(
 	employee_id int primary key auto_increment,
 	first_name varchar(128) not null,
 	last_name varchar(128) not null,
 	email varchar(128) not null,
 	salary int, 
	department varchar(128) not null
 );
 
insert into employees(first_name, last_name, email, salary, department) values("Steven","King",	"SKING", 24000, "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Neena" , "Kochhar" , "NKOCHHAR" , 17000 , "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Lex" , "De Haan" , "LDEHAAN" , 17000 , "Sales");
insert into employees(first_name, last_name, email, salary, department) values("Alexander" , "Hunold" , "AHUNOLD" , 9000 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Bruce" , "Ernst" , "BERNST" , 6000 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Valli" , "Pataballa" , "VPATABAL" , 4800 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Diana" , "Lorentz" , "DIANALO" , 8800 , "Finance");
insert into employees(first_name, last_name, email, salary, department) values("Nancy" , "Greenberg" , "NGREENBE" , 12008 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Daniel" , "Faviet" , "DFAVIET" , 9000 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Jose Manuel" , "Urman" , "JMURMAN" , 7800 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Luis" , "Popp" , "LPOPP" , 6900 , "Shipping");
insert into employees(first_name, last_name, email, salary, department) values("Den" , "Raphaely" , "DRAPHEAL" , 11000 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Alexander" , "Khoo" , "AKHOO" , 3100 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Shelli" , "Baida" , "SBAIDA" , 2900 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Sigal" , "Tobias" , "STOBIAS" , 2800 , "Marketing");
insert into employees(first_name, last_name, email, salary, department) values("Matthew" , "Weiss" , "MWEISS" , 8000 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Fripp" , "AFRIPP" , 8200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Payam" , "Kaufling" , "PKAUFLIN" , 7900 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Shanta" , "Vollman" , "SVOLLMAN" , 6500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Kevin" , "Mourgos" , "KMOURGOS" , 5800 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Julia" , "Nayer" , "JNAYER" , 3200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Markle" , "SMARKLE" , 2200 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Laura" , "Bissot" , "LBISSOT" , 3300 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Mozhe" , "Atkinson" , "MATKINSO" , 2800 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Joshua" , "Patel" , "JPATEL" , 2500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Trenna" , "Rajs" , "TRAJS" , 3500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("John" , "Russell" , "JRUSSEL" , 14000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Karen" , "Partners" , "KPARTNER" , 13500 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Alberto" , "Errazuriz" , "AERRAZUR" , 12000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Gerald" , "Cambrault" , "GCAMBRAU" , 11000 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Eleni" , "Zlotkey" , "EZLOTKEY" , 10500 , "IT");
insert into employees(first_name, last_name, email, salary, department) values("Adam" , "Vargas" , "PVARGAS" , 2500 , "Human Resources");
insert into employees(first_name, last_name, email, salary, department) values("Laura" , "Errazuriz" , "AERRAZUR" , 12000 , "IT");

select * from employees;

-- Изменить департамент сотрудника Steven King на IT
update employees
set department = 'IT'
where first_name = 'Steven' and last_name = 'King';

-- Повысить зарплату Laura Bissot на 5000.
update employees
set salary = salary + 5000
where first_name = 'Laura' and last_name = 'Bissot';

-- Повысить зарплату работников отдела IT в 2 раза.
update employees
set salary = salary * 2
where department = 'IT';

-- Изменить фамилию Luis Popp на Smith.
update employees
set last_name = 'Smith'
where first_name = 'Luis' and last_name = 'Popp';

-- Д/З

-- John Russell перевели в отдел Marketing и повысили зарплату на 5000. Измените данные для работника John Russell.
-- Удалить сотрудника Adam Fripp из таблицы.
-- Всех работников отдела Shipping уволили. Удалите работников Shipping из таблицы.
-- Всех сотурдников отдела Sales перевели в отдел Finance и повысли зарплаты на 1000. Изменить данные для этих сотрудников.
-- Удалить сотрудников с employee_id 2, 7, 10.
-- Очистить таблицу обнуляя auto_increment.
-- Включить безопасный режим обновления данных
