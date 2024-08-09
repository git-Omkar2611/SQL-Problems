--Let's see who can solve this problem in the simplest way

--Here is the script :

--create table clocked_hours(
--empd_id int,
--swipe time,
--flag char
--);

--insert into clocked_hours values
--(11114,'08:30','I'),
--(11114,'10:30','O'),
--(11114,'11:30','I'),
--(11114,'15:30','O'),
--(11115,'09:30','I'),
--(11115,'17:30','O');


with cte1 as (
	select * , lead(flag,1) over(partition by empd_id order by empd_id) as next_outcome , lead(swipe) over(partition by empd_id order by empd_id) as next_hours  from clocked_hours 
)


select empd_id ,  SUM( CASE 
WHEN flag = 'I' and next_outcome='O' THEN DATEDIFF(hour,swipe , next_hours) ELSE 0 END) as clocked_hours from cte1 
group by empd_id

