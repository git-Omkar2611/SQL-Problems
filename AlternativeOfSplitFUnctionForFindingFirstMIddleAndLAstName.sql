--create table customers  (customer_name varchar(30))
--insert into customers values ('Ankit Bansal')
--,('Vishal Pratap Singh')
--,('Michael'); 

with cte as (
select * ,
	len(customer_name) - len(replace(customer_name,' ','')) as no_of_spaces,
	CHARINDEX(' ',customer_name) as first_place_space ,
	CHARINDEX(' ' , customer_name , CHARINDEX(' ',customer_name)+1) as second_place_space
	from customers
)

select customer_name , CASE WHEN first_place_space = 0 then customer_name 
				WHEN first_place_space > 0 then SUBSTRING(customer_name,1,first_place_space-1)
				ELSE NULL
				END as 'first_name' ,
		   CASE WHEN no_of_spaces <=1 then NULL 
		   ELSE SUBSTRING(customer_name , first_place_space+1 , second_place_space-first_place_space-1)
		   END as 'middle_name' ,
		   CASE WHEN no_of_spaces = 0  then NULL
		   when no_of_spaces = 1  then SUBSTRING(customer_name , first_place_space+1,len(customer_name)-first_place_space)
		   ELSE SUBSTRING(customer_name , second_place_space+1 , len(customer_name) -second_place_space )
		   END as 'last_name'
from cte




