-- scenarios based interview question

--create table entries ( 
--name varchar(20),
--address varchar(20),
--email varchar(20),
--floor int,
--resources varchar(10));

--insert into entries 
--values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
--,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')
with floor_visit as (
select name,floor,count(1) as no_of_floor_visit
,rank() over(partition by name order by count(1) desc) as rn
from entries
group by name,FLOOR)
,resources_used as ( select name , count(name) as total_visits  from entries e group by e.name)
, resources_name as (select distinct name ,resources from entries)
, agg_resouces as (select name , string_agg(resources,',') as used_resouces from resources_name group by name)

select a.name , a.floor , a.no_of_floor_visit , b.total_visits , x.used_resouces from floor_visit a 
inner join resources_used b
on a.name = b.name
inner join agg_resouces x
on x.name = a.name
where rn = 1



