
;with cte as (
select submission_date , 
	hacker_id , 
	count(hacker_id) as total_number_of_submissions,
	DENSE_RANK() over(order by submission_date) as day_number
	from Submissions
group by submission_date , hacker_id
)
, cte2 as (
select submission_date,
	hacker_id,
	day_number,
	total_number_of_submissions,
		count(*) over(partition by hacker_id order by submission_date) as cnt,
		case when day_number = count(*) over(partition by hacker_id order by submission_date) then 1 else 0 end as unique_flag
from cte
)
, cte3 as (
select submission_date , hacker_id , 	total_number_of_submissions , SUM(unique_flag) over(partition by submission_date) as unique_cnt ,
ROW_NUMBER() over(partition by submission_date order by total_number_of_submissions desc, hacker_id) as rn 
from cte2
)

select submission_date , hacker_id , unique_cnt from cte3 where rn = 1