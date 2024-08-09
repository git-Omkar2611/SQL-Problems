---- Create table
--CREATE TABLE employee_579 (
--    Id INT,
--    Month INT,
--    Salary INT
--);

---- Insert data
--INSERT INTO employee_579 (Id, Month, Salary) VALUES
--(1, 1, 20),
--(2, 1, 20),
--(1, 2, 30),
--(2, 2, 30),
--(3, 2, 40),
--(1, 3, 40),
--(3, 3, 60),
--(1, 4, 60),
--(3, 4, 70);

with cte  as (
select * , row_number()over(partition by id order by month) as all_months from employee_579
) , cte2 as (
select id , max(all_months) as recent_month from cte
group by id
)

select c1.id , c1.month , sum(salary) over(partition by c1.id order by month) as Salary from cte c1 
left join cte2 c2
on c1.id = c2.id
where c1.all_months != c2.recent_month
order by c1.id asc , month desc

