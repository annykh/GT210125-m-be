use hr;

-- Вывести максимальные зарплаты по департаментам.
select dep.department_name, max(emp.salary) as max_salary 
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name;

-- Вывести те департаменты, в которых макс. зарплата меньше 10000.
select dep.department_name, max(emp.salary) as max_salary 
from employees as emp
join departments as dep
on emp.department_id = dep.department_id
group by dep.department_name
having max(emp.salary) < 10000;

-- Найти кол/во департаментов, в которых макс. зарплата меньше 10000.
select count(t1.department_name)
from (select dep.department_name, max(emp.salary) as max_salary 
		from employees as emp
		join departments as dep
		on emp.department_id = dep.department_id
		group by dep.department_name
		having max(emp.salary) < 10000) as t1;

select count(t1.department_id)
from (select department_id, max(salary) as max_salary 
		from employees 
        where department_id is not null
		group by department_id
		having max(salary) < 10000) as t1;
        
-- Найти кол/во департаментов по городам. Вывести city и dep_count.
select loc.city, count(dep.department_id) as dep_count
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
group by loc.city;

-- Найти кол/во департаментов по странам. Вывести county_name и dep_count.
select cnt.country_name, count(dep.department_id)
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on loc.country_id = cnt.country_id
group by cnt.country_name;


select *
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on loc.country_id = cnt.country_id;

select cnt.country_name, loc.city, count(dep.department_id)
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on loc.country_id = cnt.country_id
group by cnt.country_name, loc.city
order by cnt.country_name;

-- Найти регион с максимальным кол/вом департаментов.

-- 1. Найти кол/во департаментов по регионам.
select reg.region_name, count(dep.department_id) as dep_count
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on loc.country_id = cnt.country_id
join regions as reg
on cnt.region_id = reg.region_id
group by reg.region_name;

-- 2. Найти макс. кол/во департаментов по регионам.
select max(t1.dep_count)
from (select reg.region_name, count(dep.department_id) as dep_count
		from departments as dep
		join locations as loc
		on dep.location_id = loc.location_id
		join countries as cnt
		on loc.country_id = cnt.country_id
		join regions as reg
		on cnt.region_id = reg.region_id
		group by reg.region_name) as t1;

-- 4. Найти регион с макс. кол/во департаментов.        
select reg.region_name
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
join countries as cnt
on loc.country_id = cnt.country_id
join regions as reg
on cnt.region_id = reg.region_id
group by reg.region_name
having count(dep.department_id) =  (select max(t1.dep_count)
									from (select reg.region_name, count(dep.department_id) as dep_count
											from departments as dep
											join locations as loc
											on dep.location_id = loc.location_id
											join countries as cnt
											on loc.country_id = cnt.country_id
											join regions as reg
											on cnt.region_id = reg.region_id
											group by reg.region_name) as t1);      
                                            
                                            
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    Budget DECIMAL(10, 2)
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    HoursWorked DECIMAL(5, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    PRIMARY KEY (EmployeeID, ProjectID)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID, HireDate) VALUES
(1, 'John', 'Doe', 6000, 1, '2021-01-15'),
(2, 'Jane', 'Smith', 7500, 1, '2019-11-23'),
(3, 'Jim', 'Brown', 8000, 2, '2020-03-12'),
(4, 'Jake', 'Williams', 5500, 2, '2022-07-01'),
(5, 'Jess', 'Taylor', 7000, 3, '2018-05-08'),
(6, 'Jill', 'Adams', 6700, 3, '2021-06-22'),
(7, 'James', 'Davis', 9000, 4, '2020-09-30'),
(8, 'Jenny', 'Wilson', 6500, 4, '2019-04-18'),
(9, 'Jerry', 'Moore', 7200, 5, '2018-08-25');

