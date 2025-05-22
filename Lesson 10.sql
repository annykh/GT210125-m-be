-- https://github.com/annykh/genTech/blob/main/hr1.txt

select * from employees;
select * from departments;
select * from jobs;
select * from locations;
select * from countries;
select * from regions;

-- Агрегатные функции

-- min(поле) - вычисляет наименьшее значенние (int/integer, numeric/decimal)
-- max(поле) - вычисляет наибольшее значенние (int/integer, numeric/decimal)
-- sum(поле) - вычисляет сумму значений (int/integer, numeric/decimal)
-- avg(поле) - вычисляет среднее значение (int/integer, numeric/decimal)
-- count(*/поле) - вычисляет кол/во строк в запросе/в поле (all data types), * - общее кол/во строк в запросе/в таблице

-- Все агрегатные функции за исключением COUNT(*) игнорируют значения NULL.


-- Вывести минимальную зарплату в компании.
select min(salary) as min_salary
from employees;

select salary
from employees
order by salary
limit 1;

-- Вывести максимальную зарплату в компании.
select max(salary) as max_salary
from employees;

select salary
from employees
order by salary desc
limit 1;

-- Вывести сотрудников, которые получают максимальную зарплату в компании
-- Вывести сотрудников, которые получают минимальную зарплату в компании
select first_name, last_name, salary
from employees
order by salary
limit 1;

select first_name, last_name, salary
from employees
order by salary desc
limit 1;

-- Если не вкл. безопасный режим группировки
select min(salary) as min_salary, first_name, last_name
from employees;
-- 2100 'Steven' 'King' - ложный результат

select max(salary) as min_salary, first_name, last_name
from employees;
-- 24000 'Steven' 'King' 

-- Безопасный режим группировки 
SET sql_mode = CONCAT(@@sql_mode, ',ONLY_FULL_GROUP_BY');

select min(salary) as min_salary, first_name, last_name
from employees;
-- Error Code: 1140. In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 'hr.employees.first_name'; this is incompatible with sql_mode=only_full_group_by	0.000 sec

-- ПОДЗАПРОСЫ 
-- Запрос который содержит одно поле/значение 
-- select column_name1, column_name2
-- from table1
-- where column_name3 = (select aggregate(column) from table1);

select first_name, last_name, salary
from employees
where salary = (select min(salary) from employees);

select first_name, last_name, salary
from employees
where salary = (select max(salary) from employees);

-- Вывести максимальную зарплату среди сотрудников из департамента с id 100.
select max(salary) as max_salary
from employees
where department_id = 100;

-- Вывести максимальную зарплату среди сотрудников из департамента IT.
select max(emp.salary) as max_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name = 'IT';

-- Найти сумму зарплат среди всех сотрудников.
select sum(salary)
from employees;

-- Найти среднюю зарплату среди всех сотрудников.
select avg(salary)
from employees;

-- Найти сумму зарплат среди сотурдников, которые не платят комиссии.
select sum(salary)
from employees
where commission_pct is null;

-- Найти среднюю зарплату среди сотурдников из департаментов 'Shipping' и 'Sales'.
select avg(emp.salary) as avg_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name in ('Shipping', 'Sales');

-- Найти кол/во сотрудников в компании.
select count(employee_id) as emp_count
from employees;

-- Найти кол/во строк/записей в таблице employees.
select count(*)
from employees;

-- Найти кол/во сотудников, которые получают больше 10000.
select count(employee_id)
from employees
where salary > 10000;

-- Вывести кол/во строк запроса, который находит сотрдуников из департаментов 'IT', 'Purchasing', 'Finance', у которых имя начинается на 'A'.
select count(*)
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name in ('IT', 'Purchasing', 'Finance') and emp.first_name like 'A%';

-- Найти сотрудников, у которых зарплата меньше средней зарплаты по компании.
select first_name, last_name, salary
from employees
where salary < (select avg(salary) from employees);

-- Найти кол/во сотрудников, у которых зарплата меньше средней зарплаты по компании.
select count(employee_id)
from employees
where salary < (select avg(salary) from employees);

