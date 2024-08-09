---- Create the 'salary' table
--CREATE TABLE salary (
--    id INT PRIMARY KEY,
--    employee_id INT,
--    amount INT,
--    pay_date DATE
--);

---- Insert data into the 'salary' table
--INSERT INTO salary (id, employee_id, amount, pay_date) VALUES
--(1, 1, 9000, '2017-03-31'),
--(2, 2, 6000, '2017-03-31'),
--(3, 3, 10000, '2017-03-31'),
--(4, 1, 7000, '2017-02-28'),
--(5, 2, 6000, '2017-02-28'),
--(6, 3, 8000, '2017-02-28');

-- Create the 'employee_department' table
--CREATE TABLE employee_department (
--    employee_id INT PRIMARY KEY,
--    department_id INT
--);

---- Insert data into the 'employee_department' table
--INSERT INTO employee_department (employee_id, department_id) VALUES
--(1, 1),
--(2, 2),
--(3, 2);

with cte as (
select FORMAT(pay_date,'yyyy-MM') as pay_date , ROUND(AVG(amount*1.00),2) as average_amount from salary s
inner join employee_department e
on s.employee_id = e.employee_id
group by FORMAT(pay_date,'yyyy-MM')
), cte2 as (

select FORMAT(pay_date,'yyyy-MM') as pay_date,e.department_id, AVG(amount) as average_amount_department from salary s
inner join employee_department e
on s.employee_id = e.employee_id
group by FORMAT(pay_date,'yyyy-MM'),e.department_id
)

select cte.pay_date,cte2.department_id , (CASE WHEN average_amount < average_amount_department then 'higher' 
when average_amount = average_amount_department then 'same'
else 'lower' end) as [comparison] from cte
inner join cte2
on cte.pay_date = cte2.pay_date



