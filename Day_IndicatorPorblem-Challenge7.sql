---- SQL Server
--IF OBJECT_ID('dbo.Day_Indicator', 'U') IS NOT NULL
--    DROP TABLE dbo.Day_Indicator;

--CREATE TABLE Day_Indicator
--(
--    Product_ID      VARCHAR(10),
--    Day_Indicator   VARCHAR(7),
--    Dates           DATE
--);

--INSERT INTO Day_Indicator VALUES ('AP755', '1010101', '2024-03-04');
--INSERT INTO Day_Indicator VALUES ('AP755', '1010101', '2024-03-05');
--INSERT INTO Day_Indicator VALUES ('AP755', '1010101', '2024-03-06');
--INSERT INTO Day_Indicator VALUES ('AP755', '1010101', '2024-03-07');
--INSERT INTO Day_Indicator VALUES ('AP755', '1010101', '2024-03-08');
--INSERT INTO Day_Indicator VALUES ('AP755', '1010101', '2024-03-09');
--INSERT INTO Day_Indicator VALUES ('AP755', '1010101', '2024-03-10');
--INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', '2024-03-04');
--INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', '2024-03-05');
--INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', '2024-03-06');
--INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', '2024-03-07');
--INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', '2024-03-08');
--INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', '2024-03-09');
--INSERT INTO Day_Indicator VALUES ('XQ802', '1000110', '2024-03-10');
with cte as (
select distinct product_id , day_indicator , SUBSTRING(day_indicator , 1 , 1) as Element , 1 as indexElement  from Day_Indicator
union all
select product_id , day_indicator , SUBSTRING(day_indicator,indexElement+1 ,1) , indexElement+1 from cte
where indexElement < len(day_indicator)
)

select * from cte


select *, DATENAME(WK,dates) from Day_Indicator


