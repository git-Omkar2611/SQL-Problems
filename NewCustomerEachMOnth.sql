with monthMentioned as (
select * , DATEPART(month,order_date) as months from sales_details) ,
cte2 as (
select *, dense_rank() over(partition by customer order by months) as ranks from monthMentioned
), cte3 as (
select FORMAT(order_date , 'MMM-yyy') as formattedMonth,* from cte2
)

select formattedMonth , months , count(ranks) from cte3
where ranks = 1
GROUP by formattedMonth , months
order by months



