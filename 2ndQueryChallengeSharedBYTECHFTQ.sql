--drop table if exists mountain_huts;
--create table mountain_huts 
--(
--	id 			integer not null unique,
--	name 		varchar(40) not null unique,
--	altitude 	integer not null
--);
--insert into mountain_huts values (1, 'Dakonat', 1900);
--insert into mountain_huts values (2, 'Natisa', 2100);
--insert into mountain_huts values (3, 'Gajantut', 1600);
--insert into mountain_huts values (4, 'Rifat', 782);
--insert into mountain_huts values (5, 'Tupur', 1370);

--drop table if exists trails;
--create table trails 
--(
--	hut1 		integer not null,
--	hut2 		integer not null
--);
--insert into trails values (1, 3);
--insert into trails values (3, 2);
--insert into trails values (3, 5);
--insert into trails values (4, 5);
--insert into trails values (1, 5);

--select * from mountain_huts ;

with cte1 as (
select
case when m.altitude > m1.altitude then t.hut1 else t.hut2  end as hut1 , case when m.altitude > m1.altitude then t.hut2 else t.hut1 end as hut2
from trails t
left join mountain_huts m
on t.hut1 = m.id
left join mountain_huts m1
on t.hut2 = m1.id)

select m1.name,m2.name,m3.name from cte1 c1
inner join cte1 c2
on c1.hut2 = c2.hut1
left join mountain_huts m1
on m1.id = c1.hut1 
left join mountain_huts m2
on m2.id = c2.hut1
left join mountain_huts m3
on m3.id = c2.hut2
order by c1.hut1



