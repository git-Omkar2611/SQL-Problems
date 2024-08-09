;with cte as (
select host_team , guest_team , case when host_goals > guest_goals then host_team
when host_goals < guest_goals then guest_team END as [Winner_Team]
from Matches
) , cte1 as (
select host_team as teams from matches
union all
select guest_team from matches
) , cte2 as (
select teams , count(teams) as [matches played] from cte1
group by teams
)


select team_id , team_name , SUM(CASE WHEN (c2.teams is NULL AND c1.Winner_Team is NULL) oR (c2.teams != c1.Winner_Team) THEN 0
WHEN c2.teams = c1.Winner_Team THEN 3 
WHEN c1.winner_team is NULL AND teams is not null then 1 END) as [num_points] 
 from  teams t
left join cte2 c2
on c2.teams = t.team_id
left join cte c1
on c2.teams = c1.host_team or c2.teams = c1.guest_team
group by team_id , team_name
