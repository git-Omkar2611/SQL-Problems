

WITH CTE as (select product.product_id,user_id,price*quantity as totalprice from Product
INNER JOIN Sales
on product.product_id = sales.product_id
) , finalTable as (select product_id,user_id,sum(totalPrice) as total from CTE
group by product_id,user_id 
)

select user_id,product_id from (select * , rank() over(partition by user_id order by total desc) as rn from finalTable)t where t.rn = 1
