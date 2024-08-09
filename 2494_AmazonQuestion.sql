--create table hall_events
--(
--hall_id integer,
--start_date date,
--end_date date
--);
--delete from hall_events
--insert into hall_events values 
--(1,'2023-01-13','2023-01-14')
--,(1,'2023-01-14','2023-01-17')
--,(1,'2023-01-15','2023-01-17')
--,(1,'2023-01-18','2023-01-25')
--,(2,'2022-12-09','2022-12-23')
--,(2,'2022-12-13','2022-12-17')
--,(3,'2022-12-01','2023-01-30');

with cte as (
select hall_id , start_date , end_date , ROW_NUMBER() over(order by hall_id,start_date) as event_id from hall_events
)
, recursive_cte as (
select hall_id , start_date , end_date , event_id , 1 as flag  from cte where event_id = 1
union all
select cte.hall_id ,   cte.start_date ,
cte.end_date , cte.event_id ,
case when cte.hall_id = recursive_cte.hall_id AND (
cte.start_date BETWEEN recursive_cte.start_date and recursive_cte.end_date
or 
recursive_cte.start_date BETWEEN cte.start_date and cte.end_date
)
then 0 else 1 end + flag as flag
from recursive_cte
inner join cte on cte.event_id = recursive_cte.event_id +1
)

select hall_id , MIN(Start_date) as start_date , MAX(end_Date) as end_date from recursive_cte
group by hall_id , flag
