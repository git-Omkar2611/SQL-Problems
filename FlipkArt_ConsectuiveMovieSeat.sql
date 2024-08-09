--Flipkart Questions

--create table movie_seats(seat_no int , occupant_gender varchar(2))

--insert into movie_seats(seat_no , occupant_gender)
--select 1,'M'
--UNION
--select 2,'M'
--UNION
--select 3,'F'
--UNION
--select 4,'M'
--UNION
--select 5,'M'
--UNION
--select 6,'M'
--UNION
--select 7,'F'
--UNION
--select 8,'F'
--UNION
--select 10,'M'
select * from movie_seats
;with cte1 as (
select seat_no , SUM( CASE when occupant_gender = 'M' then 1 end) as male_count from movie_seats
group by seat_no
) , cte2 as (
select * , ROW_NUMBER() over (order by (select 1)) as rowNUm from cte1
) , cte3 as (
select * , count(male_count) over(order by rowNum) as cnt from cte2
) , cte4 as (
select * , rowNum - cnt as consecutiveCounts from cte3 where male_count is not null
) , cte5 as (
select consecutiveCounts , count(consecutiveCounts) as cnt_males from cte4
group by consecutiveCounts
)

select seat_no from cte5 a
inner join cte4  b
on a.consecutiveCounts = b.consecutiveCounts
where cnt_males > 2

