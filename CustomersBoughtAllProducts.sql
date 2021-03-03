1045. Customers Who Bought All Products
Medium

Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
product_key is a foreign key to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key column for this table.
 

Write an SQL query for a report that provides the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

The query result format is in the following example:

 

Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+

Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+

Result table:
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
The customers who bought all the products (5 and 6) are customers with id 1 and 3.

subqueries

select customer_id
from customer c
group by customer_id
having count(distinct product_key)=(select count(distinct product_key) from product)

Most posted solutions are wrong!!!

Ignore my post if you only interested in getting your code pass the leetcode test, 
but not interested in how to do things right!!!

Most solutions posted here have used 'count distinct product_key'. However,
 this method should NOT be considered as the correct answer. For example, 
 if the Product table contains 5 & 7 instead of 5 & 6, using 'count distinct product_key',
 you will still get results of customer_id 1 & 3, which is definitely WRONG!!!

SELECT DISTINCT customer_id FROM Customer WHERE customer_id NOT IN (
SELECT customer_id FROM (
SELECT DISTINCT * FROM 
(SELECT DISTINCT customer_id FROM Customer) C
CROSS JOIN Product P) C2
WHERE (customer_id,product_key) NOT IN (SELECT customer_id,product_key FROM Customer));



