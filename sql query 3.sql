-- Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

-- The query result format is in the following example.

--  Input: 
-- Employee table:
-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+

-- Solution ----
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      with temp (sal,ranks) as (select Salary ,dense_rank() over(order by Salary desc) from Employee)
      select distinct (sal) from temp where ranks =N
  );
END