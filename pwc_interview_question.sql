select * from source

select * from target


select COALESCE(s.id,t.id) , case when t.name is NULL then 'new in source' 
when s.name != t.name then 'mismatch'
when s.name is null then 'new in target' END
from source s
full outer join target  t
on s.id = t.id
where ISNULL(s.name,'') != ISNULL(t.name,'')


with cyte as (
select *,'source' as table_name from source
union all
select *,'target' as table_name from target
)

select id,count(*) , min(name) as name_min , max(name) as name_max , min(table_name) as min_tablename , max(table_name) as max_tablename from cyte
group by id
having count(*) =1 or (count(*) > 1 and min(name) != max(name))