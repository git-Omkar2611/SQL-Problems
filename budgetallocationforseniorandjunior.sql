--select * from candidates

with cte1 as (
select * , sum(salary) over(partition by positions order by salary) as running_val from candidates
)  , cte3 as (

select * , sum(salary) over(order by positions desc,salary ) as running_total from cte1
 where running_val <= 50000

)


select SUM(case when positions ='junior' then 1 else 0 END) as juniors , SUM(case when positions ='senior' then 1 else 0 END) as seniors from cte3 where running_total < = 50000