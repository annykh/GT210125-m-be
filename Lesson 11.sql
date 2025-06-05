-- Агрегатные функции

-- min(поле) - вычисляет наименьшее значенние (int/integer, numeric/decimal)
-- max(поле) - вычисляет наибольшее значенние (int/integer, numeric/decimal)
-- sum(поле) - вычисляет сумму значений (int/integer, numeric/decimal)
-- avg(поле) - вычисляет среднее значение (int/integer, numeric/decimal)
-- count(*/поле) - вычисляет кол/во строк в запросе/в поле (all data types), * - общее кол/во строк в запросе/в таблице

-- Все агрегатные функции за исключением COUNT(*) игнорируют значения NULL.

-- ПОДЗАПРОСЫ 
-- Запрос который содержит одно поле/значение 
-- select column_name1, column_name2
-- from table1
-- where column_name3 = (select aggregate(column) from table1);

use hr;

-- Вывести имена и фамилии сотрудников, которые получают больше средней зарплаты.
select first_name, last_name
from employees
where salary > (select avg(salary) from employees);

-- Найти кол/во сотрудников, которые получают больше средней зарплаты.
select count(employee_id)
from employees
where salary > (select avg(salary) from employees);

-- Найти кол/во сотурдников из департамента "Sales".
select dep.department_name, count(emp.employee_id)
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name = 'Sales';

-- Найти кол/во сотурдников из департамента "IT".
select dep.department_name, count(emp.employee_id)
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name = 'IT';

-- Группировка
-- GROUP BY

-- SELECT столбцы
-- FROM таблица
-- [JOIN ... ON ...]
-- [WHERE условие_фильтрации_строк]
-- [GROUP BY столбец_для_группировки]
-- [HAVING условие_фильтрации_групп]
-- [ORDER BY столбцы_сортировки]
-- [LIMIT целое_число]

-- Выполняются по порядку:
-- FROM
-- JOIN ... ON ...
-- WHERE
-- GROUP BY
-- HAVING
-- SELECT
-- ORDER BY
-- LIMIT


-- Вывести кол/во сотрудников по ид департаментов.  Отсортировать по возрастанию кол/во.
select department_id, count(employee_id) as emp_count
from employees
where department_id is not null
group by department_id
order by emp_count;

-- Найти кол/во сотрудников по ид департаментов. Вывести те депараменты, в которых кол/во сотрудников больше 10.
select department_id, count(employee_id) as emp_count
from employees
where department_id is not null
group by department_id
having count(employee_id) > 10;


-- Найти средние зарплаты по департаментам. Вывести department_id и avg_salary.
select department_id, avg(salary) as avg_salary
from employees
where department_id is not null
group by department_id;

-- Найти департаменты, в которых сумма зарплат больше 30000. Вывести department_id и sum_salary.
select department_id, sum(salary) as sum_salary
from employees
where department_id is not null
group by department_id
having sum(salary) > 30000;

-- Нельзя вывести неагрегатные поля с агрегатными и с полем группировки. Все неагрегатные поля, которые нужно вывести должны быть в группировке(group by)
select department_id, sum(salary) as sum_salary, employee_id
from employees
where department_id is not null
group by department_id
having sum(salary) > 30000;
-- Error Code: 1055. Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'hr.employees.employee_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.000 sec

-- Вывести максимальные зарплаты по департаментам и 
-- вывести имена сотрудников, которые получают в своих департаментах макисмальную зарплату.
select department_id, first_name, last_name, max(salary)
from employees
where department_id is not null
group by department_id;
-- Error Code: 1055. Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'hr.employees.employee_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.000 sec

-- Найти максимальные зарплаты по департаментам. Вывести название департамента и максимальную зарплату.
select dep.department_name, max(emp.salary) as max_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name;

-- Найти департаменты, где средняя зарплата выше 10000. Вывести название департамента и среднюю зарплату.
select dep.department_name, avg(emp.salary) as avg_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name
having avg(emp.salary) > 10000;

-- Найти суммы зарплат в департаментах IT, Sales, Finance и Shipping. Вывести названия департаментов и суммы зарплат.
select dep.department_name, sum(emp.salary) as sum_salary
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
where dep.department_name in ('IT', 'Sales', 'Finance', 'Shipping')
group by dep.department_name;

-- Подзапросы 

-- Подзапрос, который возвращает таблицу(множество строк/столбцов)
-- select column1, aggregate(column)
-- from table1
-- [join ... on]
-- [where ...]
-- group by column1
-- [having ...];