INSERT INTO Projects (ProjectID, ProjectName, Budget) VALUES
(1, 'Website Redesign', 15000),
(2, 'New HR Software', 20000),
(3, 'Financial Audit', 10000),
(4, 'Sales Campaign', 25000),
(5, 'Market Research', 18000);

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked) VALUES
(1, 1, 120),
(2, 1, 80),
(3, 2, 100),
(4, 2, 60),
(5, 3, 110),
(6, 3, 90),
(7, 4, 150),
(8, 4, 110),
(9, 5, 130);

-- https://github.com/annykh/genTech/blob/main/CompanyDB.txt

select emp.firstname, emp.lastname, proj.projectname, empproj.HoursWorked
from employees as emp
join employeeprojects as empproj
on emp.EmployeeID = empproj.EmployeeID
join projects as proj
on empproj.ProjectID = proj.ProjectID;

-- 1. Найдите среднюю зарплату сотрудников в каждом департаменте. Выведите название департамента и среднюю зарплату.
select dep.DepartmentName, avg(emp.Salary) as avg_salary
from employees as emp
join departments as dep
on emp.departmentID = dep.departmentID
group by dep.DepartmentName;

-- 2. Определите количество сотрудников в каждом департаменте. Выведите название департамента и количество сотрудников.
select dep.DepartmentName, count(emp.EmployeeID) as emp_count
from employees as emp
join departments as dep
on emp.departmentID = dep.departmentID
group by dep.DepartmentName;

-- 3. Найдите минимальную и максимальную зарплаты в каждом департаменте. Выведите название департамента, минимальную и максимальную зарплату.
select dep.DepartmentName, max(emp.Salary) as max_salary, min(emp.Salary) as min_salary
from employees as emp
join departments as dep
on emp.departmentID = dep.departmentID
group by dep.DepartmentName;

-- 4. Определите общую сумму зарплат в каждом департаменте. Выведите название департамента и общую сумму зарплат.
select dep.DepartmentName, sum(emp.salary) as sum_salary
from employees as emp
join departments as dep
on emp.departmentID = dep.departmentID
group by dep.DepartmentName;

-- 5. Вывести ID департамента с самой высокой средней зарплатой сотрудников.
select departmentID
from employees
group by departmentID
having avg(salary) = (select max(sub.avg_salary)
						from (select departmentID, avg(salary) as avg_salary
								from employees
								group by departmentID) as sub);

-- 6. Вывести имя департамента с самой высокой средней зарплатой сотрудников.
select dep.departmentName
from employees as emp
join departments as dep
on emp.DepartmentID = dep.DepartmentID
group by dep.departmentName
having avg(emp.salary) = (select max(sub.avg_salary)
							from (select departmentID, avg(salary) as avg_salary
								from employees
								group by departmentID) as sub);

-- 7. Выведите имя, фамилию и зарплату сотрудников, чья зарплата выше средней по их департаменту.
select emp.firstname, emp.lastname, emp.salary
from employees as emp
join (select departmentID, avg(salary) as avg_salary
		from employees
		group by departmentID) as sub
on emp.departmentID = sub.DepartmentID
where emp.salary > sub.avg_salary;

-- Доп. задачи.
-- 8. Найдите проект с наибольшим количеством сотрудников, проработавших на нем больше 100 часов. Вывести ProjectName.
-- 9. Найдите департамент с наименьшим количеством сотрудников. Выведите название департамента и количество сотрудников.
-- 10. Определите департамент с наибольшим суммарным бюджетом проектов, на которых работают его сотрудники.
-- 10.1. Вывести ид департамента, имена и фамилии сотрудников, имена проектов и их бюджет.
-- 10.2. Вывести ид депатамента и сумма бюджета проектов по департаментам.
-- 10.3. Вывести маскимальную сумму бюджета проектов по департаментам.
-- 10.4. Вывести ид депатамента с максимальной суммой бюджета проектов по департаментам.
-- 10.5. Вывести имя депатамента с максимальной суммой бюджета проектов по департаментам.
-- 11. Найдите сотрудников, которые работают в департаменте с самой большой суммарной зарплатой среди всех департаментов.
