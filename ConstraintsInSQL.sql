Alter table tblStudents 
add constraint tblPerson_GenderId_FK FOREIGN KEY (GenderId) references tblGender(ID)

select * from tblStudents

ALTER Table tblStudents
ADD Constraint CK_GenderID CHECK (GenderID <> NULL)

ALTER TABLE tblStudents
ADD Constraint DF_GenderID
DEFAULT 3 For GenderID

ALTER TABLE tblStudents
ADD Constraint UQ_NAME UNIQUE(Name)

--CREATE TABLE tblPerson
--(
--	PersonID int Identity(1,1) Primary KEY  ,
	--NAME nvarchar(100)
--)

--INSERT INTO tblPerson VALUES('Omkar')
--DBCC CHECKIDENT('tblPerson',RESEED,0)

select gender , sum(totalmarks) from tblStudents
--WHERE SUM(TotalMarks) > 100
GROUP by Gender 
HAVING SUM(TotalMarks) > 1000

select SUM(totalmarks) from tblStudents


select MAX(TotalMarks) from tblStudents

CREATE TABLE tblDummy
(
	PersonID int Identity(1,1) Primary KEY NOT NULL ,
	NAME nvarchar(100)  Constraint CK_NAME CHECK (Name <> '')
)


select * from tblDummy

select top 1 * from tblDummy
ORDER By PersonID DESC



