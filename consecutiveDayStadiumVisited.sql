with cte_consecutiveday as (
select *  from stadium where count_people > 100
),cte2 as (
select * , datepart(DAY,date_visited) as DAY , row_number() over(order by date_visited) as rownum from cte_consecutiveday
),cte3 as (select id,date_visited,count_people , day - rownum as 'daysdata_rownumber'  from cte2)
,cte4 as (select daysdata_rownumber,count(*) as countData from cte3
group by daysdata_rownumber
HAVING COUNT(daysdata_rownumber) > 1)

select cte3.id,FORMAT(cte3.date_visited,'dd-MMM-yy'),cte3.count_people from cte3
inner join cte4
on cte4.daysdata_rownumber = cte3.daysdata_rownumber



