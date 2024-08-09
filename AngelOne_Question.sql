IF NOT EXISTS (select * from sys.objects where object_id = OBJECT_ID(N'[dbo].[Tickets]') and [type] ='U') 
BEGIN
CREATE TABLE tickets (
 airline_number VARCHAR(10),
 origin VARCHAR(3),
 destination VARCHAR(3),
 oneway_round CHAR(1),
 ticket_count INT
);
END
IF NOT EXISTS (select 1 from dbo.tickets)
BEGIN
INSERT INTO tickets (airline_number, origin, destination, oneway_round, ticket_count)
VALUES
 ('DEF456', 'BOM', 'DEL', 'O', 150),
 ('GHI789', 'DEL', 'BOM', 'R', 50),
 ('JKL012', 'BOM', 'DEL', 'R', 75),
 ('MNO345', 'DEL', 'NYC', 'O', 200),
 ('PQR678', 'NYC', 'DEL', 'O', 180),
 ('STU901', 'NYC', 'DEL', 'R', 60),
 ('ABC123', 'DEL', 'BOM', 'O', 100),
 ('VWX234', 'DEL', 'NYC', 'R', 90);
 END
 
 with cte as (
 select origin , destination , oneway_round , ticket_count from tickets
 union all
 select destination , origin , oneway_round , ticket_count from tickets where oneway_round ='R'
 )

 select top 1 origin , destination  , sum(ticket_Count) as ticket_count from cte
 group by origin , destination 
 order by sum(ticket_count) desc