--CREATE TABLE products_FirstValue (category VARCHAR(50),brand VARCHAR(50));

--INSERT INTO products_FirstValue (category, brand) VALUES('Chocolate', 'KITKAT');
--INSERT INTO products_FirstValue (category, brand) VALUES(NULL, 'Dairy Milk');
--INSERT INTO products_FirstValue (category, brand) VALUES(NULL, '5 Star');
--INSERT INTO products_FirstValue (category, brand) VALUES(NULL, 'Milkybar');
--INSERT INTO products_FirstValue (category, brand) VALUES(NULL, 'Kissme');
--INSERT INTO products_FirstValue (category, brand) VALUES('Biscuit', 'Oreo');
--INSERT INTO products_FirstValue (category, brand) VALUES(NULL, 'Parle');
--INSERT INTO products_FirstValue (category, brand) VALUES(NULL, 'Snack');
--INSERT INTO products_FirstValue (category, brand) VALUES(NULL, 'fifty fifty');
--INSERT INTO products_FirstValue (category, brand) VALUES(NULL, 'Bar');


with cte as (
select *, ROW_NUMBER() over(order by (select 1)) as rN from products_FirstValue
), cte1 as (
select * , count(category) over(order by rn) as cc from cte
)

select category ,  FIRST_VALUE(category) over(partition by cc order by cc) as updatedCategory , brand from cte1