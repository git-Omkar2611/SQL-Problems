select value,count(*) from namaste_python cross apply string_split(content,' ')
group by value
having count(value) > 1