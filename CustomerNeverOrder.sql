183. Customers Who Never Order
Easy

Suppose that a website contains two tables, the Customers table 
and the Orders table. Write a SQL query to find all customers who never order anything.

Table: Customers.

+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Table: Orders.

+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Using the above tables as example, return the following:

+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+

select customers.name as 'Customers'
from customers
where customers.id not in
(
    select customerid from orders
);

select
    c.Name as 'Customers'
from Customers c
where not exists (select o.CustomerId
from Orders o
where c.Id = o.CustomerId);




SELECT A.Name from Customers A
WHERE NOT EXISTS (SELECT 1 FROM Orders B WHERE A.Id = B.CustomerId)

SELECT A.Name 
from Customers A
LEFT JOIN Orders B 
on  a.Id = B.CustomerId
WHERE b.CustomerId is NULL

SELECT A.Name 
from Customers A
WHERE A.Id NOT IN (SELECT B.CustomerId from Orders B)