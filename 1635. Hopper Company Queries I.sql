WITH cte AS (
    SELECT 1 AS [month], 2020 AS [year]
    UNION ALL
    SELECT [month] + 1, [year] FROM cte
    WHERE [month] <= 11
)

SELECT month , count(distinct DR.driver_id) as active_drivers , count( case when month(RD.requested_at) = cte.month AND AR.ride_id is not null then 1 END) as accepted_rides
FROM cte
left join Drivers DR
on dr.join_date <= EOMONTH(DATEFROMPARTS(cte.year,cte.month,1)) 
left join Rides  RD
on rd.requested_at <= EOMONTH(DATEFROMPARTS(cte.year,cte.month,1)) and Year(rd.requested_at) = 2020
left join AcceptedRides AR
on AR.ride_id = Rd.ride_id AND AR.driver_id = DR.driver_id
group by [month]




--WITH MonthlyDates AS (
--    SELECT 1 AS [month], 2020 AS [year]
--    UNION ALL
--    SELECT [month] + 1, [year] FROM MonthlyDates
--    WHERE [month] < 12
--)

--SELECT
--    md.[month],
--    COUNT(DISTINCT D.driver_id) AS active_drivers,
--    COUNT(DISTINCT CASE WHEN R.ride_id IS NOT NULL AND AR.ride_id IS NOT NULL THEN R.ride_id END) AS accepted_rides
--FROM MonthlyDates md
--LEFT JOIN Drivers D ON D.join_date <= EOMONTH(DATEFROMPARTS(md.[year], md.[month], 1))
--LEFT JOIN Rides R ON MONTH(R.requested_at) = md.[month] AND YEAR(R.requested_at) = md.[year]
--LEFT JOIN AcceptedRides AR ON AR.ride_id = R.ride_id AND AR.driver_id = D.driver_id
--GROUP BY md.[month], md.[year];




