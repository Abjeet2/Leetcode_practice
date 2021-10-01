-- Given the information about sales in a store, calculate the total revenue for each day, month, year, and product.

-- Notes
-- The sales table stores only the dates for which any data has been recorded - the information about individual sales (what was sold, and when) is stored in the sales_details table instead
-- The sales_details table stores totals per product per date
-- Order the result by the product_name, year, month, day columns
-- We're interested only in the product-specific data, so you shouldn't return the total revenue from all sales


-- Input tables
-- ----------------------------------------
-- |    Table      |   Column   |  Type   |
-- |---------------+------------+---------|
-- | products      | id         | int     |
-- |               | name       | text    |
-- |               | price      | numeric |
-- |---------------+------------+---------|
-- | sales         | id         | int     |
-- |               | date       | date    |
-- |---------------+------------+---------|
-- | sales_details | id         | int     |
-- |               | sale_id    | int     |
-- |               | product_id | int     |
-- |               | count      | int     |
-- -----------------------------------------

-- Example output
-- product_name | year | month | day | total
-- -------------+------+-------+-----+------
--  milk        | 2019 | 01    | 01  | 200
--  milk        | 2019 | 01    | 02  | 190
--  milk        | 2019 | 01    |     | 390
--  milk        | 2019 | 02    | 01  | 240
--  milk        | 2019 | 02    |     | 240
--  milk        | 2019 |       |     | 630
--  milk        |      |       |     | 630

-----------------------------------------------------------------------------
-- Solution -
with temp(name,price,date,count) as (select p.name,p.price,s.date,sd.count from products as p inner join sales_details as sd on sd.product_id=p.id
inner join sales as s on s.id=sd.sale_id)

select name as product_name, extract(year from date) as year,extract(month from date) as month,extract(day from date) as day , 
cast(sum(price*count) as float) as total from temp 
group by name,extract(year from date),extract(month from date),extract(day from date)

union all

select name as product_name, extract(year from date) as year, null as month,null as day, 
cast(sum(price*count) as float) as total from temp group by name,extract(year from date) 

union all

select name as product_name, extract(year from date) as year,extract(month from date) as month,null as day ,  cast(sum(price*count) as float) as total from temp 
group by name,extract(year from date),extract(month from date)


union all

select name as product_name, null as year,null as month,null as day ,  cast(sum(price*count) as float) as total from temp 
group by name
order by product_name,year,month,day
