
--select 
--price_date,
-- DATEFROMPARTS( year(price_date) , month(price_date) , 1) as start_of_month ,
-- DATEADD(day , 1, EOMONTH(DATEFROMPARTS( year(price_date) , month(price_date) , 1))) as end_of_month,
-- price,
-- lag(price,1,price) over(order by price_date) as newPrice
-- from sku
-- where DATEPART(day , price_date) = 1

-- select 
--price_date,
-- DATEFROMPARTS( year(price_date) , month(price_date) , 1) as start_of_month ,
-- DATEADD(day , 1, EOMONTH(DATEFROMPARTS( year(price_date) , month(price_date) , 1))) as end_of_month,
-- price,
-- lag(price,1,price) over(order by price_date) as newPrice
-- from sku
---- where DATEPART(day , price_date) > 1


;with cte as (
 select * , DENSE_RANK() over(partition by MONTH(price_date) order by price_date desc) as rN from sku
 )

select 
 DATEFROMPARTS( year(price_date) , month(price_date) , 1) as start_of_month , price , sku_id
 from cte
 where rn = 1 and DATEPART(day,price_date) = 1
UNION ALL
select  DATEADD(day , 1, EOMONTH(DATEFROMPARTS( year(price_date) , month(price_date) , 1))) as end_of_month,
 price , sku_id from cte 
 where rn = 1 and DATEADD(day , 1, EOMONTH(DATEFROMPARTS( year(price_date) , month(price_date) , 1))) not in (DATEFROMPARTS( year(price_date) , month(price_date) , 1))

