-- Сортировка. ORDER BY

-- Получение диапазона строк. Оператор LIMIT
-- limit N - N кол/во строк, которое нужно вывести
-- limit M, N - M кол/во строк, которое нужно пропустить, N кол/во строк, которое нужно вывести

-- Оператор AS - изменить название выходного столбца в запросе (определить псевдоним столбца)

-- Встроенные функции

-- Функция CASE проверяет истинность набора условий
-- и в зависимости от результата проверки может возвращать тот или иной результат.

-- case
-- 		when условие_1 then результат1
-- 		when условие_2 then результат2
-- 		when условие_3 then результат3
--     [else альтернативный_результат]
-- end

use gt210125;

create table phones(
	id int primary key auto_increment,
    product_name varchar(128),
    product_count int,
    product_price int,
    tax int
);

insert into phones (product_name, product_count, product_price, tax)
values ('iphone 15', 15, 800, null),
		('iphone 15 pro', 20, 850, 5),
        ('iphone 15 pro max', 7, 900, 5),
        ('iphone 16', 3, 1000, null),
        ('iphone 16 pro', 10, 1100, 10),
        ('iphone 16 pro max', 2, 1200, 10),
        ('iphone 16e', 3, 800, null);
        
select * from phones;

-- Создать поле count_info и заполнить:
	 -- 'Нет в наличии', если кол/во = 0 
	 -- 'Товар заканчивается', если кол/во меньше 2.
	 -- 'Мало товара', если кол/во меньше 5.
	 -- 'Есть в наличии', если кол/во меньше 15.
	 -- 'Много товара', в остальных случаях.
     
alter table phones
add column count_info varchar(128);

set sql_safe_updates = 0;

update phones
set count_info = case
					when product_count = 0 then 'Нет в наличии'
                    when product_count < 2 then 'Товар заканчивается'
                    when product_count < 5 then 'Мало товара'
                    when product_count < 15 then 'Есть в наличии'
                    else 'Много товара'
				  end;
                  
select * from phones;

-- Посчитать конечную стоимость и представить как final_price
-- final_price = (product_price + product_price * tax / 100)

select product_name, product_price, tax, (product_price + product_price * tax / 100) as final_price
from phones;

-- Вариант 1
select product_name, product_price, tax, 
	case
		when (product_price + product_price * tax / 100) is null then product_price
		else (product_price + product_price * tax / 100)
	end as final_price
from phones;

-- Функция COALESCE
-- Функция COALESCE принимает список значений и возвращает первое из них, которое не равно NULL.
-- coalesce(value1, value2, value3, ...)
-- value - поле, константное значение, формула, функция...

-- Вариант 2
select product_name, product_price, tax, 
	coalesce((product_price + product_price * tax / 100), product_price, 'не указана цена товара') as final_price
from phones;

-- Функция IF
-- Функция IF в зависимости от результата условного выражения возвращает одно из двух значений.
-- if(условие, значение1, значени2)

-- Вариант 3
select product_name, product_price, tax, 
	if((product_price + product_price * tax / 100) is null, product_price, (product_price + product_price * tax / 100)) as final_price
from phones;    


-- Функция IFNULL
-- Функция IFNULL проверяет значение некоторого выражения. 
-- Если оно равно NULL, то функция возвращает значение, которое передается в качестве второго параметра:
-- ifnull(выражение, значение)

-- Вариант 4
select product_name, product_price, tax, ifnull((product_price + product_price * tax / 100), product_price) as final_price
from phones;

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

-- 1. Повысить зарплаты для отдела sales на 20%, для finance 15%, для shipping 10%, для marketing 25%, для Human Resources 20% и для IT 35%. 
-- Записать данные в новое поле new_salary. Поле создавать не нужно, используем AS. 
select first_name, last_name, department, 
	case
		when department in ('Sales', 'Human Resources') then salary + salary * 20 / 100
		when department = 'Finance' then salary + salary * 15 / 100
        when department = 'Shipping' then salary + salary * 10 / 100
        when department = 'Marketing' then salary + salary * 25 / 100
        when department = 'IT' then salary + salary * 35 / 100
        else salary
    end as new_salary
from employees;

