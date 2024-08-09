--select * from Signups

--select * from Confirmations

with cte as (
select s.user_id , COUNT(case when action = 'confirmed' then 1 END) as confirmed_count , COUNT(case when action = 'timeout'  then 1 END) as time_count , 
COUNT(case when action = 'confirmed' then 1 END)  + COUNT(case when action = 'timeout'  then 1 END) as total_count
from Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
group by s.user_id
)


select user_id , CAST(case when confirmed_count = 0*1.00 then 0 ELSE confirmed_count*1.00 /total_count END as DECIMAL(5,2) ) as confirmation_rate  from cte





