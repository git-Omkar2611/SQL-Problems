--create table hierarchy_employees(emp_id int , reporting_id int )

--insert into hierarchy_employees
--select 1,NULL
--union
--select 2,1 
--union
--select 3,1 
--union
--select 4,2 
--union
--select 5,2 
--union
--select 6,3 
--union
--select 7,3 
--union
--select 8,4 
--union
--select 9,4 
 

with root_level as (
select emp_id as emp_id , emp_id as emp_hierarchy  from hierarchy_employees 
UNION all
select ro.emp_id , he.emp_id   from root_level ro
inner join hierarchy_employees he
on he.reporting_id = ro.emp_hierarchy 
)
select * from root_level order by emp_id