-- Для сотурдников 'Diana' 'Lorentz', 'Bruce' 'Ernst' и 'Lex' 'De Haan' изменить значение зарплаты на NULL.
update employees
set salary = null
where first_name = 'Diana' and last_name = 'Lorentz'
	or first_name = 'Bruce' and last_name = 'Ernst'
    or first_name = 'Lex' and last_name = 'De Haan';
    
select * from employees;

-- Написать запрос, который выведет имя, фамилию и зарплату каждого сотрудника.
-- Если зарплата NULL, замените ее на 5000.
select first_name, last_name, coalesce(salary, 5000) as salary
from employees;

select first_name, last_name, ifnull(salary, 5000) as salary
from employees;

select first_name, last_name, if(salary is null, 5000, salary) as salary
from employees;

-- Написать запрос, который выведет имя, фамилию, зарплату и флаг (Да или Нет), 
-- указывающий, получает ли сотрудник в отделе "IT" зарплату выше 12000.
-- Вывести сотрудников из отдела "IT".
select first_name, last_name, salary, 
		case 
			when salary > 12000 then 'Да'
            else 'Нет'
        end as flag
from employees
where department = 'IT';

select first_name, last_name, salary, 
		if(salary > 12000, 'Да', 'Нет') as flag
from employees
where department = 'IT';

-- Соединение таблиц

-- Вертикальное соединение 
-- UNION/UNION ALL

-- Оператор UNION позволяет обединить две однотипных выборки. 
-- Эти выборки могут быть из разных таблиц или из одной и той же таблицы.

create database shop1;

use shop1;

create table user_bremen(
	id int primary key auto_increment,
    first_name varchar(128),
    last_name varchar(128),
    age int,
    email varchar(128),
    phone varchar(128)
);

create table user_berlin(
	id int primary key auto_increment,
    first_name varchar(128),
    last_name varchar(128),
    age int,
    email varchar(128)
);

insert into user_bremen (first_name, last_name, age, email, phone)
values ('John', 'Smith', 34, 'jsmith@gmail.com', '+1234890765'),
		('Linda', 'Jonson', 23, 'ljonson@gmail.com', '+37412345676'),
        ('Barbarra', 'Thomas', 45, 'bthomas@gmail.com', '+13427774568'),
        ('Ben', 'King', 54, 'bking@gmail.com', '+1009456888'),
		('Lucas', 'Jameson', 36, 'lujameson@gmail.com', +1789098567);
        
insert into user_berlin (first_name, last_name, age, email)
values ('Carol', 'Robson', 35, 'crobson@gmail.com'),
		('Bob', 'Brown', 54, 'bbrown@gmail.com'),
        ('Barbarra', 'Thomas', 45, 'bthomas@gmail.com'),
        ('Mellissa', 'Wans', 20, 'mwans@gmail.com'),
        ('Laura', 'Smith', 34, 'lsmith@gmail.com');


select * from user_berlin;
select * from user_bremen;

select first_name, last_name, age, email
from user_bremen;

select first_name, last_name, age, email
from user_berlin;

-- select поле1, поле2, поле3 from таблица1
-- union/union all
-- select поле1, поле2, поле3 from таблица2;

-- Вывести имена, фамилии, возраст и эл. адресс пользователей из Бремена и Берлина без дубликатов.
select first_name, last_name, age, email
from user_bremen
union 
select first_name, last_name, age, email
from user_berlin;

-- Вывести имена, фамилии, возраст и эл. адресс пользователей из Бремена и Берлина.
select first_name, last_name, age, email
from user_bremen
union all
select first_name, last_name, age, email
from user_berlin;

select * from user_berlin
union 
select * from user_bremen;
-- Error Code: 1222. The used SELECT statements have a different number of columns	0.000 sec

-- Вывести имена, фамилии, возраст, эл. адресса и телефонные номера пользователей из двух магазинов. 
-- Если телефонный номер не указан, вывести null
select first_name, last_name, age, email, phone
from user_bremen
union
select first_name, last_name, age, email, null as phone
from user_berlin;

create table employees(
 	employee_id int primary key auto_increment,
 	firstname varchar(128) not null,
 	lastname varchar(128) not null,
 	email varchar(128) not null,
 	salary int, 
	department varchar(128) not null
 );
 
