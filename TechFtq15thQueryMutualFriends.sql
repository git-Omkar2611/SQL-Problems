--DROP TABLE IF EXISTS Friends_15;

--CREATE TABLE Friends_15
--(
--	Friend1 	VARCHAR(10),
--	Friend2 	VARCHAR(10)
--);
--INSERT INTO Friends_15 VALUES ('Jason','Mary');
--INSERT INTO Friends_15 VALUES ('Mike','Mary');
--INSERT INTO Friends_15 VALUES ('Mike','Jason');
--INSERT INTO Friends_15 VALUES ('Susan','Jason');
--INSERT INTO Friends_15 VALUES ('John','Mary');
--INSERT INTO Friends_15 VALUES ('Susan','Mary');
with cte_friends as (
select friend1 as cf_friend1, friend2 as cf_friend2 from Friends_15
UNION ALL 
select friend2, friend1 from Friends_15
)

select distinct friend1,friend2,COUNT(cf.cf_friend2) over(partition by friend1,friend2 order by friend1,friend2) as mutual_friends from Friends_15 f
left join cte_friends cf
on f.friend1 = cf.cf_friend1 and cf.cf_friend2 in ( select af2.cf_friend2 from cte_friends af2 where af2.cf_friend1 = f.friend2   )


;WITH cte_friends AS (
    SELECT friend1 AS cf_friend1, friend2 AS cf_friend2 FROM Friends_15
    UNION ALL 
    SELECT friend2, friend1 FROM Friends_15

)

SELECT 
    DISTINCT f1.friend1,
    f1.friend2,
    cf.cf_friend1,cf_friend2  AS mutual_friends
FROM 
    Friends_15 f1
LEFT JOIN 
    cte_friends cf ON f1.friend1 = cf.cf_friend1 AND f1.friend2 <> cf.cf_friend2









