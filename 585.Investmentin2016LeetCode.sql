with cte as (
select tiv_2016, count(lat) over(partition by lat,lon) as cntlat , count(tiv_2015) over(partition by tiv_2015) as cnt2015 from leetcode_insurance
)

select sum(tiv_2016) as tiv_2016 from cte where cntlat = 1 and cnt2015 > 1


