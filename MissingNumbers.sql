--create table tempids (id int)

--insert into tempids values(1)
--insert into tempids values(3)
--insert into tempids values(5)
--insert into tempids values(6)
--insert into tempids values(7)
--insert into tempids values(9)
--insert into tempids values(10)
DECLARE @MaxNumber INT = 0 , @minNumber INT = 0

select @MaxNumber = MAX(id) from tempids
select @minNumber = min(id) from tempids
;WITH NumberSequence AS (
    select @minNumber as Number
	UNION ALL
	select Number + 1 as Number
	from NumberSequence
	where Number < @MaxNumber
)

SELECT Number FROM NumberSequence a
LEFT JOIN tempids b
on a.Number = b.id
where id is NULL



