---- Create Users_1159 table
--CREATE TABLE Users_1159 (
--    user_id INT PRIMARY KEY,
--    join_date DATE,
--    favorite_brand VARCHAR(50)
--);

---- Insert data into Users_1159 table
--INSERT INTO Users_1159 (user_id, join_date, favorite_brand)
--VALUES
--    (1, '2019-01-01', 'Lenovo'),
--    (2, '2019-02-09', 'Samsung'),
--    (3, '2019-01-19', 'LG'),
--    (4, '2019-05-21', 'HP');

---- Create Orders_1159 table
--CREATE TABLE Orders_1159 (
--    order_id INT PRIMARY KEY,
--    order_date DATE,
--    item_id INT,
--    buyer_id INT,
--    seller_id INT,
--    FOREIGN KEY (buyer_id) REFERENCES Users_1159(user_id),
--    FOREIGN KEY (seller_id) REFERENCES Users_1159(user_id)
--);

---- Insert data into Orders_1159 table
--INSERT INTO Orders_1159 (order_id, order_date, item_id, buyer_id, seller_id)
--VALUES
--    (1, '2019-08-01', 4, 1, 2),
--    (2, '2019-08-02', 2, 1, 3),
--    (3, '2019-08-03', 3, 2, 3),
--    (4, '2019-08-04', 1, 4, 2),
--    (5, '2019-08-04', 1, 3, 4),
--    (6, '2019-08-05', 2, 2, 4);

---- Create Items_1159_1159 table
--CREATE TABLE Items_1159 (
--    item_id INT PRIMARY KEY,
--    item_brand VARCHAR(50)
--);

---- Insert data into Items_1159 table
--INSERT INTO Items_1159 (item_id, item_brand)
--VALUES
--    (1, 'Samsung'),
--    (2, 'Lenovo'),
--    (3, 'LG'),
--    (4, 'HP');

with cte as (
select o.order_id, o.item_id , o.seller_id , i.item_brand from 
Orders_1159 o
left join Items_1159 i
on o.item_id = i.item_id
) , cte2 as (
select * , row_number() over(partition by seller_id order by order_id ) as [second_order] from cte
)

select u.user_id ,CASE WHEN second_order =2 AND u.favorite_brand = c.item_brand then 'yes' else 'no' END as [2nd_item_fav_brand] from 
users_1159 u 
left join cte2 c
on u.user_id = c.seller_id
where c.second_order iS NULL or c.second_order = 2
