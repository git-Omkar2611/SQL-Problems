--CREATE TABLE covid_cases (
--    cases_reported INT,
--    dates DATE
--);

--INSERT INTO covid_cases VALUES (20124,'2020-01-10');
--INSERT INTO covid_cases VALUES (40133,'2020-01-15');
--INSERT INTO covid_cases VALUES (65005,'2020-01-20');
--INSERT INTO covid_cases VALUES (30005,'2020-02-08');
--INSERT INTO covid_cases VALUES (35015,'2020-02-19');
--INSERT INTO covid_cases VALUES (15015,'2020-03-03');
--INSERT INTO covid_cases VALUES (35035,'2020-03-10');
--INSERT INTO covid_cases VALUES (49099,'2020-03-14');
--INSERT INTO covid_cases VALUES (84045,'2020-03-20');
--INSERT INTO covid_cases VALUES (100106,'2020-03-31');
--INSERT INTO covid_cases VALUES (17015,'2020-04-04');
--INSERT INTO covid_cases VALUES (36035,'2020-04-11');
--INSERT INTO covid_cases VALUES (50099,'2020-04-13');
--INSERT INTO covid_cases VALUES (87045,'2020-04-22');
--INSERT INTO covid_cases VALUES (101101,'2020-04-30');
--INSERT INTO covid_cases VALUES (40015,'2020-05-01');
--INSERT INTO covid_cases VALUES (54035,'2020-05-09');
--INSERT INTO covid_cases VALUES (71099,'2020-05-14');
--INSERT INTO covid_cases VALUES (82045,'2020-05-21');
--INSERT INTO covid_cases VALUES (90103,'2020-05-25');
--INSERT INTO covid_cases VALUES (99103,'2020-05-31');
--INSERT INTO covid_cases VALUES (11015,'2020-06-03');
--INSERT INTO covid_cases VALUES (28035,'2020-06-10');
--INSERT INTO covid_cases VALUES (38099,'2020-06-14');
--INSERT INTO covid_cases VALUES (45045,'2020-06-20');
--INSERT INTO covid_cases VALUES (36033,'2020-07-09');
--INSERT INTO covid_cases VALUES (40011,'2020-07-23');
--INSERT INTO covid_cases VALUES (25001,'2020-08-12');
--INSERT INTO covid_cases VALUES (29990,'2020-08-26');
--INSERT INTO covid_cases VALUES (20112,'2020-09-04');
--INSERT INTO covid_cases VALUES (43991,'2020-09-18');
--INSERT INTO covid_cases VALUES (51002,'2020-09-29');
--INSERT INTO covid_cases VALUES (26587,'2020-10-25');
--INSERT INTO covid_cases VALUES (11000,'2020-11-07');
--INSERT INTO covid_cases VALUES (35002,'2020-11-16');
--INSERT INTO covid_cases VALUES (56010,'2020-11-28');
--INSERT INTO covid_cases VALUES (15099,'2020-12-02');
--INSERT INTO covid_cases VALUES (38042,'2020-12-11');
--INSERT INTO covid_cases VALUES (73030,'2020-12-26');
with cte_cases as (
SELECT month(dates) as months, sum(cases_reported) as cases_reported  FROM covid_cases
group by month(dates)
) , sums_cte_cases as (
select * ,  sum(cases_reported) over(order by months asc) as sums_cases_reported from cte_cases
)

select months , CAST( (cases_reported * 1.0 / lag(sums_cases_reported) over(order by months)) * 100 as decimal(5,1)) from sums_cte_cases


