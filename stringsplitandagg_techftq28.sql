--drop table if exists item;
--create table item
--(
--	id		int,
--	items	varchar(50)
--);
--insert into item values(1, '22,122,1022');
--insert into item values(2, ',6,0,9999');
--insert into item values(3, '100,2000,2');
--insert into item values(4, '4,44,444,4444');

select id, string_agg(len(value),',') from item
cross apply string_split(items,',')
group by id