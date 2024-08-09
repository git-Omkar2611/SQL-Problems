with cte as (
select * , row_number() over(order by ball_no) as legal_balls,
CEILING(row_number() over(order by ball_no)*1.0 / 6) as over_number
from cricket_runs
where delivery_type ='legal'
)  ,cte_extras as (
select * 
from cricket_runs
where delivery_type !='legal'
) , legal_cte as (
select over_number as over_number , sum(runs)as legal_runs ,lag(max(a.ball_no),1 ,0) over(order by over_number)+1 as first_ball  , max(a.ball_no) as last_ball   from cte a
group by over_number
)
, final_cte as (
select over_number , legal_runs , COALESCE(sum(runs),0) + COALESCE(count(runs),0) as [extra_runs] from legal_cte a
left join cte_extras b
on b.ball_no between a.first_ball and a.last_ball
group by over_number , legal_runs
)


select over_number , legal_runs + ISNULL(extra_runs,0) as runs_scored from final_cte