-- Освновной запрос 1
-- select t2.column1, sub_table.column2
-- from table2 as t2
-- join (Подзапрос) as sub_table
-- on t2.column3 = sub_table.column4
-- [where ...]
-- [group by ...]
-- [having ...];

-- Освновной запрос 2
-- select t2.column1, sub_table.column2
-- from (Подзапрос) as sub_table
-- join table2 as t2
-- on t2.column3 = sub_table.column4
-- [where ...]
-- [group by ...]
-- [having ...];

-- Освновной запрос 3
-- select sub_table.column1
-- from (Подзапрос) as sub_table
-- [where ...]
-- [group by ...]
-- [having ...];

-- Найти имена и фамили сотрудников, которые получают максимальную зарплату в своих департаментах.
-- 1. Найти максимальные зарплаты по департаментам. (Подзапрос)
select department_id, max(salary) as max_salary
from employees
where department_id is not null
group by department_id;

-- 2. Решение (Основной запрос)
select t1.first_name, t1.last_name, t2.department_id, t2.max_salary
from employees as t1
join (select department_id, max(salary) as max_salary
		from employees
		where department_id is not null
		group by department_id) as t2 -- subtable for max salaries by departments
on t1.department_id = t2.department_id
where t1.salary = t2.max_salary; 

-- Вывести имена, фамилии и зарплаты сотрудников, которые получают больше чем средняя зарплата в их департаментах.
select department_id, avg(salary) as avg_salary
from employees
where department_id is not null
group by department_id;

select t2.first_name, t2.last_name, t2.salary
from (select department_id, avg(salary) as avg_salary
		from employees
		where department_id is not null
		group by department_id) as t1 -- subtable for avg salaries by departments
join employees as t2
on t1.department_id = t2.department_id
where t2.salary > t1.avg_salary;

-- Найти кол/во сотрудников, которые получают больше чем средняя зарплата в их департаментах.
select count(t2.employee_id)
from (select department_id, avg(salary) as avg_salary
		from employees
		where department_id is not null
		group by department_id) as t1 -- subtable for avg salaries by departments
join employees as t2
on t1.department_id = t2.department_id
where t2.salary > t1.avg_salary;

-- Найти кол/во департментов, в которых максимальная зарплата выше 10000. 
select count(t1.department_id)
from (select department_id, max(salary) as max_salary
		from employees
		where department_id is not null
		group by department_id) as t1
where t1.max_salary > 10000;

select count(sub.department_id) as dep_count
from (
	select department_id, max(salary) as max_salary
	from employees
	where department_id is not null
	group by department_id 
	having max(salary) > 10000
	) as sub;
    
-- Найти департаменты с наименьшим кол/вом сотрудников.
-- 1. Найти кол/во сотрудников по департаментам.
select department_id, count(employee_id) as emp_count
from employees
where department_id is not null
group by department_id;

-- 2. Найти миниманльное кол/во сотурдников по департаментам.
select min(t1.emp_count) as min_emp_count
from (select department_id, count(employee_id) as emp_count
	from employees
	where department_id is not null
	group by department_id) as t1;

-- 3. Вывести департмамент с наименьшим кол/вом сотрудников.
select dep.department_name, count(emp.employee_id)
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name
having count(emp.employee_id) = (select min(t1.emp_count) as min_emp_count
								from (select department_id, count(employee_id) as emp_count
									from employees
									where department_id is not null
									group by department_id) as t1);

-- Найти кол/во департаментов с наибольшим кол/во сотрудников.
-- 1. Найти кол/во сотрудников по департаментам.
select department_id, count(employee_id) as emp_count
from employees
where department_id is not null
group by department_id;

-- 2. Найти наибольшое кол/во сотрудников по департаментам.
select max(t1.emp_count) as max_emp_count
from (select department_id, count(employee_id) as emp_count
		from employees
		where department_id is not null
		group by department_id) as t1;

-- 3. Вывести ид департаментов с  наибольшим кол/во сотрудников.
select department_id
from employees 
group by department_id
having count(employee_id) = (select max(t1.emp_count) as max_emp_count
							from (select department_id, count(employee_id) as emp_count
									from employees
									where department_id is not null
									group by department_id) as t1);
                                    
-- 4. Найти кол/во департаментов с наибольшим кол/во сотрудников.
select count(max_count_emp_dep.department_id)
from (select department_id
		from employees 
		group by department_id
		having count(employee_id) = (select max(t1.emp_count) as max_emp_count
										from (select department_id, count(employee_id) as emp_count
												from employees
												where department_id is not null
												group by department_id) as t1)) as max_count_emp_dep;
