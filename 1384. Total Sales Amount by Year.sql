--Approach One
select 
t.product_id,
p.product_name,
t.report_year,
t.amount
from (
select 
product_id,
'2018' as report_year, 
average_daily_sales * (DATEDIFF( day , CASE WHEN period_start > '2018-01-01' THEN period_start ELSE '2018-01-01' END,
CASE WHEN period_end < '2018-12-31' THEN period_end ELSE '2018-12-31' END
)+1) as amount  from Sales_Leetcode1384
where YEAR(period_start)='2018' or year(period_end) ='2018'

UNION ALL

select 
product_id,
'2019' as report_year, 
average_daily_sales * (DATEDIFF( day , CASE WHEN period_start > '2019-01-01' THEN period_start ELSE '2019-01-01' END,
CASE WHEN period_end < '2019-12-31' THEN period_end ELSE '2019-12-31' END
)+1) as amount  from Sales_Leetcode1384
where YEAR(period_start)<='2019' AND year(period_end)>='2019'

UNION ALL

select 
product_id,
'2020' as report_year, 
average_daily_sales * (DATEDIFF( day , CASE WHEN period_start > '2020-01-01' THEN period_start ELSE '2020-01-01' END,
CASE WHEN period_end < '2020-12-31' THEN period_end ELSE '2020-12-31' END
)+1) as amount  from Sales_Leetcode1384
where YEAR(period_start)='2020' or year(period_end) ='2020'

)t
JOIN Product_Leetcode1384 p
on p.product_id = t.product_id
ORDER BY t.product_id,t.report_year

--Approach Two
;WITH recursive_cte AS (
  SELECT MIN(period_start) AS recursive_period_start, MAX(period_end) AS recursive_period_end 
  FROM Sales_Leetcode1384
  UNION ALL
  SELECT DATEADD(day, 1, recursive_period_start) AS recursive_period_start, recursive_period_end 
  FROM recursive_cte
  WHERE recursive_period_start < recursive_period_end
)

SELECT pl.product_id,pl.product_name ,YEAR(recursive_period_start) as [report_year] ,SUM(average_daily_sales) as total_amount
FROM recursive_cte 
LEFT JOIN Sales_Leetcode1384 s ON 
  recursive_period_start >= period_start AND 
  recursive_period_start <= period_end
INNER JOIN Product_Leetcode1384 pl
on pl.product_id = s.product_id
GROUP BY pl.product_id,YEAR(recursive_period_start),pl.product_name
order by pl.product_id,YEAR(recursive_period_start)
OPTION (MAXRECURSION 1000);
