with running_cte as (
select * , sum(salary) over(partition by positions order by id,salary) as running_val
from candidates
),senior_salary_cte as (
select positions,salary from running_cte where running_val <=50000 and positions='senior' 
), junior_salary_cte as (
select positions,salary from running_cte where positions = 'junior' and running_val <= 50000 - (select COALESCE(sum(salary),0) from senior_salary_cte)
) , final_cte as (
select * from senior_salary_cte
UNION
select * from junior_salary_cte
)

select case when positions = 'junior' then count(positions) ELSe 0 END as juniors ,
case when positions = 'senior' then count(positions) ELSe 0 END as seniors
from final_cte
group by positions


