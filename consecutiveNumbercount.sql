with cte1 as (select *,lead(num,1) over(order by id) as next_one , lead(num,2) over(order by id) as next2next from Logs
)

select distinct num as ConsecutiveNums  from cte1 where num = next_one and next_one = next2next 

