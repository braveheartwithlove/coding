1164. Product Price at a Given Date
Medium

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write an SQL query to find the prices of all products on 2019-08-16. 
Assume the price of all products before any change is 10.

The query result format is in the following example:

Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+

Result table:
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+


UNION


select distinct product_id, 10 as price
from Products
group by product_id
having (min(change_date) > "2019-08-16")

union

select p2.product_id, new_price
from Products p2
where (p2.product_id, p2.change_date) in

(
select product_id, max(change_date) as recent_date
from Products
where change_date <= "2019-08-16"
group by product_id
)


Similar idea using LEFT JOIN:

SELECT T1.product_id, IFNULL(T2.new_price,10) AS price
FROM (SELECT DISTINCT product_id FROM Products) AS T1 
  LEFT JOIN
            (SELECT product_id, new_price
              FROM Products
              WHERE (product_id, change_date) IN (SELECT product_id, MAX(change_date) AS last_date
                                                                                 FROM Products
                                                                                  WHERE change_date <= '2019-08-16'
                                                                                  GROUP BY product_id)) AS T2
 ON T1.product_id = T2.product_id;
 
 
 
 select distinct a.product_id, coalesce(b.new_price, 10) as price from Products as a
left join
(select product_id, rank() over(partition by product_id order by change_date DESC) as xrank, new_price from Products
where change_date<='2019-08-16') as b
on a.product_id=b.product_id and b.xrank=1
order by 2 DESC;




with cte as
	(
		select product_id, 
		max(change_date) over(partition by product_id) max_change_date, new_price, change_date 
		from Products p
		where change_date <= cast('2019-08-16' as date)
	)
select t.product_id,coalesce(new_price, 10)  price
from (select distinct product_id from products) t 
left join cte c
on t.product_id = c.product_id
and c.max_change_date = c.change_date
order by 2 desc