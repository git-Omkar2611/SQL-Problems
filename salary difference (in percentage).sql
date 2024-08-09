--select * from Employeess

--select * from Departments
--Write a query to find the salary difference (in percentage) with respect to the highest salaried employee within each department.
with cte1 as (
	select ds.dep_id , MAX(Salary) as highest_sal from Departments ds
inner join Employeess es
on ds.dep_id = es.dep_id
group by ds.dep_id
) , cte2 as (
select es.* , c1.highest_sal from Employeess es
inner join cte1 c1
on es.dep_id = c1.dep_id
), cte3 as (
select * from cte2 where salary <> highest_sal
)

select emp_id , emp_name , dep_id , salary , highest_sal , CAST ( CAST( ROUND(((highest_sal-salary) / salary)*100,2) as decimal(5,2)) as varchar(10)) + '%' as percentage_change from cte3
order by dep_id



