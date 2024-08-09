--drop table if exists auto_repair;
--create table auto_repair
--(
--	client			varchar(20),
--	auto			varchar(20),
--	repair_date		int,
--	indicator		varchar(20),
--	value			varchar(20)
--);
--insert into auto_repair values('c1','a1',2022,'level','good');
--insert into auto_repair values('c1','a1',2022,'velocity','90');
--insert into auto_repair values('c1','a1',2023,'level','regular');
--insert into auto_repair values('c1','a1',2023,'velocity','80');
--insert into auto_repair values('c1','a1',2024,'level','wrong');
--insert into auto_repair values('c1','a1',2024,'velocity','70');
--insert into auto_repair values('c2','a1',2022,'level','good');
--insert into auto_repair values('c2','a1',2022,'velocity','90');
--insert into auto_repair values('c2','a1',2023,'level','wrong');
--insert into auto_repair values('c2','a1',2023,'velocity','50');
--insert into auto_repair values('c2','a2',2024,'level','good');
--insert into auto_repair values('c2','a2',2024,'velocity','80');
with cte as (
select client ,repair_date , MAX(CASE WHEN indicator = 'level' then value END) as level ,
MAX(case when indicator = 'velocity' then value end) as velocity
from auto_repair
group by client ,repair_date
)

select velocity , 
		COUNT(CASE WHEN level = 'good' then 1 END) as 'Good' ,
		COUNT(CASE WHEN level = 'wrong' then 1  END) as 'Wrong',
		COUNT(CASE WHEN level = 'regular' then 1 END) as 'Regular'
from cte
group by velocity