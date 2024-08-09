--create table input (
--id int,
--formula varchar(10),
--value int
--)

--insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);


with cte as(
select id, formula, value,
left (formula, 1) left_ , right (formula,1) right_, substring(formula, 2, 1) op
from input)
select c.id, c. formula, c.value,left_ , right_,
case when op='+' 
then i1.value+i2.value 
else i1.value-i2.value end as new_val
from cte c join input i1
on i1.id=c.left_
join input i2
on i2.id=c.right_