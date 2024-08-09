with cte as (
select top 1 * , dateadd(day,-90,event_datetime) as 'days_90' , 
dateadd(day,-180,event_datetime) as 'days_180' ,
dateadd(day,-270,event_datetime) as 'days_270' ,
dateadd(day,-365,event_datetime) as 'days_365' 
from warehouse
)

, inv_90days as (
select sum(e.OnHandQuantityDelta) as 'days_90_sum' from warehouse e
cross join cte c
where e.event_type ='Inbound' and e.event_datetime > c.days_90
) ,
inv_90days_final as (
select case when days_90_sum > OnHandQuantity then OnHandQuantity ELSE days_90_sum END as 'Days_90_Old' from inv_90days
cross join cte
) 

, inv_180days as (
select sum(e.OnHandQuantityDelta) as 'days_180_sum' from warehouse e
cross join cte c
where e.event_type ='Inbound' and e.event_datetime > c.days_180 and e.event_datetime < c.days_90
) ,

inv_180days_final as (
select case when days_180_sum > OnHandQuantity - days_90_sum then (OnHandQuantity - days_90_sum) ELSE days_180_sum END as 'Days_180_Old'  from inv_180days
cross join cte , inv_90days
)

, inv_270days as (
select sum(e.OnHandQuantityDelta) as 'days_270_sum' from warehouse e
cross join cte c
where e.event_type ='Inbound' and e.event_datetime > c.days_270 and e.event_datetime < c.days_90
) ,

inv_270days_final as (
select case when days_270_sum > OnHandQuantity - Days_90_Old - Days_180_Old then (OnHandQuantity - Days_90_Old - Days_180_Old) ELSE days_270_sum END as 'Days_270_Old'  from inv_270days
cross join cte , inv_90days_final , inv_180days_final
)

, inv_365days as (
select sum(e.OnHandQuantityDelta) as 'days_365_sum' from warehouse e
cross join cte c
where e.event_type ='Inbound' and e.event_datetime > c.days_270 and e.event_datetime < c.days_90
) ,

inv_365days_final as (
select case when days_365_sum > OnHandQuantity - Days_90_Old - Days_180_Old-Days_270_Old then (OnHandQuantity - Days_90_Old - Days_180_Old-Days_270_Old) ELSE days_365_sum END as 'Days_365_Old'  from inv_365days
cross join cte , inv_90days_final , inv_180days_final,inv_270days_final
)

select Days_90_Old as '0-90Days',Days_180_Old as '91-180Days' , Days_270_Old as '181-270Days' , Days_365_Old as '271-365Days'  from 
inv_90days_final
cross join
inv_180days_final , inv_270days_final,inv_365days_final
--select Days_90_Old as '0 - 90 Days Old' from inv_90days_final