182. Duplicate Emails
Easy

Write a SQL query to find all duplicate emails in a table named Person.

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
For example, your query should return the following for the above table:

+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Note: All emails are in lowercase.

Approach II: Using GROUP BY and HAVING condition [Accepted]


A more common used way to add a condition to a GROUP BY is to use the HAVING clause, which is much simpler and more efficient.

So we can rewrite the above solution to this one.

MySQL

select Email
from Person
group by Email
having count(Email) > 1;


select Email
from Person
group by Email
having count(*) > 1


1. Use self join.

 SELECT DISTINCT a.Email
 FROM Person a JOIN Person b
 ON (a.Email = b.Email)
 WHERE a.Id <> b.Id
 
 
 

Approach I: Using GROUP BY and a temporary table [Accepted]


Algorithm

Duplicated emails existed more than one time. To count the times each email exists, we can use the following code.

select Email, count(Email) as num
from Person
group by Email;
| Email   | num |
|---------|-----|
| a@b.com | 2   |
| c@d.com | 1   |
Taking this as a temporary table, we can get a solution as below.

select Email from
(
  select Email, count(Email) as num
  from Person
  group by Email
) as statistic
where num > 1
;




Approach II: Using GROUP BY and HAVING condition [Accepted]


A more common used way to add a condition to a GROUP BY is to use the HAVING clause, which is much simpler and more efficient.

So we can rewrite the above solution to this one.

MySQL

select Email
from Person
group by Email
having count(Email) > 1;


select Email
from Person
group by Email
having count(*) > 1


1. Use self join.

 SELECT DISTINCT a.Email
 FROM Person a JOIN Person b
 ON (a.Email = b.Email)
 WHERE a.Id <> b.Id
 
2. Use subquery with EXISTS:

 SELECT DISTINCT a.Email
 FROM Person a
 WHERE EXISTS(
     SELECT 1
     FROM Person b
     WHERE a.Email = b.Email
     LIMIT 1, 1
 )
 
3. Basic idea is this query:

 SELECT DISTINCT Email FROM Person
 MINUS
 (SELECT Id, Email FROM Person GROUP BY Email)
But since MySQL does not support MINUS, we use LEFT JOIN:

 SELECT DISTINCT a.Email FROM Person a
 LEFT JOIN (SELECT Id, Email from Person GROUP BY Email) b
 ON (a.email = b.email) AND (a.Id = b.Id)
 WHERE b.Email IS NULL


