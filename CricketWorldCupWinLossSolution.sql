--Derive an output from the input table
----create table icc_world_cup
----(
----Team_1 Varchar(20),
----Team_2 Varchar(20),
----Winner Varchar(20)
----);

--INSERT INTO icc_world_cup values('India','SL','India');
--INSERT INTO icc_world_cup values('SL','Aus','Aus');
--INSERT INTO icc_world_cup values('SA','Eng','Eng');
--INSERT INTO icc_world_cup values('Eng','NZ','NZ');
--INSERT INTO icc_world_cup values('Aus','India','India');
with cte1_team1 as 
(
select team_1 from icc_world_cup
) , cte2_team2 as (select distinct team_2 from icc_world_cup)
,cte3_merged as (select team_1 from cte1_team1 union all select team_2 from cte2_team2)
, cte4_matches_played as (
select team_1 , count(team_1) as matches_played from cte3_merged
group by team_1)


select a.team_1 , matches_played , SUM(case when i.winner = a.team_1 then 1 ELSE 0 END) as no_of_wins ,
SUM(case when i.winner != a.team_1 THEN 1 ELSE 0 END) as no_of_losses
from cte4_matches_played a
left join icc_world_cup i
on (a.team_1 = i.team_1) or (a.team_1 = i.team_2)
group by a.team_1,matches_played




--select a.team_1 , matches_played ,
--SUM(CASE WHEN winner is NOT NULL then 1 ELSE 0 END) as no_of_wins ,
--SUM(CASE WHEN winner is NULL or winner = a.team_1 then 1 ELSE 0 END) as no_of_losses
--from cte4_matches_played a
--left join icc_world_cup b
--ON a.team_1 = b.winner
--group by a.team_1 , matches_played

