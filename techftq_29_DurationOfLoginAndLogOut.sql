/*
PROBLEM STATEMENT: Given table provides login and logoff details of one user.
Generate a report to reqpresent the different periods (in mins) when user was logged in.
*/
--drop table if exists login_details;
--create table login_details
--(
--	times	time,
--	status	varchar(3)
--);
--insert into login_details values('10:00:00', 'on');
--insert into login_details values('10:01:00', 'on');
--insert into login_details values('10:02:00', 'on');
--insert into login_details values('10:03:00', 'off');
--insert into login_details values('10:04:00', 'on');
--insert into login_details values('10:05:00', 'on');
--insert into login_details values('10:06:00', 'off');
--insert into login_details values('10:07:00', 'off');
--insert into login_details values('10:08:00', 'off');
--insert into login_details values('10:09:00', 'on');
--insert into login_details values('10:10:00', 'on');
--insert into login_details values('10:11:00', 'on');
--insert into login_details values('10:12:00', 'on');
--insert into login_details values('10:13:00', 'off');
--insert into login_details values('10:14:00', 'off');
--insert into login_details values('10:15:00', 'on');
--insert into login_details values('10:16:00', 'off');
--insert into login_details values('10:17:00', 'off');
with cte as (
select * , ROW_NUMBER() over(order by times) as rn from login_details
)
, recursive_Cte as (
select top 1 times as times , status , rn , 1 as  'login' , 1 as grouping_factor from cte where status ='on'

union all

select c.times , 
		c.status , 
		c.rn, 
		case when lower(r.status) = 'on' and lower(c.status) = 'off' then 0
			 when lower(r.status) = 'off' and lower(c.status) = 'on' then 1
				 END as  'login' ,
		case when lower(r.status) = 'on' and lower(c.status) = 'off' then grouping_factor
		when lower(r.status) = 'off' and lower(c.status) = 'on' then grouping_factor+1
		ELSE grouping_factor
		END
				 from cte c
inner join recursive_Cte r
on c.rn = r.rn + 1 
)

select MAX(case when status ='on' then times END) as 'LOG_ON' ,  
		MAX(case when status ='off' then times END) as 'LOG_OFF' ,
		DATEDIFF(MINUTE , MAX(case when status ='on' then times END)  , MAX(case when status ='off' then times END) ) as Duration
	from recursive_Cte
where login is not null
group by grouping_factor;


