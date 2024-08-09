SELECT TOP 1 SALARY
FROM (
SELECT DISTINCT TOP 3 SALARY
FROM tblEmployee
ORDER BY SALARY DESC
) RESULT
ORDER BY SALARY



select top 1 Salary from (select DISTINCT top 3 Salary from tblEmployee order by Salary DESC) RESULT ORDER BY Salary