---- Create table
--CREATE TABLE Sessions (
--    user_id INT,
--    session_start DATETIME,
--    session_end DATETIME,
--    session_id INT,
--    session_type VARCHAR(20)
--);

---- Insert data
--INSERT INTO Sessions (user_id, session_start, session_end, session_id, session_type) VALUES
--(101, '2023-11-06 13:53:42', '2023-11-06 14:05:42', 375, 'Viewer'),
--(101, '2023-11-22 16:45:21', '2023-11-22 20:39:21', 594, 'Streamer'),
--(102, '2023-11-16 13:23:09', '2023-11-16 16:10:09', 777, 'Streamer'),
--(102, '2023-11-17 13:23:09', '2023-11-17 16:10:09', 778, 'Streamer'),
--(101, '2023-11-20 07:16:06', '2023-11-20 08:33:06', 315, 'Streamer'),
--(104, '2023-11-27 03:10:49', '2023-11-27 03:30:49', 797, 'Viewer'),
--(103, '2023-11-27 03:10:49', '2023-11-27 03:30:49', 798, 'Streamer');
select * from Sessions
;with cte as (
select user_id, session_type , row_number() over(partition by user_id order by session_start) as session from Sessions
)

select c.user_id , count(case when b.session_type ='Streamer' then 1 END) as [sessions_count] from cte c
inner join Sessions b
on c.user_id = b.user_id
where c.session = 1 and c.session_type ='Viewer'
GROUP by c.user_id
HAVING count(case when b.session_type ='Streamer' then 1 END) > 0
order by user_id,count(case when b.session_type ='Streamer' then 1 END) desc





