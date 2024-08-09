--Highest and Lowest Salary Employees in Each department.


select e.dep_id ,
(
select emp_name from emps where dep_id = e.dep_id and salary = (select MAX(salary) from emps where dep_id = e.dep_id)
) as emp_name_max_salary ,
(
select emp_name from emps where dep_id = e.dep_id and salary = (select min(salary) from emps where dep_id = e.dep_id)
) as emp_name_min_salary 
from (select distinct dep_id from emps) e


with cte1 as (
select dep_id , max(salary) as maxSalary , min(salary) as minSalary
from emps
group by dep_id) ,
cte2 as (
select a.dep_id as dep , a.maxSalary , a.minSalary , b.dep_id , b.salary , b.emp_name from cte1 a 
inner join emps b
on a.dep_id = b.dep_id
)

select dep_id , 
MAX(case when salary = maxSalary then emp_name end) ,
MAX(case when salary = minSalary then emp_name end) 
from cte2
group by dep_id