-- Найти кол/во сотрудников, которые платят комиссии.
-- Кол/во строк в запросе(null or not null), где commission_pct is not null
select count(*)
from employees
where commission_pct is not null;

-- Кол/во не null значений в поле employee_id, где commission_pct is not null
select count(employee_id)
from employees
where commission_pct is not null;

-- Кол/во не null значений в поле commission_pct
select count(commission_pct)
from employees;

-- Найти кол/во менеджеров в компании по manager_id.
select count(distinct manager_id) as mng_count
from employees;

-- Найти количество сотрудников из департамента с ID 60, которые зарабатывают больше средней зарплаты по компании.
select count(employee_id)
from employees
where department_id = 60 and salary > (select avg(salary) from employees);

-- select count(employee_id)
-- from employees
-- where department_id = 60 and salary > avg(salary);
-- Error Code: 1111. Invalid use of group function	0.016 sec

-- Вывести имена и фамилии сотрудников с максимальной и минимальной зарплатой.
select first_name, last_name
from employees
where salary in ((select max(salary) from employees), (select min(salary) from employees));
-- where salary = (select max(salary) from employees) or salary = (select min(salary) from employees);

-- Вывести список сотрудников с должностью 'Programmer'(job_title), чья зарплата выше средней зарплаты среди всех сотрудников с этой должностью.
select emp.first_name, emp.last_name
from employees as emp
join jobs as jb
on emp.job_id = jb.job_id
where jb.job_title = 'Programmer' and emp.salary > (select avg(emp.salary)
	from employees as emp
	join jobs as jb
	on emp.job_id = jb.job_id
	where jb.job_title = 'Programmer');


-- Найти количество департаментов, в которых никто не работает.
select count(dep.department_id) as dep_count
from departments as dep
left join employees as emp
on dep.department_id = emp.department_id
where emp.employee_id is null;

-- Найти самую низкую и самую высокую зарплату среди сотрудников с должностями IT_PROG и ST_MAN (job_id).
select min(salary) as min_salary, max(salary) as max_salary
from employees
where job_id in ('IT_PROG', 'ST_MAN');

-- Вывести имена и фамилии сотрудников с должностями(job_id) IT_PROG и ST_MAN, которые получают либо самую низкую, либо самую высокую зарплату в компании.
select first_name, last_name
from employees
-- where job_id in ('IT_PROG', 'ST_MAN') and salary in ((select max(salary) from employees), (select min(salary) from employees));
where (job_id = 'IT_PROG' or job_id = 'ST_MAN') and (salary = (select max(salary) from employees) or salary = (select min(salary) from employees));

-- Вывести имена и фамилии сотрудников из отделов(job_id) IT_PROG и ST_MAN, которые получают либо самую низкую, либо самую высокую зарплату в своих отделах. 
select first_name, last_name, job_id, salary
from employees
where job_id in ('IT_PROG', 'ST_MAN') and 
		salary in (
			(select max(salary) from employees where job_id in ('IT_PROG', 'ST_MAN')), 
			(select min(salary) from employees where job_id in ('IT_PROG', 'ST_MAN')));
            
-- Найти количество сотрудников из департамента Shipping, которые зарабатывают меньше средней зарплаты среди всех сотрудников этого департамента.
-- Средняя зарплата среди сотрдуников из департамента Shipping
select avg(emp.salary)
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name = 'Shipping';

-- Сотрудники из департамента Shipping, которые зарабатывают меньше средней зарплаты среди всех сотрудников этого департамента.
select emp.first_name, emp.last_name, emp.salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name = 'Shipping' and emp.salary < (select avg(emp.salary)
				from employees as emp
				join departments as dep
				on emp.department_id = dep.department_id
				where dep.department_name = 'Shipping');
                
-- Кол/во сотрудников, ....                
select count(employee_id)
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name = 'Shipping' and emp.salary < (select avg(emp.salary)
				from employees as emp
				join departments as dep
				on emp.department_id = dep.department_id
				where dep.department_name = 'Shipping');                
