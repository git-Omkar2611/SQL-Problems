----Q. Write a SQL query to find the list of customers who have purchased for 3 or more consecutive days.

--CREATE TABLE purchasess (
-- purchase_id INT,
-- customer_id INT,
-- purchase_date DATE
--);

--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (1, 101, '2024-01-01');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (2, 102, '2024-01-02');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (3, 101, '2024-01-02');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (4, 103, '2024-01-03');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (5, 101, '2024-01-03');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (6, 104, '2024-01-04');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (7, 102, '2024-01-04');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (8, 103, '2024-01-05');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (9, 102, '2024-01-05');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (10, 103, '2024-01-06');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (11, 102, '2024-01-06');
--INSERT INTO purchasess (purchase_id, customer_id, purchase_date) VALUES (12, 107, '2024-01-07');

with cte1 as (
select * , DATEPART(DAY , purchase_date) as [date] , row_number() over(partition by customer_id order by purchase_date) as rowNum from purchasess 
) , cte2 as (
select * , date - rowNum as diff from cte1
) , cte3 as (
select customer_id , diff , count(diff) as cnt
from cte2
group by customer_id, diff
having count(diff) > 2
)

select customer_id  from cte3
