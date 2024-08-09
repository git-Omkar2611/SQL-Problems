drop TABLE if exists orders;
CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders VALUES
(1, '2024-02-18', 101),
(1, '2024-02-18', 102),
(1, '2024-02-18', 103),
(1, '2024-02-19', 101),
(1, '2024-02-19', 103),
(2, '2024-02-18', 104),
(2, '2024-02-18', 105),
(2, '2024-02-19', 101),
(2, '2024-02-19', 106); 

with cte as (
select * , row_number() over(partition by customer_id , dates order by product_id) as rn from orders 
) ,
recursive_cte as (
select customer_id , dates , CAST(product_id as varchar(max)) as product_id , rn from cte where rn = 1
union all
select o.customer_id , o.dates , CONCAT_WS(',',r.product_id , o.product_id) as product_id , o.rn from cte o
inner join recursive_cte r
on o.rn = r.rn + 1 and o.dates = r.dates and o.customer_id = r.customer_id
)

select dates , product_id from recursive_cte
union 
select dates, cast(product_id as varchar(max)) from cte where rn!=1