insert into employees(firstname, lastname, email, salary, department) values("Steven","King",	"SKING", 24000, "Sales");
insert into employees(firstname, lastname, email, salary, department) values("Neena" , "Kochhar" , "NKOCHHAR" , 17000 , "Sales");
insert into employees(firstname, lastname, email, salary, department) values("Lex" , "De Haan" , "LDEHAAN" , 17000 , "Sales");
insert into employees(firstname, lastname, email, salary, department) values("Alexander" , "Hunold" , "AHUNOLD" , 9000 , "Finance");
insert into employees(firstname, lastname, email, salary, department) values("Bruce" , "Ernst" , "BERNST" , 6000 , "Finance");
insert into employees(firstname, lastname, email, salary, department) values("Valli" , "Pataballa" , "VPATABAL" , 4800 , "Finance");
insert into employees(firstname, lastname, email, salary, department) values("Diana" , "Lorentz" , "DIANALO" , 8800 , "Finance");
insert into employees(firstname, lastname, email, salary, department) values("Nancy" , "Greenberg" , "NGREENBE" , 12008 , "Shipping");
insert into employees(firstname, lastname, email, salary, department) values("Daniel" , "Faviet" , "DFAVIET" , 9000 , "Shipping");

-- Вывести имена и фамилии всех пользователейиз двух таблиц, и имена и фамилии сотрудников.
select first_name, last_name
from user_bremen
union
select first_name, last_name
from user_berlin
union
select firstname, lastname
from employees;

select firstname, lastname
from employees
union
select first_name, last_name
from user_bremen
union
select first_name, last_name
from user_berlin;


select last_name, first_name
from user_bremen
union
select first_name, last_name
from user_berlin;
-- Логическая ошибка в выборке

-- Выведите имена, фамилии и телефонные номера пользователей из таблицы user_bremen.
-- Дополнительно выведите временное поле tel_number_code, в котором:
	-- Значение "USA" устанавливается, если номер телефона начинается с +1.
	-- Значение "Armenia" устанавливается, если номер телефона начинается с +374.
    
select first_name, last_name, phone, 
		case
			when phone like '+1%' then 'USA'
            when phone like '+374%' then 'Armenia'        
        end as tel_number_code
from user_bremen;

select first_name, last_name, phone, 'USA' as tel_number_code
from user_bremen
where phone like '+1%'
union
select first_name, last_name, phone, 'Armenia' as tel_number_code
from user_bremen
where phone like '+374%'
union
select first_name, last_name, phone, null as tel_number_code
from user_bremen
where phone not like '+374%' and phone not like '+1%';


-- Д/З
-- 1. Создать и заполнить таблицы products1 и products2.

create table products1(
	id int primary key,
    name varchar(50),
    quantity int check(quantity > 0 and quantity < 10),
    in_stock char(1) check(in_stock in ('Y', 'N'))
);

create table products2(
	id int primary key,
    name varchar(50),
    quantity int check(quantity > 0 and quantity < 10),
    price int check(price > 0),
    in_stock char(1) check(in_stock in ('Y', 'N'))
);

insert into products1
values (1, 'Велосипед', 2, 'Y'), 
		(2, 'Скейт', 4, 'Y'), 
		(3, 'Самокат', 2, 'Y'), 
		(4, 'Сноуборд', 7, 'N'), 
		(5, 'Санки', 1, 'Y'), 
		(6, 'Коньки', 3, 'N'), 
		(7, 'Ролики', 5, 'Y');

insert into products2 
values (1, 'Тюбинг', 5, 1000, 'Y'), 
		(2, 'Санки', 2, 1500, 'Y'), 
		(3, 'Снегокат', 2, 900, 'Y'), 
		(4, 'Сноуборд', 7, 700, 'N'), 
		(5, 'Клюшка', 8, 300, 'Y'), 
		(6, 'Коньки', 3, 350, 'N'), 
		(7, 'Форма', 9, 450, 'Y');
        

-- 2. Вывести названия товаров из обеих таблиц без дубликатов.
-- 3. Вывести названия товаров из обеих таблиц, включая дубликаты.
-- 4. Объединить данные из двух таблиц, указав price, где это возможно, где нет - указать null.
-- 5. Вывести все товары из обеих таблиц и добавить дополнительное поле source,
-- которое будет содержать 'P1' для товаров из products1 и 'P2' для товаров из products2.
-- Вывести название и source.
