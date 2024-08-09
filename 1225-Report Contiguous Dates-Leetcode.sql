-- Create the Failed table
IF NOT EXISTS (select * from Failed)
BEGIN
CREATE TABLE Failed (
    fail_date DATE
);
INSERT INTO Failed (fail_date) VALUES
    ('2018-12-28'),
    ('2018-12-29'),
    ('2019-01-04'),
    ('2019-01-05');
END
-- Create the Succeeded table
IF NOT EXISTS (select * from Succeeded)
BEGIN
CREATE TABLE Succeeded (
    success_date DATE
);

-- Insert data into the Succeeded table
INSERT INTO Succeeded (success_date) VALUES
    ('2018-12-30'),
    ('2018-12-31'),
    ('2019-01-01'),
    ('2019-01-02'),
    ('2019-01-03'),
    ('2019-01-06');
END


;with union_cte as (
select fail_date as date , 'Failed' as Result from Failed
where fail_date between '2019-01-01' AND '2019-12-31'
Union
select success_date as date , 'Successed' from Succeeded
where success_date between '2019-01-01' AND '2019-12-31'
)
, consecutive_result as (
select * , day(date) - ROW_NUMBER() over(partition by result order by date) as records from union_cte
)


select  result , min(date) as start_date , max(date) as end_date from consecutive_result
group by records , result
order by min(date)