with cte1 as (
	select * ,  row_number() over(order by (select 1)) as rownum from your_table
) , cte2 as (
	select * , count(your_column) over(order by rownum) as cnt from cte1
) , cte3 as (
	select * , lag(cnt,1,0) over(order by rownum) as pre_value from cte2
)

--select * ,FIRST_VALUE(your_column) over(partition by pre_value order by rownum desc
----rows between unbounded preceding and unbounded following
--) from cte3

select * ,LAST_VALUE(your_column) over(partition by pre_value order by rownum
rows between unbounded preceding and unbounded following
) from cte3