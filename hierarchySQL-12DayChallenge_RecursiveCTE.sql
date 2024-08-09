--select * from company
with root_level_Manager as (
select c2.employee as team_employee,c2.manager as team_manager ,concat('team ',ROW_NUMBER() over(order by c1.employee)) as teams from company c1
inner join company c2
on c1.manager = c2.employee
where c2.manager is null
)
, cte_teams as (
select c1.employee as team_employee,c1.manager as team_manager ,concat('team ',ROW_NUMBER() over(order by c1.employee)) as teams from company c1
inner join company c2
on c1.manager = c2.employee
where c2.manager is null
) 
, recursive_cte as (
select team_employee , team_manager , teams from cte_teams c
union all
select c.employee,c.manager,c1.teams from company c
inner join recursive_cte c1
on c.manager = c1.team_employee
) , final_result as (
select * from recursive_cte
union
select * from root_level_Manager
)

select teams,STRING_AGG(team_employee,',') from final_result
group by teams