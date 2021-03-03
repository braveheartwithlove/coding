1445. Apples & Oranges
Medium

Table: Sales

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| sale_date     | date    |
| fruit         | enum    | 
| sold_num      | int     | 
+---------------+---------+
(sale_date,fruit) is the primary key for this table.
This table contains the sales of "apples" and "oranges" sold each day.
 

Write an SQL query to report the difference between number of apples and oranges sold each day.

Return the result table ordered by sale_date in format ('YYYY-MM-DD').

The query result format is in the following example:

 

Sales table:
+------------+------------+-------------+
| sale_date  | fruit      | sold_num    |
+------------+------------+-------------+
| 2020-05-01 | apples     | 10          |
| 2020-05-01 | oranges    | 8           |
| 2020-05-02 | apples     | 15          |
| 2020-05-02 | oranges    | 15          |
| 2020-05-03 | apples     | 20          |
| 2020-05-03 | oranges    | 0           |
| 2020-05-04 | apples     | 15          |
| 2020-05-04 | oranges    | 16          |
+------------+------------+-------------+

Result table:
+------------+--------------+
| sale_date  | diff         |
+------------+--------------+
| 2020-05-01 | 2            |
| 2020-05-02 | 0            |
| 2020-05-03 | 20           |
| 2020-05-04 | -1           |
+------------+--------------+

Day 2020-05-01, 10 apples and 8 oranges were sold (Difference  10 - 8 = 2).
Day 2020-05-02, 15 apples and 15 oranges were sold (Difference 15 - 15 = 0).
Day 2020-05-03, 20 apples and 0 oranges were sold (Difference 20 - 0 = 20).
Day 2020-05-04, 15 apples and 16 oranges were sold (Difference 15 - 16 = -1).


Clear MySQL solution with Case When


select sale_date, sum(case when fruit='apples' then sold_num else -sold_num end) as diff
from sales
group by sale_date


Clean MySQL, SUM(IF()), GROUP BY

SELECT
    sale_date,
    SUM(IF(fruit = 'apples', sold_num, -sold_num)) AS diff
FROM Sales
GROUP BY sale_date


SELECT a.sale_date, (a.sold_num- b.sold_num) as diff
from Sales a, Sales b
where a.sale_date = b.sale_date and a.fruit='apples' and a.fruit!=b.fruit
order by a.sale_date

Solution 1:

select distinct a.sale_date, (a.sold_num - b.sold_num) as diff
from
(
  select sale_date, fruit, sold_num
  from Sales
  where fruit = 'apples'
) a
join
(
  select sale_date, fruit, sold_num
  from Sales
  where fruit = 'oranges'
) b
on a.sale_date = b.sale_date

Solution 2:

select sale_date,
       sum(case when fruit = 'apples' then sold_num 
                else sold_num * -1 end) as diff
from Sales
group by sale_date



Joing two tables:
SELECT a.sale_date sale_date, num_apples - num_oranges as diff
FROM
	# Create table for Apples
    (SELECT sale_date, sold_num as num_apples
    FROM Sales
    WHERE fruit = 'apples') a,
	# Create table for Oranges
    (SELECT sale_date, sold_num as num_oranges
    FROM Sales
    WHERE fruit = 'oranges') o
WHERE
	# Join on sale_date
    o.sale_date = a.sale_date
ORDER BY 1