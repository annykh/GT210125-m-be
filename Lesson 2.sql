-- comment - ctrl + /
-- code
-- code
-- code
-- ...

/* code 
code
code */

-- Запуск коде
-- Первая молния - запускает весь выделенный скрипт или все что есть в файле - ctrl + shift + enter
-- Вторая молния - запускает один запос, где стоит курсор - ctrl + enter

-- Создание базы данных 
-- create database название_бд;

create database gt210125;

create database gt210125;
-- Error Code: 1007. Can't create database 'gt210125'; database exists	0.016 sec

-- Переключение между бд
use gt210125;

-- Создание таблицы 

-- create table название_таблицы (
-- 		название_поля тип_данных [ограничения/атрибуты],
--     название_поля тип_данных [ограничения/атрибуты], 
--     ...
-- );


-- Простые типы данных 
-- integer / int - Целое число
-- numeric(N, M) / decimal(N, M) - числовые данные - N общее кол/во симловов (до и после точки), M кол/во дробной части (после точки), по умолч. (10, 0)
-- varchar(N) - сторки - N максимальное кол/во символов в строке
-- char(M) - строки - M фиксированное кол/во символов в строке (для ответов Y/N, для пола F/M/O)

-- decimal(5, 3)
-- 99.999

-- Ограничения/атрибуты

-- unique - значения в поле должны быть уникальными
-- not null - значения в поле не могут быть незаполненными
-- check(условие) - соответствует какому-либо условию
-- default - значение по умолчанию 
-- primary key - not null + unique - только одно поле может иметь этот атрибут в одной таблице 
-- auto_increment - авто заполнение поля целыми числами


-- Создать таблицу students
-- id целое число, уникальное значение, не null, автозаполнение 
-- firstname varchar not null
-- lastname varchar not null
-- class integer от 1 до 10 (вкл)
-- subject_name varchar not null
-- mark integer от 0 до 5 (вкл)
-- school_no integer по умолч. 0
-- checked char(1) значение Y либо N

create table students(
	id int primary key auto_increment,
    firstname varchar(64) not null,
    lastname varchar(128) not null,
    class int check(class between 1 and 10),
    subject_name varchar(64) not null,
    mark int check(mark between 0 and 5),
    school_no int default 0,
--     checked char(1) check(checked = 'Y' or checked = 'N')
	checked char(1) check(checked in ('Y', 'N'))
);

--  Создать таблицу staff с полями:
-- • id – целое число - первичный ключ с автозаполнением 
-- • firstname - строка максимум 60 символов не null
-- • lastname - строка максимум 100 символов не null
-- • position - строка максимум 100 символов
-- • age - целое число - от 0 до 110(вкл.)
-- • has_child – строка с одним символом - либо Y, либо N
-- • username - строка максимум 100 символов - уникальное значение не null

create table staff(
	id int primary key auto_increment,
    firstname varchar(60) not null,
    lastname varchar(100) not null,
    position varchar(100),
    age int check(age between 0 and 110),
    has_child char(1) check(has_child in ('Y', 'N')),
    username varchar(100) unique not null
);

-- Заполнение таблиц 
-- insert into назвние_таблицы (поле1, поле2, поле3, ...)
-- values (значение1, значение2, значение3, ...),
-- (значение1, значение2, значение3, ...),
-- ....;

insert into students 
values ('John', 'Smith', 4, 'Math', 5, 34, 'Y');
-- Error Code: 1136. Column count doesn't match value count at row 1

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('John', 'Smith', 4, 'Math', 5, 34, 'Y');

select * from students;

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('Bob', 'Brown', 3, 'Informatics', 5, 32, 'N'),
		('Lily', 'Thomas', 7, 'Math', 4, 34, 'Y'),
        ('Jane', 'King', 7, 'Informatics', 5, 32, 'Y'),
        ('Den', 'Jameson', 7, 'Informatics', 3, 32, 'N');
        
-- ERRORS
insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('Tom', 'Smith', 12, 'Math', 5, 34, 'Y');
-- Error Code: 3819. Check constraint 'students_chk_1' is violated.	0.000 sec

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('Tom', 'Smith', 10, 'Math', 10, 34, 'Y');
-- Error Code: 3819. Check constraint 'students_chk_2' is violated.	0.000 sec

insert into students (lastname, class, subject_name, mark, school_no, checked)
values ('Smith', 10, 'Math', 10, 34, 'Y');
-- Error Code: 1364. Field 'firstname' doesn't have a default value	0.000 sec

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('TomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTomTommTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTmTomTomTomTomTomTomTomTomTTomTomTomTomTom', 'Smith', 10, 'Math', 4, 34, 'Y');
-- Error Code: 1406. Data too long for column 'firstname' at row 1	0.000 sec

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('Tom', 'Smith', 10, 'Math', 4, 34, 'MM');
-- Error Code: 1406. Data too long for column 'checked' at row 1	0.000 sec

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('Tom', 'Smith', 10, 'Math', 4, 34, 'M');
-- Error Code: 3819. Check constraint 'students_chk_3' is violated.	0.000 sec

insert into students (first_name, lastname, class, subject_name, mark, school_no, checked)
values ('Tom', 'Smith', 10, 'Math', 4, 34, 'Y');
-- Error Code: 1054. Unknown column 'first_name' in 'field list'	0.000 sec

insert into student (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('Tom', 'Smith', 10, 'Math', 4, 34, 'Y');
-- Error Code: 1146. Table 'gt210125.student' doesn't exist	0.000 sec

insert into students (firstname, class, lastname, subject_name, mark, school_no, checked)
values ('Tom', 'Smith', 10, 'Math', 4, 34, 'Y');
-- Error Code: 1366. Incorrect integer value: 'Smith' for column 'class' at row 1	0.000 sec

insert into students (firstname, lastname, subject_name, class, mark)
values ('Tom', 'Smith', 123, 5, 5);

select * from students;

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('Bob', 'Brown', 3, 'Informatics', 5, 32, 'N'),
		('Lily', 'Thomas', 7, 'Math', 9, 34, 'Y'),
        ('Jane', 'King', 7, 'Informatics', 5, 32, 'Y'),
        ('Den', 'Jameson', 7, 'Informatics', 3, 32, 'N');
-- Error Code: 3819. Check constraint 'students_chk_2' is violated.	0.000 sec

insert into students (firstname, lastname, class, subject_name, mark, school_no, checked)
values ('Bob', 'Brown', 3, 'Informatics', 5, 32, 'N'),
		('Lily', 'Thomas', 7, 'Math', 3, 34, 'Y'),
        ('Jane', 'King', 7, 'Informatics', 5, 32, 'Y'),
        ('Den', 'Jameson', 7, 'Informatics', 3, 32, 'N');

-- Вывести имена и фамилии студентов, у которых оценка больше 4.
select firstname, lastname
from students
where mark > 4;

-- Удаление таблицы 
-- drop table название_таблицы;

-- Удаление базы данных
-- drop database название_бд;
drop database gt21135;
-- Error Code: 1008. Can't drop database 'gt21135'; database doesn't exist	0.016 sec

-- Созадние бд с проверкой на наличие
-- create database if not exists название_бд;
create database if not exists gt210125;

-- Удаление базы данных с проверкой на наличие
drop database if exists gt21135;

drop table students;

-- Переименование таблицы 
-- rename table старое_название to новое_название;
rename table staff to employees;

-- CRUD - команды SQL можно разделить на:
	-- CREATE
	-- READ
	-- UPDATE
	-- DELETE
