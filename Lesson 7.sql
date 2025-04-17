select * from employees;
select * from departments;
select * from jobs;
select * from locations;
select * from countries;
select * from regions;

-- select column1, column2, column3,...
-- from table1
-- [inner] join table2
-- on table1.column = table2.column 
-- [inner] join table3
-- on условие..

-- Вывести имена и фамилии сотрудников, а также названия их департаментов и названия городов, кототых находятся департаменты.
select emp.first_name, emp.last_name, dep.department_name, loc.city
from employees as emp 
join departments as dep
on emp.department_id = dep.department_id
join locations as loc
on dep.location_id = loc.location_id;

-- Вывести имена, фамилии сотрудников, название департаментов, в которых они работают,
-- города, в которых находятся департаменты и название стран, в которых находятся города.
select emp.first_name, emp.last_name, dep.department_name, loc.city, cnt.country_name
from employees as emp 
join departments as dep
on emp.department_id = dep.department_id
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on loc.country_id = cnt.country_id;

-- Вывести имена и фамилии сотрудников, департаменты которых находятся в стране 'United Kingdom'(country_name).
select emp.first_name, emp.last_name
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on loc.country_id = cnt.country_id
where cnt.country_name = 'United Kingdom';

-- Вывести департамнеты, которые находятся в регионе 'Europe'. Вывести только имя департамента.
select dep.department_name
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on loc.country_id = cnt.country_id
join regions as reg
on cnt.region_id = reg.region_id
where reg.region_name = 'Europe';

-- Вывести имена, фамилии сотрудников, должности и название департаментов.
select emp.first_name, emp.last_name, jb.job_title, dep.department_name
from employees as emp
join jobs as jb
on emp.job_id = jb.job_id
join departments as dep
on emp.department_id = dep.department_id;

select emp.first_name, emp.last_name, jb.job_title, dep.department_name
from employees as emp
join departments as dep
on dep.department_id = emp.department_id
join jobs as jb
on emp.job_id = jb.job_id;

select emp.first_name, emp.last_name, jb.job_title, dep.department_name
from departments as dep
join employees as emp
on dep.department_id = emp.department_id
join jobs as jb
on emp.job_id = jb.job_id;

-- Вывести имена, фамилии и должности сотрудников, которые зарабатывают ровно минимальную или масимальную зарплату для должности.
select emp.first_name, emp.last_name, jb.job_title
from employees as emp
join jobs as jb
on emp.job_id = jb.job_id
where emp.salary = jb.min_salary or emp.salary = jb.max_salary;