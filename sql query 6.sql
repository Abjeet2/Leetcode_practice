
-- Given a posts table that contains a created_at timestamp column write a query that returns a first date of the month, a number of posts created in a given month and a month-over-month growth rate.

-- The resulting set should be ordered chronologically by date.

-- Note:

-- percent growth rate can be negative
-- percent growth rate should be rounded to one digit after the decimal point and immediately followed by a percent symbol "%". See the desired output below for the reference.


-- Desired Output
-- The resulting set should look similar to the following:

-- date       | count | percent_growth
-- -----------+-------+---------------
-- 2016-02-01 |   175 |           null
-- 2016-03-01 |   338 |          93.1%
-- 2016-04-01 |   345 |           2.1%
-- 2016-05-01 |   295 |         -14.5%
-- 2016-06-01 |   330 |          11.9%


-----------------------------------------------------------------------------------
--Solution

with temp(date,count,lag) as 

(select cast(date_trunc('month', created_at) as date) as date,
 
count(created_at), 
 
(lag(count(created_at),1) over (order by cast(date_trunc('month', created_at) as date))) as lagg
 
from posts 
 
group by cast(date_trunc('month', created_at) as date) order by date)


select date, count ,
case when concat(to_char(float8 ((count-lag)/lag::float*100), 'FM999999999.0'), '%') = '%' then null
else concat(to_char(float8 ((count-lag)/lag::float*100), 'FM999999999.0'),'%')
end as percent_growth

from temp