


WITH cte1 as (
	
	select productid , sum(amount) as 'total_amt'   from sales_data
	group by productid
) , cte2 as (
	select AVG(total_amt) as average from cte1
) , cte3 as (
select * from cte1,cte2 where total_amt > average
)

select sd.productid,sd.saledate,sd.productid,sd.amount , sum(amount) over(order by sd.saledate)  from sales_data  sd
inner join cte3 ct
on sd.productid = ct.productid


