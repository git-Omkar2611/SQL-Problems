--IF NOT EXISTS(select 1 from sys.objects where name = 'tasks' and type='U')
--BEGIN
--CREATE TABLE tasks (
--    id INT PRIMARY KEY,
--    start_date DATE,
--    end_date DATE
--);
--END

--if not exists(select 1 from tasks)
--begin
--INSERT INTO tasks (id, start_date, end_date)
--VALUES
--    (0, '2021-08-04', '2021-08-05'),
--    (1, '2021-08-06', '2021-08-07'),
--    (2, '2021-08-07', '2021-08-08'),
--    (3, '2021-08-08', '2021-08-09'),
--    (4, '2021-08-10', '2021-08-11'),
--    (5, '2021-08-12', '2021-08-13'),
--    (6, '2021-08-13', '2021-08-14'),
--    (7, '2021-08-14', '2021-08-15'),
--    (8, '2021-08-16', '2021-08-17'),
--    (9, '2021-08-17', '2021-08-18');
--end



--;with cte as (
--	select * , 0 as flag from tasks where id = 0
	
--	union all 

--	select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t 
--	inner join cte c
--	on c.id + 1 = t.id 
--)

--select DATEDIFF(day , min(start_date) ,  max(end_date)) as total_days , STRING_AGG(id,',') as sub_tasks , min(start_date) as proj_start , max(end_date) as proj_end from cte
--group by flag
--order by DATEDIFF(day , min(start_date) ,  max(end_date))





select * , 0 as flag from tasks where id = 0 -- cte base condition / base start

union all 

select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t 
inner join (
	select * , 0 as flag from tasks where id = 0
	) c
on c.id + 1 = t.id 

union all 

select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t 
inner join (
select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t 
	inner join (
	select * , 0 as flag from tasks where id = 0
	) c
	on c.id + 1 = t.id 
) c
on c.id + 1 = t.id

union all

select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t
inner join(
select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t 
inner join (
select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t 
	inner join (
	select * , 0 as flag from tasks where id = 0
	) c
	on c.id + 1 = t.id 
) c
on c.id + 1 = t.id
) c
on c.id + 1 = t.id


union all 

select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t
inner join (
select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t
inner join(
select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t 
inner join (
select t.* , case when t.start_date != c.end_date THEN flag+1 else flag END as  flag from tasks t 
	inner join (
	select * , 0 as flag from tasks where id = 0
	) c
	on c.id + 1 = t.id 
) c
on c.id + 1 = t.id
) c
on c.id + 1 = t.id
) c
on c.id + 1 = t.id



