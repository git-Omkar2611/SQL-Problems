--Write an SQL query to obtain the 𝐦𝐨𝐧𝐭𝐡-𝐨𝐯𝐞𝐫-𝐦𝐨𝐧𝐭𝐡 𝐩𝐞𝐫𝐜𝐞𝐧𝐭𝐚𝐠𝐞 𝐜𝐡𝐚𝐧𝐠𝐞 𝐢𝐧 𝐭𝐨𝐭𝐚𝐥 𝐩𝐚𝐠𝐞 𝐯𝐢𝐞𝐰𝐬. 𝐓𝐡𝐞 𝐩𝐞𝐫𝐜𝐞𝐧𝐭𝐚𝐠𝐞 𝐜𝐡𝐚𝐧𝐠𝐞 𝐜𝐨𝐥𝐮𝐦𝐧 𝐰𝐢𝐥𝐥 𝐛𝐞 𝐩𝐨𝐩𝐮𝐥𝐚𝐭𝐞𝐝 𝐟𝐫𝐨𝐦 𝐭𝐡𝐞 𝐬𝐞𝐜𝐨𝐧𝐝 𝐦𝐨𝐧𝐭𝐡 𝐟𝐨𝐫𝐰𝐚𝐫𝐝.#

𝐦𝐨𝐧𝐭𝐡-𝐨𝐯𝐞𝐫-𝐦𝐨𝐧𝐭𝐡-𝐩𝐞𝐫𝐜𝐞𝐧𝐭𝐚𝐠𝐞-𝐜𝐡𝐚𝐧𝐠𝐞-𝐢𝐧-𝐭𝐨𝐭𝐚𝐥-𝐩𝐚𝐠𝐞-𝐯𝐢𝐞𝐰𝐬
with cte1 as (
select * , datepart(month , date) as month from web_traffic
) , cte2 as (
	select month , sum(page_views) as total_page_views from cte1
	group by month
), cte3 as (
	select month , total_page_views ,lag(total_page_views,1) over(order by month asc) as previous_page_view from cte2
)


select month , CASE WHEN previous_page_view is NULL THEN NULL 
WHEN previous_page_view > 0 then CAST((total_page_views - previous_page_view)*100.00 / previous_page_view as Decimal(5,1)) END as per_change
from cte3

