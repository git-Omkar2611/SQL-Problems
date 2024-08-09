



--with user_pages as (
--select distinct f.user_id , l.page_id from friends f 
--inner join likes l
--on f.user_id = l.user_id
--) ,
--friends_page as (
--select distinct f.user_id , f.friend_id , l.page_id from friends f 
--inner join likes l
--on f.friend_id = l.user_id
--)

--select f.user_id , f.page_id from friends_page f 
--left join user_pages u
--on u.user_id = f.user_id and f.page_id = u.page_id
--where u.page_id is null
--order by f.user_id 


select * from friends f
inner join likes l
on f.friend_id = l.user_id
left join likes l1
on f.user_id = l1.user_id and l.page_id = l1.page_id
