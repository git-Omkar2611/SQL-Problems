
-- Find the median ages of countries

--drop table if exists people_techftq20;
--create table people_techftq20
--(
--	id			int,
--	country		varchar(20),
--	age			int
--);
--insert into people_techftq20 values(1 ,'Poland',10 );
--insert into people_techftq20 values(2 ,'Poland',5  );
--insert into people_techftq20 values(3 ,'Poland',34   );
--insert into people_techftq20 values(4 ,'Poland',56);
--insert into people_techftq20 values(5 ,'Poland',45  );
--insert into people_techftq20 values(6 ,'Poland',60  );
--insert into people_techftq20 values(7 ,'India',18   );
--insert into people_techftq20 values(8 ,'India',15   );
--insert into people_techftq20 values(9 ,'India',33 );
--insert into people_techftq20 values(10,'India',38 );
--insert into people_techftq20 values(11,'India',40 );
--insert into people_techftq20 values(12,'India',50  );
--insert into people_techftq20 values(13,'USA',20 );
--insert into people_techftq20 values(14,'USA',23 );
--insert into people_techftq20 values(15,'USA',32 );
--insert into people_techftq20 values(16,'USA',54 );
--insert into people_techftq20 values(17,'USA',55  );
--insert into people_techftq20 values(18,'Japan',65  );
--insert into people_techftq20 values(19,'Japan',6  );
--insert into people_techftq20 values(20,'Japan',58  );
--insert into people_techftq20 values(21,'Germany',54  );
--insert into people_techftq20 values(22,'Germany',6  );
--insert into people_techftq20 values(23,'Malaysia',44  );

with cte as (
select * , ROW_NUMBER() over(partition by country order by age) as rn , CAST(
COUNT(country) over(partition by country order by age range between unbounded preceding and unbounded following) as decimal(5,2)) as cnt  from people_techftq20
)

select country , age from cte
where rn >= cnt/2 and rn<= (cnt/2) + 1