---- Create the Candidates_LeetCode table
--CREATE TABLE Candidates_LeetCode (
--    id INT,
--    Name VARCHAR(255)
--);

---- Insert data into the Candidates_LeetCode table
--INSERT INTO Candidates_LeetCode (id, [Name]) VALUES
--(1, 'A'),
--(2, 'B'),
--(3, 'C'),
--(4, 'D'),
--(5, 'E');

---- Create the Votes table
--CREATE TABLE Votes (
--    id INT,
--    CandidateId INT
--);

---- Insert data into the Votes table
--INSERT INTO Votes (id, CandidateId) VALUES
--(1, 2),
--(2, 4),
--(3, 3),
--(4, 2),
--(5, 5);


with cte as (
select c.Name , COUNT(c.id)  as cnt from Votes v
inner join Candidates_LeetCode c
on v.CandidateID = c.ID
group by c.name
) , cte2 as (
select  max(cnt) as maxcnt from cte 
)

select top 1 name from cte where cnt = (select maxcnt from cte2 )



