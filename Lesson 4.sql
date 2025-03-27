
use gt210125;

-- run code
-- ctrl + enter - Вторая молния
-- ctrl + shift + enter - Первая молния

-- https://github.com/annykh/GT210125-m-be/blob/main/employees.sql

set sql_safe_updates = 0;

-- John Russell перевели в отдел Marketing и повысили зарплату на 5000. Измените данные для работника John Russell.
update employees
set department = 'Marketing', salary = salary + 5000
where first_name = 'John' and last_name = 'Russell';

-- Удалить сотрудника Adam Fripp из таблицы.
delete from employees
where first_name = 'Adam' and last_name = 'Fripp';

-- Всех работников отдела Shipping уволили. Удалите работников Shipping из таблицы.
delete from employees
where department = 'Shipping';

-- Всех сотурдников отдела Sales перевели в отдел Finance и повысли зарплаты на 1000. Изменить данные для этих сотрудников.
update employees
set department = 'Finance', salary = salary + 1000
where department = 'Sales';

-- Удалить сотрудников с employee_id 2, 7, 10.
delete from employees
where employee_id in (2, 7, 10);
-- where employee_id = 2 or employee_id = 7 or employee_id = 10;

-- Очистить таблицу обнуляя auto_increment.
truncate table employees;

-- Включить безопасный режим обновления данных
set sql_safe_updates = 1;

select * from employees;

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

-- Выборка уникальных значений. Оператор DISTINCT

-- Вывести уникальные названия департаментов из таблицы employees
select distinct department 
from employees;

-- Вывести уникальные пары имен и фамилии из employees.
select distinct first_name, last_name
from employees;


-- Сортировка. ORDER BY

-- asc - по возр. (по алф. порядку) - по умолчанию
-- desc - по убыв.

-- Вывести имена фамилии и зарплаты сотрудников. Отсортировать по возр. зарлат.
select first_name, last_name, salary
from employees
order by salary asc;

-- Вывести имена и фамилии сотрудников. Отсортировать по именам по алф. порядку.
select first_name, last_name
from employees
order by first_name asc;

-- Вывести имена, фамилии и зарплаты сотрудников, у которых зарплата меньше 5000. Отсортировать по именам по алф. порядку.
select first_name, last_name, salary
from employees
where salary < 5000
order by first_name;

-- Вывести имена, фамилии и зарплаты сотрудников, у которых зарплата меньше 5000. Отсортировать по убыв. зарплат.
select first_name, last_name, salary
from employees
where salary < 5000
order by salary desc;

-- Вывести имена, фамилии и департаменты. Отсортировать по именам департаментов по алф. порядку.
select first_name, last_name, department
from employees
order by department;

-- Вывести сотрудников. Отсортировать по алф. порядку first_name, в обр. поярдке last_name.
select *
from employees
order by first_name asc, last_name desc;

-- Вывести имена, фамилии и зарплаты сотрудников, которые работают в департаменте IT. Отсортировать выборку по убыванию зарплат и по алфавитному порядку имен.
select first_name, last_name, salary
from employees
where department = 'IT'
order by salary desc, first_name asc;


-- Получение диапазона строк. Оператор LIMIT
-- limit N - N кол/во строк, которое нужно вывести
-- limit M, N - M кол/во строк, которое нужно пропустить, N кол/во строк, которое нужно вывести

-- select 
-- from 
-- where
-- order by
-- limit

-- Вывести первых трех сотрудников, которые зарабатывают больше 5000.
select *
from employees
where salary > 5000
limit 3;

-- Вывести трех сотрудников, которые зарабатывают больше 5000, пропуская первых двух.
select *
from employees
where salary > 5000
limit 2, 3;

-- Вывести сотрудника с максимальной зарплатой.
select *
from employees
order by salary desc
limit 1;

-- Вывести двух сотрудников из отдела IT, пропуская первого.
select * 
from employees
where department = 'IT'
limit 1, 2;

-- Вывести первых двух сотрудников из отдела Sales, которые получают самые высокие зарплаты.
select *
from employees
where department = 'Sales'
order by salary desc
limit 2;

-- Оператор AS - изменить название выходного столбца в запросе (определить псевдоним столбца)

-- Вывести имена и фамилии сотрудников. Дать first_name псевдоним name, а last_name - surname.
select first_name as name, last_name as surname
from employees; 

-- Вывести зарплаты сотрудников, и зарплаты - 10% ком..
select salary, salary - (salary * 10 / 100) as salary_with_commission
from employees;

-- Вывести имена, фамилии, зарплаты и департаменты сотр. Дать псевдоним department_name полю department.
select first_name, last_name, salary, department as department_name
from employees;

-- Встроенные функции
-- Функции CASE, IF, IFNULL, COALESCE

-- Функция CASE проверяет истинность набора условий
-- и в зависимости от результата проверки может возвращать тот или иной результат.

-- case
-- 		when условие_1 then результат1
-- 		when условие_2 then результат2
-- 		when условие_3 then результат3
--     [else альтернативный_результат]
-- end

-- Вывести имена, фамилии, зарплаты сотрудников, и поле salary_cat, где:
-- Если зарплата меньше 7000, то значение low
-- Если зарплата меньше 15000, то значение mid
-- Если зарплата больше/равна 15000, то значение high

select first_name, last_name, salary, 
		case
			when salary < 7000 then 'low'
            when salary < 15000 then 'mid'
            else 'high'
        end as salary_cat
from employees;

-- Создать поле salary_cat varchar(24), вставить после salary.
alter table employees
add column salary_cat varchar(24) after salary;

-- Заполнить поле salary_cat:
-- Если зарплата меньше 7000, то значение low
-- Если зарплата меньше 15000, то значение mid
-- Если зарплата больше/равна 15000, то значение high

set sql_safe_updates = 0;

-- update employees
-- set salary_cat = 'low'
-- where salary < 7000;

-- update employees
-- set salary_cat = 'mid'
-- where salary >= 7000 and salary < 15000;

-- update employees
-- set salary_cat = 'high'
-- where salary >= 15000;


update employees
set salary_cat = case
						when salary < 7000 then 'low'
                        when salary < 15000 then 'mid'
                        else 'high'
				end;


-- Обновить зарплаты сотрудников:
-- если salary_cat равен low, увеличить зарплату на 10%
-- если salary_cat равен mid, увеличить зарплату на 5%

update employees
set salary = case
					when salary_cat = 'low' then salary + (salary * 10 / 100)
                    when salary_cat = 'mid' then salary + (salary * 5 / 100)
                    else salary
			 end;

select * from employees;

-- Вывести имена, фамилии и названия департаментов на русском как поле department_name_ru.
-- Переводы департаментов:
-- Sales → Продажи
-- Finance → Финансы
-- Shipping → Доставка
-- Marketing → Маркетинг
-- Human Resources → Управление персоналом
-- IT → Информационные технологии

select first_name, last_name,  
  case
            when department = 'Sales' then 'Продажи'
            when department = 'Finance' then 'Финансы'
            when department = 'Shipping' then 'Доставка'
            when department = 'Marketing' then 'Маркетинг'
            when department = 'Human Resources' then 'Управление персоналом'
            when department = 'IT' then 'Информационные технологии'
    end as department_name_ru
from employees;
