-- Create the Spending table
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Spending')
BEGIN
CREATE TABLE Spending (
    user_id INT,
    spend_date DATE,
    platform VARCHAR(20),
    amount INT
);

-- Insert data into the Spending table
INSERT INTO Spending (user_id, spend_date, platform, amount) VALUES
    (1, '2019-07-01', 'mobile', 100),
    (1, '2019-07-01', 'desktop', 100),
    (2, '2019-07-01', 'mobile', 100),
    (2, '2019-07-02', 'mobile', 100),
    (3, '2019-07-01', 'desktop', 100),
    (3, '2019-07-02', 'desktop', 100);
END

;with  cte as (
select value as platforms from string_split('mobile,desktop,both',',') 
) , cte2 as (
select distinct spend_date , platforms from Spending
cross join cte
),cte3 as (
select user_id , spend_date , count(user_id) as cnt , sum(amount) as amount from Spending
group by user_id , spend_date
)
, cte4 as (
select distinct c.user_id , c.spend_date , c.amount , case when cnt > 1 then 'both' else s.platform end as platforms from cte3 c
inner join Spending s
on c.user_id = s.user_id
)

select cte2.spend_date , ISNULL(cte4.amount,0) as amount , cte2.platforms ,count(cte4.user_id) from cte2
left join cte4
on cte4.platforms = cte2.platforms and cte4.spend_date = cte2.spend_date
group by cte2.spend_date , cte4.amount , cte2.platforms