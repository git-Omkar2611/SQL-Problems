
IF NOT EXISTS(select 1 from Books_1098)
BEGIN

CREATE TABLE Books_1098 (
    book_id INT,
    name VARCHAR(255),
    available_from DATE
);

INSERT INTO Books_1098 (book_id, name, available_from)
VALUES 
    (1, 'Kalila And Demna', '2010-01-01'),
    (2, '28 Letters', '2012-05-12'),
    (3, 'The Hobbit', '2019-06-10'),
    (4, '13 Reasons Why', '2019-06-01'),
    (5, 'The Hunger Games', '2008-09-21');
END

IF NOT EXISTS(select 1 from Orders_1098)
BEGIN
-- Creating the Orders_1098 table
CREATE TABLE Orders_1098 (
    order_id INT,
    book_id INT,
    quantity INT,
    dispatch_date DATE
);

-- Inserting data into the Orders_1098 table
INSERT INTO Orders_1098 (order_id, book_id, quantity, dispatch_date)
VALUES 
    (1, 1, 2, '2018-07-26'),
    (2, 1, 1, '2018-11-05'),
    (3, 3, 8, '2019-06-11'),
    (4, 4, 6, '2019-06-05'),
    (5, 4, 5, '2019-06-20'),
    (6, 5, 9, '2009-02-02'),
    (7, 5, 8, '2010-04-13');
END

select books.book_id , books.name from Books_1098 books
left join Orders_1098 orders
on books.book_id = orders.book_id and year(orders.dispatch_date) >= year(DATEADD(YYYY , -1 , '2019-06-23'))
where books.available_from < DATEADD(month , -1 , '2019-06-23') 
group by books.book_id , books.name
HAVING SUM(ISNULL(orders.quantity,0)) < 10
order by books.book_id


