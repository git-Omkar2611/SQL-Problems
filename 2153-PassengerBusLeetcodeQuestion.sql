--select * from Buses

--select * from Passengers

;with cte_buses as (
select row_number() over(order by arrival_time) as rn ,
		b.bus_id , b.capacity ,
		(select count(1) from Passengers p where p.arrival_time <= b.arrival_time) as total_passengers  
		from Buses b
)
, recursive_cte as (
	select rn ,
	bus_id , 
	capacity , 
	total_passengers,
	CASE WHEN capacity < total_passengers THEN capacity else total_passengers END as onboarded_bus,
	CASE WHEN capacity < total_passengers THEN capacity else total_passengers END as total_onboarded_bus
	from cte_buses where rn = 1

	union all

	select cb.rn ,
	cb.bus_id , 
	cb.capacity , 
	cb.total_passengers,
	(CASE WHEN cb.capacity < cb.total_passengers - rc.onboarded_bus THEN cb.capacity else cb.total_passengers - rc.onboarded_bus END)  as onboarded_bus,
	rc.total_onboarded_bus + (CASE WHEN cb.capacity < cb.total_passengers- rc.onboarded_bus THEN cb.capacity else cb.total_passengers- rc.onboarded_bus END)  as total_onboarded_bus
	from recursive_cte rc
	inner join cte_buses cb
	on cb.rn = rc.rn+1

)

select bus_id , onboarded_bus as passengers_cnt from recursive_cte
order by bus_id




