/*
PROBLEM STATEMENT:
Given table contains tokens taken by different customers in a tax office.
Write a SQL query to return the lowest token number which is unique to a customer (meaning token should be allocated to just a single customer).
*/

--drop table if exists tokens;
--create table tokens
--(
--	token_num	int,
--	customer	varchar(20)
--);
--insert into tokens values(1, 'Maryam');
--insert into tokens values(2, 'Rocky');
--insert into tokens values(3, 'John');
--insert into tokens values(3, 'John');
--insert into tokens values(2, 'Arya');
--insert into tokens values(1, 'Pascal');
--insert into tokens values(9, 'Kate');
--insert into tokens values(9, 'Ibrahim');
--insert into tokens values(8, 'Lilly');
--insert into tokens values(8, 'Lilly');
--insert into tokens values(5, 'Shane');

with cte as (
select * , dense_rank() over(order by token_num,customer) as drn from tokens
)

select top 1 token_num , customer from cte
group by token_num , customer
HAVING COUNT(drn) > 1
order by token_num