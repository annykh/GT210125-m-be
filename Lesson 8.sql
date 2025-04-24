select * from customers;
select * from products;
select * from categories;
select * from orders;
select * from order_items;

-- 11. Получить список всех заказов и их клиентов, отсортированный по дате заказа. Вывести first_name, last_name, order_date.
select c.first_name, c.last_name, o.order_date
from customers as c
join orders as o
on c.customer_id = o.customer_id
order by o.order_date;

-- 12. Вывести имена клиентов и даты их заказов, где общая сумма заказа(total) превышает 500. Отсортировать по имени клиента.
select c.first_name, c.last_name, o.order_date
from customers as c
join orders as o
on c.customer_id = o.customer_id
where o.total > 500
order by c.first_name, c.last_name;

-- 13. Получить список товаров(product_name) из категории "Clothing", отсортированных по цене(price) по убыванию. Вывести первые 2 записи.
select p.product_name
from products as p
join categories as cat
on p.category_id = cat.category_id
where cat.category_name = "Clothing"
order by p.price desc
limit 2;

-- 14. Найти все заказы, содержащие товары категории "Furniture". Вывести order_id и order_date.
select o.order_id, o.order_date
from orders as o
join order_items as o_i
on o.order_id = o_i.order_id
join products as p
on o_i.product_id = p.product_id
join categories as cat
on p.category_id = cat.category_id
where cat.category_name = "Furniture";

-- 15. Получить список всех заказов, где были куплены товары из категории "Clothing". Вывести order_id и order_date.
select distinct o.order_id, o.order_date
from orders as o
join order_items as o_i
on o.order_id = o_i.order_id
join products as p
on o_i.product_id = p.product_id
join categories as cat
on p.category_id = cat.category_id
where cat.category_name = "Clothing";

-- OUTER JOIN - LEFT JOIN, RIGHT JOIN

-- Второй распространенный вариант — внешнее соединение. 
-- Если внутреннее объединение имеет сходство с бинарным «и», то внешнее — несколько вариаций бинарного
-- «или». Такой JOIN более гибкий, он возвращает не только строгое пересечение между двумя таблицами, 
-- но и отдельные элементы, которые принадлежат только одному из множеств. Какому — зависит от типа.

-- Left Join. Возвращает пересечение множеств и все элементы из левой таблицы. 
-- Например, человек хочет посмотреть кино, но на русский фильм согласен, только если это боевик. 
-- Фильтр вернет ему все фильмы из множества «боевики», фильмы из подмножества «русские боевики», 
-- но других фильмов из множества «русские» там не будет.

-- Right Join. Работает по тому же принципу, но вместо левой таблицы — правая. 
-- То есть человек получит в результатах боевики, только если они русские.

-- Left Join с NULL. Возвращает данные из левой таблицы, но без пересечений с правой. 
-- Человеку покажутся все боевики, но русского кино и в частности русских боевиков среди них не будет.

-- Right Join с NULL. Соответственно, работает так же, но по отношению к «правой», второй таблице.

use hr;

select * from employees;
select * from departments;

-- select column_name1, column_name2
-- from table1 -- left table
-- left/right join table2 -- right table
-- on table1.column_name1 = table2.column_name2; 

-- Вывести всех сотрудников и название их департаментов.
select emp.first_name, emp.last_name, dep.department_name
from employees as emp
join departments as dep
on emp.department_id = dep.department_id;

-- Вывести всех сотрудников и название их департаментов, если департамент указан, если нет вывести null.
select emp.first_name, emp.last_name, dep.department_name
from employees as emp -- left
left join departments as dep -- right
on emp.department_id = dep.department_id;

select emp.first_name, emp.last_name, dep.department_name
from departments as dep -- left
right join employees as emp -- right
on emp.department_id = dep.department_id;

-- Вывести все департаменты и имена и фамилии сотрудников, которые работают в этих департаментах. Если никто не работает вывести null.
select emp.first_name, emp.last_name, dep.department_name
from employees as emp -- left
right join departments as dep -- right
on emp.department_id = dep.department_id;

-- left join
select emp.first_name, emp.last_name, dep.department_name
from departments as dep -- left
left join employees as emp -- right
on emp.department_id = dep.department_id;

