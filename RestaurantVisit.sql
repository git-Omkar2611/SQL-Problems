--Create table  Customer (customer_id int, name varchar(20), visited_on date, amount int)
--Truncate table Customer
--insert into Customer (customer_id, name, visited_on, amount) values (1, 'Jhon', '2019-01-01', 100)
--insert into Customer (customer_id, name, visited_on, amount) values (2, 'Daniel', '2019-01-02',110)
--insert into Customer (customer_id, name, visited_on, amount) values (3, 'Jade', '2019-01-03', 120)
--insert into Customer (customer_id, name, visited_on, amount) values (4, 'Khaled', '2019-01-04', 130)
--insert into Customer (customer_id, name, visited_on, amount) values (5, 'Winston', '2019-01-05', 110)
--insert into Customer (customer_id, name, visited_on, amount) values (6, 'Elvis', '2019-01-06', 140)
--insert into Customer (customer_id, name, visited_on, amount) values (7, 'Anna', '2019-01-07', 150)
--insert into Customer (customer_id, name, visited_on, amount) values (8, 'Maria', '2019-01-08', 80)
--insert into Customer (customer_id, name, visited_on, amount) values (9, 'Jaze', '2019-01-09', 110)
--insert into Customer (customer_id, name, visited_on, amount) values (1, 'Jhon', '2019-01-10', 130)
--insert into Customer (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-10', 150)


with cte as (
  select visited_on, sum(amount) as amount
  from Customer
  group by visited_on
)
, cte2 as (
select visited_on , sum(amount) over(order by visited_on rows between 6 preceding and current row) as amount  ,
CAST(ROUND(1.00*SUM(amount) over(order by visited_on rows between 6 preceding and current row) , 2)/7 as decimal(5,2)) as average_amount
from cte
)

select visited_on,amount,average_amount from cte2 where visited_on >= (select top 1 DATEADD(day,6,visited_On) from cte2 order by visited_on  )








