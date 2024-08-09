with cte as (
select name , tradedate , tradetype , quantity*tradeprice as totalPrice from stocktrades
) , cte2 as (
select name , tradetype , SUM(totalPrice) as price from cte
group by name , tradetype
) , cte3 as (
select * , lag(tradeType,1) over(partition by name order by name) as nextTrade , 
lag(price,1) over(partition by name order by name) as buyPrice
from cte2
)

select  name,price - buyprice as profit  from cte3 where tradeType ='Sell' and nextTrade ='Buy' and buyPrice is not null 
and price - buyprice > 0