
--CREATE TABLE subscriber (
-- sms_date date ,
-- sender varchar(20) ,
-- receiver varchar(20) ,
-- sms_no int
--);
---- insert some values
--INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
--INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);

with cte1 as (
select * , lead(receiver,1,sender) over(order by (select 1) ) as receiver1 ,
lead(sender,1,receiver) over(order by (select 1) ) as sender1,
lead(sms_no,1,0) over(order by (select 1) ) as sms_no1
from subscriber
)

select * 
from cte1 where sender1 = receiver and sender = receiver1



select * from subscriber
;with cte as (
 select * , case when sender < receiver then sender else receiver end as p1,
 case when receiver < sender then sender else receiver end as p2
 from subscriber
)


select sms_date , p1, p2 , sum(sms_no) as total_amount from cte group by sms_date , p1, p2