-- Вывести те департаменты, в которых никто не работает.
select emp.first_name, emp.last_name, dep.department_name
from departments as dep -- left
left join employees as emp -- right
on emp.department_id = dep.department_id
where emp.first_name is null;

select emp.first_name, emp.last_name, dep.department_name
from departments as dep -- left
left join employees as emp -- right
on emp.department_id = dep.department_id
where emp.last_name is null;

-- Проверку на is null делаем с полем primary key
select dep.department_name
from departments as dep -- left
left join employees as emp -- right
on emp.department_id = dep.department_id
where emp.employee_id is null;

select * from locations;

-- Вывести все департаменты и города, в которых они находятся.
select dep.department_name, loc.city
from departments as dep
join locations as loc
on dep.location_id = loc.location_id;

-- Вывести все города и название департаментов, если в городе нет департамента вывести null.
select loc.city, dep.department_name
from locations as loc -- left
left join departments as dep -- right
on loc.location_id = dep.location_id;

-- Вывести те города, в которых нет департаментов.
select loc.city
from locations as loc -- left
left join departments as dep -- right
on loc.location_id = dep.location_id
where dep.department_id is null;

-- Вывести название(department_name) и адрес(street_address) тех департаментов, в которых никто не работает.
select dep.department_name, loc.street_address
from departments as dep
left join employees as emp
on dep.department_id = emp.department_id
join locations as loc
on dep.location_id = loc.location_id
where emp.employee_id is null;

-- select ...
-- from departments
-- join locations
-- on ...
-- left join employees
-- on ...

-- select ...
-- from emplyees
-- right join departments
-- on ...
-- join locations
-- on ...

-- Из города Seattle вывести те департаменты, в которых никто не работает.
select dep.department_name
from departments as dep
join locations as loc
on dep.location_id = loc.location_id
left join employees as emp
on emp.department_id = dep.department_id
where emp.employee_id is null and loc.city = 'Seattle';


select * from countries;

-- Страны, где в каких-то городах нет департментов
select distinct country_name
from countries as cnt
left join locations as loc
on cnt.country_id = loc.country_id
left join departments as dep
on dep.location_id = loc.location_id
where dep.department_id is null;

-- Вывести те страны, в которых нет департаментов.
select distinct country_name
from countries as cnt
join locations as loc
on cnt.country_id = loc.country_id
left join departments as dep
on dep.location_id = loc.location_id
where dep.department_id is null;

select distinct country_name
from countries as cnt
join locations as loc
on cnt.country_id = loc.country_id
join departments as dep
on dep.location_id = loc.location_id;


-- ПОДЗАПРОСЫ - SUBSELECT
-- 1 Вариант
-- ПОДЗАПРОС - таблица

-- 2 вариант
-- ПОДЗАПРОС - значение (одно поле)

-- Вариант 1
-- select ....
-- from (subselect) as t1
-- join ...
-- where ...;

-- select ...
-- from table1
-- join (subselect) as t1
-- on ...

-- Таблица с одним столбцом
-- select ...
-- from table1
-- join table2
-- on ...
-- where column_name1 in (subselect)
-- where column_name1 not in (subselect)


-- Первая таблица 
select * from countries;

-- Вторая таблица - t2
select distinct country_name
from countries as cnt
join locations as loc
on cnt.country_id = loc.country_id
join departments as dep
on dep.location_id = loc.location_id;

select country_name
from countries as cnt -- все страны 
left join (select distinct cnt.country_id
		from countries as cnt
		join locations as loc
		on cnt.country_id = loc.country_id
		join departments as dep
		on dep.location_id = loc.location_id) as t1 -- подзапрос, где страны в которых есть департаменты
on cnt.country_id = t1.country_id -- получаем все из countries, даже если нет общего с подзапросом
where t1.country_id is null; -- оставили те страны, которых нет в подзапросе (t1) 


-- Подзапрос, который имеет один столбец
select country_name
from countries -- все страны 
where country_name not in (select distinct country_name
							from countries as cnt
							join locations as loc
							on cnt.country_id = loc.country_id
							join departments as dep
							on dep.location_id = loc.location_id); -- где название страны не совп. со значением из списка подзапроса
