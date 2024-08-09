---- Create the spend_data table
--CREATE TABLE spend_data (
--    user_id INT,
--    spend_date DATE,
--    platform VARCHAR(20),
--    amount DECIMAL(10, 2)
--);

---- Insert the data into the spend_data table
--INSERT INTO spend_data (user_id, spend_date, platform, amount) VALUES
--    (1, '2019-07-01', 'mobile', 100.00),
--    (1, '2019-07-01', 'desktop', 100.00),
--    (2, '2019-07-01', 'mobile', 100.00),
--    (2, '2019-07-02', 'mobile', 100.00),
--    (3, '2019-07-01', 'desktop', 100.00),
--    (3, '2019-07-02', 'desktop', 100.00);

with cte1 as (
select user_id , spend_date , count(distinct platform) as platformCount
from spend_data
group by user_id , spend_date
) ,
cte2 as (
select m1.spend_date , case when M2.platformCount > 1 then 'both' else platform end as  platform , m1.amount , m1.user_id from spend_data M1
join cte1 M2
on M1.User_id = m2.User_id AND m1.spend_date = m2.spend_date
), cte3 as (
select spend_date , platform , user_id , sum(amount) as total_amount from cte2
group by spend_date , platform , user_id
), 
spend_dates as (
select distinct spend_date from spend_data
) , desired_platforms as (
select value from String_split('mobile,desktop,both',',') as platforms
) , cte4 as (
select * from desired_platforms
cross join spend_dates
)


select a.spend_date ,value as platform , ISNULL(total_amount , 0) as total_amount ,ISNULL(user_id , 0) as total_users from cte4 a 
left join cte3 b
on b.platform = a.value and b.spend_date = a.spend_date
