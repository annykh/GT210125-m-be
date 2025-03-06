-- Работа в песочнице 
-- https://www.programiz.com/sql/online-compiler/

-- comment
/*
comment1
comment2
comment3
*/

-- Выборки 

/* 
SELECT поле1, поле2
FROM имя_таблицы;

select поле1, поле2
from имя_таблицы;

select поле1, поле2 from имя_таблицы;
*/

-- * все поля
/* 
select *
from имя_таблицы;
*/

-- Вывести таблицу Customers 
/* 
select *
from customers; 
*/

/*
select *
from Customers;
*/

-- Вывести имена и фамилии покупателей из таблицы Customers
/* select first_name, last_name
from customers; */

-- Вывести имена и возраст покупателей из таблицы Customers
/* select first_name, age
from customers; */

-- Вывести имена, фамилии и возраст покупателей, которым больше 25.
/* select first_name, last_name, age
from customers
where age > 25; */

-- Вывести покупателей из 'USA'
/* select *
from customers
where country = 'USA'; */

-- Вывести имена и фамилии покупателей, у которых фамилия Doe.
/* select first_name, last_name
from customers
where last_name = "Doe"; */

-- Вывести покупателей, которые не из UK
/* select *
from customers
where country <> 'UK'; */

/* select *
from customers
where country != 'UK'; */

-- Вывести покупателей, которым больше 18 и они из USA.
/* select *
from customers
where age > 18 and country = 'USA'; */

-- Вывести покупателей, которые из USA или UK. 
-- Вывести покупателей из USA и UK.
/* select * 
from customers
where country = 'USA' or country = 'UK'; */

-- Вывести покупателей, которым больше 25 и они из USA или, которым меньше 25 и ид меньше 6.
/* select * 
from customers
where age > 25 and country = 'USA' or age < 25 and customer_id < 6; */

-- Вывести покупателей, которым больше 30 или меньше 25.
/* select *
from customers
where age > 30 or age < 25; */

-- where column between min and max -- [min; max]

-- Вывести покупателей, которым от 25 до 30(вкл.).
/* select *
from customers
where age between 25 and 30; */

/* select *
from customers
where age >= 25 and age <= 30; */

-- Вывести покупателей, которым больше 30 или меньше 25.
-- (-infinity; 25) and (30; +infinity)
-- not [25; 30]

/* select *
from customers
where age not between 25 and 30; */

-- where column in (value1, value2, ...)

-- Вывести покупателей, которые из USA или UK. 
/* select *
from customers
where country in ('USA', 'UK'); */

-- Вывести покупателей с именами John, David, Tom, Betty
/* select *
from customers
where first_name = 'John' or first_name = 'David' or first_name = 'Tom' or first_name = 'Betty'; */

/* select * 
from customers
where first_name in ("John", 'David', 'Tom', 'Betty'); */

-- Вывести покупателей, у которых фамилия ни Doe, ни Robinson, ни Smith. 
/* select *
from customers
where last_name not in ('Doe', 'Robinson', 'Smith'); */

/* where column like 'шаблон'
% - любое кол/во любых символов
_ - один символ(любой) */

/* 
-- имя начинается на букву 'B' 
select *
from customers
where first_name like 'b%';
-- Ben, Betty, B, barbarra

-- имя заканчивается на букву 'n'
select *
from customers
where first_name like '%n';
-- John, Non, n, Ben

-- имя содержит подсторку 'oh'
select *
from customers
where first_name like '%oh%';

-- имя где вторая буква 'o'
select *
from customers
where first_name like '_o%';

-- имя где вторая буква  'o', а последняя 'n'
select *
from customers
where first_name like '_o%n';

-- имя которое содержит 4 буквы
select *
from customers
where first_name like '____';

-- имя в середние которого есть бувка 'b'
-- Robert
-- Barbarra
-- Abba
select *
from customers
where first_name like '_%b%_';
*/

-- Вывести покупателей в возрасте от 27 до 35(вкл.), фамилии которых начинаются на 'R'.
/* select *
from customers
where age between 27 and 35 and last_name like 'r%'; */
