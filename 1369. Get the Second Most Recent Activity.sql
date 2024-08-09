-- Creating the UserActivity table

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserActivity]') AND type in (N'U'))
BEGIN
CREATE TABLE UserActivity (
    username VARCHAR(255),
    activity VARCHAR(255),
    startDate DATE,
    endDate DATE
);

-- Inserting data into the UserActivity table
INSERT INTO UserActivity (username, activity, startDate, endDate)
VALUES 
    ('Alice', 'Travel', '2020-02-12', '2020-02-20'),
    ('Alice', 'Dancing', '2020-02-21', '2020-02-23'),
    ('Alice', 'Travel', '2020-02-24', '2020-02-28'),
    ('Bob', 'Travel', '2020-02-11', '2020-02-18');
END

select username , activity , startDate , endDate from (
select username , 
	activity , 
	startDate , 
	endDate , 
	Count(username) over (partition by username order by (select 1)) as cnt ,
	row_number() over (partition by username order by endDate desc ) as rn
	from UserActivity
)t
where rn = CASE WHEN cnt = 1 then rn ELSE cnt - 1 END