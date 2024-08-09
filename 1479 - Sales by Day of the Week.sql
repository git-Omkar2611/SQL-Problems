with cte as (
select item_category  , quantity, DATENAME(WEEKDAY , order_date) as weekday  from items_leetcode_1479  o
left join orders_leetcode_1479 i
on o.item_id = i.item_id
)

select item_category , SUM(case when weekday ='MONDAY' then quantity ELSE 0 END) as  'Monday' ,
SUM(case when weekday ='Tuesday' then quantity ELSE 0 END) as  'Tuesday' ,
SUM(case when weekday ='Wednesday' then quantity ELSE 0 END) as  'Wednesday' ,
SUM(case when weekday ='Thursday' then quantity ELSE 0 END) as  'Thursday' ,
SUM(case when weekday ='Friday' then quantity ELSE 0 END) as  'Friday' ,
SUM(case when weekday ='Saturday' then quantity ELSE 0 END) as  'Saturday' ,
SUM(case when weekday ='Sunday' then quantity ELSE 0 END) as  'Sunday' 
from cte
group by item_category