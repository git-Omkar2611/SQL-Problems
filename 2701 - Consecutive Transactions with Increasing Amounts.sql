with cte as (
select customer_id ,transaction_date , day(transaction_date) - row_number() over(partition by customer_id order by transaction_id) as cnt from transactions
)
, cte2 as (
select customer_id , cnt ,  min(transaction_date) as [consecutive_start ] , max(transaction_date) as [consecutive_end ] from cte
group by customer_id , cnt
having count(cnt) > 2
)

select customer_id ,[consecutive_start ],[consecutive_end ]  from cte2