-- For this challenge you need to create a simple SELECT statement that will return all columns from the people table, 
-- and join to the sales table so that you can return the COUNT of all sales and RANK each person by their sale_count.

-- people table schema
-- id
-- name
-- sales table schema
-- id
-- people_id
-- sale
-- price
-- You should return all people fields as well as the sale count as "sale_count" and the rank as "sale_rank".


---------------------------------------------------------------------

--solution:
-- Create your SELECT statement here
select p.id,p.name, count(s.sale) as sale_count, dense_rank() over(order by count(s.sale)) as sale_rank from people as p inner join sales as s on p.id = s.people_id 
group by p.id,p.name