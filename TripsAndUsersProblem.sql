select request_at , SUM(case when status ='cancelled_by_driver' or status ='cancelled_by_client' then 1 else 0 END) from trips r 
inner join users  u
on r.client_id = u.users_id
inner join users u1
on r.driver_Id = u1.users_id
where u.banned = 'no' and u1.banned = 'no'
group by request_at



/* Write your T-SQL query statement below */
select request_at day
        ,round(sum(case when status = 'cancelled_by_driver' or status = 'cancelled_by_client' then 1 else 0 end)
         / (count(id) * 1.00),2) 'Cancellation Rate'
  from Trips t 
 where request_at between '2013-10-01' and '2013-10-03'
   and client_id in (select users_id from Users where banned = 'No')
   and driver_id in  (select users_id  from Users where banned = 'No')
group by request_at