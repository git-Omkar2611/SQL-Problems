--DROP TABLE IF EXISTS FOOTER;
--CREATE TABLE FOOTER 
--(
--	id 			INT PRIMARY KEY,
--	car 		VARCHAR(20), 
--	length 		INT, 
--	width 		INT, 
--	height 		INT
--);

--INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
--INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
--INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
--INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
--INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

with cte as (
select * , row_number() over(order by id) as rn from FOOTER
), cte1 as (
select *,count(car) over(order by rn) as cnt , count(length) over(order by rn) as cnt_length, 
 count(height) over(order by rn) as cnt_height  ,
 count(width) over(order by rn) as cnt_width from cte
)

select top 1 FIRST_VALUE(car) over(partition by cnt order by rn) as car
, FIRST_VALUE(length) over(partition by cnt_length order by rn) as length
,FIRST_VALUE(width) over(partition by cnt_width order by rn) as width
,FIRST_VALUE(height) over(partition by cnt_height order by rn) as height
from cte1
order by rn desc
