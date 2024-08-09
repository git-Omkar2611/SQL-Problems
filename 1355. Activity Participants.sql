with cte as (
select activity , count(activity) as cnt from friends
group by activity
)
, cte2 as (
select max(cnt) as cnt from cte
union 
select min(cnt) as cnt from cte
)

select activity from cte c1
left join cte2 c2
on c1.cnt = c2.cnt
where c2.cnt is null

