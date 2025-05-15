-- INNER JOIN
-- OUTER JOIN - LEFT JOIN, RIGHT JOIN 

-- База данных university -  https://github.com/annykh/GT210125-m-be/blob/main/university.sql
-- Тех. описание базы данных - https://github.com/annykh/GT210125-m-be/blob/main/%D0%A2%D0%B5%D1%85_%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5_university.txt


select * from students;
select * from courses;
select * from teachers;
select * from competencies;
select * from students2courses;
select * from teachers2competencies;

-- Задания:
-- 1. Вывести имена студентов (name) и идентификаторы курсов (course_id), которые они посещают.
select t1.name, t2.course_id
from students as t1
join students2courses as t2
on t1.id = t2.student_id;

-- 2. Вывести имена студентов и идентификаторы курсов:
--     Если студент проходит курс, указать соответствующий course_id.
--     Если студент не проходит ни одного курса, вывести NULL в качестве значения course_id.
select t1.name, t2.course_id
from students as t1
left join students2courses as t2
on t1.id = t2.student_id;

-- 3. Вывести имена студентов, которые не записаны ни на один курс.
select t1.name
from students as t1
left join students2courses as t2
on t1.id = t2.student_id
where t2.course_id is null;

-- 4. Найти курсы, которые не посещает ни один студент.
select t1.title
from courses as t1
left join students2courses as t2
on t1.id = t2.course_id
where t2.id is null;

-- 5. Найти компетенции, которые не принадлежат ни одному преподавателю.
select t1.title
from competencies as t1
left join teachers2competencies as t2
on t1.id = t2.competencies_id
where t2.competencies_id is null;

select t2.title
from teachers2competencies as t1
right join competencies as t2
on t1.competencies_id = t2.id
where t1.competencies_id is null;

-- 6. Вывести название курса и имя преподавателя, который является заведующим кафедрой для данного курса.
select t1.title, t2.name
from courses as t1
join teachers as t2
on t1.headman_id = t2.id;

-- 7. Вывести имя студента и имена преподавателей, которые являются заведующими кафедрой для курсов, на которые записан студент.
-- Анатолий - Максим
-- Олег - Максим
select t1.name, t4.name
from students as t1
join students2courses as t2
on t1.id = t2.student_id
join courses as t3
on t2.course_id = t3.id
join teachers as t4
on t3.headman_id = t4.id;

-- 8. Вывести названия курсов, имена преподавателей, которые ведут курсы, имена преподавателей, которые являются зав. кафедрой этих курсов.
select crs.title, tch.name as teacher_name, hdman.name as headman_name
from courses as crs
join teachers as tch
on crs.teacher_id = tch.id
join teachers as hdman
on crs.headman_id = hdman.id;


-- https://github.com/annykh/GT210125-m-be/blob/main/shop.sql
-- https://github.com/annykh/GT210125-m-be/blob/main/%D0%A2%D0%B5%D1%85_%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5_shop.txt

select * from customers;
select * from sellers;
select * from orders;

-- SELF JOIN 

-- 1. Вывести имена продавцов и их начальников.
-- Олег - Лев
-- Лев - Екатерина
-- Арсений - Екатерина
-- Екатерина - Леонид
-- Леонид - NULL

select sell.sname as seller_name, boss.sname as boss_name
from sellers as sell
join sellers as boss
on sell.BOSS_ID = boss.SELL_ID;

-- 2. Вывести продавцов, у которых нет начальников. 
select sname
from sellers
where BOSS_ID is null;

-- 3. Вывести всех продавцов и имена начальников, если они есть, если нет - null.
select sell.sname as seller_name, boss.sname as boss_name
from sellers as sell
left join sellers as boss
on sell.BOSS_ID = boss.SELL_ID;

-- 4. Вывести продавцов, у которых нет начальников или указан не правильный id начальника.
select sell.sname as seller_name, boss.sname as boss_name
from sellers as sell
left join sellers as boss
on sell.BOSS_ID = boss.SELL_ID
where boss.SNAME is null;

-- 5. Вывести имена покупателей и даты и суммы их заказов.
select t1.cname, t2.odate, t2.amt
from customers as t1
join orders as t2
on t1.CUST_ID = t2.CUST_ID;

-- 6. Вывести пары покупателей и обслуживших их продавцов из одного города.  
select cname, sname
from customers as t1
join orders as t2
on t1.CUST_ID = t2.CUST_ID
join sellers as t3
on t2.SELL_ID = t3.SELL_ID
where t1.CITY = t3.CITY;

-- Д/З

-- https://github.com/annykh/GT210125-m-be/blob/main/shop.sql
-- https://github.com/annykh/GT210125-m-be/blob/main/%D0%A2%D0%B5%D1%85_%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5_shop.txt

-- 1. Вывести всех продавцов, чьи имена начинаются на букву 'Л'.  
-- 2. Вывести всех клиентов из города Тула с рейтингом больше 100.  
-- 3. Вывести всех продавцов, чьи комиссии между 0.10 и 0.15 (включительно).  
-- 4. Вывести имена продавцов, у которых нет заказов.  
-- 5. Вывести имена всех продавцов, которые продают товары клиентам из Тулы.  
-- 6. Вывести имена клиентов, у которых нет заказов.  
-- 7. Вывести пары продавцов, работающих в одном городе.
-- 8. Вывести имена начальников и их подчиненных, если у начальника комиссия выше, чем у подчиненного.
