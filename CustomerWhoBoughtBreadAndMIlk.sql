--CREATE TABLE UserProducts (
-- user_id INT,
-- user_name VARCHAR(255),
-- product_name VARCHAR(255)
--);

--INSERT INTO UserProducts (user_id, user_name, product_name) VALUES 
--(1, 'Alice', 'Bread'),
--(1, 'Alice', 'Milk'),
--(1, 'Alice', 'Eggs'),
--(2, 'Bob', 'Bread'),
--(2, 'Bob', 'Juice'),
--(3, 'Charlie', 'Milk'),
--(3, 'Charlie', 'Cheese'),
--(4, 'David', 'Bread'), 
--(4,'David','Milk'), 
--(4,'David','Butter');


select user_name , string_agg(product_name,'+') from UserProducts
where product_name in ('Bread','Milk')
group by USER_NAME
having count(distinct product_name) = 2
