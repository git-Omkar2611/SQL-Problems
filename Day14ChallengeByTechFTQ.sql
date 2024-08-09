--drop table if exists invoice;

--create table invoice
--(
--    serial_no       int,
--    invoice_date    date
--);

--insert into invoice values (330115, '2024-03-01');
--insert into invoice values (330120, '2024-03-01');
--insert into invoice values (330121, '2024-03-01');
--insert into invoice values (330122, '2024-03-02');
--insert into invoice values (330125, '2024-03-02');

--select * from invoice

--https://www.youtube.com/watch?v=WBqTj-FYux8

;with cte_invoices as (

select MIN(serial_no) as serial_no , MAX(serial_no) as max_serial_no from invoice
union all
select serial_no + 1 , max_serial_no from cte_invoices
where serial_no < max_serial_no
)

select ci.serial_no from cte_invoices ci
left join invoice i
on ci.serial_no = i.serial_no
where i.serial_no is NULL