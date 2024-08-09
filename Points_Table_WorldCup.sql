with cte as (
select team_1 from icc_world_cups
union all
select team_2 from icc_world_cups
) , cte2_aggregate as (
select team_1 as Team , count(team_1) as [Played] from cte
group by team_1
) , cte3_won as (
select a.team as Teams , Played as P , count(case when a.team = b.winner then 1 end) as W ,
Played - count(case when a.team = b.winner then 1 end) - count(case when b.winner ='DRAW' then 1 END) as L,
 count(case when b.winner ='DRAW' then 1 END) as D , count(case when a.team = b.winner then 1 end)*2 + count(case when b.winner ='DRAW' then 1 END) as Pts
from cte2_aggregate  a
left join icc_world_cups b
on a.team = b.team_1 or a.team = b.team_2
group by a.team , Played
--group by a.team_1 , Played
) 

select * from cte3_won