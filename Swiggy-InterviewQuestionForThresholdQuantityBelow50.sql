--CREATE TABLE supplier_inventory (
-- Supplier_id VARCHAR(255),
-- Product_id VARCHAR(255),
-- Stock_quantity INT,
-- Record_date DATE
--);

--INSERT INTO supplier_inventory (Supplier_id, Product_id, Stock_quantity, Record_date)
--VALUES
-- ('S1', 'P1', 60, '2023-01-01'),
-- ('S1', 'P1', 40, '2023-01-02'),
-- ('S1', 'P1', 100, '2023-01-04'),
-- ('S1', 'P1', 20, '2023-01-05'),
-- ('S1', 'P1', 10, '2023-01-11'),
-- ('S1', 'P2', 5, '2023-01-06'),
-- ('S1', 'P2', 90, '2023-01-07'),
-- ('S1', 'P2', 1, '2023-01-08'),
-- ('S1', 'P3', 90, '2023-01-09'),
-- ('S1', 'P3', 50, '2023-01-10'),
-- ('S1', 'P3', 30, '2023-01-12');
with cte_datePart as (
select * , datepart(day,record_date) as dateOfrecord
from supplier_inventory)
, cte2 as (
select * , row_number () over (order by dateOfRecord) as rowNum from cte_datePart
),cte3 as (
	select * , dateOfRecord - rowNum as grpBy from cte2
) , cte4 as (
select * , stock_quantity + lead(stock_quantity,1,stock_quantity) over(order by grpBy) as final_qty from cte3 
)


select supplier_id , product_id , record_date from cte4 where final_qty < 50




with cte as (
 select *,
 dateadd(day, - row_number() over(order by Record_date),record_date) as grp
 from supplier_inventory
 where Stock_quantity < 50
), cte2 as (
select * , row_number() over (partition by grp order by grp desc) as num from cte
)

select * from cte2