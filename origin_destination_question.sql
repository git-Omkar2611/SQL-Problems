with cte as (
select cid , origin , destination, FIRST_VALUE(origin) over(partition by cid order by cid) as origins , 
LAST_VALUE(destination) over(partition by cid order by cid) as destinations from flights
group by cid, origin , destination
)

select cid , origins, destinations from cte
group by cid , origins, destinations