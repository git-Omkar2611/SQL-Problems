with cte as (
select 
MONTH(order_time) as order_month ,
	FORMAT(order_time , 'MMM-yy') as 'period',
	CONCAT ( 
		CAST(
			ROUND(
				SUM(CASE WHEN	DATEDIFF(MINUTE,order_time,actual_delivery) > 30 then 1 ELSE 0 END) * 100.00 / count(1) 
			, 1)
		as decimal(8,2) )			
	, '%')
	as delayed_delivery_perc ,
	SUM(CASE WHEN	DATEDIFF(MINUTE,order_time,actual_delivery) > 30 then no_of_pizzas ELSE 0 END) as Free_Pizzas
	from pizza_delivery
	where actual_delivery is not null
	group by FORMAT(order_time , 'MMM-yy') ,MONTH(order_time)
)

select period , delayed_delivery_perc , Free_Pizzas from cte order by order_month



