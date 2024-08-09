--create table user_login
--(
--	user_id		int,
--	login_date	date
--);
--insert into user_login values(1, convert(datetime,'01/03/2024',103));
--insert into user_login values(1, convert(datetime,'02/03/2024',103));
--insert into user_login values(1, convert(datetime,'03/03/2024',103));
--insert into user_login values(1, convert(datetime,'04/03/2024',103));
--insert into user_login values(1, convert(datetime,'06/03/2024',103));
--insert into user_login values(1, convert(datetime,'10/03/2024',103));
--insert into user_login values(1, convert(datetime,'11/03/2024',103));
--insert into user_login values(1, convert(datetime,'12/03/2024',103));
--insert into user_login values(1, convert(datetime,'13/03/2024',103));
--insert into user_login values(1, convert(datetime,'14/03/2024',103));
--insert into user_login values(1, convert(datetime,'20/03/2024',103));
--insert into user_login values(1, convert(datetime,'25/03/2024',103));
--insert into user_login values(1, convert(datetime,'26/03/2024',103));
--insert into user_login values(1, convert(datetime,'27/03/2024',103));
--insert into user_login values(1, convert(datetime,'28/03/2024',103));
--insert into user_login values(1, convert(datetime,'29/03/2024',103));
--insert into user_login values(1, convert(datetime,'30/03/2024',103));
--insert into user_login values(2, convert(datetime,'01/03/2024',103));
--insert into user_login values(2, convert(datetime,'02/03/2024',103));
--insert into user_login values(2, convert(datetime,'03/03/2024',103));
--insert into user_login values(2, convert(datetime,'04/03/2024',103));
--insert into user_login values(3, convert(datetime,'01/03/2024',103));
--insert into user_login values(3, convert(datetime,'02/03/2024',103));
--insert into user_login values(3, convert(datetime,'03/03/2024',103));
--insert into user_login values(3, convert(datetime,'04/03/2024',103));
--insert into user_login values(3, convert(datetime,'04/03/2024',103));
--insert into user_login values(3, convert(datetime,'04/03/2024',103));
--insert into user_login values(3, convert(datetime,'05/03/2024',103));
--insert into user_login values(4, convert(datetime,'01/03/2024',103));
--insert into user_login values(4, convert(datetime,'02/03/2024',103));
--insert into user_login values(4, convert(datetime,'03/03/2024',103));
--insert into user_login values(4, convert(datetime,'04/03/2024',103));
--insert into user_login values(4, convert(datetime,'04/03/2024',103));

with cte as (
select user_id , login_date , day(login_date) - row_number() over (partition by user_id order by day(login_date)) as cnt from user_login
group by user_id , login_date 
) , cte1 as (
select user_id  ,  cnt , count(cnt) as consecutive_days from cte
group by  user_id , cnt
HAVING count(cnt) > 4
)


select c1.user_id ,  min(login_date) as start_date , max(login_date) as end_date , consecutive_days  from cte1 c1
inner join cte c2
on c1.cnt = c2.cnt
group by c1.user_id , consecutive_days
order by c1.user_id
