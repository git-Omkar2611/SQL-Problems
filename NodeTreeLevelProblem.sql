select t1.id , MAX(case when t1.p_id is null then 'root' 
when t1.id = t2.p_id and t1.p_id is not null then 'inner'
else 'leaf'
end) as type_ from tree t1
left join tree t2
on t1.id = t2.p_id
group by t1.id