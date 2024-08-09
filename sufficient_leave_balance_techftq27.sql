--/*
--PROBLEM STATEMENT: 
--Given vacation_plans tables shows the vacations applied by each employee during the year 2024. 
--Leave_balance table has the available leaves for each employee.
--Write an SQL query to determine if the vacations applied by each employee can be approved or not based on the available leave balance. 
--If an employee has enough available leaves then mention the status as "Approved" else mention "Insufficient Leave Balance".
--Assume there are no public holidays during 2024. weekends (sat & sun) should be excluded while calculating vacation days. 
--*/

--drop table if exists vacation_plans;
--create table vacation_plans
--(
--	id 			int primary key,
--	emp_id		int,
--	from_dt		date,
--	to_dt		date
--);
--insert into vacation_plans values(1,1, '2024-02-12', '2024-02-16');
--insert into vacation_plans values(2,2, '2024-02-20', '2024-02-29');
--insert into vacation_plans values(3,3, '2024-03-01', '2024-03-31');
--insert into vacation_plans values(4,1, '2024-04-11', '2024-04-23');
--insert into vacation_plans values(5,4, '2024-06-01', '2024-06-30');
--insert into vacation_plans values(6,3, '2024-07-05', '2024-07-15');
--insert into vacation_plans values(7,3, '2024-08-28', '2024-09-15');


--drop table if exists leave_balance;
--create table leave_balance
--(
--	emp_id			int,
--	balance			int
--);
--insert into leave_balance values (1, 12);
--insert into leave_balance values (2, 10);
--insert into leave_balance values (3, 26);
--insert into leave_balance values (4, 20);
--insert into leave_balance values (5, 14);

--select * from vacation_plans;
--select * from leave_balance;


with cte as (
select  id , 
		v.emp_id,
		from_dt ,
		to_dt ,
		datediff(day,from_dt,to_dt)+1 - datediff(week,from_dt,to_dt)*2 as vacation_days ,
		dense_rank() over(partition by v.emp_id order by id) as rn,
		l.balance as balance
from vacation_plans v
inner join leave_balance l
on v.emp_id = l.emp_id
)
, recursive_Cte as (
select id ,
		emp_id ,
		from_dt , 
		to_dt , 
		vacation_days , 
		balance , 
		balance - vacation_days as calculated_balance , 
		rn from cte where rn = 1
	
	union all

select c.id ,
		c.emp_id ,
		c.from_dt ,
		c.to_dt , 
		c.vacation_days , 
		r.calculated_balance as balance , 
		r.calculated_balance - c.vacation_days as calculated_balance , 
		c.rn  from cte c
	inner join recursive_Cte  r
		on c.rn = r.rn+1 and c.emp_id = r.emp_id 

)

select id , 
		emp_id , 
		from_dt , 
		to_dt , 
		vacation_days  , 
		case when calculated_balance > -1 then 'Approved' ELSE 'Insufficient Leave Balance' END as [Status] from recursive_Cte 
order by case when calculated_balance > -1 then 'Approved' ELSE 'Insufficient Leave Balance' END asc



