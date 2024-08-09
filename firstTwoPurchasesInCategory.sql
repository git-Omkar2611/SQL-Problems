--CREATE TABLE Orders (
-- OrderID INT PRIMARY KEY,
-- CustomerID INT,
-- OrderDate DATE,
-- OrderAmount DECIMAL(10, 2),
-- Category VARCHAR(50)
--);

--INSERT INTO Orders VALUES (1, 100, '2023-01-05', 250.00, 'Electronics');
--INSERT INTO Orders VALUES (2, 101, '2023-01-06', 100.00, 'Books');
--INSERT INTO Orders VALUES (3, 100, '2023-01-07', 200.00, 'Electronics');
--INSERT INTO Orders VALUES (4, 102, '2023-01-08', 150.00, 'Clothing');
--INSERT INTO Orders VALUES (5, 101, '2023-01-09', 120.00, 'Electronics');
--INSERT INTO Orders VALUES (6, 100, '2023-01-10', 300.00, 'Books');
--INSERT INTO Orders VALUES (7, 101, '2023-01-11', 90.00, 'Books');
--INSERT INTO Orders VALUES (8, 100, '2023-01-12', 180.00, 'Electronics');
--INSERT INTO Orders VALUES (9, 102, '2023-01-13', 200.00, 'Books');
--INSERT INTO Orders VALUES (10, 101, '2023-01-14', 110.00, 'Books');

with cte1 as (
select * , row_number() over(partition by customerid,category order by customerid) as rowNum from Orders
)

select customerId , category , SUM(OrderAmount) , AVG(orderamount) from cte1 where rowNum < 3
group by customerId , category