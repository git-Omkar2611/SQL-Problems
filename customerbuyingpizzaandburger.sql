
--𝐏𝐫𝐨𝐛𝐥𝐞𝐦 𝐒𝐭𝐚𝐭𝐞𝐦𝐞𝐧𝐭:
--1. Write an SQL query 𝐭𝐨 𝐟𝐞𝐭𝐜𝐡 𝐭𝐡𝐞 𝐮𝐬𝐞𝐫_𝐢𝐝𝐬 𝐰𝐡𝐢𝐜𝐡 𝐡𝐚𝐯𝐞 𝐨𝐧𝐥𝐲 𝐛𝐨𝐮𝐠𝐡𝐭 '𝐁𝐮𝐫𝐠𝐞𝐫' 𝐚𝐧𝐝 '𝐂𝐨𝐥𝐝 𝐃𝐫𝐢𝐧𝐤' 𝐚𝐧𝐝 𝐧𝐨 𝐨𝐭𝐡𝐞𝐫 𝐢𝐭𝐞𝐦𝐬.

with burger_orders as (
select * from orders_details where lower(item_ordered) = 'burger'
) , cold_drink_orders as (
select * from orders_details where lower(item_ordered) = 'cold drink'
)

select c1.user_id from cold_drink_orders c1
INNER JOIN burger_orders b1
on c1.user_id = b1.user_id