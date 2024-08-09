--Problem Statement: Find the new and repeated customer from the input table as shown in the figure below.

--create table customer_orders (
--order_id integer,
--customer_id integer,
--order_date date,
--order_amount integer
--);

--insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),
--(3,300,cast('2022-01-01' as date),2100),(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),
--(6,500,cast('2022-01-02' as date),2700),(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),
--(9,600,cast('2022-01-03' as date),3000);

with cte1 as (
select * , DENSE_RANK() over(partition by customer_id order by order_date) as customers_visit from customer_orders
)

select order_date , SUM(CASE WHEN customers_visit = 1 then 1 ELSE 0 END) as first_visit_customer,
SUM(CASE when customers_visit > 1 then 1 ELSE 0 END) as repeated_visit_customer
from cte1
group by order_date