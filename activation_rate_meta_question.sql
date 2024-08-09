--select * from signups
--select * from activations

with cte_activation as (
	select user_id , count( case when lower(activation_status) = 'confirmed' then 1 END ) as confirmed_status
	from activations
	group by user_id
) , cte_signups as (
	select user_id , count(user_id) as cnt from Signups_Details
	group by user_id
)

select 
CAST
(SUM(Case when confirmed_status = 1 then 1 END)*100.00/count(b.user_id) as decimal(5,0) ) as activation_rate from cte_activation a
inner join cte_signups b
on a.user_id = b.user_id