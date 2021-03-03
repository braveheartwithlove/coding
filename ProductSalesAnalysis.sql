1068. Product Sales Analysis I
Easy


Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key of this table.
product_id is a foreign key to Product table.
Note that the price is per unit.
 

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key of this table.
 

Write an SQL query that reports the product_name, year, and price for each sale_id in the Sales table.

Return the resulting table in any order.

The query result format is in the following example:

 

Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+

Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+

Result table:
+--------------+-------+-------+
| product_name | year  | price |
+--------------+-------+-------+
| Nokia        | 2008  | 5000  |
| Nokia        | 2009  | 5000  |
| Apple        | 2011  | 9000  |
+--------------+-------+-------+
From sale_id = 1, we can conclude that Nokia was sold for 5000 in the year 2008.
From sale_id = 2, we can conclude that Nokia was sold for 5000 in the year 2009.
From sale_id = 7, we can conclude that Apple was sold for 9000 in the year 2011.


SELECT p.product_name, s.year, s.price
FROM Sales s 
left Join Product p
ON p.product_id = s.product_id

SELECT p.product_name, d.year, d.price 
FROM Product as p 
JOIN 
    (SELECT DISTINCT(product_id), year, price FROM Sales) as d 
ON p.product_id = d.product_id
	
	
DISTINCT helps filtering the table early on


SELECT product_name,year,price 
from Product p
join (select distinct product_id, year, price from Sales) s
using (product_id)

select product_name, year, price
from Product P
right join Sales S
on P.product_id = S.product_id


Likely what is happening is that in the Sales table there are multiple transactions of the same product_id,
 year, price at different quantity. As a result, if DISTINCT entries were retrieved before joining with Product
 table, it runs a lot faster.

SELECT DISTINCT 
    P.product_name, S.year, S.price 
FROM 
    (SELECT DISTINCT product_id, year, price FROM Sales) S
INNER JOIN
    Product AS P
USING (product_id);